
AddCSLuaFile( "autorun/client/cl_homeless_hommat.lua" )

-- what would you do, if you were immortal?

function doubtMyOwnExistence( doubter, satisfaction, displeasure )
    timer.Simple( 0, function()
        if not IsValid( doubter ) then return end
        if not terminator_Extras then SafeRemoveEntity( doubter ) return end
        if doubter.homeless_DeservesToExist then
            if satisfaction then satisfaction( doubter ) end
            return

        end
        if terminator_Extras.areDebugging then
            if satisfaction then satisfaction( doubter ) end
            return

        end

        if displeasure then
            local shouldReturn = displeasure( doubter )
            if shouldReturn then return end

        end

        SafeRemoveEntity( doubter )

    end )
end

if not terminator_Extras then return end

local IsValid = IsValid
local math = math
local table = table
local string = string
local areaMeta = FindMetaTable( "CNavArea" )

-- effects/breenscreen_static01_

resource.AddWorkshop( "3288654264" )

local modelsLower = {
    ["models/humans/corpse1.mdl"] = true,
    ["models/humans/charple01.mdl"] = true,
    ["models/player/corpse1.mdl"] = true,
    ["models/player/charple.mdl"] = true,
}

local translations = {
    ["models/humans/corpse1.mdl"] = "models/player/corpse1.mdl",
    ["models/humans/charple01.mdl"] = "models/player/charple.mdl",
    ["models/player/corpse1.mdl"] = "models/player/corpse1.mdl",
    ["models/player/charple.mdl"] = "models/player/charple.mdl",
}

local maxOnMap = {
    ["terminator_nextbot_homeless"] =   { [0] = 1, [1] = 1, [2] = 1 },
    ["npc_tf2_ghost"] =                 { [0] = 1, [1] = 1, [2] = 1 },
    ["homeless_campfire"] =             { [0] = 1, [1] = 1, [2] = 8 },
    ["npc_seagull"] =                   { [0] = 1, [1] = 1, [2] = 1 },
    ["homeless_deadseagullking"] =      { [0] = 1, [1] = 1, [2] = 4 },
    ["homeless_seagullking"] =          { [0] = 1, [1] = 1, [2] = 2 },
    ["homeless_note"] =                 { [0] = 1, [1] = 1, [2] = 200 },
    ["homeless_radio"] =                { [0] = 1, [1] = 2, [2] = 200 },
}

local decalsPlaced = {}
local maxDecalsOnMap = {
    ["homeless/decals/him"] = 1,
    ["homeless/decals/him_faded"] = 1,
    ["homeless/decals/shrine"] = 1,
    ["homeless/decals/wallman"] = 1,
    ["homeless/decals/gull4"] = 1,
    ["homeless/decals/gull5"] = 1,
    ["homeless/decals/gull6"] = 1,
    ["homeless/decals/realdoor"] = 1,
    ["decals/decalgraffiti038a"] = 1,
    ["homeless/decals/end"] = 4,
}

local canContainNoteModels = {
    ["models/props_junk/cardboard_box001a.mdl"] = true,
    ["models/props_junk/cardboard_box001b.mdl"] = true,
    ["models/props_junk/cardboard_box002a.mdl"] = true,
    ["models/props_junk/cardboard_box002b.mdl"] = true,
    ["models/props_junk/cardboard_box003a.mdl"] = true,
    ["models/props_junk/cardboard_box003b.mdl"] = true,
}

local comfortableMaps = {
    "rp_downtown_v2",
    "gm_shambles",
    "rp_bangclaw",
    "gm_theater",
    "gm_obselisk",
    "gm_oxidation",
    "gm_erased",
    "gm_construct_13_beta",
    "gm_daedalus",
}

local overlookNookOffsets = {
    -- cardinal directions with a bias downwards
    Vector( 0.7, 0, -0.1 ),
    Vector( -0.7, 0, -0.1 ),
    Vector( 0, 0.7, -0.1 ),
    Vector( 0, -0.7, -0.1 ),

    -- 45 degree directions with a bias downwards
    Vector( -0.35, 0.35, -0.15 ),
    Vector( -0.35, -0.35, -0.15 ),
    Vector( 0.35, 0.35, -0.15 ),
    Vector( 0.35, -0.35, -0.15 ),
}

local didNight

if math.random( 1, 100 ) < 25 then
    didNight = true
    table.insert( comfortableMaps, "night" )

end

local defQuota = 157871824 -- based off bigcity!
local quotas = {
    [0] = defQuota,
    [1] = defQuota * 0.85,
    [2] = defQuota * 0.4,
}
local minCounts = {
    [0] = 1,
    [1] = 1,
    [2] = 12,
}
local activeMinCounts = {
    [0] = 2,
    [1] = 8,
    [2] = 24,
}
local bigShelters = {
    [0] = 12,
    [1] = 18,
    [2] = 34,
}
local centerpieceBudgetBoosts = {
    [0] = 0,
    [1] = 0,
    [2] = math.random( 200, 600 ),
}

local vec12kZ = Vector( 0, 0, 12000 )
local vecUpOff = Vector( 0, 0, 25 )

homeless_restless_waking = nil
terminator_Extras.homeless_ExistingShelters = terminator_Extras.homeless_ExistingShelters or {}
terminator_Extras.homeless_ScoredShelters = terminator_Extras.homeless_ScoredShelters or {}

terminator_Extras.homeless_Loaded = terminator_Extras.homeless_Loaded or false

local forceAwake
local forceSleeper
local currentAwakeShyness
terminator_Extras.areDebugging = nil

local homeless = terminator_Extras.homeless or nil
local potentials = {}
local surfaceArea = 0
local fullMapWaitTime = 15

local sheltersSpawned = 0

local goodShelterAreas
local goodShelterAreaIndexes

local ignoreNextWake
local allAreasAverageZ
local maxComplexityThisPass

local posIsInterrupting = terminator_Extras.posIsInterrupting -- have to grab these funcs in InitPostEntity
local areaIsInterruptingSomeone = terminator_Extras.areaIsInterruptingSomeone -- these are just here for autorefresh
local GetNookScore = terminator_Extras.GetNookScore

local coroutine_yield = coroutine.yield
local inCoroutine
local function yieldIfWeCan( ... )
    if not inCoroutine then return end
    coroutine_yield( ... )

end

function homeless_IsHomelessActive()
    return IsValid( terminator_Extras.homeless ), homeless

end

function homeless_ResetShelterSpawnCount()
    sheltersSpawned = 0

end

local developer = GetConVar( "developer" )
local function debugging()
    if not terminator_Extras.areDebugging then return end
    if developer:GetInt() < 1 then return end
    return true

end

local function debugPrint( ... )
    if not debugging() then return end
    print( ... )

end

local function debugPrintTable( ... )
    if not debugging() then return end
    PrintTable( ... )

end

local function posIsIgnored( pos )
    for _, looker in player.Iterator() do
        if terminator_Extras.PosCanSee( looker:GetShootPos(), pos ) then return end
        local bearing = math.abs( terminator_Extras.BearingToPos( looker:GetShootPos(), looker:GetAngles(), pos, looker:GetAngles() ) )
        local badBearing = bearing > 90

        local distSqr = looker:GetPos():DistToSqr( pos )
        if badBearing and distSqr < 1500^2 then return end
        if distSqr < 500^2 then return end

    end
    return true

end

function homeless_MakeSchizophrenic( ent, barelyAppear )
    local timerName = "homeless_schizophrenic_manage_" ent:GetCreationID()
    ent.homeless_SeenCount = 0
    ent.homeless_SeenToFade = math.random( 1, 6 )
    if barelyAppear then
        ent.homeless_SeenBarelyAppear = true
        ent.homeless_SeenToFade = math.random( 4, 8 )

    end

    timer.Create( timerName, 1, 0, function()
        if not IsValid( ent ) then timer.Remove( timerName ) return end
        local pos = ent:WorldSpaceCenter()

        if ent.homeless_SeenCount < ent.homeless_SeenToFade then
            local ignored = posIsIgnored( pos )
            if not ignored then
                ent.homeless_SeenCount = ent.homeless_SeenCount + 1
                if barelyAppear then
                    timer.Adjust( timerName, 0.05 )

                end
            elseif barelyAppear then
                timer.Adjust( timerName, 0.5 )

            end
        elseif barelyAppear or posIsIgnored( pos ) then
            SafeRemoveEntity( ent )
            timer.Stop( timerName )

        end
    end )
end

local function IsUnderSkyPos( pos )
    pos = pos + vecUpOff
    -- get the sky
    local skyTraceDat = {
        start = pos,
        endpos = pos + vec12kZ,
        mask = CONTENTS_SOLID,
    }
    local skyTraceResult = util.TraceLine( skyTraceDat )

    if skyTraceResult.HitSky then
        return true

    elseif not skyTraceResult.Hit then
        return true

    else
        return false

    end
end

local underSkyCache = {}

local function IsUnderSky( area )
    local cached = underSkyCache[area]
    if cached then return cached end
    local underSky = IsUnderSkyPos( area:GetCenter() )

    underSkyCache[area] = underSky
    return underSky

end

local nookScoreCache = {}
local function GetAreasNookScore( area )
    local cached = nookScoreCache[area]
    if cached then return cached end
    local score = GetNookScore( area:GetCenter() + vecUpOff )

    nookScoreCache[area] = score
    return score

end

local function homeless_MakeUntouchable( ent )
    ent.Homeless_Untouchable = true
    ent.PhysgunDisabled = true
    ent.CanProperty = function()
        if IsValid( homeless ) then
            ent.PhysgunDisabled = nil
            ent.CanProperty = nil
            ent.CanTool = nil
            return true

        end
        return false

    end
    ent.CanTool = function()
        if IsValid( homeless ) then
            ent.PhysgunDisabled = nil
            ent.CanProperty = nil
            ent.CanTool = nil
            return true

        end
        return false

    end
end

hook.Add( "OnPlayerSit", "nohomelesssitting", function( _ply, _pos, _ang, parent )
    if not parent then return end
    if parent.Homeless_Untouchable then return false end

end )

hook.Add( "CanProperty", "homelessuntouchable", function( _ply, _pos, ent )
    if ent.Homeless_Untouchable then return false end

end )

local function identifyAsHomeless( ent, waker, firstWake )
    if not IsValid( ent ) then return end
    homeless = ent
    terminator_Extras.homeless = ent

    ent.homeless_DeservesToExist = true

    if not IsValid( waker ) then return end
    ent:OnIdentifyWaker( waker, "identifyAsHomeless", firstWake )

end

