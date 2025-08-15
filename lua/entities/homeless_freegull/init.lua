AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

local entMeta = FindMetaTable( "Entity" )
local vecMeta = FindMetaTable( "Vector" )
local IsValid = IsValid
local CurTime = CurTime
local Vector = Vector
local math = math
local util = util

local size = 15
local mins, maxs = Vector( -size / 2, -size / 2, 0 ), Vector( size / 2, size / 2, size )
local gullMask = bit.bor( MASK_SOLID, MASK_WATER )

local gullCount = #ents.FindByClass( "homeless_freegull*" )


local bigNegativeZ = Vector( 0, 0, -3000 )
local startOffset = Vector( 0, 0, 100 )

local function getFloorTr( pos, filter )
    local traceDat = {
        mask = gullMask,
        start = pos + startOffset,
        endpos = pos + bigNegativeZ,
        filter = filter,

    }

    local trace = util.TraceLine( traceDat )
    return trace

end

local function displeasure( me )
    homeless_MakeSchizophrenic( me )
    return true -- block deletion

end

function ENT:RegisterGullSpawn()
    gullCount = gullCount + 1

end

function ENT:Initialize()
    self:SetModel( "models/seagull.mdl" )
    self:SetCollisionBounds( mins, maxs )
    self:SetMoveType( MOVETYPE_FLY )
    self:SetSolid( SOLID_BBOX )
    self:PhysicsInitShadow( true, true )

    if math.random( 1, 200 ) > gullCount then
        self:SetTrigger( true )
        self:UseTriggerBounds( true, 500 )

    else
        self:DrawShadow( false )

    end

    self.ThinkSpeed = 0.1
    self.NextTurn = CurTime()

    self:RegisterGullSpawn()

    --self.murdererTarget = Entity( 1 )
    self:DropToFloor()

    doubtMyOwnExistence( self, nil, displeasure )

end

function ENT:OnRemove()
    gullCount = gullCount - 1
    if gullCount <= 0 then
        gullCount = 0

    end
end

local vecRandom = Vector( 0, 0, 0 )
local function randomVec( scale )
    vecRandom.x = math.Rand( -1, 1 )
    vecRandom.y = math.Rand( -1, 1 )
    vecRandom.z = math.Rand( -1, 1 )

    vecRandom:Normalize()

    return vecRandom * scale
end

local flightFlattener = Vector( 1, 1, 0.9 )
local gullLeadRadius = 2000^2

