AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
    self:SetModel( "models/props_debris/concrete_spawnplug001a.mdl" )
    self:SetMaterial( "models/props_debris/plasterwall009d" )
    self:SetModelScale( 0.5 )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:DrawShadow( false )

    self:SetCollisionGroup( COLLISION_GROUP_WORLD )

    local phys = self:GetPhysicsObject()
    if IsValid( phys ) then
        phys:EnableMotion( false )

    end

    self:SetPos( self:GetPos() + Vector( 0,0,10 ) )

    timer.Simple( 0, function()
        if not IsValid( self ) then return end
        local traceDat = {
            start = self:WorldSpaceCenter(),
            endpos = self:WorldSpaceCenter() + Vector( 0, 0, -50 ),
            mask = MASK_SOLID_BRUSHONLY,

        }
        local trResult = util.TraceLine( traceDat )
        self:SetPos( trResult.HitPos )
        ang = trResult.HitNormal:Angle()
        ang:RotateAroundAxis( ang:Right(), -90 )
        ang:RotateAroundAxis( ang:Up(), math.random( -180, 180 ) )

        self:SetAngles( ang )

    end )
    timer.Simple( 0.05, function()
        if not IsValid( self ) then return end
        self:SetPos( self:GetPos() + Vector( 0,0,-3 ) )

    end )

    self.nextFire = 0
    self.nextEat = 0
    self:SetFuel( math.random( 1, 80 ) )

    doubtMyOwnExistence( self )

end

local sizedEffects = {
    [ 0 ] = "fire_small_02",
    [ 45 ] = "fire_small_01",
    [ 100 ] = "fire_small_03",
    [ 200 ] = "fire_medium_02",

}

local flammableMatParts = {
    "wood",
    "paper",
    "cardboard",
    "plastic",
    "rubber",
    "upholstery"
}
local gasModels = {
    ["models/props_junk/gascan001a.mdl"] = true,
    ["models/props_junk/metalgascan.mdl"] = true,
    ["models/props_c17/oildrum001_explosive.mdl"] = true,
    ["models/props_junk/propane_tank001a.mdl"] = true,
}


function ENT:Think()
    local myPos = self:LocalToWorld( self:GetPhysicsObject():GetMassCenter() )

    local ourSize = self:GetFuel()

    local loss = math.max( ourSize / 400, 0.015 )

    if ourSize >= 45 then
        loss = math.max( ourSize / 150, 0.015 )

    end
    local newFuel = math.Clamp( ourSize - loss, 0, 400 )

    if self.nextEat < CurTime() then
        local distNeeded = math.Clamp( newFuel * 0.45, 5, 80 )
        for _, ent in ipairs( ents.FindInSphere( myPos, 80 ) ) do
            if ent == self then continue end

            local model = ent:GetModel()
            local gasCan = model and gasModels[ model ] and ent:GetMaxHealth() > 1
            local gullKing = ent:GetClass() == "homeless_seagullking"
            local whitelisted = gullKing or gasCan
            local goodMat = gasCan
            if not whitelisted then
                local entsObj = ent:GetPhysicsObject()
                if not IsValid( entsObj ) then continue end

                if not entsObj:IsMotionEnabled() then continue end

                local entsMat = entsObj:GetMaterial()
                if not entsMat then continue end

                entsMat = string.lower( entsMat )

                for _, currGood in ipairs( flammableMatParts ) do
                    if string.find( entsMat, currGood ) then
                        goodMat = true
                        break

                    end
                end
            end
            local can = ( newFuel > 0 ) or ( newFuel <= 0 and ent:IsOnFire() )
            local close = ent:NearestPoint( myPos ):DistToSqr( myPos ) < distNeeded ^ 2
            local entsNextEat = ent.homeless_nextEat or 0
            if newFuel > 0 and close then
                ent.homeless_CampfireLastEat = CurTime()
                if ent:IsPlayer() then
                    local damageI = DamageInfo()
                    damageI:SetDamage( loss * 20 )
                    damageI:SetAttacker( self )
                    damageI:SetInflictor( self )
                    damageI:SetDamageType( DMG_BURN )
                    ent:TakeDamageInfo( damageI )

                elseif gasCan then
                    ent:Ignite( 1 )
                    ent.homeless_nextEat = CurTime() + 0
                    ent.homeless_EatenGasCan = true

                elseif goodMat then
                    ent:Ignite( 5 )

                elseif ent:IsNPC() or gullKing then
                    local damageI = DamageInfo()
                    damageI:SetDamage( loss * 20 )
                    damageI:SetAttacker( self )
                    damageI:SetInflictor( self )
                    damageI:SetDamageType( DMG_BURN )
                    ent:TakeDamageInfo( damageI )
                    ent:Ignite( 5 )

                else
                    local damageI = DamageInfo()
                    damageI:SetDamage( loss * 5 )
                    damageI:SetAttacker( self )
                    damageI:SetInflictor( self )
                    damageI:SetDamageType( DMG_BURN )
                    ent:TakeDamageInfo( damageI )

                end
            end
            if can and entsNextEat < CurTime() and goodMat and close then
                self.nextEat = CurTime() + 1
                ent.homeless_nextEat = CurTime() + 4
                local time = 3 - ( loss * 0.5 )
                time = math.max( time, 0.5 )
                local value
                if gasCan then
                    time = 0.5
                    value = 100

                end
                timer.Simple( time, function()
                    if not IsValid( ent ) then return end
                    if not IsValid( self ) then return end
                    if not IsValid( ent:GetPhysicsObject() ) then return end
                    if ent:NearestPoint( myPos ):DistToSqr( myPos ) > distNeeded ^ 2 then return end
                    value = value or ent:GetPhysicsObject():GetMass()
                    self:SetFuel( self:GetFuel() + value )
                    ent:EmitSound( "ambient/fire/mtov_flame2.wav" )

                    ent.homeless_CampfireEaten = true
                    ent.homeless_CampfireLastEat = CurTime()
                    hook.Run( "homeless_oncampfireeat", ent, self )

                    ent:TakeDamage( math.huge, self, self )
                    SafeRemoveEntityDelayed( ent, 0 )

                end )
                break

            end
        end
    end

    self:SetFuel( newFuel )

    if newFuel <= 0 then
        self:NextThink( CurTime() + 3 )
        return true

    end

    local sizedEffect
    local bestSize = 0
    for size, effect in pairs( sizedEffects ) do
        if size < newFuel and size >= bestSize then
            sizedEffect = effect

        end
    end

    if self.nextFire < CurTime() then
        local particleeffect = ents.Create( "info_particle_system" )
        self.particleeffect = particleeffect

        particleeffect:SetKeyValue( "effect_name", sizedEffect )
        particleeffect:SetKeyValue( "start_active" , 1 )
        particleeffect:SetOwner( self )
        particleeffect:SetPos( myPos )
        particleeffect:SetAngles( self:GetAngles() )
        particleeffect:Spawn()
        particleeffect:Activate()
        particleeffect:SetParent( self )
        local stop = math.Rand( 2, 3 )
        self.nextFire = stop + -0.5

        particleeffect:Fire( "Stop", "", stop )

        SafeRemoveEntityDelayed( self.particleeffect, stop )

    end

    if newFuel > math.random( 0, 150 ) then
        local effDat = EffectData()
        effDat:SetEntity( self )

        local allPlys = RecipientFilter()
        allPlys:AddAllPlayers()
        util.Effect( "fire_smokesignal", effDat, nil, allPlys )

    end

    self:NextThink( CurTime() + math.Rand( 0.5, 1 ) )
    return true

end