local function makeRestless( sleepers )
    if #sleepers < 0 then return end

    local name = "homeless_restless_sleepers"
    local nextClk = 0

    homeless_restless_waking = true
    timer.Remove( name )
    timer.Create( name, 0.5, 0, function()
        if not homeless_restless_waking then timer.Remove( name ) return end
        if not homeless_FirstPlyLoaded() then return end
        if nextClk > CurTime() then return end

        local itsPos
        local sleeper

        local nearestPly
        local nearestDist = math.huge

        local wasOneValid
        for _, potSleeper in ipairs( sleepers ) do
            if not IsValid( potSleeper ) then continue end
            if potSleeper.glee_skulldecapitated then continue end
            if potSleeper:IsPlayer() or potSleeper:IsNPC() then continue end -- already awake

            wasOneValid = true

            local potsPos = potSleeper:WorldSpaceCenter()
            local obj = potSleeper:GetPhysicsObject()
            if IsValid( obj ) then
                potsPos = potSleeper:LocalToWorld( obj:GetMassCenter() )

            end

            local wasABetter
            for _, ply in player.Iterator() do
                local dist = ply:GetPos():DistToSqr( potsPos )
                if dist < nearestDist then
                    nearestPly = ply
                    nearestDist = dist
                    wasABetter = true

                end
            end
            if wasABetter then
                itsPos = potsPos
                sleeper = potSleeper

            end
        end

        if not wasOneValid then timer.Remove( name ) return end
        if not IsValid( nearestPly ) then return end

        local close = nearestDist < 400^2
        local awake = sleeper.homeless_Awakened

        if not awake then
            if nearestDist > 1600^2 then
                -- think slow
                nextClk = CurTime() + 2

            end
            local plysNext = nearestPly:GetInfoNum( "cl_homeless_nexthomeless", 0 )
            -- think slow
            if plysNext > os.time() then
                nextClk = CurTime() + 25
                debugPrint( "they aren't ready!" )
                return

            end

            if nearestPly:IsFlagSet( FL_NOTARGET ) then return end

            if not terminator_Extras.PosCanSee( nearestPly:GetShootPos(), itsPos ) then return end
            if not close then return end
            if nearestPly:GetEyeTrace().HitPos:Distance( itsPos ) > 150 then return end

            sleepers = { sleeper }
            sleeper.homeless_SleeperWaker = nearestPly
            sleeper.homeless_Awakened = true
            terminator_Extras.homeless_DeservedWake = true

            return

        elseif awake then
            if close then return end
            if not posIsIgnored( itsPos ) then return end

            local area = navmesh.GetNearestNavArea( itsPos, true, 1500, false, true, -2 )
            if not IsValid( area ) then return end

            local translated = translations[ sleeper:GetModel() ]
            local newHomeless = ents.Create( "terminator_nextbot_homeless" )

            identifyAsHomeless( newHomeless, sleeper.homeless_SleeperWaker, true )

            if not IsValid( homeless ) then timer.Remove( name ) return end

            terminator_Extras.homeless_DeservedWake = nil

            homeless:SetPos( area:GetCenter() )
            homeless:Spawn()

            if math.random( 0, 100 ) > 25 then
                homeless:MakeShy( 0.25, "restlessWake" )

            end
            homeless:SetModel( translated )

            if IsValid( homeless.homeless_Waker ) then
                local currTimeReal = os.time()
                local oldNext = homeless.homeless_Waker:GetInfoNum( "cl_homeless_nexthomeless", 0 )

                if oldNext < currTimeReal then
                    local old = homeless.homeless_Waker:GetInfoNum( "cl_homeless_dedication", 0 )
                    homeless.homeless_Waker:ConCommand( "cl_homeless_dedication " .. math.max( old, 1 ) )

                    local oldEarned = homeless.homeless_Waker:GetInfoNum( "cl_nav_readyness", 0 )
                    local newEarned = math.Clamp( oldEarned + 2, 0, 4 )
                    homeless.homeless_Waker:ConCommand( "cl_nav_readyness " .. newEarned )

                end

                local hour = 3600
                local nextTime = os.time() + ( hour * math.random( 1, 24 ) )
                if math.random( 0, 100 ) < 25 then
                    nextTime = nextTime * math.random( 1, 6 )

                end
                homeless.homeless_Waker:ConCommand( "cl_homeless_nexthomeless " .. tostring( nextTime ) )

                homeless.homeless_doingRunAway = homeless_NoteDetail( homeless.homeless_Waker ) <= 4

            end

            local shoveProp = ents.Create( "env_physexplosion" )
            shoveProp:SetOwner( homeless )
            shoveProp:SetPos( itsPos )
            shoveProp:SetKeyValue( "spawnflags", bit.bor( 1, 4 ) )
            shoveProp:SetKeyValue( "magnitude", 10 )
            shoveProp:SetKeyValue( "radius", 150 )
            shoveProp:Spawn()
            shoveProp:Activate()
            shoveProp:Fire( "Explode" )

            sound.Play( "physics/flesh/flesh_impact_hard6.wav", itsPos, 75, 100, 1 )
            timer.Simple( 1, function()
                if not IsValid( homeless ) then return end
                homeless:EmitSound( "ambient/materials/squeekyfloor2.wav", 70, 100, 1 )

            end )

            SafeRemoveEntity( sleeper )
            timer.Remove( name )
            return

        end
    end )
end

function homeless_NoteDetail( ply )
    if not IsValid( ply ) then return end
    if not ply:IsPlayer() then return end

    return ply:GetInfoNum( "ai_note_detail", -1 )

end

local min_disp = -10
local max_disp = 10

function homeless_NudgeRelation( ply, nudge )
    if not IsValid( ply ) then return end
    if not ply:IsPlayer() then return end

    local old = ply:GetInfoNum( "cl_ai_disposition", 0 )
    local new = old + nudge
    new = math.Round( new, 2 )
    new = math.Clamp( new, min_disp, max_disp )

    ply:ConCommand( "cl_ai_disposition " .. new )

    debugPrint( "nudge disp, " .. math.Round( nudge, 2 ) )

end

function homeless_GetRelation( ply )
    if not IsValid( ply ) then return end
    if not ply:IsPlayer() then return end

    return ply:GetInfoNum( "cl_ai_disposition", 0 )

end

local function onDisturbed( ply, prop )
    if not IsValid( ply ) then return end
    if not IsValid( prop ) then return end
    if not ply:IsPlayer() then return end

    if prop.homeless_Disturbed then return end
    local active = homeless_IsHomelessActive()

    local isDead = prop.Health and prop:Health() <= 0

    if not isDead and prop:GetPos():DistToSqr( prop.homeless_Furniture_OriginalSpot ) < 150^2 then return end
    prop.homeless_Disturbed = true
    if prop.homeless_BurnDoNotDuplicate then
        prop.DoNotDuplicate = nil
        prop.homeless_BurnDoNotDuplicate = nil

    end

    local obj = prop:GetPhysicsObject()

    local hour = 3600
    local bite = hour / 2
    local killedSeagull
    local mass = prop.homeless_Mass

    if prop:IsNPC() then
        killedSeagull = prop:GetClass() == "npc_seagull"
        bite = hour * 24

    elseif IsValid( obj ) then
        mass = obj:GetMass()
        if mass < 25 then
            bite = bite * 0.25

        elseif mass < 50 then
            bite = bite * 0.5

        end
    end

    debugPrint( "disturbed!", bite )

    if killedSeagull then
        local old = ply:GetInfoNum( "cl_homeless_dedication", 0 )
        ply:ConCommand( "cl_homeless_dedication " .. math.max( old, 1 ) )

        if not ply.homeless_Murderer then
            homeless_DoItButPerf( math.random( 3, 5 ) + homeless_FirstPly():GetInfoNum( "cl_homeless_dedication", 0 ) )
            homeless_NudgeRelation( ply, -2 )

            for _, currHomeless in ipairs( ents.FindByClass( "terminator_nextbot_homeless" ) ) do
                if currHomeless.homeless_IsDecoy or not currHomeless.homeless_DeservesToExist then continue end

                -- how could you do that?!?!?
                currHomeless.HomelessFrustration = math.max( currHomeless.HomelessFrustration, currHomeless.HomelessFrustrationToAnger + -1 )

                if IsValid( currHomeless.homeless_Waker ) then continue end
                currHomeless:OnIdentifyWaker( ply, "killedseagull", not currHomeless.homeless_HadWaker )

            end
        end
        homeless_Playerness( ply, 5 )
        ply.homeless_Murderer = true
        return

    end

    homeless_Playerness( ply, 0.05 )

    local passMass = mass and mass > math.random( 5, 25 )
    if passMass or prop.homeless_EatenGasCan then
        if prop.homeless_CampfireLastEat and ( prop.homeless_CampfireLastEat + 5 ) > CurTime() then
            if not prop.homeless_DoneFireReward then
                local relation = 0.25
                if prop.homeless_EatenGasCan then
                    relation = 0.5

                end
                prop.homeless_DoneFireReward = true
                homeless_NudgeRelation( ply, relation )

            end
        else
            local relation = math.Rand( -0.25, -0.15 )
            homeless_NudgeRelation( ply, relation )

        end
    end
    if active then
        if isDead and passMass then
            for _, currHomeless in ipairs( ents.FindByClass( "terminator_nextbot_homeless" ) ) do
                if currHomeless.homeless_IsDecoy or not currHomeless.homeless_DeservesToExist then continue end

                -- frustrating...
                local nudge = currHomeless:GetFrustationAdded() / 2
                currHomeless:NudgeFrustration( nudge, "brokefurnitue" )
                local wrongOldWaker = not IsValid( currHomeless.homeless_Waker ) or currHomeless.homeless_Waker ~= ply
                local angryEnough = currHomeless.HomelessFrustration >= currHomeless:GetFrustationAdded()
                if wrongOldWaker and angryEnough then
                    currHomeless:OnIdentifyWaker( ply, "brokefurnitue" )

                end
            end
        end
    else
        local oldNext = ply:GetInfoNum( "cl_homeless_nexthomeless", 0 )
        local oldMessage = ply:GetInfoNum( "cl_homeless_nextmessage", 0 )
        local currTimeReal = os.time()

        if oldNext > currTimeReal then
            local bitten = oldNext - bite
            bitten = math.Round( bitten )
            ply:ConCommand( "cl_homeless_nexthomeless " .. tostring( bitten ) )

            debugPrint( "biteHomeless", oldNext, currTimeReal )

        end

        if oldMessage > currTimeReal then
            local bitten = oldMessage - bite
            bitten = math.Round( bitten )
            ply:ConCommand( "cl_homeless_nextmessage " .. tostring( bitten ) )

            debugPrint( "biteMessage", oldMessage - currTimeReal )

        else
            local timerName = "homeless_screamat_" .. ply:GetCreationID()
            timer.Create( timerName, math.random( 0, 240 ), 1, function()
                if not IsValid( ply ) then return end
                net.Start( "homeless_misc_ambiance" )
                net.Send( ply )

            end )
        end
    end
end

hook.Add( "OnPlayerPhysicsDrop", "homeless_protective", function( ply, prop )
    if not prop.homeless_Furniture then return end
    if prop.homeless_Disturbed then return end
    prop.homeless_LastHolder = ply

    timer.Simple( math.Rand( 1, 5 ), function()
        onDisturbed( ply, prop )

    end )
end )

hook.Add( "GravGunOnDropped", "homeless_protective", function( ply, prop )
    if not prop.homeless_Furniture then return end
    if prop.homeless_Disturbed then return end
    prop.homeless_LastHolder = ply

    timer.Simple( math.Rand( 1, 5 ), function()
        onDisturbed( ply, prop )

    end )
end )

hook.Add( "GravGunPunt", "homeless_protective", function( ply, prop )
    if not prop.homeless_Furniture then return end
    if prop.homeless_Disturbed then return end
    prop.homeless_LastHolder = ply

    timer.Simple( math.Rand( 1, 5 ), function()
        onDisturbed( ply, prop )

    end )
end )