function ENT:Think()
    local myTbl = entMeta.GetTable( self )
    local isFlying = myTbl.GetFlying( self )
    if isFlying and myTbl.NextTurn < CurTime() then
        local myPos = entMeta.GetPos( self )

        local flightSpeed = myTbl.GetFlightSpeed( self )
        local tryingToGoDir = ( entMeta.GetForward( self ) + randomVec( 0.1 ) ) * flightFlattener
        local isLeader = myTbl.isFreeLeader

        local target = myTbl.murdererTarget
        local validTarg = IsValid( target )
        if validTarg and entMeta.IsFlagSet( target, FL_NOTARGET ) then
            if myTbl.EternallyScorned and entMeta.Health( target ) < 0 then
                SafeRemoveEntity( self )
                return

            elseif not myTbl.EternallyScorned then
                myTbl.murdererTarget = nil
                return

            end
        end

        local canCrashIntoSomething = validTarg and entMeta.Health( target ) > 0 and terminator_Extras.PosCanSee( myPos, target:GetShootPos() )

        if canCrashIntoSomething then
            local subtProduct = entMeta.GetPos( target ) - myPos
            local dirToTarget = vecMeta.GetNormalized( subtProduct )
            tryingToGoDir = tryingToGoDir + ( dirToTarget * 0.9 )
            vecMeta.Normalize( tryingToGoDir )

            flightSpeed = flightSpeed * math.Rand( 1.05, 1.25 )

        else
            if isLeader then
                local floorResult = getFloorTr( myPos, self )
                if not floorResult.Hit or floorResult.Fraction > 0.5 then
                    tryingToGoDir.z = tryingToGoDir.z - 0.75

                else
                    tryingToGoDir.z = tryingToGoDir.z - ( floorResult.Fraction / 4 )

                end
            else
                tryingToGoDir.z = tryingToGoDir.z - 0.1

            end

            local myFreeLeader = myTbl.myFreeLeader
            if not IsValid( myFreeLeader ) then -- make us a leader
                for _, gull in ipairs( ents.FindByClass( entMeta.GetClass( self ) ) ) do
                    if gull == self then continue end
                    if vecMeta.DistToSqr( entMeta.GetPos( gull ), myPos ) > gullLeadRadius then continue end
                    if gull.isFreeLeader then
                        myTbl.myFreeLeader = gull
                        myTbl.isFreeLeader = false
                        break

                    end
                    gull.myFreeLeader = self

                end
                myTbl.isFreeLeader = true

            else -- we are being led
                local subtProduct = entMeta.GetPos( myFreeLeader ) - myPos
                local dirToMyBuddy = vecMeta.GetNormalized( subtProduct )
                tryingToGoDir = tryingToGoDir + ( dirToMyBuddy * 0.5 )
                vecMeta.Normalize( tryingToGoDir )

                if vecMeta.LengthSqr( subtProduct ) > gullLeadRadius then
                    flightSpeed = flightSpeed * math.Rand( 1.05, 1.25 )

                end
            end
        end

        local max
        local offset = math.random( 500, 2000 )
        if isLeader then
            offset = offset * 2.5
            max = 30

        else
            max = 15

        end

        local worstFraction = 1
        local hitWall = true

        for ind = 1, max do
            offset = offset * 0.75
            local traceData = {
                start = myPos,
                endpos = myPos + tryingToGoDir * ( flightSpeed + offset ), -- Offset in the forward direction
                filter = self,
                mask = gullMask,
                mins = mins,
                maxs = maxs,

            }
            local trace = util.TraceHull( traceData )

            worstFraction = math.min( worstFraction, trace.Fraction )

            local hit = trace.Hit
            local hitEnt = trace.Entity

            if hit and hitEnt ~= target then
                -- If we hit something, adjust the direction slightly and try again
                tryingToGoDir = tryingToGoDir + randomVec( 0.35 )
                if worstFraction <= 0.5 and ind > max / 4 then -- dont FLY INTO THE FLOORR
                    tryingToGoDir.z = tryingToGoDir.z + math.Rand( -1, 1 )

                end
                vecMeta.Normalize( tryingToGoDir )

            elseif hitEnt == target then
                hitWall = true
                break

            else
                hitWall = hit
                break

            end
        end

        if hitWall and worstFraction <= 0.01 then
            myTbl.Die( self )

        else
            -- set velocity correctly here pls
            local velocity = tryingToGoDir * flightSpeed
            entMeta.SetVelocity( self, velocity - entMeta.GetVelocity( self ) )
            entMeta.SetAngles( self, vecMeta.Angle( tryingToGoDir ) )

        end

        if ( isLeader or gullCount <= 2 ) and worstFraction > 0.5 then
            myTbl.ManageNumbers( self, myTbl, myPos, tryingToGoDir )

        end

        if isLeader then
            myTbl.NextTurn = CurTime() + worstFraction / 2
            myTbl.ThinkSpeed = worstFraction * 0.05

        else
            myTbl.NextTurn = CurTime() + 0.1 + worstFraction
            myTbl.ThinkSpeed = worstFraction * 0.15

        end

    elseif not isFlying then
        myTbl.ThinkSpeed = math.Rand( 1, 15 )

    end
    local goalSeq
    if isFlying then
        goalSeq = "fly"
        if not myTbl.wasFlying then
            myTbl.wasFlying = true

        end
    else
        if myTbl.wasFlying then
            myTbl.wasFlying = false

        end
        goalSeq = "Idle01"

    end
    if goalSeq ~= myTbl.oldSeq then
        entMeta.ResetSequence( self, goalSeq )
        myTbl.oldSeq = goalSeq

    end

    entMeta.NextThink( self, CurTime() + myTbl.ThinkSpeed )
    return true

end

