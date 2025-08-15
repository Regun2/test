function EFFECT:Init( data )
    self.Ent = data:GetEntity()

end

local vec_Up = Vector( 0, 0, 1 )
local wind = Vector( math.random( -1, 1 ), math.random( -1, 1 ), 0 )
wind = wind:GetNormalized()
wind = wind * 0.01

function EFFECT:Think()
    if not IsValid( self.Ent ) then return end
    local vOffset = self.Ent:GetPos() + vec_Up * 10
    local smokeEmitter = ParticleEmitter( vOffset )

    local lifetime = math.random( 120, 160 )
    local particleOffset = VectorRand() * 5

    local finalPos = vOffset + particleOffset

    if bit.band( util.PointContents( finalPos ), CONTENTS_SOLID ) > 0 then return end

    -- Smoke particles
    local smokeParticle = smokeEmitter:Add( "particle/particle_smokegrenade", finalPos )
    if smokeParticle then
        local zNoDown = VectorRand()
        zNoDown.z = math.Clamp( zNoDown.z, 0, math.huge )
        smokeParticle:SetVelocity( ( zNoDown * 5 ) + ( vec_Up * math.random( 50, 150 ) ) )
        smokeParticle:SetAirResistance( 1 )
        smokeParticle:SetDieTime( lifetime * math.Rand( 0.75, 1.25 ) )
        smokeParticle:SetColor( 100, 100, 100 )
        smokeParticle:SetStartAlpha( math.random( 190, 220 ) )
        smokeParticle:SetEndAlpha( 0 )
        smokeParticle:SetStartSize( 10 )
        smokeParticle:SetEndSize( math.random( 400, 800 ) )
        smokeParticle:SetRoll( math.Rand( -25, 25 ) )
        smokeParticle:SetRollDelta( math.Rand( -0.15, 0.15 ) )
        smokeParticle:SetGravity( vec_Up + wind )

        smokeParticle:SetCollide( true )
        smokeParticle:SetCollideCallback( function( part )
            part:SetDieTime( 0 )
            part:SetCollide( false )

        end )

    end

    smokeEmitter:Finish()

    return false
end

function EFFECT:Render()
end