hook.Add( "PhysgunDrop", "homeless_protective", function( ply, prop )
    if not prop.homeless_Furniture then return end
    if prop.homeless_Disturbed then return end
    prop.homeless_LastHolder = ply

    timer.Simple( math.Rand( 1, 5 ), function()
        onDisturbed( ply, prop )

    end )
end )

hook.Add( "EntityTakeDamage", "homeless_protective", function( prop, dmg )
    if not prop.homeless_Furniture then return end
    if prop.homeless_Disturbed then return end

    local ply = dmg:GetAttacker()
    if not IsValid( ply ) then return end
    if not ply:IsPlayer() then return end

    if not prop.Health then return end

    prop.homeless_LastDamager = ply

    local obj = prop:GetPhysicsObject()
    if IsValid( obj ) then
        prop.homeless_Mass = obj:GetMass()

    end
end )

hook.Add( "homeless_oncampfireeat", "homeless_protective", function( prop, _campfire )
    prop.homeless_Disturbed = nil
    onDisturbed( prop.homeless_LastHolder, prop )

end )

local homelessesPos
local homelessesModel
local homelessesWaker
local homelessPeeping
local homelessHadWaker
local homelessHasHitched
local homelessesFinalSeen
local homelessesFrustration
local homelessesHiddenStage
local homelessesFinalBailStage
local homelessBurnedAReadyness
local homelessTrackedWhileInvis
local homelessIgnoreScornWisdom

local homelessesNextPoster
local homelessesPosterInterval

local lastShelterLeave

function homeless_ShelterForSaftey()
    if not IsValid( terminator_Extras.homeless ) then return end
    homeless = homeless or terminator_Extras.homeless

    homelessesPos = homeless:GetPos()
    homelessesModel = homeless:GetModel()
    homelessesWaker = homeless.homeless_Waker
    homelessPeeping = homeless.homeless_Peeping
    homelessHadWaker = homeless.homeless_HadWaker
    homelessHasHitched = homeless.homeless_DoneWatchHitch
    homelessesFinalSeen = homeless.homeless_FinalSeen
    homelessesFrustration = homeless.HomelessFrustration
    homelessesHiddenStage = homeless.TryingToBeHidden
    homelessesFinalBailStage = homeless.homeless_FinalBailStage
    homelessBurnedAReadyness = homeless.homeless_BurnedAReadyness
    homelessTrackedWhileInvis = homeless.homeless_PlayerTrackedWhileInvis
    homelessIgnoreScornWisdom = homeless.homeless_IgnoreScornWisdom

    homelessesNextPoster = homeless.homeless_NextPoster
    homelessesPosterInterval = homeless.homeless_PosterInterval