function ENT:ManageNumbers( myTbl, myPos, tryingToGoDir )
    if not myTbl.homeless_DeservesToExist then return end
    local eternallyScorned = self.EternallyScorned
    if not eternallyScorned and player.GetCount() > 6 then return end -- don't disrupt
    if not homeless_FirstPlyLoaded() then return end

    if not eternallyScorned and homeless_FirstPly():IsFlagSet( FL_NOTARGET ) then
        if gullCount > 25 then-- cleanup non-scorned gulls
            SafeRemoveEntity( self )

        end
        return

    end

    local firstPly
    if eternallyScorned then
        for _, ply in player.Iterator() do
            if not ply.homeless_Scorned then continue end
            if not ply:Alive() then continue end
            firstPly = ply
            break

        end
    else
        firstPly = homeless_FirstPly()

    end
    local relation = eternallyScorned and -10 or homeless_GetRelation( firstPly )
    local targetNum
    if eternallyScorned then -- dont impact non-scorned perf too much
        targetNum = 100

    elseif relation <= -5 then
        targetNum = 200

    elseif relation <= 0 then
        targetNum = 100

    elseif relation <= 5 then
        targetNum = 50

    elseif relation <= 10 then
        targetNum = 25

    end
    if ( gullCount >= targetNum and relation <= 0 ) or ( relation <= -10 and math.Rand( 0, 100 ) <= 0.1 ) then
        local gulls = ents.FindByClass( entMeta.GetClass( self ) )
        for _, gull in ipairs( gulls ) do
            local gullsTbl = entMeta.GetTable( gull )
            if gullsTbl.myFreeLeader ~= self then continue end
            gullsTbl.murdererTarget = firstPly

        end
    elseif gullCount < targetNum then
        local nextBaby = myTbl.nextBaby or 0
        if nextBaby > CurTime() then return end

        if not eternallyScorned and gullCount < 20 and terminator_Extras.posIsInterrupting( myPos ) then myTbl.nextBaby = CurTime() + 5 return end

        local nextAdd
        if eternallyScorned then
            nextAdd = 5

        else
            nextAdd = 5 + relation

        end

        myTbl.nextBaby = CurTime() + nextAdd

        local gull = ents.Create( entMeta.GetClass( self ) )
        if IsValid( gull ) then
            gull:SetPos( myPos + ( -tryingToGoDir * size * self:GetModelScale() *  3.5 ) )
            gull:SetAngles( entMeta.GetAngles( self ) )
            gull:Spawn()

            gull.homeless_DeservesToExist = true
            gull.myFreeLeader = self
            gull:Takeoff()

        end
    end
end


local playerClass = "player"

function ENT:StartTouch( touched )
    if entMeta.GetClass( touched ) ~= playerClass then return end
    self:Takeoff()

end

local gullTakeoffRadius = 800^2
local takeoffOffset = Vector( 0, 0, 10 )

function ENT:Takeoff()
    local myTbl = entMeta.GetTable( self )
    local myPos = entMeta.GetPos( self )
    entMeta.SetPos( self, myPos + takeoffOffset )
    myTbl.takingOff = true
    myTbl.SetFlying( self, true )
    myTbl.SetFlightSpeed( self, self.BaseFlightSpeed )

    for _, gull in ipairs( ents.FindByClass( entMeta.GetClass( self ) ) ) do
        local gullsTbl = entMeta.GetTable( gull )
        if gullsTbl.takingOff then continue end
        if gullsTbl.GetFlying( gull ) then continue end
        if vecMeta.DistToSqr( entMeta.GetPos( gull ), myPos ) > gullTakeoffRadius then continue end

        timer.Simple( math.Rand( 0.5, 3 ), function()
            if not IsValid( gull ) then return end
            if gullsTbl.GetFlying( gull ) then return end
            gullsTbl.Takeoff( gull )

        end )
    end
    entMeta.NextThink( self, CurTime() + 0.1 )

end

function ENT:PhysicsCollide( colData )
    if colData.Speed <= 100 then return end

    self:Die()

end

