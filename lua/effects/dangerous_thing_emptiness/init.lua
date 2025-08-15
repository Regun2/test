local flatten = Vector( 1, 1, 0.2 )
local toTheSide = Vector( 1, 1, 0 )
local toTheSideOfSide = toTheSide:Cross( Vector( 0,0,1 ) )

function EFFECT:Init( data )
    self.Ent = data:GetEntity()
    self.Scale = data:GetScale() or 25
    if self.Scale <= 0 then return end

end

function EFFECT:Think()
    local vOffset = self.Ent:GetPos() + self.Ent:GetVelocity() * 1.5
    local emitter = ParticleEmitter( vOffset )
    local lifetime = 10

    for _ = 1, 50 * self.Scale do

        local toTheSideComp = toTheSide * 1000
        local randomComp = toTheSideOfSide * math.random( -1500, 1500 )
        randomComp = randomComp * flatten

        local particleOffset = toTheSideComp + randomComp

        local rollparticle = emitter:Add( "particle/particle_smokegrenade1", vOffset )
        rollparticle:SetPos( vOffset + particleOffset )

        local vel = ( -toTheSide + ( VectorRand() * 0.5 ) )
        vel = vel * flatten * math.random( 150, 250 ) * self.Scale
        vel.z = math.Clamp( vel.z, 10, math.huge )

        rollparticle:SetVelocity( vel )

        rollparticle:SetDieTime( lifetime + math.Rand( -5, 5 ) )
        rollparticle:SetColor( 10, 10, 10 )
        rollparticle:SetStartAlpha( 255 )
        rollparticle:SetEndAlpha( 50 )
        rollparticle:SetStartSize( 225 )
        rollparticle:SetEndSize( 800 )
        rollparticle:SetRoll( math.Rand( -360, 360 ) )
        rollparticle:SetRollDelta( math.Rand( -0.1, 0.1 ) )
        rollparticle:SetAirResistance( 1 )
        rollparticle:SetGravity( Vector( 0, 0, -.5 ) )
        rollparticle:SetCollide( false )

    end
    emitter:Finish()

    return false

end

function EFFECT:Render()

end