end
function homeless_LeaveShelterForSaftey( forcedWaker )
    if IsValid( terminator_Extras.homeless ) then return end
    if not homelessesPos then return end

    local waker = forcedWaker or homelessesWaker

    local newHomeless = ents.Create( "terminator_nextbot_homeless" )
    identifyAsHomeless( newHomeless, waker, false )

    if not IsValid( homeless ) then return end

    local sinceLast
    if lastShelterLeave then
        sinceLast = math.abs( lastShelterLeave - CurTime() )

    end
    if sinceLast and sinceLast < math.random( 20, 30 ) then -- are we stuck??
        local nearestArea = navmesh.GetNearestNavArea( homelessesPos, true, 5000, false, true )
        local snappedPos = nearestArea:GetClosestPointOnArea( homelessesPos )

        local foundAreas = {}
        local count = 0
        local maxs = Vector( 1, 1, 1 )
        local mins = -maxs

        while #foundAreas < 25 and count < 8 do
            count = count + 1
            mul = ( count^1.2 ) * 500
            foundAreas = navmesh.FindInBox( snappedPos + ( mins * mul ), snappedPos + ( maxs * mul ) )

        end
        if #foundAreas >= 25 then -- all good!
            randArea = foundAreas[math.random( 1, #foundAreas )]
            if IsValid( randArea ) then
                homelessesPos = randArea:GetCenter()

            end
        end
    end

    homeless:SetPos( homelessesPos )
    homeless.TryingToBeHidden = ( homelessesHiddenStage or 0 ) + 1
    homeless.homeless_Peeping = homelessPeeping
    homeless.homeless_HadWaker = homelessHadWaker
    homeless.HomelessFrustration = homelessesFrustration
    homeless.homeless_FinalSeen = homelessesFinalSeen
    homeless.homeless_FinalBailStage = homelessesFinalBailStage
    homeless.homeless_DoneWatchHitch = homelessHasHitched
    homeless.homeless_BurnedAReadyness = homelessBurnedAReadyness
    homeless.homeless_IgnoreScornWisdom = homelessIgnoreScornWisdom
    homeless.homeless_PlayerTrackedWhileInvis = homelessTrackedWhileInvis

    homeless.homeless_NextPoster = homelessesNextPoster
    homeless.homeless_PosterInterval = homelessesPosterInterval

    homeless:Spawn()
    homeless:SetModel( homelessesModel or "models/player/corpse1.mdl" )

    homelessesPos = nil
    homelessesModel = nil
    homelessesWaker = nil
    homelessPeeping = nil
    homelessHasHitched = nil
    homelessesFinalSeen = nil
    homelessesFrustration = nil
    homelessesHiddenStage = nil
    homelesseFinalBailCount = nil
    homelessBurnedAReadyness = nil
    homelessTrackedWhileInvis = nil
    homelessIgnoreScornWisdom = nil

    homelessesNextPoster = nil
    homelessesPosterInterval = nil

    lastShelterLeave = CurTime()

    return homeless

end

hook.Add( "PreCleanupMap", "homeless_sheltering", function()
    homeless_ShelterForSaftey()

end )

hook.Add( "PostCleanupMap", "homeless_sheltering", function()
    homeless_LeaveShelterForSaftey()

end )

local findPotentials

do
    local function tackle( ent ) -- schizo anti-continue practice
        if not IsValid( ent ) then return end

        local model = ent:GetModel()
        if not model then return end

        yieldIfWeCan()
        if ent.glee_skulldecapitated then return end

        model = string.lower( model )
        if not modelsLower[ model ] then return end

        yieldIfWeCan()
        local area = navmesh.GetNearestNavArea( ent:GetPos(), true, 500, false, false, -2 )
        if not IsValid( area ) then return end

        table.insert( potentials, ent )
        ent:CallOnRemove( "homeless_resetpotentials", function()
            timer.Simple( 1, function()
                findPotentials()

            end )
        end )

        if ent:GetClass() ~= "prop_ragdoll" then return end
        homeless_MakeUntouchable( ent )

    end

    findPotentials = function()
        potentials = {}
        for _, ent in ents.Iterator() do
            tackle( ent )

        end
    end
end

local function getTimeIsDay( osTime )
    local hourTime24 = tonumber( os.date( "%H", osTime ) )
    local isDay = hourTime24 > 5 and hourTime24 < 19
    local late = hourTime24 < 4 or hourTime24 > 23
    return isDay or late

end

local peepTimer = "homeless_peep"

local function peep( force )
    if navmesh.GetNavAreaCount() <= 0 then
        debugPrint( "peepnonav" )
        timer.Remove( peepTimer )
        return

    end
    if IsValid( homeless ) then
        debugPrint( "peepawake" )
        return

    end
    if #potentials >= 1 then
        debugPrint( "peepsleeper" )
        return

    end

    local first = homeless_FirstPly()
    if not IsValid( first ) then return end
    local level = first:GetInfoNum( "cl_homeless_dedication", 0 )

    local added = terminator_Extras.homeless_PeepAdded or 0 -- longer the session, more likely the peep
    terminator_Extras.homeless_PeepAdded = added + 1

    if game.IsDedicated() then
        added = added * 0.001

    else
        added = added * 0.01

    end

    if not force then
        if level <= 0 and math.random( 0, 100 ) <= 98 - added then debugPrint( "peepfail0" )  return end
        if level <= 1 and math.random( 0, 100 ) <= 98 - added then debugPrint( "peepfail1" ) return end
        if math.random( 0, 100 ) <= 99 - added then debugPrint( "peepfail2" ) return end

    end

    local peepPos
    if terminator_Extras.homeless_OverlookPos then
        peepPos = terminator_Extras.homeless_OverlookPos

    else
        peepPos = first:GetPos()

    end

    local area = navmesh.GetNearestNavArea( peepPos, true, 1500, false, true, -2 )
    if not IsValid( area ) then debugPrint( "peepfailnav" ) return end

    local newHomeless = ents.Create( "terminator_nextbot_homeless" )
    identifyAsHomeless( newHomeless, first, true )

    if not IsValid( homeless ) then debugPrint( "peepfail" ) timer.Remove( peepTimer ) return end

    terminator_Extras.homeless_PeepAdded = nil

    homeless.homeless_Peeping = true -- important!

    homeless:SetPos( area:GetCenter() )
    homeless:Spawn()
    homeless:SetModel( "models/player/corpse1.mdl" )

    homeless:MakeShy( math.Round( math.Rand( 0, 6 ), 1 ), "peep" )

    debugPrint( "peeped" )

end

terminator_Extras.homeless_Peep = peep

local wallSnapDirections = {
    Vector( 1, 0, 0 ),
    Vector( -1, 0, 0 ),
    Vector( 0, 1, 0 ),
    Vector( 0, -1, 0 ),

}
local floorSnapDirections = { -- "directions", lol
    Vector( 0, 0, -1 )

}

local defaultClass = "prop_physics"
local defaultAng = Angle()
local defaultPos = Vector( 0, 0, 25 )
local defaultSize = 75
local defaultLikesSky = false

function homeless_SpawnASheltersFurniture( chosenShelter, origin, angle )
    if not terminator_Extras.homeless_Loaded then return end
    local spawned = {}
    local shelterScore = 0

    local validModels = {}
    for _, furniture in ipairs( chosenShelter.furniture ) do
        local currModel = furniture.mdl
        if currModel and isstring( currModel ) then
            validModels[currModel] = true

        end
    end

    local canMove = {}

    for ind, ent in ipairs( ents.FindInSphere( origin, 4000 ) ) do
        if ( ind % 30 ) == 1 then
            yieldIfWeCan()

        end
        if not IsValid( ent ) then continue end
        if ent.homeless_Furniture then continue end

        local mdl = ent:GetModel()
        if not mdl then continue end
        if not isstring( mdl ) then continue end
        if not validModels[ mdl ] then continue end

        if not IsValid( ent:GetPhysicsObject() ) then continue end

        table.insert( canMove, ent )

    end

    local sheltersFurniture = chosenShelter.furniture
    local furnitureToSpawn

    if chosenShelter.randomlychoose1 then
        furnitureToSpawn = { sheltersFurniture[math.random( 1, #sheltersFurniture )] }

    else
        furnitureToSpawn = table.Copy( sheltersFurniture )

    end

    for _, furniture in ipairs( furnitureToSpawn ) do -- spawn each furniture, one by one
        yieldIfWeCan()
        local model = furniture.mdl
        if isfunction( model ) then
            model = model()

        end
        local class = furniture.class or terminator_Extras.shelter_DefaultClassOverrides[ model ] or defaultClass
        if isfunction( class ) then
            class = class()

        end

        if model and isstring( model ) and not util.IsValidModel( model ) then continue end -- dont spawn ERROR models please

        -- overcomplicated special case for decals
        if class == "infodecal" then
            local tex = furniture.keys.texture
            local potentialTextures
            if istable( tex ) then
                potentialTextures = {}
                for _, currTex in ipairs( tex ) do
                    table.insert( potentialTextures, currTex )

                end
            else
                potentialTextures = { tex }

            end
            local finalTextures = {}
            for _, currTex in ipairs( potentialTextures ) do
                if maxDecalsOnMap[currTex] and decalsPlaced[currTex] and decalsPlaced[currTex] > maxDecalsOnMap[currTex] then continue end
                table.insert( finalTextures, currTex )

            end

            if #finalTextures <= 0 then debugPrint( "blocked infodecal late" ) continue end

            furniture.keys.texture = finalTextures

        end

        local new = ents.Create( class )
        if not IsValid( new ) then continue end

        new.homeless_DeservesToExist = true
        new.homeless_Furniture = true

        local pos = furniture.pos

        if isnumber( pos ) then -- random offset
            local rand = VectorRand()
            rand.z = rand.z * 0.5
            rand:Normalize()
            rand = rand * math.random( 0, pos )
            pos = Vector( 0, 0, math.random( 35, 55 ) ) + rand

        end
        local worldPos, worldAng = LocalToWorld( pos or defaultPos, furniture.ang or defaultAng, origin, angle )

        local noDrawn

        if model then
            new:SetModel( model )

            noDrawn = true -- so we aren't seen too early
            new:SetNoDraw( true )

            local toReplace
            local nearestDistSqr = math.huge

            for ind, potentialMove in ipairs( canMove ) do
                if ( ind % 30 ) == 1 then
                    yieldIfWeCan()

                end
                if not IsValid( potentialMove ) then continue end

                local itsClass = potentialMove:GetClass()
                if itsClass ~= class and itsClass ~= defaultClass then continue end

                local itsModel = potentialMove:GetModel()
                if itsModel ~= model then continue end

                local potentialsPos = potentialMove:WorldSpaceCenter()

                local distSqr = potentialsPos:DistToSqr( origin )
                if distSqr > nearestDistSqr then continue end

                if posIsInterrupting( potentialsPos, inCoroutine ) then continue end

                nearestDistSqr = distSqr
                toReplace = potentialMove

            end

            if IsValid( toReplace ) then
                if debugging() then
                    debugoverlay.Line( toReplace:GetPos(), origin, 10, color_white, true )

                end
                local obj = toReplace:GetPhysicsObject()
                if IsValid( obj ) then
                    local force = terminator_Extras.dirToPos( toReplace:WorldSpaceCenter(), worldPos )
                    force = force * 500
                    force = force * obj:GetMass()
                    obj:ApplyForceCenter( force )

                end

                SafeRemoveEntityDelayed( toReplace, 0.1 )

            end

            if canContainNoteModels[model] then
                new:CallOnRemove( "homeless_noteonbreak", function( broken )
                    if math.random( 0, 100 ) > 25 then return end
                    if terminator_Extras.homeless_SpawnedNoteOnBreak then return end

                    local notes = ents.FindByClass( "homeless_note" )
                    if #notes > 0 then return end

                    local newNote = ents.Create( "homeless_note" )
                    if not IsValid( newNote ) then return end
                    terminator_Extras.homeless_SpawnedNoteOnBreak = true

                    newNote:SetPos( broken:WorldSpaceCenter() )
                    newNote:SetAngles( AngleRand() )
                    newNote:Spawn()

                end )
            end
        end

        yieldIfWeCan()

        new:SetPos( worldPos )
        new:SetAngles( worldAng )

        if class == "infodecal" then
            furniture.keys = furniture.keys or {}
            furniture.keys["targetname"] = tostring( math.random( -200000, 200000 ) )
            furniture.fire = furniture.fire or {}
            furniture.fire["Activate"] = ""

        end

        if furniture.keys then
            local setKeys = {}
            for key, val in pairs( furniture.keys ) do
                if istable( val ) then
                    val = val[math.random( 1, #val )]
                end
                setKeys[key] = val
                new:SetKeyValue( key, val )

            end
            if class == "infodecal" then
                local setTexture = setKeys.texture
                if furniture.alwaysLimitGrafitti and not maxDecalsOnMap[setTexture] then
                    maxDecalsOnMap[setTexture] = 1

                end
                if maxDecalsOnMap[setTexture] then
                    debugPrint( "placed tracked decal " .. setTexture )
                    decalsPlaced[setTexture] = ( decalsPlaced[setTexture] or 0 ) + 1

                end
            end
        end

        local classesMaxes = maxOnMap[class]
        local currMax = classesMaxes
        if currMax then
            debugPrint( "placed tracked class " .. class )

        end

        if class == "terminator_nextbot_homeless" then
            new:MakeWait( currentAwakeShyness, "spawnedAwake" )
            identifyAsHomeless( new, nil, true )

        end

        if furniture.skin then
            if isstring( furniture.skin ) then
                if furniture.skin == "?" then
                    new:SetSkin( math.random( 0, new:SkinCount() ) )

                end
                -- do nothing
            else
                new:SetSkin( furniture.skin )

            end
        end

        if furniture.mat then
            new:SetMaterial( furniture.mat )

        end

        shelterScore = shelterScore + 1

        yieldIfWeCan()

        timer.Simple( 0, function()
            if not IsValid( new ) then shelterScore = shelterScore + -1 return end

            local smallestFraction = math.huge
            local smallestDat
            local distance = 1000
            local mins, maxs = new:GetRotatedAABB( new:OBBMins(), new:OBBMaxs() )

            mins = mins * math.Rand( 1.15, 1.25 )
            maxs = maxs * math.Rand( 1.15, 1.25 )

            local cantNilSnap = #furnitureToSpawn > 1 or class ~= defaultClass
            local wallSnappin = furniture.wallsnap ~= false and not ( furniture.wallsnap == nil and cantNilSnap )

            local snapDirections
            if wallSnappin or furniture.facewall ~= nil then
                snapDirections = table.Copy( wallSnapDirections )

            end
            if furniture.facefloor then
                if snapDirections then
                    if debugging() then
                        ErrorNoHaltWithStack( "AAA FACEFLOOR AND FACEWALL BAD MIX" )

                    end
                    SafeRemoveEntity( new )
                    return

                else
                    snapDirections = table.Copy( floorSnapDirections )

                end
            end

            if snapDirections then
                for _, direction in ipairs( snapDirections ) do
                    yieldIfWeCan()
                    local traceData = {
                        start = worldPos + vecUpOff,
                        endpos = worldPos + vecUpOff + direction * distance,
                        mins = mins,
                        maxs = maxs,
                        mask = MASK_SOLID_BRUSHONLY,

                    }

                    local trace = util.TraceHull( traceData )
                    if not trace.Hit then continue end

                    local fraction = trace.Fraction
                    if fraction < smallestFraction then
                        smallestFraction = fraction
                        smallestDat = trace

                    end
                end

                if smallestDat then
                    new:SetPos( smallestDat.HitPos )

                end

                local faceNormal

                -- false to face away, true to face
                if smallestDat and furniture.facewall ~= nil then
                    faceNormal = smallestDat.Normal
                    if not furniture.facewall then
                        faceNormal = -faceNormal

                    end
                end

                if smallestDat and furniture.facefloor then
                    faceNormal = smallestDat.Normal
                    if not furniture.facefloor then
                        faceNormal = -faceNormal

                    end
                end

                if faceNormal then
                    local oldCenter = new:WorldSpaceCenter()

                    new:SetAngles( ( faceNormal ):Angle() )

                    local subtProduct = oldCenter - new:WorldSpaceCenter()
                    new:SetPos( new:GetPos() + subtProduct )

                end
            end

            new:Spawn() -- :steamhappy:
            if noDrawn then  -- ready now!
                new:SetNoDraw( false )

            end

            if furniture.mdlafter then
                model = furniture.mdl
                if isfunction( model ) then
                    model = model()

                end
                new:SetModel( model )

            end

            local frozen = furniture.frozen
            local doDrop = furniture.drop
            if frozen and doDrop == nil then -- default no drop when frozen
                doDrop = false

            end
            if doDrop ~= false then new:DropToFloor() end

            if frozen and IsValid( new:GetPhysicsObject() ) then
                new:GetPhysicsObject():EnableMotion( false )

            end

            new.homeless_Furniture_OriginalSpot = new:GetPos()
            if not new.DoNotDuplicate then
                new.homeless_BurnDoNotDuplicate = true
                new.DoNotDuplicate = true -- dont clutter saves with furniture

            end

            new:CallOnRemove( "homeless_understandremoved", function( prop )
                if not IsValid( prop.homeless_LastDamager ) then return end
                local ply = prop.homeless_LastDamager
                onDisturbed( ply, prop )

            end )

            if furniture.fire then
                for theInput, param in pairs( furniture.fire ) do
                    new:Fire( theInput, param )

                end
            end

            if furniture.schizophrenic and math.random( 0, 100 ) < furniture.schizophrenic then
                homeless_MakeSchizophrenic( new, furniture.schizobarelyappear ) -- was that really there?

            end
        end )

        table.insert( spawned, new )

    end
    return spawned, shelterScore

end

local potentialSpawningOffsets = {
    Vector( 0, 0, 0 ), -- center
    Vector( 1, 0, 0 ),
    Vector( -1, 0, 0 ),
    Vector( 0, 1, 0 ),
    Vector( 0, -1, 0 ),
    Vector( 1, 1, 0 ),
    Vector( -1, -1, 0 ),
    Vector( -1, 1, 0 ),
    Vector( 1, -1, 0 ),

}

include( "homeless_shelter/shelters.lua" )

-- picks shelter for an area, then goes through all the steps to get it ready to build
function homeless_SpawnShelterAt( area, maxComplexity, data )
    if not homeless_FirstPlyLoaded() then debugPrint( "cant shelter, no ply" ) return end

    data = data or {}

    local isFollower = data.follower
    local centerpieceFollower = data.centerpiecefollower
    local pickMask = data.pickMask
    local modelFilter = data.modelFilter
    local overlooking = data.overlooking

    local old = terminator_Extras.homeless_ExistingShelters[area]
    if old then
        for _, thing in ipairs( old ) do
            if IsValid( thing ) then
                SafeRemoveEntity( thing )

            end
        end
        terminator_Extras.homeless_ExistingShelters[area] = nil

    end

    local chosenShelter = data.forcedShelter
    local spawnedHomeless
    local firstPly = homeless_FirstPly()
    local underSky = IsUnderSky( area )
    local areasMinSize = math.min( area:GetSizeX(), area:GetSizeY() )

    if chosenShelter then
        debugPrint( "doing forced shelter" )

    elseif not chosenShelter then
        local dedication = 0
        local noteDetail = 0
        local disposition = 0
        local canSpawnHomeless
        local trueNote

        if IsValid( firstPly ) and firstPly:IsPlayer() then
            dedication = firstPly:GetInfoNum( "cl_homeless_dedication", 0 )
            noteDetail = homeless_NoteDetail( firstPly )
            disposition = homeless_GetRelation( firstPly )
            local plysNext = firstPly:GetInfoNum( "cl_homeless_nexthomeless", 0 )
            canSpawnHomeless = ignoreNextWake or plysNext < os.time()
            canSpawnHomeless = canSpawnHomeless and not IsValid( homeless )

            trueNote = firstPly:GetInfoNum( "ai_note_ideal_detail", 0 ) ~= homeless_NoteDetail( firstPly )

        end

        maxComplexity = maxComplexity or math.huge
        maxComplexity = math.min( maxComplexity, maxComplexityThisPass )

        local pool = {}

        local onlySleepers = forceSleeper and #potentials <= 0
        local onlyAwake = forceAwake and not IsValid( homeless )

        local allShelters
        local normalShelter
        if overlooking then
            allShelters = terminator_Extras.homeless_LookoutLeftovers

        else
            normalShelter = true
            allShelters = terminator_Extras.homeless_Shelters

        end
        local potentialShelters
        if pickMask then
            normalShelter = nil
            potentialShelters = {}
            for _, index in ipairs( pickMask ) do
                table.insert( potentialShelters, allShelters[index] )

            end
        else
            potentialShelters = allShelters

        end

        for _, shelter in ipairs( potentialShelters ) do
            yieldIfWeCan()
            local rightDedication = shelter.dedication == -1 or shelter.dedication == dedication
            if not rightDedication then continue end

            local noteBlocked = shelter.notedetail and shelter.notedetail < noteDetail
            if noteBlocked then continue end

            local sheltersDisp = shelter.disposition
            if sheltersDisp then
                if sheltersDisp < 0 and disposition > sheltersDisp then continue end
                if sheltersDisp > 0 and disposition < sheltersDisp then continue end
            end

            local itsMin = shelter.minsize or defaultSize
            local areaIsTooSmall = areasMinSize < itsMin
            if areaIsTooSmall then continue end

            local tooComplex = #shelter.furniture > maxComplexity
            if tooComplex then continue end

            local oversized = shelter.maxsize and areasMinSize > shelter.maxsize
            if oversized then continue end

            local good = true
            local notSleeperBlock
            local notAwakeBlock

            if normalShelter then
                if onlySleepers and not isFollower then
                    notSleeperBlock = true

                end

                if onlyAwake and not isFollower then
                    notAwakeBlock = true

                end
            end

            local passesFilter

            for _, item in ipairs( shelter.furniture ) do
                yieldIfWeCan()
                local validMdl = isstring( item.mdl )
                if modelFilter and validMdl and string.find( item.mdl, modelFilter ) then passesFilter = true break end

                local isRagdoll = item.class and string.find( item.class, "ragdoll" )
                local isSleeper = isRagdoll and validMdl and modelsLower[string.lower( item.mdl )]
                local isAwake = item.class == "terminator_nextbot_homeless" and validMdl and modelsLower[string.lower( item.mdl )]
                local isHim = isSleeper or isAwake

                -- only allow forced sleepers/awake ones if we're not a follower
                if isFollower and isHim then
                    good = nil
                    break

                end

                if onlySleepers and good and isSleeper then
                    notSleeperBlock = nil

                end
                if onlyAwake and good and isAwake then
                    notAwakeBlock = nil

                end

                local classesMaxes = maxOnMap[item.class]
                local currMax = classesMaxes and classesMaxes[dedication] or nil
                if currMax and ( #ents.FindByClass( item.class ) >= currMax ) then
                    good = nil
                    break

                end
            end

            if modelFilter and not passesFilter then
                good = nil

            end

            if onlySleepers and notSleeperBlock then
                good = nil

            end

            if onlyAwake and notAwakeBlock then
                good = nil

            end

            if shelter.onlycenterpiecefollower and not centerpieceFollower and math.random( 1, 100 ) < 95 then -- rarely allow a pass
                good = nil

            end

            if centerpieceFollower and shelter.centerpiece then
                good = nil

            end

            -- nevercenterpiecefollower allows dont follow centerpiece behaviour without it being a centerpiece itself
            if shelter.nevercenterpiecefollower and centerpieceFollower then
                good = nil

            end

            local likesSky = shelter.likessky
            if likesSky == nil then
                if shelter.overlooker then
                    likesSky = true

                else
                    likesSky = defaultLikesSky

                end
            end
            if ( good and not shelter.skyagnostic ) then
                local happy = ( likesSky and underSky ) or ( not likesSky and not underSky )
                if not happy then
                    good = nil

                end
            end

            if good then
                table.insert( pool, shelter )

            end
        end

        while not chosenShelter do
            yieldIfWeCan()
            chosenShelter = table.remove( pool, math.random( 1, #pool ) )
            if not chosenShelter then break end

            -- trim stuff from the shelter
            for ind, item in pairs( chosenShelter.furniture ) do
                yieldIfWeCan()
                if item.skipchance and math.random( 0, 100 ) < item.skipchance then
                    continue

                end
                local sleeper = isstring( item.mdl ) and modelsLower[ string.lower( item.mdl ) ]
                local awake = item.class == "terminator_nextbot_homeless"
                local isHomeless = sleeper or awake
                if isHomeless and not canSpawnHomeless then
                    if trueNote or math.random( 0, 100 ) <= 10 then
                        debugPrint( "blocked homeless spawn " .. item.mdl .. " " .. item.class .. "\nreplaced with note" )
                        local new = table.Copy( terminator_Extras.homeless_NoteFurniture )
                        new.ang = item.ang
                        new.pos = item.pos
                        new.wallsnap = item.wallsnap
                        new.facewall = item.facewall
                        chosenShelter.furniture[ind] = new

                    elseif noteDetail >= 4 and math.random( 0, 100 ) < 50 then
                        debugPrint( "blocked homeless spawn " .. item.mdl .. " " .. item.class .. "\nreplaced with lost" )
                        local new = table.Copy( terminator_Extras.homeless_LostFurniture )
                        new.ang = item.ang
                        new.pos = item.pos
                        chosenShelter.furniture[ind] = new

                    else
                        debugPrint( "blocked homeless spawn " .. item.mdl .. " " .. item.class )
                        table.remove( chosenShelter.furniture, ind )

                    end
                elseif isHomeless then
                    spawnedHomeless = true

                end

                local isDecal = item.class == "infodecal"
                if isDecal then
                    local tex = item.keys.texture
                    if maxDecalsOnMap[tex] and decalsPlaced[tex] and decalsPlaced[tex] >= maxDecalsOnMap[tex] then
                        debugPrint( "blocked tracked decal " .. tex )
                        table.remove( chosenShelter.furniture, ind )

                    end
                end

                if isFollower and isstring( item.mdl ) and ( string.find( item.mdl, "chair" ) or string.find( item.mdl, "sofa" ) ) and math.random( 1, 100 ) < 75 then
                    table.remove( chosenShelter.furniture, ind )

                end
            end
            if table.Count( chosenShelter.furniture ) <= 0 then
                chosenShelter = nil
                spawnedHomeless = nil

            end
        end
    end

    local sheltersSize = chosenShelter and chosenShelter.minsize or defaultSize
    local origin = area:GetCenter()
    local sizeForFitting = sheltersSize * 0.5

    if not chosenShelter then
        if debugging() then
            local color = Color( 255, 0, 0 )
            debugoverlay.Cross( origin, 100, 5, color, true )
            debugoverlay.Line( firstPly:GetShootPos() + firstPly:GetAimVector() * 50, origin, 5, color, true )
            debugoverlay.Box( origin, Vector( -sizeForFitting, -sizeForFitting, 0 ), Vector( sizeForFitting, sizeForFitting, 0 ), 5, ColorAlpha( color, 50 ) )

        end
        debugPrint( "couldnt find appropriate shelter" )
        return

    end

    local likesSky = chosenShelter.likessky
    if likesSky == nil then
        if chosenShelter.overlooker then
            likesSky = true

        else
            likesSky = defaultLikesSky

        end
    end

    -- offset origin to one of the area's corners if we can
    local areasX = ( area:GetSizeX() * 0.5 )
    local areasY = ( area:GetSizeY() * 0.5 )

    if areasX > sheltersSize or areasY > sheltersSize then
        local potentialOffsets = {}
        for _, currOffset in ipairs( potentialSpawningOffsets ) do
            yieldIfWeCan()

            local bumpSizeX = areasX - sizeForFitting
            local bumpSizeY = areasY - sizeForFitting
            local xOffset = bumpSizeX * currOffset.x * math.Rand( 0.8, 1 )
            local yOffset = bumpSizeY * currOffset.y * math.Rand( 0.8, 1 )

            local currOrigin = Vector( origin.x + xOffset, origin.y + yOffset, origin.z )
            table.insert( potentialOffsets, currOrigin )

        end

        local scoredOffsets = {}

        for _, potOffset in ipairs( potentialOffsets ) do
            yieldIfWeCan()

            local score = math.random( 95, 105 )
            if not chosenShelter.skyagnostic then
                local offsetUnderSky = IsUnderSkyPos( potOffset )
                if ( likesSky and not offsetUnderSky ) or ( not likesSky and offsetUnderSky ) then
                    score = score / 4

                end
            end
            local wantsANook = #chosenShelter.furniture <= 1 and chosenShelter.furniture[1].wallsnap
            local wantsOpen = chosenShelter.overlooker

            local desiresNookScore = wantsANook or wantsOpen

            if desiresNookScore then
                if chosenShelter.overlooker then
                    dist = 5000
                    offsets = overlookNookOffsets

                end
                local nookScore = GetNookScore( potOffset + vecUpOff, dist, offsets )
                if wantsANook then
                    local adjust = nookScore / 4
                    score = score * adjust

                end
                if wantsOpen then
                    local adjust = nookScore
                    score = score / adjust

                end
            end

            scoredOffsets[score] = potOffset

        end

        local bestOffsetKey = table.maxn( scoredOffsets )
        origin = scoredOffsets[bestOffsetKey]

    end


    local randomPitch = math.random( -180, 180 )
    local angle = Angle( 0, randomPitch, 0 )

    if #chosenShelter.furniture > 1 then
        angle:SnapTo( "yaw", 90 )

    end

    if debugging() then
        local color = color_white
        debugoverlay.Cross( origin, 100, 5, color, true )
        debugoverlay.Line( firstPly:GetShootPos() + firstPly:GetAimVector() * 50, origin, 5, color, true )
        debugoverlay.Box( origin, Vector( -sizeForFitting, -sizeForFitting, 0 ), Vector( sizeForFitting, sizeForFitting, 0 ), 5, ColorAlpha( color, 50 ) )

    end

    local spawned, shelterScore = homeless_SpawnASheltersFurniture( chosenShelter, origin, angle )

    for _, ent in ipairs( ents.FindInSphere( origin, areasMinSize * 1.5 ) ) do
        if ent:GetClass() ~= "prop_door_rotating" then continue end
        if ent.homeless_Opened then continue end
        if math.random( 1, 100 ) > 20 then continue end

        ent:Fire( "Open" )
        ent:SetKeyValue( "returndelay", "-1" )
        ent.homeless_Opened = true

    end

    terminator_Extras.homeless_ExistingShelters[area] = spawned
    terminator_Extras.homeless_ScoredShelters[shelterScore] = area

    local wasCenterpiece = spawnedHomeless or chosenShelter.centerpiece
    return spawned, wasCenterpiece, chosenShelter

end

local function getAreasShelterScore( area )
    if not allAreasAverageZ then return 0 end

    local areasCenter = areaMeta.GetCenter( area )
    local score = GetAreasNookScore( area )

    if not score then return 0 end
    if score < math.Rand( 0.18, 0.21 ) then return 0 end

    local maxSize = math.max( areaMeta.GetSizeX( area ), areaMeta.GetSizeY( area ) )
    for _, ent in ipairs( ents.FindInSphere( areasCenter, maxSize ) ) do
        yieldIfWeCan()
        if ent:IsWorld() then continue end
        if not IsValid( ent ) then debugPrint( "outdatedInfoEnt" ) yieldIfWeCan( "outdatedInfo" ) return end
        if ent:IsSolid() and area:Contains( ent:NearestPoint( areasCenter ) ) then
            score = score + -2

        end
    end

    if score < 0 then return 0 end

    local areasZ = areasCenter.z

    if areasZ > allAreasAverageZ then
        score = score + -1

    elseif areasZ < allAreasAverageZ + -400 then
        score = score + 0.5

    end

    -- yes, this is additive
    if areasZ > allAreasAverageZ + 1000 then
        score = score + -1

    elseif areasZ < allAreasAverageZ + -1500 then
        score = score + 1

    end

    -- still additive
    if areasZ > allAreasAverageZ + 4000 then
        score = score + -1

    elseif areasZ < allAreasAverageZ + -5000 then
        score = score + 1

    end

    local underSky = IsUnderSky( area )

    if score > 3.5 and underSky then
        score = math.Clamp( score - 1, 0, 5 )

    elseif score > 4 and not underSky then
        score = score + 0.5

    end

    return score

end

local function areaHasSlope( area, areasCenter )
    areasCenter = areasCenter or areaMeta.GetCenter( area )
    local centersZ = areasCenter.z

    for curr = 0, 3 do
        local cornersZ = areaMeta.GetCorner( area, curr ).z
        if centersZ > cornersZ + 5 then
            return true

        elseif centersZ < cornersZ + -5 then
            return true

        end
    end
end

local function recursiveSpawnShelters( area, complexity, data )
    if not goodShelterAreaIndexes then return end
    if not terminator_Extras.homeless_Loaded then return end

    local recursiveSpawned = {}
    local doneAreas = { [area] = true }
    local potentialAreas = area:GetAdjacentAreas()
    local countLeft = data.maxloop
    local isDebugging = data.debugging

    while complexity > 0 and countLeft > 0 do
        yieldIfWeCan()
        countLeft = countLeft - 1

        local currArea = table.remove( potentialAreas, 1 )
        -- all done
        if not currArea then break end

        if doneAreas[currArea] then continue end
        doneAreas[currArea] = true

        for _, currsNeighbor in ipairs( currArea:GetAdjacentAreas() ) do
            if
                currArea:ComputeAdjacentConnectionHeightChange( currsNeighbor ) < 45
                and not currsNeighbor:IsUnderwater()

            then
                table.insert( potentialAreas, currsNeighbor )

            end
        end

        if not doneAreas[currArea] then continue end
        if not goodShelterAreaIndexes[currArea] then continue end
        if IsUnderSky( currArea ) and math.random( 1, 100 ) > 65 then continue end -- dont do under sky shelters as much!
        if areaHasSlope( currArea ) then continue end
        if getAreasShelterScore( currArea ) < 2.5 then continue end
        if not isDebugging and areaIsInterruptingSomeone( currArea, nil, inCoroutine ) then continue end

        local currSpawned = homeless_SpawnShelterAt( currArea, complexity, { follower = true, centerpiecefollower = data.centerpiecefollower } )
        if currSpawned then
            for _, curr in ipairs( currSpawned ) do
                table.insert( recursiveSpawned, curr )

            end
            complexity = complexity - 1

        end
    end
    return recursiveSpawned

end

local doneEnterCheck
terminator_Extras.empty = terminator_Extras.empty or nil

local function doNeighbors()
    if doneEnterCheck then return end
    if homeless_FirstPly():GetInfoNum( "ai_overridden_enterers", 0 ) <= 0 then return end
    doneEnterCheck = true

    if terminator_Extras.empty then
        maxComplexityThisPass = math.huge
        debugPrint( "was already doing empty" )
        return true

    end

    if #player.GetAll() > 1 then return end

    local enterers = homeless_FirstPly():GetInfoNum( "ai_overridden_enterers", 0 )

    if enterers < math.Rand( 0, 2.75 ) then return end
    if enterers < math.Rand( 0, 2.75 ) then return end
    if enterers < math.Rand( 0, 2.75 ) then return end

    if enterers < math.Rand( 0, 1.75 ) then return end
    if enterers < math.Rand( 0, 1.75 ) then return end
    if enterers < math.Rand( 0, 1.75 ) then return end
    if enterers < math.Rand( 0, 1.75 ) then return end

    terminator_Extras.empty = true
    debugPrint( "new empty" )

    local new = math.Clamp( enterers - 1, 0, 3 )
    homeless_FirstPly():ConCommand( "ai_overridden_enterers " .. tostring( new ) )

    local time = 0
    if not game.SinglePlayer() then
        time = 10

    end
    timer.Simple( time, function()
        if #player.GetAll() > 1 then return end
        include( "homeless_shelter/neighbors.lua" )
        homeless_FixNeighbors()

    end )

    return true

end

local spawnedOne
function homeless_SetupFirst( targ )
    local hour = 3600
    local day = hour * 24
    local current = os.time()
    local add = day * math.random( 2, 6 )
    targ:ConCommand( "cl_homeless_nexthomeless " .. tostring( current + add ) )
    targ:ConCommand( "cl_homeless_nextmessage " .. tostring( current + add * math.Rand( 0.25, 0.5 ) ) )
    targ:ConCommand( "cl_homeless_banishment " .. tostring( current + add * math.Rand( 1, 2 ) ) )

end

local function doThing()
    if not homeless_FirstPlyLoaded() then yieldIfWeCan( "doneWait" ) return end

    local first = homeless_FirstPly()
    if first:GetInfoNum( "cl_homeless_nexthomeless", 0 ) == 0 then
        homeless_SetupFirst( first )
        debugPrint( "doing first" )
        yieldIfWeCan( "wait" )

    end

    local allAreas = navmesh.GetAllNavAreas()
    if #allAreas <= 1 then
        debugPrint( "stopping, no navmesh" )
        yieldIfWeCan( "noMorePlease" )
        return

    end

    local osTime = os.time()
    local isDay, late = getTimeIsDay( osTime )

    local initialEntrance = first:GetInfoNum( "ai_entrance_initial", 0 )
    if not isDay and initialEntrance > 0 and initialEntrance < os.time() then
        maxComplexityThisPass = math.huge
        -- long entrance
        first:ConCommand( "ai_entrance_initial 0" )
        first:ConCommand( "cl_homeless_dedication 2" )
        first:ConCommand( "cl_nav_readyness " .. math.random( 2, 4 ) )
        if math.random( 0, 100 ) < homeless_NoteDetail( first ) then
            first:ConCommand( "ai_overridden_enterers " .. math.random( 1, 2 ) )

        end
        debugPrint( "doing long entrance, complexity upgraded, player prepared" )
        yieldIfWeCan( "wait" )

    end

    if not IsValid( first ) then first = homeless_FirstPly() end
    if not IsValid( first ) then yieldIfWeCan( "doneWait" ) debugPrint( "firstInvalid" ) return end

    local dedication = first:GetInfoNum( "cl_homeless_dedication", 0 )

    if dedication >= 1 then
        include( "homeless_shelter/stealing.lua" )
        homeless_DoStealing( dedication )

    end

    local minCount
    if IsValid( homeless ) then
        minCount = activeMinCounts[ dedication ] or 0

    else
        minCount = minCounts[ dedication ] or 0

    end
    if late then
        maxComplexityThisPass = math.Clamp( maxComplexityThisPass, 20, math.huge )
        minCount = minCount + 4

    end

    local aboveCount = sheltersSpawned >= minCount
    local alone = true
    local resting = true

    findPotentials()
    if IsValid( homeless ) then
        alone = nil
        if aboveCount then
            debugPrint( "stopping early, someone is awake", sheltersSpawned, minCount )
            yieldIfWeCan( "noMorePlease" )
            return

        else
            debugPrint( "someone is awake, early" )

        end
    elseif #potentials >= 1 then
        resting = nil
        if aboveCount then
            makeRestless( potentials )
            debugPrint( "stopping early, map already has sleepers" )
            yieldIfWeCan( "noMorePlease" )
            return

        else
            debugPrint( "already has sleepers, early" )

        end
    end

    local comfyMap
    local mapName = game.GetMap()

    if late and not didNight then
        didNight = true
        table.insert( comfortableMaps, "night" )

    end

    for _, part in ipairs( comfortableMaps ) do
        if string.find( mapName, part ) then
            comfyMap = true
            break

        end
    end

    if not comfyMap and not isDay and string.find( mapName, "construct" ) and mapName ~= "gm_construct" then -- soft comfy case
        comfyMap = true

    end

    local plysNext = first:GetInfoNum( "cl_homeless_nexthomeless", 0 )
    local plysNextBanish = first:GetInfoNum( "cl_homeless_banishment", 0 )
    local earned = first:GetInfoNum( "cl_nav_readyness", 0 )
    local currentlyEmpty = terminator_Extras.empty

    local suffering = dedication >= 2

    if alone and comfyMap and math.random( 1, 100 ) < 75 and ( plysNext > osTime or late ) then
        forceAwake = true
        ignoreNextWake = true
        debugPrint( "comfy map, forcing spawn" )
        if plysNext > osTime then
            currentAwakeShyness = math.Rand( 4, 12 )

        else
            currentAwakeShyness = math.Rand( 0.5, 1.5 )

        end
    end

    if not currentlyEmpty and suffering and earned <= 2 then -- burn it
        first:ConCommand( "cl_homeless_dedication 1" ) -- try going back
        debugPrint( "burn" )

    elseif alone and plysNext > osTime and suffering and maxComplexityThisPass == math.huge and earned >= 1 then
        currentAwakeShyness = math.Rand( 2, 4 )
        forceAwake = true
        ignoreNextWake = true
        debugPrint( "force awake" )

    elseif plysNextBanish < osTime and earned >= 1 then -- other burn, likely they havent played in ages
        first:ConCommand( "cl_nav_readyness 0" )
        first:ConCommand( "cl_homeless_dedication 0" ) -- try going back to square one
        debugPrint( "burn alt" )

    elseif alone and plysNext > osTime and earned >= 1 then
        currentAwakeShyness = math.Rand( 10, 20 )
        forceAwake = true
        ignoreNextWake = true
        debugPrint( "force awake, watching post activity" )

    elseif resting and plysNext < osTime and earned >= 1 then -- weird edge case, spawn homeless sleeper
        forceSleeper = true
        ignoreNextWake = true
        debugPrint( "force sleep" )

    end

    if maxComplexityThisPass ~= math.huge and ( suffering or not isDay ) then
        debugPrint( "trying empty" )
        if doNeighbors() then
            maxComplexityThisPass = math.huge
            first:ConCommand( "cl_homeless_dedication 2" )
            dedication = 2
            minCount = activeMinCounts[ dedication ]
            suffering = true
            forceAwake = true
            ignoreNextWake = true
            debugPrint( "force awake, empty" )

        end
    end

    if resting and terminator_Extras.homeless_DeservedWake then
        forceSleeper = true
        ignoreNextWake = true
        debugPrint( "force sleeper, deserved one" )

    end


    local recursiveSpawned = {}
    local spawned = {}
    local wasCenterpiece

    if not goodShelterAreas then -- only do this the first time
        debugPrint( "caching the big check" )
        allAreasAverageZ = 0
        goodShelterAreas = {}
        goodShelterAreaIndexes = {}

        local ignoreConnected
        local startingArea = navmesh.GetNearestNavArea( homeless_FirstPly():GetPos(), false, 20000, false, true, -2 )
        local areasConnectedToSpawn = {}
        local visited = {}
        local queue = { startingArea }
        local count = 0

        -- build a table of first player's navmesh group
        while #queue > 0 do
            count = count + 1
            yieldIfWeCan()
            local currentNavArea = table.remove( queue, 1 )
            if not IsValid( currentNavArea ) then break end

            for _, connectedNavArea in ipairs( currentNavArea:GetAdjacentAreas() ) do
                if visited[connectedNavArea] then continue end

                local connectedBothWays = connectedNavArea:IsConnected( currentNavArea ) and currentNavArea:IsConnected( connectedNavArea )
                if not connectedBothWays then continue end

                -- mark the connected navarea as visited
                visited[connectedNavArea] = true
                -- add the connected navarea to the queue to be processed
                table.insert( queue, connectedNavArea )

                -- add the connected navarea to the group
                areasConnectedToSpawn[ connectedNavArea ] = true

            end
        end

        if count < ( #allAreas / 4 ) then
            debugPrint( "first player is not inside a big group" )
            ignoreConnected = true

        else
            debugPrint( "first player IN big group" )

        end

        for _, area in ipairs( allAreas ) do
            if not IsValid( area ) then debugPrint( "outdated1" ) yieldIfWeCan( "outdatedInfo" ) return end
            if areaHasSlope( area ) then continue end -- be flat pls
            yieldIfWeCan()
            local sizeX = area:GetSizeX()
            local sizeY = area:GetSizeY()

            local areasArea = sizeX * sizeY
            surfaceArea = surfaceArea + areasArea

            allAreasAverageZ = allAreasAverageZ + area:GetCenter().z

            if sizeX > defaultSize and sizeY > defaultSize and sizeX < 1000 and sizeY < 1000 and ( ignoreConnected or areasConnectedToSpawn[ area ] ) and not area:IsUnderwater() and not area:HasAttributes( NAV_MESH_CROUCH ) then
                table.insert( goodShelterAreas, area )
                goodShelterAreaIndexes[area] = true

            end
        end

        debugPrint( "found all ok areas, now ranking" )

        allAreasAverageZ = allAreasAverageZ / #allAreas

        local overlookingSpots = {}

        for _, area in ipairs( allAreas ) do
            if not IsValid( area ) then debugPrint( "outdated1a" ) yieldIfWeCan( "outdatedInfo" ) return end
            yieldIfWeCan()

            local center = areaMeta.GetCenter( area )

            if center.z < allAreasAverageZ then continue end -- too far down, not an overlook
            if areaHasSlope( area ) then continue end -- be flat pls

            local currSpots = {}
            table.Add( currSpots, areaMeta.GetHidingSpots( area, 2 ) ) -- good sniping
            table.Add( currSpots, areaMeta.GetHidingSpots( area, 4 ) ) -- perfect sniping
            table.Add( currSpots, areaMeta.GetHidingSpots( area, 8 ) ) -- exposed

            if #currSpots <= 0 then continue end

            local surfaceAreaAdjacent = 0
            for _, adjArea in ipairs( areaMeta.GetAdjacentAreas( area ) ) do
                local currsSurfaceArea = areaMeta.GetSizeX( adjArea ) * areaMeta.GetSizeY( adjArea)
                surfaceAreaAdjacent = surfaceAreaAdjacent + currsSurfaceArea

            end

            if surfaceAreaAdjacent <= 10000 then continue end -- not a large platform/space up here

            for _, spot in ipairs( currSpots ) do
                yieldIfWeCan()
                local score1 = GetNookScore( spot + vecUpOff, 5000, overlookNookOffsets )
                local score2 = GetNookScore( spot + vecUpOff * 2, 5000, overlookNookOffsets )
                local score = score1 + score2
                score = score / 2
                score = math.Round( score, 2 )

                if score <= 6 then
                    local data = {
                        pos = spot,
                        score = score,
                        area = area,
                    }
                    table.insert( overlookingSpots, data )

                end
            end
        end

        if #overlookingSpots >= 0 then
            local smallestScore = math.huge

            for _, spotDat in ipairs( overlookingSpots ) do
                if spotDat.score <= smallestScore then
                    smallestScore = spotDat.score

                end
            end
            terminator_Extras.homeless_Overlooks = {}
            for _, spotDat in ipairs( overlookingSpots ) do
                if spotDat.score <= smallestScore + 0.5 then
                    table.insert( terminator_Extras.homeless_Overlooks, spotDat )

                end
            end

            if #terminator_Extras.homeless_Overlooks >= math.random( 1, dedication ) then
                include( "homeless_shelter/overlooking.lua" )
                homeless_DoOverlooking( dedication )

            end
        end
    end

    debugPrint( "clipping interrupting areas" )

    local greatAreas = {}
    for _, area in ipairs( goodShelterAreas ) do
        if not IsValid( area ) then debugPrint( "outdated2" ) yieldIfWeCan( "outdatedInfo" ) return end
        yieldIfWeCan()
        local areasCenter = area:GetCenter()
        local bad = areaIsInterruptingSomeone( area, areasCenter, inCoroutine )

        if not bad then
            table.insert( greatAreas, area )

        end
    end

    debugPrint( "checking score of all great areas" )

    local scoredWell = {}
    for _, area in ipairs( greatAreas ) do
        if not IsValid( area ) then debugPrint( "outdated3" ) yieldIfWeCan( "outdatedInfo" ) return end
        local score = getAreasShelterScore( area )

        if score > 3.5 then
            scoredWell[score] = area
            if debugging() then
                debugoverlay.Text( area:GetCenter(), tostring( math.Round( score ) ), 10, false )

            end
        end
    end

    if table.Count( scoredWell ) <= 0 then
        debugPrint( "no good spots to spawn, waiting. ( too many players? )" )
        fullMapWaitTime = fullMapWaitTime * 1.2
        yieldIfWeCan( "doneWait", fullMapWaitTime )
        return

    end

    debugPrint( "picking shelters!" )

    local chosenShelter
    local best, ind
    for _ = 1, 50 do
        yieldIfWeCan()
        best, ind = table.Random( scoredWell )

        if not IsValid( best ) then debugPrint( "outdated4" ) yieldIfWeCan( "outdatedInfo" ) return end
        scoredWell[ind] = nil

        spawned, wasCenterpiece, chosenShelter = homeless_SpawnShelterAt( best )
        if spawned then break end

    end

    if not IsValid( best ) or not spawned then debugPrint( "couldntspawn" ) yieldIfWeCan( "done" ) return end

    yieldIfWeCan( "wait", 0.15 ) -- let the shelter timer.simples do their thing, wont properly find sleepers otherwise

    if #spawned > 2 or wasCenterpiece then
        local complexity = math.random( 2, 4 )
        local maxLoops = 6
        if wasCenterpiece then
            local boost = centerpieceBudgetBoosts[ dedication ] or 0
            complexity = math.random( 15, 20 ) + #spawned + boost
            maxLoops = 48 + #spawned + boost

        end
        recursiveSpawned = recursiveSpawnShelters( best, complexity, { maxloop = maxLoops, centerpiecefollower = wasCenterpiece } )
        debugPrint( "spawned a shelter with ", #spawned .. " furniture and " .. #recursiveSpawned .. " followers" )
        sheltersSpawned = sheltersSpawned + 1 + #recursiveSpawned

    else
        debugPrint( "spawned a shelter with ", #spawned .. " furniture." )
        sheltersSpawned = sheltersSpawned + 1

    end

    if #spawned <= 0 then
        debugPrintTable( chosenShelter )

    end

    minCount = minCounts[ dedication ] or 0
    if late then
        minCount = minCount + 4

    end

    aboveCount = sheltersSpawned >= minCount

    findPotentials()
    if IsValid( homeless ) then
        if not homeless.homeless_BurnedAReadyness and earned > 0 then
            homeless.homeless_BurnedAReadyness = true
            earned = first:GetInfoNum( "cl_nav_readyness", 0 )
            first:ConCommand( "cl_nav_readyness " .. math.Clamp( earned - 1, 0, math.huge ) )
            debugPrint( "burned readyness on new homeless" )

        end

        if not aboveCount then
            debugPrint( "someone is awake, late" )

        else
            debugPrint( "stopping late, someone is awake" )
            yieldIfWeCan( "noMorePlease" )
            return

        end
    end
    if #potentials >= 1 then
        makeRestless( potentials )
        if not aboveCount then
            debugPrint( "successfully spawned a sleeper" )

        else
            debugPrint( "stopping late, successfully spawned a sleeper" )
            yieldIfWeCan( "noMorePlease" )
            return

        end
    end

    local proceedChance = 25
    if comfyMap then
        proceedChance = 95

    end

    if isDay and math.random( 1, 100 ) > proceedChance then
        if debugging() then
            debugPrint( "dayStop" )

        else
            debugPrint( "stopping early, is daytime" )
            yieldIfWeCan( "noMorePlease" )
            return

        end
    end

    local quota = quotas[ dedication ] or math.huge
    if #spawned <= 1 and not spawnedOne then
        spawnedOne = true
        quota = quota * 0.15

    end
    if late then
        quota = quota * 0.9

    end

    local bigShelterNeeded = bigShelters[ dedication ] or 12
    if #recursiveSpawned > bigShelterNeeded and aboveCount then
        debugPrint( "stopping, spawned a big shelter" )
        yieldIfWeCan( "noMorePlease" )
        return

    end

    local rand = math.random( 1, surfaceArea )

    -- avg 3 shelters on bigcity
    if rand < quota and aboveCount then
        debugPrint( "randomly stopping", rand, quota )
        yieldIfWeCan( "noMorePlease" )
        return

    end

    debugPrint( "spawning another shelter..." )
    yieldIfWeCan( "done" )

end

local thread
local doneThread
local nextThink = 0

local function reset()
    potentials = {}
    allAreasAverageZ = nil
    surfaceArea = 0
    goodShelterAreas = nil
    goodShelterAreaIndexes = nil

    thread = nil
    forceAwake = nil
    forceSleeper = nil
    ignoreNextWake = nil
    nextThink = 0

end

function homeless_DoItButPerf( complexity )
    if not terminator_Extras.homeless_Loaded then return end
    -- busy!
    if thread then return end

    reset()
    doneThread = nil
    maxComplexityThisPass = complexity or math.huge
    if terminator_Extras.empty then
        maxComplexityThisPass = math.huge

    end

    debugPrint( "starting with complexity", maxComplexityThisPass )
    timer.Create( peepTimer, 45, 0, peep )

    hook.Run( "homeless_begindoingit" )

    hook.Remove( "Think", "homelesshelter_establish" )
    hook.Add( "Think", "homelesshelter_establish", function()
        if doneThread then hook.Remove( "Think", "homelesshelter_establish" ) return end
        if nextThink > CurTime() then return end

        if not thread or coroutine.status( thread ) == "dead" then
            thread = coroutine.create( doThing )

        end
        if thread then
            local oldTime = SysTime()
            while math.abs( oldTime - SysTime() ) < 0.0005 do
                inCoroutine = true
                local noErrors, result, result2 = coroutine.resume( thread )
                inCoroutine = nil
                if noErrors == false then -- errored
                    thread = nil
                    if debugging() then
                        ErrorNoHaltWithStack( result )

                    end
                    break

                elseif result == "done" then -- this one returned early, resume next think
                    thread = nil
                    break

                elseif result == "noMorePlease" then -- all finished, no more attempts
                    thread = nil
                    doneThread = true
                    hook.Remove( "Think", "homelesshelter_establish" )
                    hook.Run( "homeless_nomoreplease" )
                    break

                elseif result == "outdatedInfo" then -- outdated, navmesh was modified, map cleaned up, etc. rebuild cached data pls
                    thread = nil
                    goodShelterAreaIndexes = nil
                    goodShelterAreas = nil
                    underSkyCache = {}
                    break

                elseif result == "doneWait" then
                    thread = nil
                    nextThink = CurTime() + ( result2 or 1 )
                    break

                elseif result == "wait" then
                    nextThink = CurTime() + ( result2 or 1 )
                    break

                end
            end
        end
    end )
end


local function doItNotFirst()
    local complexity = math.random( 3, 5 )

    local first = homeless_FirstPly()
    if IsValid( first ) then
        complexity = complexity + first:GetInfoNum( "cl_homeless_dedication", 0 )

    end
    homeless_DoItButPerf( complexity )

end

hook.Add( "InitPostEntity", "sv_homeless_shelter", function()
    posIsInterrupting = terminator_Extras.posIsInterrupting
    areaIsInterruptingSomeone = terminator_Extras.areaIsInterruptingSomeone
    GetNookScore = terminator_Extras.GetNookScore
    terminator_Extras.homeless_Loaded = true

    if thread then return end
    timer.Simple( 0.25, function() homeless_DoItButPerf( math.huge ) end )

end )

hook.Add( "PostCleanupMap", "sv_homeless_shelter", function()
    terminator_Extras.homeless_DoingStealing = nil
    terminator_Extras.homeless_ScoredShelters = {}
    terminator_Extras.homeless_ExistingShelters = {}
    sheltersSpawned = 0
    spawnedOne = nil
    if thread then return end
    timer.Simple( 5, function()
        doItNotFirst()

    end )
end )

local laterName = "homeless_buildupcrust"
hook.Add( "homeless_nomoreplease", "retrylater", function()
    terminator_Extras.homeless_RetryLater()

end )
function terminator_Extras.homeless_RetryLater()
    if homeless_IsHomelessActive() then return end
    if surfaceArea < defQuota * 0.5 then return end -- map is too small
    local validFurnitureCount = 0
    for _, shelter in pairs( terminator_Extras.homeless_ExistingShelters ) do
        for _, furniture in ipairs( shelter ) do
            if IsValid( furniture ) and IsValid( furniture:GetPhysicsObject() ) and furniture:IsSolid() then
                validFurnitureCount = validFurnitureCount + 1

            end
        end
    end

    if validFurnitureCount > 100 then return end -- dont crash server pls

    local hour = 3600
    local time
    if game.IsDedicated() then
        time = hour

    else
        time = hour / 2

    end

    time = time + validFurnitureCount * 25

    timer.Create( laterName, time, 1, function()
        if player.GetCount() <= 0 then return end -- empt,
        if homeless_IsHomelessActive() then return end
        local playerness = homeless_GetFirstPlayerness()
        if not playerness or playerness < 2 then
            local osTime = os.time()
            local isDay = getTimeIsDay( osTime )
            if isDay then
                return -- if playerness is boring and its day, no extra

            end
        end
        doItNotFirst()

    end )
end

hook.Add( "PostCleanupMap", "homeless_cancelretrylater", function()
    timer.Remove( laterName )

end )

hook.Add( "homeless_begindoingit", "homeless_cancelretrylater", function()
    timer.Remove( laterName )

end )

homeless_DoItButPerf( math.huge )


if game.IsDedicated() or debugging() then
    local easyModeVar = CreateConVar( "sv_homeless_easymode", "0", { FCVAR_ARCHIVE }, "disables all permadeath" )
    local function doEasyMode()
        terminator_Extras.homeless_EasyMode = easyModeVar:GetBool()

    end
    cvars.AddChangeCallback( "sv_homeless_easymode", function( _, _, newValue )
        doEasyMode()
        MsgN( "homeless easymode set to ", newValue )

    end, "homeless_easymode" )
    doEasyMode()

    concommand.Add( "homeless_debugdump", function()
        if game.IsDedicated() and IsValid( caller ) then return end
        print( "thehomeless", homeless, terminator_Extras.homeless )
        if IsValid( terminator_Extras.homeless ) then
            print( "waker", terminator_Extras.homeless.homeless_Waker )
            print( "enem", homeless:GetEnemy() )
            print( "waiting", terminator_Extras.homeless.homeless_Waiting )
            print( "frust", terminator_Extras.homeless.HomelessFrustration )
            print( "frustReason", terminator_Extras.homeless.homeless_LastFrustNudgeReason )
            print( "toAng", terminator_Extras.homeless.HomelessFrustrationToAnger )
            print( "hide", terminator_Extras.homeless.TryingToBeHidden )
            print( "yoinkCount", terminator_Extras.homeless.homeless_YoinkCount )

        end
        local firstPly = homeless_FirstPly()
        if firstPly then
            print( "firstply is real" )
            print( firstPly )
            print( "playerness", homeless_GetFirstPlayerness( firstPly ) )
            print( "next", os.time(), firstPly:GetInfoNum( "cl_homeless_nexthomeless", 0 ) )
            print( "banis", os.time(), firstPly:GetInfoNum( "cl_homeless_banishment", 0 ) )
            print( "dedi", firstPly:GetInfoNum( "cl_homeless_dedication", 0 ) )
            print( "note", homeless_NoteDetail( firstPly ) )
            print( "disp", homeless_GetRelation( firstPly ) )
            print( "ready", firstPly:GetInfoNum( "cl_nav_readyness", 0 ) )

        else
            print( "no firstply" )

        end
    end, nil, "for charity" )
end

if not debugging() then return end

concommand.Add( "homeless_testrealhomeless", function( ply )
    local newHomeless = ents.Create( "terminator_nextbot_homeless" )
    identifyAsHomeless( newHomeless, ply, true )

    if not IsValid( newHomeless ) then return end

    local aimAtPos = ply:GetEyeTrace().HitPos
    newHomeless:SetPos( aimAtPos )
    newHomeless:Spawn()

    debugPrint( newHomeless )

end )

concommand.Add( "homeless_testshelter", function( ply, _cmd, args )
    local best = terminator_Extras.getNearestNav( ply:GetEyeTrace().HitPos )
    local spawned, wasCenterpiece = homeless_SpawnShelterAt( best, math.huge, { modelFilter = args[1] } )
    if not spawned then return end

    if #spawned > 2 or wasCenterpiece then
        local complexity = math.random( 2, 4 )
        local maxLoops = 6
        if wasCenterpiece then
            complexity = math.random( 15, 20 ) + #spawned
            maxLoops = 48 + #spawned

        end
        recursiveSpawnShelters( best, complexity, { maxloop = maxLoops, centerpiecefollower = wasCenterpiece, debugging = true } )
    end

    for _, new in ipairs( spawned ) do
        debugPrint( new, new:GetClass(), new:GetModel() )

    end
end )

concommand.Add( "homeless_testdecalshelter", function( ply )
    local best = terminator_Extras.getNearestNav( ply:GetEyeTrace().HitPos )
    local spawned = homeless_SpawnShelterAt( best, 2, { pickMask = terminator_Extras.decalShelterIndexes } )
    if not spawned then return end

    for _, new in ipairs( spawned ) do
        debugPrint( new, new:GetClass(), new:GetModel() )

    end
end )

local solidExceptions = {
    homeless_deadseagullking = true,
}

concommand.Add( "homeless_import", function( ply, _, args )
    local area = terminator_Extras.getNearestNav( ply:GetEyeTrace().HitPos )
    local areasCenter = area:GetCenter()
    local maxSize = math.max( area:GetSizeX(), area:GetSizeY() )
    local toPrint = {}
    for _, ent in ipairs( ents.FindInSphere( areasCenter, math.min( maxSize, 75 ) ) ) do
        local closestToCenter = ent:NearestPoint( areasCenter ) + vecUpOff
        if util.IsInWorld( closestToCenter ) and ( ent:IsSolid() or ( ent.GetClass and solidExceptions[ ent:GetClass() ] ) ) and area:Contains( closestToCenter ) then

            local closestPointsArea = navmesh.GetNearestNavArea( closestToCenter, true, 3000, true, true, -2 )
            if IsValid( closestPointsArea ) and closestPointsArea == area then
                table.insert( toPrint, ent )

            end
        end
    end
    local doLocals = true
    local getFrozen
    if #toPrint <= 1 then
        doLocals = nil

    end
    if args and #args > 0 then
        doLocals = true
        getFrozen = true

    end

    local areasMinSize = math.min( area:GetSizeX(), area:GetSizeY() )

    debugPrint( "{" )

    debugPrint( "    dedication = ," )

    if maxSize > defaultSize then
        debugPrint( "    minsize = " .. areasMinSize .. "," )

    end

    debugPrint( "    furniture = {" )

    bumpedCount = 0

    for _, ent in ipairs( toPrint ) do
        local doBump = true
        str = "        { mdl = \"" .. ent:GetModel() .. "\""
        if not string.find( ent:GetClass(), defaultClass ) then
            str = str .. ", class = \"" .. ent:GetClass() .. "\""

        end
        if getFrozen and IsValid( ent:GetPhysicsObject() ) and not ent:GetPhysicsObject():IsMotionEnabled() then
            doBump = nil
            str = str .. ", frozen = true"

        end
        if ent:GetSkin() ~= 0 then
            str = str .. ", skin = " .. ent:GetSkin()

        end
        if ent:GetMaterial() ~= "" then
            local matStr = ent:GetMaterial()
            if matStr == "models/props_wasteland/wood_fence01a" then
                str = str .. ", wallsnap = true"
                matStr = "wasteFenceMat"

            end
            str = str .. ", mat = " .. matStr

        end
        if doLocals then
            local localPos, localAng = WorldToLocal( ent:GetPos(), ent:GetAngles(), areasCenter, Angle( 0, 0, 0 ) )
            if doBump then
                localPos.z = localPos.z + bumpedCount / 10
                bumpedCount = bumpedCount + 1

            end
            str = str .. ", pos = Vector( " .. math.Round( localPos.x, 1 ) .. ", " .. math.Round( localPos.y, 1 ) .. ", " .. math.Round( localPos.z, 1 ) .. " )"
            str = str .. ", ang = Angle( " .. math.Round( localAng.p, 1 ) .. ", " .. math.Round( localAng.y, 1 ) .. ", " .. math.Round( localAng.r, 1 ) .. " )"

        end

        str = str .. " },"
        debugPrint( str )

    end

    debugPrint( "    }" )
    debugPrint( "}," )

end )
