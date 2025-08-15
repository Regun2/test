AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
    self:SetModel( "models/hunter/misc/sphere1x1.mdl" )
    self:SetNoDraw( true )
    self:DrawShadow( false )

    doubtMyOwnExistence( self, function( me ) me:SetReady( true ) end )
end

function ENT:Think()
    self:EmitSound( "ambient/creatures/flies" .. math.random( 1, 5 ) .. ".wav", 68, math.Rand( 98, 102 ) )
    self:NextThink( CurTime() + math.Rand( 1, 5 ) )
    return true

end