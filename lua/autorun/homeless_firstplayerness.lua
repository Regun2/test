-- main character syndrome

AddCSLuaFile()

if CLIENT then
    function homeless_FirstPly()
        return GetGlobal2Entity( "homeless_firstply", nil )

    end
    return

end

function homeless_FirstPlyLoaded()
    local firstPly = homeless_FirstPly()
    if not IsValid( firstPly ) then return end
    if not firstPly:IsPlayer() then return end
    if not firstPly.GetShootPos then return end

    return true

end

if not SERVER then return end

local entMeta = FindMetaTable( "Entity" )
local CurTime = CurTime

local firstPly = nil
local firstPlayerness = {}
local nextThink = 0
local nextUpdate = 0

local wasEverOver1Ness = false
local hour = 3600

local function playernessThink()
    if nextThink > CurTime() then return end
    nextThink = CurTime() + 0.05
    nextUpdate = CurTime() + 60

    local bestPlayer = Entity(1)
    local bestNess = -math.huge
    for _, ply in player.Iterator() do
        if entMeta.IsFlagSet( ply, FL_NOTARGET ) then continue end

        local playerness = firstPlayerness[ply] or 0
        if playerness <= bestNess then continue end

        bestPlayer = ply
        bestNess = playerness

        if not wasEverOver1Ness and bestNess > 1 then
            if CurTime() > hour then -- only do this if we've been at 0 playerness for longer than an hour
                homeless_DoItButPerf( 3 )

            end
            wasEverOver1Ness = true

        end
    end

    firstPly = bestPlayer
    SetGlobal2Entity( "homeless_firstply", bestPlayer )

end

function homeless_FirstPly()
    if nextUpdate < CurTime() then
        playernessThink()

    end
    local theFirst = firstPly or GetGlobal2Entity( "homeless_firstply", nil )
    return theFirst

end

function homeless_GetFirstPlayerness( ply )
    if not IsValid( ply ) or not ply:IsPlayer() then
        ply = homeless_FirstPly()
    end
    return firstPlayerness[ply]

end

function homeless_ResetPlayerness( ply )
    firstPlayerness[ply] = nil
    playernessThink()

end

function homeless_Playerness( ply, bump )
    if not IsValid( ply ) then return end
    if not ply:IsPlayer() then return end

    bump = bump or 1
    local oldPlayerness = firstPlayerness[ply] or 0
    firstPlayerness[ply] = math.Round( oldPlayerness + bump, 2 )
    playernessThink()

end

function homeless_GetPlayerness( ply )
    if not IsValid( ply ) then return 0 end
    if not ply:IsPlayer() then return 0 end

    return firstPlayerness[ply] or 0

end

hook.Add( "PlayerDisconnected", "homeless_quitters", function( ply )
    nextThink = 0 -- need to think NOW
    homeless_ResetPlayerness( ply )

end )

hook.Add( "PlayerInitialSpawn", "homeless_arrivers", function()
    playernessThink()

end )

playernessThink()

-- the longer you linger
local bumpAmount = 0.01
local bumpInterval = 60 * 10
timer.Create( "homeless_PlayernessTimer", bumpInterval, 0, function()
    for _, ply in player.Iterator() do
        homeless_Playerness( ply, bumpAmount )

    end
end )
