
ENT.PhysgunDisabled = true
ENT.DefaultStepHeight = 18
ENT.StandingStepHeight = ENT.DefaultStepHeight * 1 -- used in crouch toggle in motionoverrides
ENT.CrouchingStepHeight = ENT.DefaultStepHeight * 0.9
ENT.StepHeight = ENT.StandingStepHeight
ENT.PathGoalToleranceFinal = 50
ENT.DoMetallicDamage = false
ENT.MetallicMoveSounds = false
ENT.SpawnHealth = 100000000
ENT.AimSpeed = 3000
ENT.WalkSpeed = 100
ENT.MoveSpeed = 400
ENT.RunSpeed = 800
ENT.AccelerationSpeed = 2000
ENT.DeathDropHeight = 200000
ENT.InformRadius = 0

ENT.isTerminatorHunterChummy = false
ENT.ReallyStrong = false
ENT.ReallyHeavy = false
ENT.TERM_FISTS = false

ENT.CanSwim = true
ENT.TakesFallDamage = false
ENT.homeless_Peeping = false

ENT.FootstepClomping = false
ENT.Term_FootstepMode = "human"
ENT.Term_FootstepTiming = "timed"

ENT.Models = { "models/player/corpse1.mdl" }

local decreaseInterval = 110
local hour = 3600

local scornedAnger = math.random( 15, 35 )
local baseAnger = math.random( 3, 4 )

function ENT:IsImmuneToDmg( dmg )
    local attacker = dmg:GetAttacker()
    local nextAnger = self.homeless_NextTakeDamageAnger or 0
    if nextAnger < CurTime() and IsValid( attacker ) and attacker:IsPlayer() then
        self.homeless_NextTakeDamageAnger = CurTime() + 1
        self:NudgeFrustration( self:GetFrustationAdded(), "damaged" )

    end
    return true

end

util.AddNetworkString( "homeless_seen_seen_seen" )

net.Receive( "homeless_seen_seen_seen", function()
    local seen = net.ReadEntity()
    if not IsValid( seen ) then return end
    if not seen.IsHomeless then return end
    seen.homeless_CraftySeen = true

end )

util.AddNetworkString( "homeless_seen" )

net.Receive( "homeless_seen", function( _, ply )
    local seen = net.ReadEntity()
    if not IsValid( seen ) then return end
    if not seen.IsHomeless then return end
    seen.homeless_OnSomeonesScreen = true

    if IsValid( seen.homeless_Waker ) and seen.homeless_Waker == ply then return end

    if seen:GetPos():Distance( ply:GetPos() ) > 750 then return end

    if seen.HomelessFrustration <= 2 then
        seen:OnIdentifyWaker( ply, "homeless_seen" )

    end
end )

local function nextHomeless( ply, seconds )
    local old = ply:GetInfoNum( "cl_homeless_nexthomeless", 0 )
    local nextTime = math.max( old, os.time() + seconds )
    ply:ConCommand( "cl_homeless_nexthomeless " .. tostring( nextTime ) )

end

function ENT:Use2( toUse )
    pcall( function() BaseClass.Use2( toUse ) end ) -- shhhh

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

local spokenSounds = {
    "ambient/creatures/town_scared_breathing1.wav",
    "ambient/creatures/town_scared_breathing2.wav",
    "ambient/levels/streetwar/building_rubble1.wav",
    "ambient/levels/streetwar/building_rubble2.wav",
    "ambient/levels/streetwar/building_rubble3.wav",
    "ambient/levels/streetwar/building_rubble4.wav",
    "ambient/creatures/flies1.wav",
    "ambient/creatures/flies2.wav",
    "ambient/creatures/flies3.wav",
    "ambient/creatures/flies4.wav",
    "ambient/creatures/flies5.wav",
    "ambient/voices/cough1.wav",
    "ambient/voices/cough2.wav",
    "ambient/voices/cough3.wav",
    "ambient/voices/cough4.wav",
    "ambient/water/wave1.wav",
    "ambient/water/wave2.wav",
    "ambient/water/wave3.wav",
    "ambient/water/wave4.wav",
    "ambient/water/wave5.wav",
    "ambient/water/wave6.wav",
    "ambient/materials/rock1.wav",
    "ambient/materials/rock2.wav",
    "ambient/materials/rock3.wav",
    "ambient/materials/rock4.wav",
    "ambient/materials/rock5.wav",
    "ambient/water/rain_drip1.wav",
    "ambient/water/rain_drip2.wav",
    "ambient/water/rain_drip3.wav",
    "ambient/water/rain_drip4.wav",
    "physics/cardboard/cardboard_cup_impact_hard1.wav",
    "physics/cardboard/cardboard_cup_impact_hard2.wav",
    "physics/cardboard/cardboard_cup_impact_hard3.wav",
    "doors/door1_stop.wav",
    "doors/door_wood_close1.wav",
    "doors/door_metal_medium_close1.wav",
    "doors/door_metal_thin_close2.wav",

}

local rareSpokenSounds = {
    "homeless/ambiance/amb1.mp3", -- below from gm_russia
    "homeless/ambiance/amb2.mp3",
    --"homeless/ambiance/beat_door_loud.mp3",
    "homeless/ambiance/breathe_scared1.mp3",
    --"homeless/ambiance/breathe_scared2.mp3",
    "homeless/ambiance/death_breath.mp3",
    "homeless/ambiance/metal1.mp3",
    "homeless/ambiance/metal2.mp3",
    "homeless/ambiance/metal3.mp3",
    "homeless/ambiance/metal4.mp3",
    "homeless/ambiance/metal5.mp3",
    "homeless/ambiance/metal6.mp3",
    "homeless/ambiance/metal7.mp3",
    "homeless/ambiance/metal8.mp3",
    "homeless/ambiance/metal9.mp3",
    "homeless/ambiance/metalhit_far1.mp3",
    "homeless/ambiance/metalhit_far2.mp3",
    "homeless/ambiance/metalhit_far3.mp3",
    "homeless/ambiance/metalhit_far4.mp3",
    "homeless/ambiance/metalhit_far5.mp3",
    "homeless/ambiance/metalhit_far6.mp3",
    "homeless/ambiance/metalhit_far7.mp3",
    "homeless/ambiance/metalhit_far8.mp3",
    "homeless/ambiance/metalhit_far10.mp3",
    "homeless/ambiance/scream_far1.mp3",
    "homeless/ambiance/scream_far2.mp3",
    "homeless/ambiance/scream_far3.mp3",
    "homeless/ambiance/talking.mp3",
    --"homeless/ambiance/underground_scream.mp3",
    "homeless/ambiance/thumping_1.mp3",
    "homeless/ambiance/thumping_2.mp3",
    "homeless/ambiance/thumping_3.mp3",
    "homeless/ambiance/thumping_4.mp3",
    "homeless/ambiance/thumping_5.mp3",
    "homeless/ambiance/thumping_6.mp3",
}

function ENT:GetFrustationAdded()
    local added = 1
    if self:GetModel() == "models/player/charple.mdl" then
        added = 2

    end
    return added

end

-- TODO, move GetFrustrationAdded muls into this nudger? maybe not
function ENT:NudgeFrustration( nudge, reason )
    local old = self.HomelessFrustration or 0
    local new = math.Round( old + nudge, 2 )
    self.HomelessFrustration = new

    if old == new then return end
    if new > old + 1 then
        self.homeless_NextHiddenDecrease = math.max( self.homeless_NextHiddenDecrease, CurTime() + decreaseInterval * 0.25 )
        self.homeless_NextHiddenDecrease = CurTime() + decreaseInterval

    end
    if reason then
        reason = "- " .. reason
        self.homeless_LastFrustNudgeReason = reason

    end
    debugPrint( "nudgeFrust" .. reason, old, new )

end

function ENT:SetFrustration( new )
    self.HomelessFrustration = new
    debugPrint( "setFrust", new )

end

