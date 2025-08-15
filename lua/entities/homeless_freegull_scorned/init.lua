AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

DEFINE_BASECLASS( ENT.Base )

local recursivePreventExtent = 0

local function RecursiveSetPreventTransmit( ent, toStop, stopTransmitting )
    if not IsValid( ent ) then return end
    if recursivePreventExtent > 500 then return end
    recursivePreventExtent = recursivePreventExtent + 1

    if ent.SetPreventTransmitReason then
        ent:SetPreventTransmitReason( toStop, stopTransmitting, "homeless_scornedgull_recursive" )

    else
        ent:SetPreventTransmit( toStop, stopTransmitting )

    end

    if not isfunction( ent.GetChildren ) then return end
    local tab = ent:GetChildren()
    for i = 1, #tab do
        RecursiveSetPreventTransmit( tab[ i ], toStop, stopTransmitting )

    end
end

local function setupTransmit( gull, scornedMask )
    if scornedMask then
        for _, ply in player.Iterator() do
            recursivePreventExtent = 0
            if scornedMask[ ply ] or math.random( 0, 100 ) < 1 then
                RecursiveSetPreventTransmit( gull, ply, false )

            else
                RecursiveSetPreventTransmit( gull, ply, true )

            end
        end
    else
        for _, ply in player.Iterator() do
            recursivePreventExtent = 0
            if ply.homeless_Scorned or math.random( 0, 100 ) < 1 then
                RecursiveSetPreventTransmit( gull, ply, false )

            else
                RecursiveSetPreventTransmit( gull, ply, true )

            end
        end
    end
end

local hooking

function ENT:Initialize()
    setupTransmit( self )
    self:SetModelScale( 2 )
    BaseClass.Initialize( self )
    timer.Simple( 0, function()
        if not IsValid( self ) then return end
        self:Takeoff()
    end )

    if not hooking then
        hooking = true
        hook.Add( "PlayerInitialSpawn", "scornedgull", function()
            local gulls = ents.FindByClass( "homeless_freegull_scorned" )
            if #gulls == 0 then
                hooking = false
                hook.Remove( "PlayerInitialSpawn", "scornedgull" )
                return

            end

            for _, gull in ipairs( gulls ) do
                setupTransmit( gull )

            end
        end )
    end
end

hook.Add( "homeless_scornedcountchanged", "scornedgull", function( scornedMask, newCount, _oldCount )
    local gulls = ents.FindByClass( "homeless_freegull_scorned" )
    if #gulls == 0 then return end

    if newCount == 0 then
        for _, gull in ipairs( gulls ) do
            SafeRemoveEntity( gull )

        end
        return

    end

    for _, gull in ipairs( gulls ) do
        setupTransmit( gull, scornedMask )

    end
end )