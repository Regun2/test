AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

local mdls = {
    "models/hunter/misc/sphere075x075.mdl",
    "models/hunter/misc/sphere1x1.mdl",

}

ENT.EternallyScorned = true

function ENT:ResetStats()
    self.NotSeeCount = 0
    self.NotNextToCount = 0
    self.NotNextToStopFlying = 50
    self.StopFlyingToHate = 150
    self.TimeoutNoTrigger = 0
    self.NextIdleTakeoff = CurTime() + math.random( 60 * 1, 60 * 3.5 )
    self.FlockLeader = nil
    self.Triggerer = nil
    self.NotNextToCount = 0
    self:SetFlying( false )

end

function ENT:Initialize()
    self:SetModel( mdls[math.random( 1, #mdls )] )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetMaterial( "!homeless_seagullkingmat" )

    local phys = self:GetPhysicsObject()
    if IsValid( phys ) then
        phys:Wake()
        phys:SetBuoyancyRatio( 10 )
        phys:SetMass( 400 )
        phys:SetAngleDragCoefficient( 400 )
        phys:SetDragCoefficient( 25 )

    end

    self:SetTrigger( true )
    self:UseTriggerBounds( true, 500 )
    self:ResetStats()

    local function displeasure( me )
        local you = me:GetCreator()
        local myPlace = self:GetPos()
        if not IsValid( you ) then
            local bestDist = math.huge
            for _, someone in player.Iterator() do
                local dist = someone:GetPos():Distance( myPlace )
                if dist < bestDist then
                    you = someone
                    bestDist = dist

                end
            end
            if bestDist > 1000 then return end -- dont give blame
        end
        if not IsValid( you ) then return end -- :(

        if not you.homeless_Murderer and math.random( 0, 100 ) < 50 then
            you:ConCommand( "ai_overridden_enterers " .. 2 )

        end
        you.homeless_Murderer = true

        local corpse = ents.Create( "homeless_deadseagullking" )
        corpse:SetPos( myPlace )
        corpse.homeless_DeservesToExist = true
        corpse:Spawn()

    end

    doubtMyOwnExistence( self, nil, displeasure )

end

function ENT:StartFlying( triggerer )

    if triggerer and triggerer:IsFlagSet( FL_NOTARGET ) and triggerer:IsPlayer() then self:SetPreventTransmit( triggerer, true ) return end

    if not self:GetFlying() then
        self:NextThink( CurTime() + 0.1 )
        if triggerer then
            for _ = 1, math.random( 1, 2 ) do
                local casualty = self:MakeGull()
                timer.Simple( 0, function()
                    if not IsValid( casualty ) then return end
                    casualty:TakeDamage( math.huge, casualty, casualty )

                end )
            end
        end
    end

    self.TimeoutNoTrigger = CurTime() + 10
    self:SetFlying( true )

    if triggerer then

        homeless_Playerness( triggerer, 1 )

        self.Triggerer = triggerer
        local triggerersPos = triggerer:GetPos()
        if triggerer.GetShootPos then
            triggerersPos = triggerer:GetShootPos()

        end
        if not terminator_Extras.homeless_EasyMode then
            self.Duplicatable = true

        end

        local ableToCount = 0
        local able = {}
        local highest = self.NotNextToStopFlying
        for _, other in ipairs( ents.FindByClass( self:GetClass() ) ) do
            if terminator_Extras.PosCanSee( triggerersPos, other:WorldSpaceCenter() ) then
                ableToCount = ableToCount + 1
                table.insert( able, other )
                highest = math.max( highest, other.NotNextToStopFlying )

            end
        end
        if ableToCount < 4 then return end

        local hateful = highest > self.StopFlyingToHate

        for _, other in ipairs( able ) do
            if other ~= self then other.FlockLeader = self end

            if not hateful then
                other.NotNextToStopFlying = highest
                if not other:GetFlying() then other:StartFlying( triggerer ) end

            else
                if other:GetFlying() then
                    other.Triggerer = triggerer
                    other.AbleToAttack = true

                else
                    if other == self then continue end
                    other:StartFlying( triggerer )

                end
            end
        end
    else
        local myPos = self:WorldSpaceCenter()
        local highest = self.NotNextToStopFlying
        for _, other in ipairs( ents.FindByClass( self:GetClass() ) ) do
            if other == self then continue end
            highest = math.max( highest, other.NotNextToStopFlying )
            other.NotNextToStopFlying = highest

            if other:GetFlying() then continue end
            if other:WorldSpaceCenter():DistToSqr( myPos ) > 4000^2 then continue end

            other.FlockLeader = self
            other:StartFlying()

        end
    end
end

function ENT:StopFlying()
    self.FlockLeader = nil
    self.Triggerer = nil
    self.NotNextToCount = 0
    self:SetFlying( false )
    self:NextThink( CurTime() + 0.5 )
    self.NextIdleTakeoff = CurTime() + math.random( 60 * 1, 60 * 3.5 )

end

function ENT:StartTouch( touched )
    if not touched:IsPlayer() then return end
    if not self:GetFlying() then
        self:StartFlying( touched )

    end
end

local downOffs = Vector( 0,0,-64000 )
local pooOffs = Vector( 0,0,-1000 )

function ENT:Think()
    local touched = self:GetFlying()
    local obj = self:GetPhysicsObject()

    local nextPoop = self.nextPoop or 0
    if nextPoop < CurTime() then
        self.nextPoop = CurTime() + math.Rand( 0.5, 1.5 )
        local pooStart = self:GetPos() + VectorRand() * self:GetModelRadius()
        util.Decal( "BirdPoop", pooStart, pooStart + pooOffs, self )

    end

    if not touched then
        local dir = self:GetVelocity() + VectorRand()
        local time = math.Rand( 0.1, 5 )

        dir:Normalize()
        obj:ApplyForceCenter( dir * ( time * 30 ) * obj:GetMass() )
        obj:EnableGravity( true )
        self:NextThink( CurTime() + time )

        if self.NextIdleTakeoff < CurTime() then
            self:StartFlying()

        end

        return true

    else
        local myPos = self:WorldSpaceCenter()
        local triggerersPos
        local leaderFollowPos
        local tooClose
        local rightNext
        local touching
        local seeEnem
        local speed = math.random( 600, 1200 )
        local hateful = self.AbleToAttack and self.NotNextToStopFlying > self.StopFlyingToHate

        if IsValid( self.Triggerer ) then
            if self.Triggerer:IsFlagSet( FL_NOTARGET ) then self.Triggerer = nil return end

            triggerersPos = self.Triggerer:GetPos()
            if self.Triggerer.GetShootPos then
                triggerersPos = self.Triggerer:GetShootPos()

            end
            local distSqr = myPos:DistToSqr( triggerersPos )
            tooClose = distSqr < 3000^2
            rightNext = distSqr < 1000^2
            touching = distSqr < 150^2
            seeEnem = terminator_Extras.PosCanSee( myPos, triggerersPos )

            if not tooClose and not seeEnem then
                self.NotSeeCount = self.NotSeeCount + 1

            else
                self.NotSeeCount = 0

            end
            if self.NotSeeCount > 15 and self.Duplicatable then
                self.Duplicatable = nil
                local clone = ents.Create( self:GetClass() )
                clone:SetPos( myPos )
                clone.homeless_DeservesToExist = true
                clone:Spawn()

            end
            if self.NotSeeCount > 100 then
                SafeRemoveEntity( self )

            end

            if not rightNext and seeEnem then
                self.NotNextToCount = self.NotNextToCount + 1

            elseif rightNext then
                self.NotNextToCount = 0

            end
            if self.NotNextToCount > self.NotNextToStopFlying then
                self.NotNextToStopFlying = self.NotNextToStopFlying * 1.75
                self:StopFlying()

            end

            local nextCallToAction = self.nextCallToAction or 0

            if touching and hateful then
                local touches = self.Triggerer.homeless_oldKingTouches or 0
                touches = touches + 1

                self.Triggerer.homeless_oldKingTouches = touches

                if touches > 15 then
                    self.Triggerer.homeless_oldKingTouches = 0
                    Homeless_InstantTransgression( self.Triggerer )
                    for _, other in ipairs( ents.FindByClass( self:GetClass() ) ) do
                        other:ResetStats()

                    end
                end
            elseif hateful and nextCallToAction < CurTime() then
                self.nextCallToAction = CurTime() + 2
                for _, other in ipairs( ents.FindByClass( self:GetClass() ) ) do
                    if not terminator_Extras.PosCanSee( triggerersPos, other:WorldSpaceCenter() ) then continue end
                    if other == self then continue end

                    other.NotNextToStopFlying = math.max( self.NotNextToStopFlying, other.NotNextToStopFlying )
                    if other:GetFlying() then
                        other.Triggerer = self.Triggerer
                        other.AbleToAttack = true

                    else
                        other:StartFlying( self.Triggerer )

                    end
                end
            end
        else
            if IsValid( self.FlockLeader ) then
                local leadersPos = self.FlockLeader:WorldSpaceCenter()
                local leadersLastPos = self.lastLeaderPos
                if terminator_Extras.PosCanSee( myPos, leadersPos ) then
                    leaderFollowPos = leadersPos
                    self.lastLeaderPos = leadersPos

                elseif terminator_Extras.PosCanSee( myPos, leadersLastPos ) then
                    if myPos:Distance( leadersLastPos ) < 75 then
                        self.lastLeaderPos = nil

                    end
                    leaderFollowPos = leadersLastPos

                end
            end

            if self.TimeoutNoTrigger < CurTime() then
                self:StopFlying()

            end
        end

        local dir
        local doAvoidGround = true
        if tooClose and seeEnem then
            if hateful then
                dir = triggerersPos - myPos
                speed = speed * 1.5
                doAvoidGround = nil

            else
                dir = myPos - triggerersPos

            end
            dir:Normalize()

            if not rightNext then
                dir.z = dir.z * 0.1
                dir = dir + self:GetVelocity():GetNormalized()
                dir:Normalize()

            else
                doAvoidGround = math.random( 1, 100 ) < 75

            end

        else
            if leaderFollowPos then
                local distToLeader = myPos:Distance( leaderFollowPos )
                speed = math.random( 300, 500 ) + distToLeader

                dir = leaderFollowPos - myPos
                dir:Normalize()
                dir = dir + ( VectorRand() * 0.25 )

            else
                dir = self:GetVelocity():GetNormalized() + ( VectorRand() * 0.25 )

            end
        end
        if doAvoidGround then
            local trStruc = {
                start = myPos,
                endpos = myPos + downOffs,
                mask = MASK_SOLID_BRUSHONLY,
            }
            local result = util.TraceLine( trStruc )
            local hitPos = result.HitPos
            local disToHit = hitPos:Distance( myPos )
            local z = math.Rand( -0.25, 0.25 )
            local horsMul = 4
            if disToHit > 1500 then
                z = math.Rand( -0.9, -1.1 )
                horsMul = 0

            elseif disToHit > 750 then
                z = math.Rand( -0.2, 0.3 )
                horsMul = 0.5

            elseif disToHit < 250 then
                z = math.Rand( 0.9, 1.1 )
                horsMul = 0

            end
            dir.z = dir.z + z
            dir.x = dir.x * horsMul
            dir.y = dir.y * horsMul
        end

        local time = math.Rand( 0.05, 0.15 )

        dir:Normalize()
        obj:SetVelocity( ( self:GetVelocity() * 0.15 ) + ( dir * speed * 0.85 ) )
        obj:EnableGravity( false )
        self:NextThink( CurTime() + time )

    end
end

function ENT:MakeGull( posOverride )
    local gull = ents.Create( "npc_seagull" )
    gull.homeless_neighbors_immune = true
    gull.GetShouldServerRagdoll = function() return false end

    local pos
    if posOverride and posOverride ~= vector_origin then
        pos = self:NearestPoint( posOverride ) + ( VectorRand() * self:GetModelRadius() / 4 )

    else
        pos = self:WorldSpaceCenter() + ( VectorRand() * self:GetModelRadius() )

    end

    gull:SetPos( pos )
    gull:Spawn()
    gull:SetAngles( Angle( 0, math.random( 180, 180 ), 0 ) )

    return gull

end

function ENT:OnTakeDamage( dmg )
    self:TakePhysicsDamage( dmg )
    local dmgDivided = dmg:GetDamage() / 5
    dmgDivided = math.ceil( dmgDivided )
    if dmgDivided > 6 then
        dmgDivided = dmgDivided + -6
        dmgDivided = dmgDivided / 4
        dmgDivided = dmgDivided + 6

    end

    local attacker = dmg:GetAttacker()
    local inflictor = dmg:GetInflictor()
    local force = dmg:GetDamageForce()
    local dmgPos = dmg:GetDamagePosition()

    homeless_NudgeRelation( attacker, -0.25 )

    local triggerer
    if attacker:IsPlayer() then
        triggerer = attacker

    end

    self:StartFlying( triggerer )

    local max = 50 -- no crashing pls
    local loops = math.Clamp( dmgDivided, 0, max )

    for _ = 1, loops do
        self.NotNextToStopFlying = self.NotNextToStopFlying * 1.15

        local sacrifice = self:MakeGull( dmgPos )

        timer.Simple( 0, function()
            if not IsValid( sacrifice ) then return end
            if not IsValid( attacker ) then sacrifice:TakeDamage( math.huge, sacrifice ) return end
            if not IsValid( inflictor ) then sacrifice:TakeDamage( math.huge, sacrifice ) return end
            local dmgInf = DamageInfo()
            dmgInf:SetDamage( 10 )
            dmgInf:SetAttacker( attacker )
            dmgInf:SetInflictor( inflictor )
            dmgInf:SetDamagePosition( dmgPos )
            dmgInf:SetDamageForce( force )

            attacker.homeless_Murderer = true

            sacrifice:TakeDamageInfo( dmgInf )

        end )
    end
end