function ENT:DoSpeaking( speakChance )
    local enemy = self:GetEnemy()
    if not ( IsValid( enemy ) and enemy:IsPlayer() ) then return end

    local defaultSpeakChance = 100

    local wasWitnessed = self.homeless_WasWitnessed
    if wasWitnessed and wasWitnessed[enemy] and self.HomelessFrustration <= self.HomelessFrustrationToAnger then
        defaultSpeakChance = 10
        baitOut = math.random( 1, 100 ) < 10

    elseif self.HomelessFrustration > self.HomelessFrustrationToAnger then
        defaultSpeakChance = 100
        baitOut = math.random( 1, 100 ) < 50

    end

    if not speakChance then
        speakChance = defaultSpeakChance

    end

    if math.random( 1, 100 ) < speakChance then
        local filterOnlyEnemy = RecipientFilter()
        filterOnlyEnemy:AddPlayer( enemy )

        local line
        if math.random( 0, 100 ) < 99 then
            line = spokenSounds[ math.random( 1, #spokenSounds ) ]

        else
            line = rareSpokenSounds[ math.random( 1, #rareSpokenSounds ) ]

        end

        if baitOut then
            local rand = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 )
            local pos = enemy:GetPos()
            pos = pos + rand * math.random( 500, 2000 )
            sound.Play( line, pos, 80, math.random( 95, 100 ) )
        else
            self:EmitSound( line, 80, math.random( 95, 100 ), 0.15, CHAN_STATIC, 0, 0, filterOnlyEnemy )

        end
    else
        local oldMessage = enemy:GetInfoNum( "cl_homeless_nextmessage", 0 )
        local currTimeReal = os.time()

        if oldMessage > currTimeReal then
            local bite = hour * math.random( 4, 48 )
            local bitten = oldMessage - bite
            bitten = math.Round( bitten )
            enemy:ConCommand( "cl_homeless_nextmessage " .. tostring( bitten ) )

        else
            if not IsValid( enemy ) then return end
            net.Start( "homeless_misc_ambiance" )
            net.Send( enemy )

        end
    end
end

-- copied the original function
function ENT:AdditionalFootstep()
    if not self:IsSolid() then return true end -- block footsteps
end

function ENT:DoHardcodedRelations()
    self:SetClassRelationship( "player", D_HT,1 )
    self:SetClassRelationship( "npc_lambdaplayer", D_HT,1 )
    self:SetClassRelationship( "rpg_missile", D_NU )
    self:SetClassRelationship( "terminator_nextbot", D_HT, 1 )
    self:SetClassRelationship( "terminator_nextbot_slower", D_HT, 1 )

end

function ENT:GetDesiredEnemyRelationship( _myTbl, ent, _entsTbl, _isFirst )
    local disp = D_NU
    local theirdisp = D_NU
    local priority = 1

    if ent:GetClass() == self:GetClass() then
        disp = D_LI
        theirdisp = D_LI
    end

    if ent:IsPlayer() then
        disp = D_HT
        priority = 1000
    end

    return disp,priority,theirdisp
end

function ENT:GetAimVector()
    local dir = self:GetEyeAngles():Forward()

    if self:HasWeapon() then
        local deg = 0.01
        local active = self:GetActiveLuaWeapon()
        if isfunction( active.GetNPCBulletSpread ) then
            deg = active:GetNPCBulletSpread( self:GetCurrentWeaponProficiency() )
            deg = math.sin( math.rad( deg ) )
        end

        dir:Add( Vector( math.Rand( -deg, deg ), math.Rand( -deg, deg ), math.Rand( -deg, deg )))
    end

    return dir
end

-- it's OUR furniture!
function ENT:ItsOurFurniture( furniture )
    if math.random( 1, 100 ) < 10 then
        self:BeCuriousAbout( furniture )

    end
end


function ENT:AdditionalUnderstand( substantialStuff )
    for _, thing in ipairs( substantialStuff ) do
        if thing.homeless_Furniture then
            self:ItsOurFurniture( thing )

        end
    end
end

local function flickerMaybeKill( ent )
    if not ent:GetOn() then return end

    ent:SetOn( not ent:GetOn() )
    local name = "homeless_flickerlights_" .. ent:GetCreationID()
    timer.Create( name, 0.01, math.random( 1, 6 ), function()
        timer.Adjust( name, math.Rand( 0.01, 0.25 ) )
        if not IsValid( ent ) then return end
        ent:SetOn( not ent:GetOn() )

        if timer.RepsLeft( name ) ~= 0 then return end
        if math.random( 0, 100 ) > 50 then return end

        ent:NetworkVarNotify( "On", function() end )

    end )

end

local function flickerMaybeKillToggle( ent )
    if ent.GetName and ent:GetName() and #ent:GetName() > 1 then return end -- map ent
    local count = 2 * math.random( 1, 2 )
    for ind = 1, count do
        ent:Fire( "Toggle", true, ind * math.Rand( 0.1, 0.25 ) )

    end
end

local function flickerMaybeKillLightToggle( ent )
    local count = 2 * math.random( 1, 2 )
    for ind = 1, count do
        ent:Fire( "LightToggle", true, ind * math.Rand( 0.25, 0.5 ) )

    end
end

local function radarJam( ent )
    if ent.Jammed then return end
    ent:TakeDamage( math.random( 5, 200 ), ent, ent )

end

local function jamPathfinder( ent, homeless )
    if not ent:IsWeapon() then return end -- generic ass classname
    if not PathfinderSystem then return end

    local owner = ent:GetOwner()
    if not IsValid( owner ) then return end
    local pathingBot = PathfinderSystem.PathingBots[owner:SteamID()]

    if not IsValid( pathingBot ) then return end
    if pathingBot.homeless_NoMoreTattling then return end

    local host = pathingBot:GetHost()

    if not IsValid( host ) then return end
    if homeless.HomelessFrustration > ( baseAnger + -1 ) then -- really fuck with em
        local allShelters = terminator_Extras.homeless_ExistingShelters
        if not allShelters then return end

        local randomFurniture
        local count = 0
        while not randomFurniture and count < 100 do
            count = count + 1
            local randomShelter = table.Random( allShelters )
            if not randomShelter then break end

            randomFurniture = randomShelter[math.random( 1, #randomShelter )]
            if IsValid( randomFurniture ) and IsValid( randomFurniture:GetPhysicsObject() ) then
                pathingBot:SetEnemy( randomFurniture )

            else
                randomFurniture = nil

            end
        end

    elseif math.random( 0, 100 ) > 75 then
        homeless_ResetShelterSpawnCount()
        homeless_DoItButPerf( math.random( 1, 3 ) )

    end

    local oldEnemy = pathingBot:GetEnemy()
    pathingBot:SetEnemy( host )

    pathingBot.homeless_NoMoreTattling = true
    timer.Simple( math.Rand( 0, homeless.HomelessFrustration * 4 ), function()
        if not IsValid( pathingBot ) then return end
        pathingBot.homeless_NoMoreTattling = nil
        if not IsValid( oldEnemy ) then return end
        pathingBot:SetEnemy( oldEnemy )

    end )
end

local tattleables = {
    ["pathfinder"] = { defChance = 25, increaseChance = true, func = jamPathfinder },
    ["sent_ep2_radar_large"] = { defChance = 50, minFrust = 1, increaseChance = true, func = radarJam },
    ["sent_ep2_radar"] = { defChance = 50, minFrust = 1, increaseChance = true, func = radarJam },
    ["weapon_ep2_radar"] = { defChance = 50, minFrust = 1, increaseChance = true, func = function( ent )
        local old = ent:GetNWBool( "DrawDispl", false )
        if old == true then
            ent:SetNWBool( "DrawDispl", not old )
            ent:EmitSound( "ambient/energy/spark" .. math.random( 1, 6 ) .. ".wav", 65, 85 )

        end
    end },
    ["npc_citizen"] = { defChance = 25, func = function( ent, homeless )
        local homelessPos = homeless:GetPos()
        local entsPos = ent:GetPos()
        local frust = homeless.HomelessFrustration
        local snd
        if frust >= homeless.HomelessFrustrationToAnger or math.Rand( 0, 100 ) < 1 or entsPos:Distance( homelessPos ) < 450 then
            ent:AddEntityRelationship( homeless, D_FR, 1000 )
            snd = SOUND_DANGER

        else
            snd = SOUND_COMBAT

        end
        local sndPos = entsPos + terminator_Extras.dirToPos( entsPos, homelessPos ) * 300
        timer.Simple( math.Rand( 0.5, 1.5 ), function()
            if not IsValid( homeless ) then return end
            sound.EmitHint( snd, sndPos, 400, frust, homeless )

        end )
    end },
    ["homeless_radio"] = { defChance = 90, func = function( ent )
        ent:TakeDamageRandomizeSong()

    end },
    ["homeless_radio_bliss"] = { defChance = 90, func = function( ent )
        ent:TakeDamageRandomizeSong()

    end },
    ["homeless_camera"] = { defChance = 90, func = function( ent )
        ent:TakePhoto()

    end },
    ["gmod_lamp"] = { defChance = 90, func = flickerMaybeKill },
    ["gmod_light"] = { defChance = 90, func = flickerMaybeKill },

    ["light"] = { defChance = 35, func = flickerMaybeKillToggle },
    ["light_spot"] = { defChance = 35, func = flickerMaybeKillToggle },

    ["point_spotlight"] = { defChance = 35, func = flickerMaybeKillLightToggle },

}

local function tattle( homeless, pos, rad, ignoreChance )
    local homelessesPos = homeless:GetPos()
    local myFrust = homeless.HomelessFrustration

    local hintRand = math.random( 0, 150 )
    if hintRand < rad / 2 then
        sound.EmitHint( SOUND_COMBAT, pos, hintRand, 1, homeless )

    end

    for _, ent in ipairs( ents.FindInSphere( pos, rad ) ) do

        local tattleDat = tattleables[ ent:GetClass() ]
        if not tattleDat then continue end
        if tattleDat.minFrust and myFrust < tattleDat.minFrust then continue end

        local tattleFunc = tattleDat.func
        local defChance = tattleDat.defChance

        local entsChance = ent.homeless_entTattleChance or defChance
        local change

        if ent:IsPlayerHolding() or ent:IsWeapon() then
            change = -5

        else
            change = -1

        end

        if change and tattleDat.increaseChance then
            change = -change
            ent.homeless_entTattleChance = entsChance + change
            change = nil

        end

        if math.Rand( 0, 100 ) > entsChance and not ignoreChance then continue end

        local entsPos = ent:WorldSpaceCenter()
        local closeOrSee = homelessesPos:DistToSqr( entsPos ) < 1000^2 or terminator_Extras.PosCanSee( homeless:GetShootPos(), entsPos )
        if not closeOrSee then continue end

        tattleFunc( ent, homeless )

        if change then
            ent.homeless_entTattleChance = entsChance + change

        end

        -- only use 1 ent
        return
    end
end

function ENT:BeCuriousAbout( ent )
    local oldAttention = ent.homeless_plyAttention
    if not oldAttention then
        oldAttention = 0
        table.insert( self.EnemyAttentionTbl, ent )

    end
    local increase = 2
    if ent:IsPlayerHolding() then
        if ent.homeless_Furniture and not ent.homeless_WasDefensiveWith and ent:GetPos():DistToSqr( ent.homeless_Furniture_OriginalSpot ) > 50^2 then
            ent.homeless_WasDefensiveWith = true
            self:NudgeFrustration( self:GetFrustationAdded() / 2, "curiousAbout" )
            increase = 20

        else
            increase = 4

        end
    elseif tattleables[ ent:GetClass() ] then
        increase = 4

    end

    local newAttention = oldAttention + increase
    ent.homeless_plyAttention = newAttention
end

function ENT:GetEntToBeCuriousAbout()
    local enemy = self:GetEnemy()
    if not IsValid( enemy ) then return end
    if not enemy.GetEyeTrace then return end

    local enemysShootPos = self:EntShootPos( enemy )
    local enemysWatchedEnt = enemy and enemy:GetEyeTrace().Entity or nil
    local attTbl = self.EnemyAttentionTbl
    local unWatchedStuff = {}
    local bestEnt
    local bestAttention = 0

    for ind, ent in ipairs( attTbl ) do
        if not IsValid( ent ) then table.remove( attTbl, ind ) continue end
        if enemysWatchedEnt and ent == enemysWatchedEnt then continue end
        if terminator_Extras.PosCanSeeComplex( ent:WorldSpaceCenter(), enemysShootPos, nil, MASK_SOLID_BRUSHONLY ) then
            local foundAGoodOne = #unWatchedStuff > 10 and bestAttention > 100
            local justTooMany = ind > 150
            if foundAGoodOne or justTooMany then
                break

            end
            continue

        end
        table.insert( unWatchedStuff, ent )

        local attention = ent.homeless_plyAttention
        if attention > bestAttention then
            bestEnt = ent
            bestAttention = attention

        end
    end

    return bestEnt, bestAttention
end

function ENT:SetHidden( hidden )
    self:DrawShadow( not hidden )
    self:SetNotSolid( hidden )

    if hidden then
        self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
        self:SetSolidMask( MASK_NPCWORLDSTATIC )
        self:AddFlags( FL_NOTARGET )

    else
        if self.homeless_IsDecoy then
            SafeRemoveEntity( self )
            return

        end
        local enemy = self:GetEnemy()
        self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
        self:SetSolidMask( MASK_NPCSOLID )
        self:RemoveFlags( FL_NOTARGET )
        local frustratedABit = self.HomelessFrustration >= 1

        for _, ply in ipairs( player.GetAll() ) do
            local state
            if frustratedABit then
                state = true
                if ply == enemy then
                    state = false

                end
            else
                state = false

            end
            self:SetPreventTransmit( ply, state )

        end
        local myPos = self:GetPos()
        tattle( self, myPos, 1000 )
        if IsValid( enemy ) then
            tattle( self, enemy:GetPos(), 500 )

        end
    end
end

function ENT:MakeShy( shyScale, reason )
    shyScale = shyScale or 1
    self.TryingToBeHidden = math.Round( math.random( 2 * shyScale, 5 * shyScale ) )
    self.HomelessFrustration = 0

    debugPrint( "shy homeless with scale " ..  shyScale ..  ", resulting in hidden of " .. self.TryingToBeHidden .. ", reason " .. reason )

end

function ENT:MakeWait( shyScale, reason )
    shyScale = shyScale or 1
    self.homeless_Waiting = true
    self:MakeShy( shyScale, reason .. "-makeWait" )

    timer.Simple( math.random( 300, 1200 ), function() -- they never found us
        if not IsValid( self ) then return end
        if not homeless_FirstPlyLoaded() then return end
        if IsValid( self.homeless_Waker ) then return end

        self:OnIdentifyWaker( homeless_FirstPly(), "waitWaker", true )

        if not IsValid( self.homeless_Waker ) then self:MakeWait( shyScale ) return end -- ????? might happen

        self.homeless_Waiting = nil
        self:MakeShy( shyScale * 1.5, reason .. "-finishWait" )

        nextHomeless( self.homeless_Waker, hour * math.random( 12, 24 ) )

    end )
end

local killedCount = 0
local timeToUnshelter = 1
local killedRelation = -8
local homeless_leave
local lastKiller

function ENT:OnIdentifyWaker( waker, reason, firstWake )
    if not IsValid( waker ) then return end

    debugPrint( "onidentifywaker with reason", reason, "    is firstwake ", firstWake )

    self.homeless_Waker = waker
    self.homeless_HadWaker = true
    self:AddEntityRelationship( waker, D_HT, 2000 )

    if not self.homeless_DeservesToExist then return end
    if self.homeless_IsDecoy then return end

    local oldPos = nil

    local name = "homeless_persistence_" .. self:GetCreationID()
    timer.Create( name, 1, 0, function()
        if IsValid( self ) then
            homeless_ShelterForSaftey()
            oldPos = self:GetPos()
            return

        end

        timer.Simple( timeToUnshelter, function()
            if homeless_IsHomelessActive() then return end
            if homeless_leave then debugPrint( "sayonara" ) homeless_leave = nil return end -- bye :)

            local forcedWaker
            if IsValid( lastKiller ) and lastKiller:IsPlayer() then
                lastKiller.homeless_Murderer = true
                forcedWaker = lastKiller
                lastKiller = nil

            end

            local newHomeless = homeless_LeaveShelterForSaftey( forcedWaker )
            if not IsValid( newHomeless ) then return end -- :(

            if timeToUnshelter > 15 then
                newHomeless.homeless_IgnoreScornWisdom = true

            end
            if timeToUnshelter > 40 then
                newHomeless:SetNW2Bool( "homeless_hallofmirrorify", true )
                newHomeless:SetNW2Bool( "homeless_hallofmirrorify_glitchy", false )

            elseif timeToUnshelter > 20 then
                newHomeless:SetNW2Bool( "homeless_hallofmirrorify", true )
                newHomeless:SetNW2Bool( "homeless_hallofmirrorify_glitchy", true )

            end

            timeToUnshelter = timeToUnshelter * 2^1.15

            newHomeless:SetFrustration( newHomeless.HomelessFrustrationToAnger + 1 )

            homeless_NudgeRelation( newHomeless.homeless_Waker, killedRelation )
            homeless_Playerness( newHomeless.homeless_Waker, 2 )

            killedRelation = killedRelation * 0.5 -- diminishing returns

            killedCount = killedCount + 1
            if killedCount <= 1 then return end

            local relevantPly = forcedWaker or homeless_FirstPly()
            if homeless_NoteDetail( relevantPly ) < 2 then return end
            if homeless_GetRelation( relevantPly ) > 0 then return end

            local size = killedCount * 500
            local bounds = Vector( size, size, size )
            local nearbyNavs = navmesh.FindInBox( oldPos - bounds, oldPos + bounds )
            for _ = 0, killedCount do
                local pos
                local randnav = nearbyNavs[ math.random( 1, #nearbyNavs ) ]
                if not IsValid( randNav ) then continue end
                pos = randnav:GetCenter()

                local gull = ents.Create( "homeless_freegull" )
                gull.homeless_DeservesToExist = true
                gull:SetPos( pos )
                gull:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )
                gull:Spawn()
                gull:Takeoff()

            end
        end )
        timer.Remove( name ) -- timer is restarted when we leave our shelter

    end )

    local forThisGuy
    if waker.homeless_LeadOn then
        forThisGuy = scornedAnger
        self:SetNW2Bool( "homeless_hallofmirrorify", true )
        self:SetNW2Bool( "homeless_hallofmirrorify_glitchy", true )
        debugPrint( "lead-on waker with toAnger of ", forThisGuy )

    else
        forThisGuy = baseAnger + ( homeless_NoteDetail( waker ) * 0.25 ) + homeless_GetRelation( waker )
        forThisGuy = math.Clamp( forThisGuy, baseAnger, scornedAnger * 0.5 )
        forThisGuy = math.Round( forThisGuy, 2 )
        debugPrint( "waker with toAnger of ", forThisGuy )

    end
    self.HomelessFrustrationToAnger = forThisGuy

    if waker.homeless_Murderer then
        local oldFrustration = self.HomelessFrustration or 0
        self.HomelessFrustration = math.max( forThisGuy / 2, oldFrustration )

    end

    if not firstWake then return end

    homeless_NudgeRelation( waker, 1 )
    homeless_Playerness( waker, 1 )

end

hook.Add( "OnNPCKilled", "homeless_hatekillers", function( died, attacker ) -- extra hate

    if not died.IsHomeless then return end
    if not died.GetEnemy then return end -- nuh uh

    local enemy = died:GetEnemy()
    if not IsValid( enemy ) then return end
    if not enemy:IsPlayer() then return end

    lastKiller = attacker
    homeless_NudgeRelation( lastKiller, killedRelation )
    homeless_Playerness( lastKiller, 1 )

    killedRelation = killedRelation * 0.5 -- diminishing returns

end )

function ENT:AdditionalInitialize()
    self:AddFlags( FL_NOTARGET )
    self:SetHidden( true )

    self.HealthRegenInterval = 0.5
    self.HealthRegen = 50000

    self.DoNotDuplicate = true

    self.Term_FOV = 180
    self.AutoUpdateFOV = nil
    self.homeless_PlayerTrackedWhileInvis = 0
    self.homeless_FinalBailStage = 0

    self.EnemyAttentionTbl = {}
    self.HomelessFrustration = self.HomelessFrustration or 0
    self.TryingToBeHidden = self.TryingToBeHidden or 0
    self.HomelessFrustrationToAnger = self.HomelessFrustrationToAnger or baseAnger

    if self.homeless_IsDecoy then
        self.homeless_Peeping = true

    end

    if homeless_MakeUntouchable then homeless_MakeUntouchable( self ) end -- ??? error

    -- advanced existence doubting
    timer.Simple( 0, function()
        if not IsValid( self ) then return end
        if not terminator_Extras then SafeRemoveEntity( self ) return end
        if not self.homeless_DeservesToExist then
            if terminator_Extras and debugging() then
                self.homeless_DeservesToExist = true
                return

            end

            local pos = self:GetPos()

            SafeRemoveEntity( self )

            local nearestPly = nil
            local nearestDist = math.huge
            for _, ply in player.Iterator() do
                local dist = ply:GetPos():DistToSqr( pos )
                if dist < nearestDist then
                    nearestPly = ply
                    nearestDist = dist

                end
            end
            if IsValid( nearestPly ) then
                if not Homeless_ScornWisdom( nearestPly ) then
                    nearestPly.homeless_Murderer = true

                elseif not nearestPly.homeless_UndeservedLives or nearestPly.homeless_UndeservedLives < 4 then
                    local old = nearestPly.homeless_UndeservedLives or 0
                    nearestPly.homeless_UndeservedLives = old + 1
                    homeless_DoItButPerf( nearestPly:GetInfoNum( "cl_homeless_dedication", 0 ) * 2 )

                end
            end
        end
    end )
end

function ENT:AdditionalThink( myTbl )
    local nextDecrease = myTbl.homeless_NextHiddenDecrease
    if not nextDecrease then
        myTbl.homeless_NextHiddenDecrease = CurTime() + decreaseInterval
        return

    end

    local min = -1000
    if myTbl.HomelessFrustration > 1 then
        min = -500

    end
    if math.random( min, myTbl.HomelessFrustrationToAnger ) > myTbl.HomelessFrustration then
        tattle( self, self:GetPos(), myTbl.WalkSpeed * 2 )

    end

    self:SetHealth( self:GetMaxHealth() * math.Rand( 0.75, 1 ) )

    if self:IsOnFire() and math.random( 1, 100 ) < 15 then self:Extinguish() end

    if nextDecrease > CurTime() then return end

    local add = decreaseInterval
    local enemy = self:GetEnemy()
    if IsValid( enemy ) then
        local relation = homeless_GetRelation( enemy )
        local relationComponent = -relation * 5 -- when relation is negative, decrease slower, faster when positive
        add = add + relationComponent

    end
    myTbl.homeless_NextHiddenDecrease = CurTime() + add
    debugPrint( "decaying, next in ", add, " seconds" )

    for _, child in ipairs( self:GetChildren() ) do
        if child and IsValid( child ) then
            local owner = CPPI and child:CPPIGetOwner() or child:GetCreator()
            if IsValid( owner ) then
                owner:KillSilent()
                child:SetParent()
                return

            end
        end
    end

    if myTbl.HomelessFrustration >= myTbl.HomelessFrustrationToAnger then myTbl.TryingToBeHidden = 0 return end -- stop trying to be hidden

    if myTbl.HomelessFrustration > 0 then
        local nudge = math.Clamp( myTbl.HomelessFrustration - 0, 0, 1 )
        self:NudgeFrustration( -nudge, "decay" )

    else
        myTbl.HomelessFrustration = myTbl.HomelessFrustration + self:GetFrustationAdded()

    end

    if myTbl.TryingToBeHidden >= 0 then
        myTbl.TryingToBeHidden = math.Clamp( myTbl.TryingToBeHidden + -1, 0, math.huge )

    else
        myTbl.TryingToBeHidden = myTbl.TryingToBeHidden + 1

    end

    if myTbl.HomelessFrustration >= 1 then return end
    if myTbl.TryingToBeHidden < -2 or myTbl.TryingToBeHidden > 2 then return end

    if not IsValid( enemy ) then return end
    if not enemy:IsPlayer() then return end

    homeless_NudgeRelation( enemy, 0.15 )

end

local ignorePlayers = GetConVar( "ai_ignoreplayers" )
local cheats = GetConVar( "sv_cheats" )
local aiDisabled = GetConVar( "ai_disabled" )

function ENT:IgnoringPlayers()
    if cheats:GetBool() and ignorePlayers:GetBool() then return true end

end
function ENT:DisabledThinking()
    if cheats:GetBool() and aiDisabled:GetBool() then return true end

end

function ENT:DoCustomTasks( _ )
    self.TaskList = {
        ["shooting_handler"] = {
            StartsOnInitialize = true,
            OnStart = function( self, data )
            end,
            BehaveUpdatePriority = function( self, data, interval )
                local enemy = self:GetEnemy()
                if IsValid( enemy ) then
                    local tattleLook = enemy:IsPlayer() and self.homeless_LookAtEnemysTarget and ( CurTime() % 100 < 20 )
                    local eyeTr
                    if tattleLook then -- made this more restrictive, looked like a bug before
                        eyeTr = enemy:GetEyeTrace()
                        tattleLook = IsValid( eyeTr.Entity ) and istable( tattleables[eyeTr.Entity:GetClass()] )
                        self.OverrideCrouch = CurTime() + 0.25

                    end
                    if tattleLook then
                        self:shootAt( eyeTr.HitPos, true )

                    else
                        self:shootAt( self:EntShootPos( enemy ), true )
                    end
                end

            end,
            StartControlByPlayer = function( self, data, ply )
                self:TaskFail( "shooting_handler" )
            end,
        },
        ["enemy_handler"] = {
            StartsOnInitialize = true,
            OnStart = function( self, data )
                data.UpdateEnemies = CurTime()
                data.HasEnemy = false
                data.nextCheck = 0
                data.playerCheckIndex = 0
                data.blockSwitchingEnemies = 0
                self.IsSeeEnemy = false
                self.NothingOrBreakableBetweenEnemy = nil
                self.DistToEnemy = 0
                self:SetEnemy( NULL )
            end,
            BehaveUpdatePriority = function( self, data )
                local cur = CurTime()
                if data.nextCheck > cur then return end
                local myTbl = data.myTbl

                data.nextCheck = cur + 0.1
                myTbl.ForgetOldEnemies( self, myTbl )

                local prevenemy = self:GetEnemy()
                local newenemy = prevenemy

                if forceupdateenemies or ( not data.UpdateEnemies ) or ( CurTime() > data.UpdateEnemies ) or ( data.HasEnemy and not IsValid( prevenemy ) ) then
                    data.UpdateEnemies = CurTime() + 0.5

                    self:FindEnemies()

                    -- rotate through all players one by one
                    -- we check looong distance here so it's staggered.
                    if not self.homeless_Waiting then
                        local allPlayers = player.GetAll()
                        local pickedPlayer = IsValid( self.homeless_Waker ) and self.homeless_Waker or allPlayers[data.playerCheckIndex]

                        local tooLongSinceLastEnemy = ( self.LastEnemySpotTime + 20 ) < CurTime()
                        if tooLongSinceLastEnemy and homeless_FirstPlyLoaded() and math.random( 0, 100 ) < 75 then
                            pickedPlayer = homeless_FirstPly()

                        end

                        -- check if alive etc
                        -- MESSY but it's better than it going off to the right
                        if
                            IsValid( pickedPlayer ) and
                            (
                                ( self:ShouldBeEnemy( pickedPlayer ) and terminator_Extras.PosCanSee( self:GetShootPos(), self:EntShootPos( pickedPlayer ) ) ) or
                                tooLongSinceLastEnemy
                            )
                        then
                            self:UpdateEnemyMemory( pickedPlayer, pickedPlayer:GetPos() )

                        end

                        local new = data.playerCheckIndex + 1
                        if new > #allPlayers then
                            data.playerCheckIndex = 1

                        else
                            data.playerCheckIndex = new

                        end
                    end

                    local enemy = self:FindPriorityEnemy()

                    -- manage waker
                    local waker = self.homeless_Waker
                    if IsValid( waker ) then
                        if waker:IsFlagSet( FL_NOTARGET ) then -- crap waker
                            self.homeless_Waker = nil

                        end
                    elseif not self.homeless_Waiting and self.homeless_HadWaker then
                        debugPrint( "invalid waker, going into waiting" )
                        self.homeless_Waiting = true

                    end

                    -- only target players
                    if not enemy:IsPlayer() then
                        self:AddEntityRelationship( enemy, D_NU, 1 )
                        if enemy.AddEntityRelationship then
                            enemy:AddEntityRelationship( self, D_NU, 1 )

                        end

                    -- conditional friction for switching enemies.
                    -- fixes bot jumping between two enemies that get obscured as it paths, and doing a little dance
                    elseif
                        IsValid( enemy ) and
                        IsValid( prevenemy ) and
                        -- prevenemy:Health() > 0 and -- old enemy DOESNT need to be alive...
                        prevenemy ~= enemy and
                        ( data.blockSwitchingEnemies > 0 and enemy ~= self.homeless_Waker ) and -- friction, unless new enemy is our waker
                        self:GetPos():Distance( enemy:GetPos() ) > self.WalkSpeed -- enemy needs to be far away, otherwise just switch now

                    then -- friction activated, start wearing it down
                        data.blockSwitchingEnemies = data.blockSwitchingEnemies + -1
                        enemy = prevenemy

                    elseif IsValid( enemy ) then
                        if self.homeless_Waiting then
                            if enemy.homeless_Murderer or enemy == homeless_FirstPly() or homeless_GetPlayerness( enemy ) >= 0.15 or self.DistToEnemy < 400 then -- they found us
                                self:OnIdentifyWaker( enemy, "homeless_Waiting", true )
                                self.homeless_Waiting = nil
                                nextHomeless( self.homeless_Waker, hour * math.random( 12, 96 ) )

                            else
                                self:Term_SetEntityRelationship( enemy, D_NU, 0 )
                                timer.Simple( 60, function()
                                    self:Term_SetEntityRelationship( enemy, D_HT, 1 )

                                end )
                            end
                        elseif not IsValid( self.homeless_Waker ) then
                            self:OnIdentifyWaker( enemy, "homeless_invalidoldwaker", false )

                        end
                        newenemy = enemy
                        local enemysShoot = self:EntShootPos( enemy )
                        if not self.EnemyLastPos then self.EnemyLastPos = enemysShoot end

                        self.LastEnemySpotTime = CurTime()
                        self.DistToEnemy = self:GetPos():Distance( enemysShoot )
                        self.IsSeeEnemy = self:CanSeePosition( enemysShoot )
                        self.NothingOrBreakableBetweenEnemy = self:ClearOrBreakable( self:GetShootPos(), enemysShoot, true )
                        local hitGlassTr = {
                            start = self:GetShootPos(),
                            endpos = enemysShoot,
                            filter = { self },
                            mask = MASK_SOLID,
                        }

                        -- homeless specific
                        self.GlassBetweenEnemy = util.TraceLine( hitGlassTr ).MatType == MAT_GLASS

                        if self.IsSeeEnemy and not self.WasSeeEnemy then
                            hook.Run( "homeless_spotenemy", self, enemy )

                        elseif not self.IsSeeEnemy and self.WasSeeEnemy then
                            hook.Run( "homeless_loseenemy", self, enemy )

                        end

                        hook.Run( "terminator_enemythink", self, enemy ) -- work with the patcher!!!
                        hook.Run( "homeless_enemythink", self, enemy )

                        self.WasSeeEnemy = self.IsSeeEnemy

                    else
                        self.DistToEnemy = math.huge

                    end
                end

                if IsValid( newenemy ) then
                    if not data.HasEnemy then
                        self:RunTask( "EnemyFound", newenemy )

                    elseif prevenemy ~= newenemy then
                        data.blockSwitchingEnemies = math.random( 100, 200 )
                        self:RunTask( "EnemyChanged", newenemy, prevenemy )

                    end
                    data.HasEnemy = true

                    if self:CanSeePosition( newenemy ) then
                        self.LastEnemyShootPos = self:EntShootPos( newenemy )
                        self.AimAtEnemyShootPosTime = CurTime() + 10
                        self:UpdateEnemyMemory( newenemy, newenemy:GetPos() )

                    end
                else
                    if data.HasEnemy then
                        self:RunTask( "EnemyLost", prevenemy )

                    end
                    self:SetHidden( true )
                    data.HasEnemy = false
                    self.IsSeeEnemy = false

                end

                local stopShootingTime = self.AimAtEnemyShootPosTime or 0
                if stopShootingTime < CurTime() then
                    self.LastEnemyShootPos = nil

                end

                self:SetEnemy( newenemy )
            end,
            StartControlByPlayer = function( self, data, ply )
                self:TaskFail( "enemy_handler" )
            end,
        },
        ["movement_handler"] = {
            StartsOnInitialize = true,
            OnStart = function( self, data )
                self:TaskComplete( "movement_handler" )
                self:StartTask2( "movement_walkintolos", nil, "getem!" )

            end,
        },
        ["movement_walkintolos"] = {
            OnStart = function( self, data )
                data.nextPath = 0
                data.sincePerfect = 0
                data.seenCount = 0
                data.boredTime = 0
                data.startingDistance = 0
                data.seenAt = {}
                data.hiddenAt = {}
                data.discomfort = 0
                data.nextCuriousCheck = 0

                data.cornerCheckHull = Vector( 20, 20, 20 )
                data.biggerCornerCheckHull = Vector( 50, 50, 20 )

                local distToShootpos = self:GetPos():Distance( self:GetShootPos() )
                data.offsetToShootPos = Vector( 0, 0, distToShootpos )
                data.endToEnemyBlockedCount = 0

                data.Hide = function( data2, self2 )
                    local bearingToMe2 = self2:enemyBearingToMeAbs()
                    local pitchToMe = self2:enemyPitchToMeAbs()
                    if self.homeless_Peeping and bearingToMe2 < 40 and pitchToMe < 50 then
                        debugPrint( "bye1" )
                        homeless_leave = true
                        SafeRemoveEntity( self )
                        return

                    end
                    self2.homeless_CraftySeen = nil -- seen while hiding is not a real seen
                    data2.delayedHiding = nil
                    self2:SetHidden( true )
                    data2.seen = true
                    data2.seenCount = data2.seenCount + 1
                    local witnessed = self2.IsSeeEnemy and bearingToMe2 < 12 and pitchToMe < 20
                    local ignored = self2.IsSeeEnemy and ( bearingToMe2 > 45 or pitchToMe > 45 )
                    if witnessed then
                        local enemy = self2:GetEnemy()
                        self2.homeless_WasWitnessed = self2.homeless_WasWitnessed or {}
                        self2.homeless_WasWitnessed[enemy] = true
                        if IsValid( enemy ) and enemy:IsPlayer() then
                            local witnessedFrust = self2:GetFrustationAdded()
                            local witnessedShy
                            local relation = homeless_GetRelation( enemy )
                            if relation >= 1 then
                                witnessedFrust = witnessedFrust * 0.5
                                witnessedShy = witnessedFrust -- half shyness, half frust

                            end
                            self2:NudgeFrustration( witnessedFrust, "hideWitnessed" )
                            if witnessedShy then
                                self2.TryingToBeHidden = self2.TryingToBeHidden + witnessedShy

                            end
                            local old = enemy:GetInfoNum( "cl_homeless_dedication", 0 )
                            enemy:ConCommand( "cl_homeless_dedication " .. math.max( old, 1 ) )

                        end
                        timer.Simple( 0.5, function()
                            if not IsValid( self2 ) then return end
                            self2.overrideCrouch = CurTime()

                        end )
                    elseif ignored then
                        self2:NudgeFrustration( -0.15, "ignoredDecay" )

                    end
                end
                data.ResetProgress = function( data2, self2 )
                    self2:SetNW2Bool( "homeless_hallofmirrorify", false )
                    self2:SetNW2Bool( "homeless_hallofmirrorify_glitchy", false )

                    self2.homeless_FinalSeen = nil
                    self2.homeless_WasWitnessed = {}
                    self2.homeless_DoneWatchHitch = nil
                    self2.homeless_IgnoreScornWisdom = nil
                    self2.homeless_FinalBailStage = 0

                    local yoinks = self2.homeless_YoinkCount or 0
                    self2.HomelessFrustrationToAnger = baseAnger
                    if game.IsDedicated() then
                        local bite = yoinks^2
                        self2:SetFrustration( math.random( 1, baseAnger + -1 ) + -bite )
                        if yoinks >= 2 then
                            self2.TryingToBeHidden = self2.TryingToBeHidden + bite

                        end
                    end

                    self2.homeless_Waker = nil

                    -- reset all data. stuff
                    self2:TaskComplete( "movement_walkintolos" )
                    self2:StartTask2( "movement_walkintolos", nil, "scorned em" )

                end
            end,
            BehaveUpdateMotion = function( self, data )
                local enemy = self:GetEnemy()
                local validEnem = IsValid( enemy )
                if not validEnem then return end

                local enemysAimEnt = enemy:IsPlayer() and enemy:GetEyeTrace().Entity
                local enemysShootPos = self:EntShootPos( enemy ) or enemy:GetShootPos()
                local see = self.IsSeeEnemy and ( self.NothingOrBreakableBetweenEnemy or self.GlassBetweenEnemy )
                local enemyBearingToMeAbs = self:enemyBearingToMeAbs()
                local enemsCrouchShootPos = enemysShootPos + ( -data.offsetToShootPos / 2 )

                local endCanSeeEnemy
                local enemyIsLookingAtEnd
                local pathing = self:primaryPathIsValid()
                local iAmSolid = self:IsSolid()

                data.endCanSeeEnemy = nil

                if pathing and IsValid( enemy ) then
                    local pathEnd = self:GetPath():GetEnd()
                    endCanSeeEnemy = self:ClearOrBreakable( pathEnd + data.offsetToShootPos, enemysShootPos, true )
                    enemyIsLookingAtEnd = endCanSeeEnemy and math.abs( terminator_Extras.BearingToPos( enemysShootPos, enemy:GetAngles(), pathEnd, enemy:GetAngles() ) ) > 170

                    data.endCanSeeEnemy = endCanSeeEnemy
                    data.endToEnemyBlockedCount = data.endToEnemyBlockedCount + 1

                end
                if endCanSeeEnemy then
                    data.endToEnemyBlockedCount = 0

                end

                local bearingLookingAtMe = 40
                local maxDiscomfort = 10
                local boredTime = 60
                if self.DistToEnemy < 800 then
                    bearingLookingAtMe = bearingLookingAtMe + 10
                    maxDiscomfort = 1
                    boredTime = 5

                elseif self.DistToEnemy < 1800 then
                    maxDiscomfort = 5
                    boredTime = 15
                    bearingLookingAtMe = bearingLookingAtMe + 5

                end
                if self.GlassBetweenEnemy or self.DistToEnemy > 1800 then
                    bearingLookingAtMe = bearingLookingAtMe - 30

                end

                -- dont be obvious
                local frustration = self.HomelessFrustration or 0
                local hiddenState = self.TryingToBeHidden or 0
                local enemyDispShyness = 0

                if enemy:IsPlayer() and self.HomelessFrustration < self.HomelessFrustrationToAnger then
                    enemyDispShyness = homeless_GetRelation( enemy )
                    enemyDispShyness = math.Clamp( enemyDispShyness, -5, 10 )

                end

                local shyness = frustration + hiddenState + enemyDispShyness

                if shyness > 0 then
                    for _ = 1, shyness do
                        maxDiscomfort = maxDiscomfort * 0.95
                        bearingLookingAtMe = bearingLookingAtMe + 2

                    end
                end

                if self:GetNW2Bool( "homeless_hallofmirrorify", false ) then
                    bearingLookingAtMe = bearingLookingAtMe / 2
                    maxDiscomfort = maxDiscomfort * 2

                end

                local bearingSelectorAvoid = 180 - bearingLookingAtMe
                local bearingGenerallyInFront = 90

                if see then
                    if data.sincePerfect >= 20 then
                        data.sincePerfect = 0

                    end
                    if IsValid( enemysAimEnt ) then
                        self:BeCuriousAbout( enemysAimEnt )

                    end
                end

                local enemyIsntLooking = enemyBearingToMeAbs > bearingLookingAtMe
                local newHidden = data.wasHidden or not see or ( self.homeless_FinalSeen and enemyIsntLooking )
                if not data.wasHidden and newHidden then -- just became hidden here
                    local myNav = self:GetTrueCurrentNavArea()
                    if IsValid( myNav ) then
                        local oldSeen = data.hiddenAt[myNav:GetID()] or 0
                        data.hiddenAt[myNav:GetID()] = oldSeen + 1

                    end

                    data.DOPOSTER = true -- time to try a poster

                end
                if not self.homeless_IsDecoy and data.DOPOSTER and newHidden and not see then
                    local myNav = self:GetTrueCurrentNavArea()
                    if IsValid( myNav ) and ( myNav:GetSizeX() <= 110 or myNav:GetSizeY() <= 110 ) and not myNav:IsVisible( enemysShootPos ) then

                        data.DOPOSTER = nil -- good area, burn the doposter

                        -- our art
                        local nextPoster = self.homeless_NextPoster or 0
                        if nextPoster < CurTime() then -- intentionally burn the doposter if too soon
                            local posterInterval = self.homeless_PosterInterval or 10
                            self.homeless_NextPoster = CurTime() + posterInterval
                            self.homeless_PosterInterval = math.Round( posterInterval^1.25, 2 )

                            homeless_SpawnShelterAt( myNav, 4, { pickMask = terminator_Extras.decalShelterIndexes } )

                        end
                    end
                end
                data.wasHidden = newHidden

                if data.hiddenToggle == nil then
                    data.hiddenToggle = iAmSolid

                end

                local tooCloseSoft = 500
                local tooCloseHard = 300

                -- invis
                if data.hiddenToggle == true then

                    -- early bail
                    if data.delayedHiding and ( self.homeless_CraftySeen or enemysAimEnt == self ) and iAmSolid then
                        data:Hide( self )
                        return

                    end

                    local activeWep = enemy:GetActiveWeapon()
                    local invisBearing = 8
                    if IsValid( activeWep ) and tattleables[activeWep:GetClass()] then
                        invisBearing = invisBearing + 3

                    end

                    local snap = 3
                    local snappedYaw = enemy:GetAngles().yaw / snap
                    snappedYaw = math.Round( snappedYaw )
                    snappedYaw = snappedYaw * snap

                    local theyHaveNewYaw = not data.oldInvisTrackYaw or snappedYaw ~= data.oldInvisTrackYaw
                    data.oldInvisTrackYaw = snappedYaw

                    -- handle trackers
                    local theySeeUsWhenInvis = theyHaveNewYaw and enemyBearingToMeAbs < invisBearing

                    if theySeeUsWhenInvis then
                        local add = 0.25
                        if pathing then
                            add = add + 0.5
                        end
                        if not self.IsSeeEnemy and self.homeless_PlayerTrackedWhileInvis > 50 and enemyBearingToMeAbs < 4 then -- def cheatin
                            add = add + 1
                        end
                        self.homeless_PlayerTrackedWhileInvis = self.homeless_PlayerTrackedWhileInvis + add

                    else
                        if enemyBearingToMeAbs > 35 then -- we lost em
                            self.homeless_PlayerTrackedWhileInvis = self.homeless_PlayerTrackedWhileInvis + -0.75

                        else
                            self.homeless_PlayerTrackedWhileInvis = self.homeless_PlayerTrackedWhileInvis + -0.1

                        end
                    end

                    local strangelyGoodAtTrackingUs = self.homeless_PlayerTrackedWhileInvis > math.random( 10, 100 )

                    if enemy:IsPlayer() and strangelyGoodAtTrackingUs then
                        local reallyGoodAtTracking = self.homeless_PlayerTrackedWhileInvis >= math.random( 75, 125 )
                        local superCheatSee = theySeeUsWhenInvis and reallyGoodAtTracking
                        local canDecoy = not IsValid( self.homeless_decoy ) and not self.homeless_Peeping and ( self:GetCreationID() % 10 ) < 7
                        if superCheatSee and canDecoy then -- mitosis
                            debugPrint( "mitosis" )
                            local decoy = ents.Create( "terminator_nextbot_homeless" )

                            if not IsValid( decoy ) then return end

                            self.homeless_decoy = decoy

                            decoy.homeless_DeservesToExist = true

                            decoy:SetIsDecoy( true )
                            decoy.homeless_IsDecoy = true

                            decoy:SetPos( self:GetPos() )
                            decoy:Spawn()
                            decoy:SetModel( self:GetModel() )

                            decoy:OnIdentifyWaker( enemy, "decoy" )

                            decoy:MakeShy( self.homeless_PlayerTrackedWhileInvis / 45, "decoy" )

                            self:NudgeFrustration( self:GetFrustationAdded() / 4, "tracked" )
                            homeless_NudgeRelation( enemy, -0.25 )
                            homeless_Playerness( enemy, 0.1 )

                            local oldNext = enemy:GetInfoNum( "cl_homeless_nextfollower", 0 )
                            local new = oldNext + -hour
                            enemy:ConCommand( "cl_homeless_nextfollower " .. math.Round( new ) )

                            tattle( self, self:GetPos(), 500 )
                            tattle( self, enemy:GetPos(), 500 )

                        elseif superCheatSee and self:GetCurrentSpeed() >= 50 then
                            debugPrint( "overtracked, just mad" )
                            self:NudgeFrustration( self:GetFrustationAdded(), "overtracked" )
                            tattle( self, enemy:GetPos(), math.random( 0, 100 ) * math.Rand( 0.5, 2 ) )

                        end

                        self:SetPreventTransmit( enemy, true )

                        timer.Simple( 5, function()
                            if not IsValid( self ) then return end
                            if not IsValid( enemy ) then return end
                            if self.IsSeeEnemy then return end
                            self:SetPreventTransmit( enemy, false )

                        end )
                    end

                    local nextPlayernessBump = self.homeless_NextPlayernessBump or 0
                    if theyHaveNewYaw and nextPlayernessBump < CurTime() then
                        self.homeless_NextPlayernessBump = CurTime() + decreaseInterval
                        homeless_Playerness( enemy, 0.1 )

                    end

                    -- curious setup
                    local goodCurious
                    if data.nextCuriousCheck < CurTime() and not see and not self.homeless_FinalSeen then
                        data.nextCuriousCheck = CurTime() + 5
                        local ent, entsScore = self:GetEntToBeCuriousAbout()
                        goodCurious = IsValid( ent ) and entsScore > math.random( 25, 50 )

                    end

                    local canMove = not iAmSolid

                    local tooClose = self.DistToEnemy < tooCloseHard
                    local standingStill = not pathing
                    local theyStaringBack = self.homeless_PlayerTrackedWhileInvis > 50 and standingStill
                    local walkingOverAndEndCantSee = pathing and data.endToEnemyBlockedCount > 10
                    local walkingOverAndEnemySeesEnd = pathing and data.endToEnemyBlockedCount <= 2 and enemyIsLookingAtEnd

                    local endVisibilityBad
                    if data.doingRunAway then
                        endVisibilityBad = false

                    elseif data.wasHidden then
                        endVisibilityBad = walkingOverAndEndCantSee or walkingOverAndEnemySeesEnd

                    else
                        endVisibilityBad = data.endCanSeeEnemy == true and enemyIsLookingAtEnd

                    end

                    local needsNewPath = standingStill or theyStaringBack or endVisibilityBad
                    local canDoNewPath = canMove and needsNewPath and data.nextPath < CurTime()

                    local passVelCheck = enemy:GetVelocity():Length() < math.random( 1, 200 )
                    local readyToReveal = passVelCheck and self:WaterLevel() <= 0 and self.loco:IsOnGround()

                    local canReveal = data.wasHidden and see and enemyIsntLooking and not tooClose and readyToReveal
                    --print( "can1", data.wasHidden, see, enemyIsntLooking, not tooClose, readyToReveal )

                    if self.homeless_FinalSeen or self.homeless_IgnoreScornWisdom then
                        canMove = true
                        canReveal = not tooClose and data.wasHidden and see and readyToReveal
                        --print( "can2", not tooClose, data.wasHidden, see, readyToReveal )

                    end

                    if canReveal then
                        self:InvalidatePath( "spotted enemy" )
                        timer.Simple( 0.5, function() -- reveal here with a delay so we actually stop moving
                            if not IsValid( self ) then return end
                            if not self.loco:IsOnGround() then return end
                            if data.hiddenToggle then return end
                            if self.DistToEnemy < tooCloseHard then data.hiddenToggle = true return end
                            self:SetHidden( false )

                            self:DoSpeaking()

                            self.homeless_LookAtEnemysTarget = nil
                            if self.HomelessFrustration >= 1 and self.HomelessFrustration <= 2 then
                                self.homeless_LookAtEnemysTarget = math.random( 1, 100 ) > 50

                            end

                        end )
                        data.hiddenToggle = false
                        data.startingDistance = self.DistToEnemy
                        data.boredTime = CurTime() + boredTime

                    elseif goodCurious then
                        self:TaskComplete( "movement_walkintolos" )
                        self:StartTask2( "movement_propcurious", nil, "enemy was focused on somethin" )

                    elseif canDoNewPath then
                        data.seen = nil
                        local scoreData = {}

                        scoreData.self = self
                        scoreData.enemysAng = enemy:GetAngles()
                        scoreData.myShootPos = self:GetShootPos()
                        scoreData.enemysShootPos = enemysShootPos
                        scoreData.enemysCrouchShootPos = enemsCrouchShootPos
                        scoreData.areaCenterOffset = data.offsetToShootPos
                        scoreData.startingShootPosZ = scoreData.myShootPos.z

                        local highSeenNotAngry = data.seenCount > 8 and self.HomelessFrustration <= math.random( 2, baseAnger + -1 )

                        data.doingRunAway = self.homeless_doingRunAway or self.homeless_PlayerTrackedWhileInvis > math.random( 100, 1000 ) or highSeenNotAngry
                        data.doingRunAway = data.doingRunAway and not self.homeless_FinalSeen and not self.homeless_IgnoreScornWisdom -- dont do this when we're wrapping up
                        scoreData.stayCloseToEnemy = true

                        local failAdd = data.sincePerfect * 250
                        local tooFar = math.max( self.DistToEnemy + 500, 1500 + failAdd )
                        local maxDist = 3500 + failAdd
                        local visibleWanted = false
                        local wasSomewhereWanted

                        if data.wasHidden then
                            visibleWanted = true

                        elseif data.doingRunAway then
                            self.homeless_doingRunAway = nil
                            data.seenCount = 0

                            scoreData.stayCloseToEnemy = false

                        end

                        -- find areas that have a line of sight to my enemy
                        local scoreFunction = function( scoreData, area1, area2 )
                            local area2Center = area2:GetCenter()
                            local destAreaId = area2:GetID()

                            local dist = area2Center:Distance( scoreData.enemysShootPos )
                            local score = 0
                            local mul = 1
                            if data.doingRunAway then
                                score = dist

                            else
                                score = maxDist - dist

                            end

                            score = score * math.Rand( 0.9, 1.1 )

                            -- cant come back up!
                            if not area2:IsConnected( area1 ) then return 0 end

                            local visible = area2:IsVisible( scoreData.enemysShootPos )
                            local goodVisible = visible == visibleWanted

                            local areasBearing = math.abs( terminator_Extras.BearingToPos( scoreData.enemysShootPos, scoreData.enemysAng, area2Center, scoreData.enemysAng ) )

                            local rightInFront = areasBearing > bearingSelectorAvoid
                            local generallyInFront = areasBearing > bearingGenerallyInFront
                            local finalSeen = self.homeless_FinalSeen
                            if finalSeen then
                                if dist < tooCloseSoft * 4 and goodVisible then
                                    mul = mul * 4

                                end
                                if dist < tooCloseHard then
                                    mul = mul * 0.25

                                elseif rightInFront and goodVisible then
                                    mul = mul * 0.6

                                elseif rightInFront then
                                    mul = mul * 0.85

                                end

                            elseif visibleWanted then
                                if visible then
                                    mul = mul * 4

                                end
                                if rightInFront and visible then
                                    mul = mul * 0.01

                                elseif dist < tooCloseHard then
                                    mul = mul * 0.01

                                elseif dist < tooCloseSoft then
                                    mul = mul * 0.1

                                elseif dist < tooCloseSoft * 4 then
                                    mul = mul * 0.25

                                elseif dist < tooCloseSoft * 8 then
                                    mul = mul * 0.75

                                end

                                if generallyInFront and visible then
                                    mul = mul * 0.5

                                end
                            else
                                if not visible then
                                    mul = mul * 4

                                elseif visible and rightInFront then
                                    score = score / areasBearing
                                    --debugoverlay.Text( area2Center, tostring( math.Round( score, 2 ) ), 5 )

                                end
                                if dist < tooCloseHard then
                                    mul = mul * 0.01

                                elseif generallyInFront or dist < tooCloseSoft then
                                    mul = mul * 0.5

                                end

                            end

                            if data.stayCloseToEnemy and dist > tooFar then
                                mul = 0.1

                            end

                            if not scoreData.self:areaIsReachable( area2 ) then score = 0.1 end

                            local multiplied = ( score * mul )

                            if multiplied <= 500 then
                                --debugoverlay.Text( area2Center, tostring( math.Round( multiplied ) ), 2, false )
                                return multiplied

                            end

                            -- never consider hiding/revealing at the same places twice
                            if data.seenAt[destAreaId] then
                                multiplied = multiplied / data.seenAt[destAreaId]

                            end
                            if data.hiddenAt[destAreaId] then
                                multiplied = multiplied / data.hiddenAt[destAreaId]

                            end

                            if goodVisible and not area2:HasAttributes( NAV_MESH_CROUCH ) then -- good potential area, we gotta check again now
                                visible = self:ClearOrBreakable( area2Center + data.offsetToShootPos, scoreData.enemysShootPos, true )
                                goodVisible = visible == visibleWanted

                            end

                            local badStaring = generallyInFront or area2:IsUnderwater()

                            if goodVisible then
                                wasSomewhereWanted = true
                                -- we use dist, not dist reversed
                                -- try and stay away from the player! 
                                multiplied = ( dist * mul )
                                -- prefer high ground
                                if area2Center.z > scoreData.startingShootPosZ then
                                    multiplied = multiplied * 4

                                end

                                if multiplied > 1200 and not badStaring then
                                    --debugoverlay.Text( area2Center, tostring( math.huge ), 5, false )
                                    return math.huge

                                end

                            elseif wasSomewhereWanted then
                                multiplied = multiplied * 0.1

                            end

                            --debugoverlay.Text( area2Center, tostring( math.Round( multiplied ) ), 5, false )

                            return multiplied

                        end
                        local toEnem
                        local pathToPos
                        if ( self.IsSeeEnemy or self.DistToEnemy < maxDist ) and data.sincePerfect < 20 then
                            pathToPos = self:findValidNavResult( scoreData, self:GetPos(), maxDist, scoreFunction, 8 )

                        else
                            toEnem = true
                            data.doingRunAway = nil
                            pathToPos = enemy:GetPos()

                        end
                        data.sincePerfect = data.sincePerfect + 1

                        self:InvalidatePath( "new path time" )

                        local result = terminator_Extras.getNearestPosOnNav( pathToPos )
                        local posOnNav = result.pos
                        local flankAroundResult = terminator_Extras.getNearestPosOnNav( enemy:GetPos() )
                        if result and IsValid( result.area ) then
                            if not self.homeless_FinalSeen and IsValid( flankAroundResult.area ) then
                                self:SetupFlankingPath( posOnNav, flankAroundResult.area, self.DistToEnemy * 0.75 )

                            else
                                self:SetupPathShell( posOnNav )

                            end
                        end

                        --debugoverlay.Cross( posOnNav, 100, 1, color_white, true )
                        if toEnem and util.IsInWorld( enemy:GetPos() ) and ( not self:primaryPathIsValid() or data.sincePerfect > 18 ) then
                            self:SetPos( enemy:GetPos() )

                        end

                        if not self:primaryPathIsValid() then
                            data.nextPath = CurTime() + math.Rand( 0.75, 1 )
                            return

                        end
                        data.endToEnemyBlockedCount = 0

                    end
                -- watching enem
                elseif see then
                    -- yoink
                    if self:IsSolid() and self.HomelessFrustration > self.HomelessFrustrationToAnger and enemy:IsPlayer() then
                        local relation = homeless_GetRelation( enemy )
                        local innocentSoul = enemy:IsPlayer() and enemy:GetInfoNum( "cl_homeless_nexthomeless", 0 ) == 0 and relation >= -5
                        local wise = Homeless_ScornWisdom( enemy )
                        local ignoringWisdom = self.homeless_IgnoreScornWisdom
                        if wise and not ignoringWisdom then
                            local hardLook = enemysAimEnt == self or enemyBearingToMeAbs <= 8 or self.homeless_CraftySeen
                            local upgraded = self.HomelessFrustrationToAnger >= scornedAnger
                            local theyAreNice = relation > 0 and not enemy.homeless_Murderer

                            debugPrint( "they're wise" )

                            if hardLook and not theyAreNice and not upgraded then
                                debugPrint( "leading them on" )
                                self:DoSpeaking( 100 )
                                self.HomelessFrustrationToAnger = scornedAnger
                                enemy.homeless_LeadOn = true

                                self:SetNW2Bool( "homeless_hallofmirrorify", true )
                                self:SetNW2Bool( "homeless_hallofmirrorify_glitchy", true )
                                self.overrideCrouch = CurTime() + 4
                                homeless_NudgeRelation( enemy, -0.5 )
                                homeless_Playerness( enemy, 1 )

                            elseif homeless_GetRelation( enemy ) >= -5 and upgraded and IsValid( self:GetTrueCurrentNavArea() ) and enemy:GetInfoNum( "ai_note_ideal_detail", 0 ) ~= homeless_NoteDetail( enemy ) then
                                debugPrint( "all done, leaving a note" )
                                self:DoSpeaking( 100 )
                                homeless_SpawnShelterAt( self:GetTrueCurrentNavArea(), 2, { forcedShelter = terminator_Extras.homeless_NoteShelter } )
                                debugPrint( "bye2" )
                                homeless_leave = true
                                SafeRemoveEntity( self ) -- bye
                                homeless_NudgeRelation( enemy, -0.5 )
                                homeless_Playerness( enemy, 1 )

                            elseif theyAreNice then
                                debugPrint( "but they're nice" )
                                local frust = self.HomelessFrustration
                                self.TryingToBeHidden = self.TryingToBeHidden + ( frust * 2 )
                                self.HomelessFrustration = 0

                                homeless_NudgeRelation( enemy, -1 ) -- not nice forever
                                homeless_Playerness( enemy, 1 )
                                homeless_DoItButPerf( math.random( 1, 3 ) )
                                self.homeless_doingRunAway = true

                            elseif upgraded and hardLook and terminator_Extras.homeless_EasyMode then -- always considered wise if easymode is on
                                debugPrint( "easy mode" )

                                homeless_Playerness( enemy, -1000 )
                                self:AddEntityRelationship( enemy, D_NU, 1 )

                                local old = enemy:GetInfoNum( "cl_homeless_dedication", 0 )
                                enemy:ConCommand( "cl_homeless_dedication " .. math.max( old, 2 ) )

                                homeless_NudgeRelation( enemy, -5 ) -- now he really hates you if he sees you in single
                                tattle( self, self:GetPos(), 1000, true )

                                data.ResetProgress( data, self )

                            elseif upgraded and hardLook then
                                debugPrint( "wise scorning" )
                                self.homeless_IgnoreScornWisdom = true -- you messed up

                                self:SetNW2Bool( "homeless_hallofmirrorify", true )
                                data.randomlyToggleGlitchy = true
                                homeless_NudgeRelation( enemy, -1 )
                                homeless_Playerness( enemy, 1 )

                            else
                                self:SetNW2Bool( "homeless_hallofmirrorify", false )
                                self:SetNW2Bool( "homeless_hallofmirrorify_glitchy", false )
                                self:DoSpeaking( 5 )

                            end
                            return

                        elseif innocentSoul then
                            debugPrint( "not scorning, they're too innocent" )
                            self:DoSpeaking( 100 )
                            homeless_Playerness( enemy, -1000 )
                            self:AddEntityRelationship( enemy, D_NU, 1 )

                            homeless_SetupFirst( enemy )

                            net.Start( "homeless_misc_ambiance" )
                            net.Send( enemy )
                            enemy:ConCommand( "cl_homeless_nextmessage " .. 0 ) -- overrides homeless_SetupFirst

                            homeless_NudgeRelation( enemy, 2 )
                            tattle( self, self:GetPos(), 1000, true )

                            data.ResetProgress( data, self )

                        end

                        local finalHitch = data.finalHitch or 0
                        if finalHitch > CurTime() then return end

                        local bailStage = self.homeless_FinalBailStage
                        local bailStageDist = bailStage * 15
                        local bad = not ( self.NothingOrBreakableBetweenEnemy and self.IsSeeEnemy )

                        local currDist = self.DistToEnemy
                        local looking = enemyBearingToMeAbs < 15
                        local craftySeen = self.homeless_CraftySeen
                        self.homeless_CraftySeen = nil
                        self.homeless_FinalSeen = looking or craftySeen or self.homeless_FinalSeen

                        local finalWalkDist = data.finalWalkDist or 0
                        local hitched = self.homeless_DoneWatchHitch or self.homeless_IgnoreScornWisdom
                        local bail

                        if data.randomlyToggleGlitchy and math.random( 0, 500 ) > currDist then
                            self:SetNW2Bool( "homeless_hallofmirrorify_glitchy", not self:GetNW2Bool( "homeless_hallofmirrorify_glitchy", false ) )

                        end

                        local lookAtMeYoink = enemy:GetEyeTrace().Entity == self or enemyBearingToMeAbs <= math.Clamp( 5 + bailStage, 5, 22.5 )

                        if bad then
                            if enemyBearingToMeAbs < ( 30 - bailStage ) then
                                bail = true

                            end
                        else
                            local tooCloseDist = math.Clamp( 100 + bailStageDist, 100, 250 )
                            local tooCloseFinal = currDist < tooCloseDist
                            local yoink = tooCloseFinal and lookAtMeYoink
                            if yoink then
                                if self.homeless_ScornOverride then -- glee
                                    self:homeless_ScornOverride( enemy )

                                else
                                    local oldYoink = self.homeless_YoinkCount or 0
                                    self.homeless_YoinkCount = oldYoink + 1
                                    Homeless_InstantScorn( enemy )

                                end

                                tattle( self, self:GetPos(), 1000, true )
                                homeless_NudgeRelation( enemy, -0.5 ) -- >:(

                                data.ResetProgress( data, self )

                                return

                            elseif hitched and ( enemyBearingToMeAbs < ( 40 - bailStage ) and currDist > ( 150 + bailStageDist * 2 ) ) then
                                bail = true

                            elseif enemyBearingToMeAbs > ( 25 + bailStage ) and currDist > ( 50 + bailStageDist * 5 ) then
                                self.overrideCrouch = CurTime() + 0.15
                                self.forcedShouldWalk = CurTime() + 0.15

                            end
                            if tooCloseFinal and not yoink then
                                self.homeless_FinalBailStage = bailStage + 0.05

                            end
                        end
                        if bail then
                            if not enemy.doneGulls then
                                voiceBox = ents.Create( "prop_physics" )
                                voiceBox:SetPos( self:GetPos() )
                                voiceBox:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
                                voiceBox:SetNoDraw( true )
                                voiceBox:SetNotSolid( true )
                                voiceBox:Spawn()

                                local filter = RecipientFilter()
                                filter:AddPlayer( enemy )
                                voiceBox.calling = CreateSound( voiceBox, "ambient/levels/coast/seagulls_ambient2.wav", filter )
                                voiceBox.calling:SetDSP( 131 )
                                voiceBox.calling:SetSoundLevel( 100 )
                                voiceBox.calling:PlayEx( 1, 74 )

                                SafeRemoveEntityDelayed( voiceBox, 10 )
                                enemy.doneGulls = true

                                enemy.homeless_Murderer = true

                            end
                            if self.homeless_IgnoreScornWisdom and enemy:GetMoveType() == MOVETYPE_NOCLIP and not self.EnemiesVehicle and #ents.FindByClass( "homeless_freegull" ) <= self:GetFrustationAdded() ^ 2 then
                                local gull = ents.Create( "homeless_freegull" )
                                gull.homeless_DeservesToExist = true
                                gull:SetPos( self:GetPos() )
                                gull:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )
                                gull:Spawn()
                                gull:Takeoff()

                            end

                            self.homeless_FinalBailStage = self.homeless_FinalBailStage + 1

                            data.wasHidden = false
                            self.hiddenToggle = true
                            self:SetHidden( true )
                            return

                        else
                            local nextAngryWatchLine = data.nextAngryWatchLine or 0
                            if nextAngryWatchLine < CurTime() then
                                data.nextAngryWatchLine = CurTime() + math.random( 5, 10 )
                                self:DoSpeaking()

                            end
                        end

                        if currDist < finalWalkDist and self.homeless_FinalSeen then
                            -- they backed up
                            local oldDist = data.oldFinalDist or currDist
                            if currDist > oldDist + 10 and not hitched then
                                self.homeless_DoneWatchHitch = true
                                data.finalHitch = CurTime() + 3
                                if enemy:IsPlayer() then
                                    local old = enemy:GetInfoNum( "cl_homeless_dedication", 0 )
                                    enemy:ConCommand( "cl_homeless_dedication " .. math.max( old, 2 ) )

                                end
                            end
                            data.oldFinalDist = currDist
                            local nextLastLine = data.nextLastLine or 0

                            if not util.IsInWorld( enemysShootPos ) and homeless_GetRelation( enemy ) < 0 and homeless_NoteDetail( enemy ) > 4 and #ents.FindByClass( "homeless_freegull" ) < self:GetFrustationAdded() ^ 2 then
                                local gull = ents.Create( "homeless_freegull" )
                                gull.homeless_DeservesToExist = true
                                gull:SetPos( myPos )
                                gull:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )
                                gull:Spawn()
                                gull:Takeoff()

                            end

                            if currDist > ( 75 - bailStageDist ) or lookAtMeYoink then
                                self:GotoPosSimple( data.myTbl, enemy:GetPos(), 100 )
                                if not hitched and math.random( 0, 1000 ) > self.DistToEnemy then
                                    tattle( self, self:GetPos(), 1000 )

                                end
                            elseif nextLastLine < CurTime() then
                                data.nextLastLine = CurTime() + 3
                                self:DoSpeaking()

                            end
                        elseif currDist > finalWalkDist and finalWalkDist < 3000 then
                            data.finalWalkDist = finalWalkDist + 25

                        end
                        return

                    end -- end yoink

                    local heightAbove = self:GetShootPos().z - enemysShootPos.z
                    local perfectStaringSpot
                    local okaySpot
                    if self.DistToEnemy > 750 then
                        local perfectStaringSpotTr = {
                            start = enemysShootPos,
                            endpos = self:GetShootPos(),
                            mins = -data.cornerCheckHull,
                            maxs = data.cornerCheckHull,
                            mask = MASK_SOLID,
                            filter = { enemy, self }
                        }

                        local perfectSpotResult = util.TraceHull( perfectStaringSpotTr )
                        perfectStaringSpot = perfectSpotResult.Hit
                        if perfectStaringSpot then
                            if IsValid( perfectSpotResult.Entity ) and perfectSpotResult.Entity:IsPlayerHolding() then
                                maxDiscomfort = maxDiscomfort - 5

                            else
                                maxDiscomfort = maxDiscomfort + 10

                            end
                        end

                        perfectStaringSpotTr.mins = -data.biggerCornerCheckHull
                        perfectStaringSpotTr.maxs = data.biggerCornerCheckHull

                        local okaySpotResult = util.TraceHull( perfectStaringSpotTr )

                        okaySpot = okaySpotResult.Hit
                        if IsValid( okaySpotResult.Entity ) and okaySpotResult.Entity:IsPlayerHolding() then
                            maxDiscomfort = maxDiscomfort - 2

                        else
                            if okaySpot then
                                maxDiscomfort = maxDiscomfort + 6

                            end
                            if okaySpot and heightAbove > 300 then
                                maxDiscomfort = maxDiscomfort + 10

                            end
                        end
                    end

                    if heightAbove > 100 then
                        maxDiscomfort = maxDiscomfort + 5

                    end

                    local lookingBearing = bearingLookingAtMe - 5
                    local theyreLooking = enemyBearingToMeAbs < lookingBearing or self.homeless_CraftySeen
                    local theyreDirectlyLooking = enemyBearingToMeAbs < lookingBearing * 0.1 or ( enemy.GetEyeTrace and enemy:GetEyeTrace().Entity == self )
                    local theyreLookingAway = enemyBearingToMeAbs > 90

                    local tooClose = self.DistToEnemy < data.startingDistance / 2
                    local bored = data.boredTime < CurTime()
                    if tooClose or bored or enemysAimEnt == self then
                        data.discomfort = data.discomfort + maxDiscomfort

                    elseif theyreLooking then
                        if theyreDirectlyLooking then
                            data.discomfort = data.discomfort + 20

                        elseif self.homeless_CraftySeen then
                            data.discomfort = data.discomfort + 20
                            self.homeless_CraftySeen = nil
                            local add = self:GetFrustationAdded() + ( self.HomelessFrustration / 5 )
                            self:NudgeFrustration( add, "craftySeen" )

                        elseif enemyBearingToMeAbs < lookingBearing * 0.25 then
                            data.discomfort = data.discomfort + 4

                        else
                            data.discomfort = data.discomfort + 1

                        end
                    elseif self.homeless_OnSomeonesScreen then
                        self.homeless_OnSomeonesScreen = nil
                        data.discomfort = data.discomfort + self.HomelessFrustration / 10

                    else
                        data.sincePerfect = 0
                        if theyreLookingAway or perfectStaringSpot then
                            data.discomfort = math.max( 0, data.discomfort + -1 )

                        else
                            data.discomfort = data.discomfort + 0.1

                        end
                    end

                    if data.discomfort >= maxDiscomfort then
                        data.discomfort = maxDiscomfort * 0.25
                        data.hiddenToggle = true
                        data.wasHidden = false
                        self.homeless_PlayerTrackedWhileInvis = math.max( 0, self.homeless_PlayerTrackedWhileInvis - 5 )

                        local time = 0
                        if self.GlassBetweenEnemy then
                            time = 3

                        elseif perfectStaringSpot then
                            time = 2

                        elseif okaySpot or self.DistToEnemy > 4000 then
                            time = 0.5

                        end

                        data.delayedHiding = true

                        local almostAngered = self.HomelessFrustration > 1
                        if self:IsSolid() and almostAngered and enemy:IsPlayer() and math.random( 1, 100 ) < 50 then
                            self.overrideCrouch = CurTime() + 4

                        end

                        timer.Simple( time, function()
                            if not IsValid( self ) then return end
                            if not self:IsSolid() then return end
                            data:Hide( self )

                        end )

                        local myNav = self:GetTrueCurrentNavArea()
                        if not IsValid( myNav ) then return end
                        local navareasToNeverDoAgain = { myNav }
                        table.Add( navareasToNeverDoAgain, myNav:GetAdjacentAreas() )
                        for _, area in ipairs( navareasToNeverDoAgain ) do
                            local oldSeen = data.seenAt[area:GetID()] or 0
                            data.seenAt[area:GetID()] = oldSeen + 1

                        end
                    end
                elseif not see then -- watching, but they went behind something
                    self:SetHidden( true )
                    data.hiddenToggle = true
                    self.homeless_PlayerTrackedWhileInvis = math.max( 0, self.homeless_PlayerTrackedWhileInvis - 25 )

                end
                self:ControlPath2( nil )
            end,
            StartControlByPlayer = function()
            end,
            ShouldRun = function( self, data )
                return not self:IsSolid() or self.homeless_DoneWatchHitch or self.homeless_IgnoreScornWisdom
            end,
            ShouldWalk = function( self, data )
                return ( self:IsSolid() and not self.homeless_DoneWatchHitch ) or ( self:IsSolid() and self.DistToEnemy < 100 )
            end,
        },
        [ "movement_propcurious" ] = {
            OnStart = function( self, data )
                self:SetHidden( true )
            end,
            BehaveUpdateMotion = function( self, data, interval )
                local see = self.IsSeeEnemy

                if not IsValid( data.object ) then
                    local bestEnt = self:GetEntToBeCuriousAbout()
                    data.object = bestEnt

                    if not IsValid( data.object ) then
                        self:TaskComplete( "movement_propcurious" )
                        self:StartTask2( "movement_walkintolos", nil, "nothing to be curious about" )

                    end

                elseif IsValid( data.object ) then
                    local object = data.object
                    local oldAttention = object.homeless_plyAttention
                    if oldAttention <= 0 then
                        table.RemoveByValue( self.EnemyAttentionTbl, object )
                        object.homeless_plyAttention = nil
                        data.object = nil
                        return

                    end
                    local bite = 1

                    local valid, attacked, nearAndCanHit, closeAndCanHit, isNear, isClose, visible = self:beatUpEnt( object )
                    if ( isNear and see ) or ( see and self.DistToEnemy < 250 ) then
                        self:TaskComplete( "movement_propcurious" )
                        self:StartTask2( "movement_walkintolos", nil, "they saw me!" )

                        object.homeless_plyAttention = oldAttention + -20
                        return

                    elseif attacked then
                        local obj = object:GetPhysicsObject()
                        if IsValid( obj ) then
                            obj:SetVelocity( self:GetAimVector() )

                        end
                        self:Use2( object )

                    elseif not valid then
                        data.object = nil

                    elseif not nearAndCanHit and not self:PrimaryPathIsValid() then
                        bite = bite * 4

                    end

                    object.homeless_plyAttention = oldAttention - bite

                end
            end,
            ShouldRun = function( self, data )
                local length = self:GetPath():GetLength() or 0
                local goodRun = self:canDoRun()
                return length > 200 and goodRun

            end,
            ShouldWalk = function( self, data )
                return self:shouldDoWalk()

            end,
        },
        ["reallystuck_handler"] = { -- it's really stuck!!!!!!!
            StartsOnInitialize = true,
            OnStart = function( self, data )
                data.historicPositions = {}
                data.historicNavs = {}
                data.historicStucks = {}
                data.maybeUnderCount = 0
            end,
            BehaveUpdateMotion = function( self, data )
                local nextCache = data.nextCache or 0
                if nextCache < CurTime() then
                    local myPos = self:GetPos()
                    local currentNav = navmesh.GetNearestNavArea( myPos, false, 75, false, false, -2 )
                    local size = 80

                    --debugoverlay.Cross( myPos, 10, 10, Color( 255,255,255 ), true )

                    local staringAtEnemy = not self:PathIsValid() and self.IsSeeEnemy and self:IsSolid()
                    data.nextCache = CurTime() + 1

                    local noNav = self.loco:IsOnGround() and not ( currentNav and currentNav.IsValid and currentNav:IsValid() )
                    local doAddCount = 1
                    -- go faster
                    if noNav then
                        doAddCount = doAddCount * 4

                    end
                    if self.isUnstucking then
                        doAddCount = doAddCount * 2

                    end

                    if myPos then
                        for _ = 1, doAddCount do
                            table.insert( data.historicPositions, 1, myPos )

                        end
                    end
                    if currentNav then
                        for _ = 1, doAddCount do
                            table.insert( data.historicNavs, 1, currentNav )

                        end
                    end

                    local stuck = nil
                    local sortaStuck = nil
                    local overrideStuck = self.overrideVeryStuck

                    local nextDisplacementCheck = data.nextUnderDisplacementCheck or 0
                    if nextDisplacementCheck < CurTime() then
                        data.nextUnderDisplacementCheck = CurTime() + 5
                        isUnderDisplacement, maybeUnderDisplacement = self:IsUnderDisplacement()

                        if maybeUnderDisplacement then
                            data.maybeUnderCount = data.maybeUnderCount + 1

                        elseif isUnderDisplacement then
                            data.maybeUnderCount = data.maybeUnderCount + 3

                        else
                            data.maybeUnderCount = 0

                        end
                    end

                    local underDisplacement = data.maybeUnderCount > 6

                    if #data.historicPositions > size then
                        if data.historicPositions[size + 1] then
                            table.remove( data.historicPositions, size + 1 )
                            table.remove( data.historicPositions, size + 1 )

                        end
                        if data.historicNavs[size + 1] then
                            table.remove( data.historicNavs, size + 1 )
                            table.remove( data.historicNavs, size + 1 )

                        end

                        -- start with assuming its true
                        stuck = true
                        sortaStuck = true

                        for index, historicPos in ipairs( data.historicPositions ) do
                            local distSqr = myPos:DistToSqr( historicPos )
                            --debugoverlay.Line( myPos, historicPos, 1, color_white, true )
                            if distSqr < 15^2 then
                                stuck = nil
                                break

                            end
                            if index == 10 then
                                self:SetCollisionGroup( COLLISION_GROUP_WORLD )
                                self:SetSolidMask( MASK_NPCSOLID_BRUSHONLY )

                            end
                        end
                        -- false if we haven't been here for x long
                        for blap, historicNav in ipairs( data.historicNavs ) do
                            maxExtent = blap
                            if historicNav ~= currentNav then
                                sortaStuck = nil
                                break

                            end
                        end
                        if noNav and not self:PathIsValid() and not stuck and not navmesh.GetNearestNavArea( myPos, false, 150, false, false, -2 ) then
                            stuck = true

                        end
                    end

                    if not staringAtEnemy and ( offNavmesh or stuck or sortaStuck or underDisplacement or overrideStuck ) then -- i have been in the same EXACT spot for S I Z E seconds
                        --print( self:GetCreationID(), "damnitfoundmeasstuck ", stuck, sortaStuck, underDisplacement, overrideStuck )
                        --PrintTable( data.historicNavs )
                        --debugoverlay.Cross( myPos, 100, 100, color_white, true )

                        self.overrideVeryStuck = nil
                        local distToEnemy = 0
                        local enemyPos = self:GetPos()
                        if IsValid( self:GetEnemy() ) then
                            distToEnemy = self.DistToEnemy
                            enemyPos = self.EnemyLastPos or self:GetEnemy():GetPos()

                        end

                        local scoreData = {}
                        scoreData.startPos = self:GetPos()
                        scoreData.distToEnemySqared = distToEnemy^2
                        scoreData.enemyPos = enemyPos

                        local scoreFunction = function( scoreData, _, area2 )
                            local area2Center = area2:GetCenter()
                            local score = area2Center:DistToSqr( scoreData.startPos ) ^ math.Rand( 0.9, 1.1 )
                            if area2Center:DistToSqr( scoreData.enemyPos ) < scoreData.distToEnemySqared then -- dont get closer
                                --debugoverlay.Cross( area2Center, 10, 10, Color( 255,255,255 ), true )
                                score = 0
                            end

                            return score

                        end
                        local freedomPos = nil
                        -- foolproof.. maybe
                        local nearestNavArea = navmesh.GetNearestNavArea( self:GetPos(), false, 10000, false, true, 2 )

                        for _ = 1, 10 do
                            freedomPos = self:findValidNavResult( scoreData, nearestNavArea, math.random( 2000, 3000 ), scoreFunction ) -- huge position shunt since we're so stuck.
                            if freedomPos then break end
                        end


                        --debugoverlay.Cross( freedomPos, 50, 20, Color( 255, 0, 0 ), true )
                        --print( self:GetCreationID(), "bigunstuck ", stuck, sortastuck, underDisplacement, overrideStuck, noNavAndNotStaring )

                        if freedomPos then
                            self:SetPos( freedomPos )
                            self:InvalidatePath( "i was hard unstucked! bailing path." )
                            self.loco:SetVelocity( Vector( 0,0,0 ) )
                            self.loco:ClearStuck()

                        end

                        data.nextUnderDisplacementCheck = 0 -- CHECK NOW!

                        data.historicPositions = {}
                        data.historicNavs = {}

                    end
                end
            end,
        },
    }
end

if game.IsDedicated() or debugging() then
    concommand.Add( "homeless_purge", function( caller )
        if game.IsDedicated() and IsValid( caller ) then return end

        local homeless = ents.FindByClass( "terminator_nextbot_homeless" )
        for _, it in ipairs( homeless ) do
            homeless_leave = true
            print( "bye3", it )
            SafeRemoveEntity( it )
            break

        end
    end, nil, "for charity" )

end