function ENT:OnTakeDamage( damage )
    self:Die( damage )

    if IsValid( self.murdererTarget ) then return end

    local attacker = damage:GetAttacker()
    if self.nudgedRelation then return end
    self.nudgedRelation = true
    homeless_NudgeRelation( attacker, -0.25 )

end

hook.Add( "OnEntityWaterlevelChanged", "homeless_freegull_easywayout", function( ent )
    if gullCount <= 0 then return end
    if not ent.IsFreeGull then return end
    ent:Die()

end )

function ENT:MakeGull()
    local gull = ents.Create( "npc_seagull" )
    gull.homeless_neighbors_immune = true
    gull.isFreeGullSacrifice = true
    gull.EternallyScorned = self.EternallyScorned
    gull.GetShouldServerRagdoll = function() return false end

    local pos = self:WorldSpaceCenter() + ( VectorRand() * self:GetModelRadius() )

    gull:SetPos( pos )
    gull:Spawn()
    gull:SetAngles( self:GetAngles() )

    return gull

end

function ENT:Die( damage )
    if self.Dead then return end
    self.Dead = true

    local eternallyScorned = self.EternallyScorned

    self:EmitSound( "common/null.wav", 75, 100, 1, CHAN_VOICE )

    local attacker
    local inflictor
    local force
    if damage then
        attacker = damage:GetAttacker()
        inflictor = damage:GetInflictor() or damage:GetWeapon()
        force = damage:GetDamageForce()

    end

    local myPos = self:GetPos()

    if not eternallyScorned then
        local sacrifice = self:MakeGull()

        timer.Simple( 0, function()
            if not IsValid( sacrifice ) then return end
            if not IsValid( attacker ) then sacrifice:TakeDamage( math.huge, sacrifice ) return end
            if not IsValid( inflictor ) then sacrifice:TakeDamage( math.huge, sacrifice ) return end
            local dmgInf = DamageInfo()
            dmgInf:SetDamage( 10 )
            dmgInf:SetAttacker( attacker )
            dmgInf:SetInflictor( inflictor )
            dmgInf:SetDamagePosition( myPos )
            dmgInf:SetDamageForce( force )

            sacrifice:TakeDamageInfo( dmgInf )

        end )
    end

    if self:GetFlying() then
        local crashedInto = util.QuickTrace( myPos, self:GetForward() * 50, { self, sacrifice } )
        local crashedIntoEnt = crashedInto.Entity
        if not IsValid( crashedIntoEnt ) then
            local traceData = {
                start = myPos,
                endpos = myPos + self:GetForward() * 50, -- Offset in the forward direction
                filter = { self, sacrifice },
                mask = gullMask,
                mins = mins,
                maxs = maxs,

            }
            crashedInto = util.TraceHull( traceData )
            crashedIntoEnt = crashedInto.Entity

        end

        if IsValid( crashedIntoEnt ) and not crashedIntoEnt.IsFreeGull and not crashedIntoEnt.isFreeGullSacrifice then
            local crashDamage = math.random( 5, 10 ) * self:GetModelScale()
            if eternallyScorned then
                if not crashedIntoEnt:IsPlayer() then return end

                local newHealth = crashedIntoEnt:Health() + -crashDamage
                if newHealth <= 0 then
                    crashedIntoEnt:KillSilent()

                else
                    crashedIntoEnt:SetHealth( newHealth )

                end
            else
                local dmgInf = DamageInfo()
                dmgInf:SetDamage( crashDamage )
                dmgInf:SetDamageType( DMG_SLASH )
                dmgInf:SetAttacker( self )
                dmgInf:SetInflictor( self )
                dmgInf:SetDamagePosition( crashedInto.HitPos )
                dmgInf:SetDamageForce( crashedInto.Normal * 500 )

                crashedIntoEnt:TakeDamageInfo( dmgInf )

            end

            crashedIntoEnt:EmitSound( "Flesh.ImpactHard" )
            if crashedIntoEnt:IsPlayer() then
                local punch = 10
                crashedIntoEnt:ViewPunch( Angle( math.random( -punch, punch ), math.random( -punch, punch ), math.random( -punch, punch ) ) )

            end
        end
    end

    SafeRemoveEntity( self )

end