AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
    self:SetModel( "models/maxofs2d/camera.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )

    local phys = self:GetPhysicsObject()
    if IsValid( phys ) then
        phys:Wake()

    end

    self.photoInterval = 5
    self.nextPhotoTime = 0
    self.maxPhotos = math.random( 1, 2 )
    if math.random( 1, 100 ) < 25 then
        self.maxPhotos = math.huge

    end
    self.photosTaken = 0
end

local shootsound = Sound( "NPC_CScanner.TakePhoto" )
function ENT:TakePhoto()
    if self.broken then return end

    if self.nextPhotoTime > CurTime() then return end
    self.nextPhotoTime = CurTime() + self.photoInterval

    if self.photosTaken > self.maxPhotos then return end

    self:EmitSound( shootsound )

    local vPos = self:WorldSpaceCenter()
    local vForward = self:GetForward()

    local trace = {}
    trace.start = vPos
    trace.endpos = vPos + vForward * 256
    trace.filter = self

    local tr = util.TraceLine( trace )

    local effect = EffectData()
        effect:SetOrigin( tr.HitPos )
    util.Effect( "camera_flash", effect )

end

function ENT:Think()
    self:NextThink( CurTime() + math.Rand( 0.75, 1.25 ) )
    local pos = self:WorldSpaceCenter()
    local trace = {
        start = pos,
        endpos = pos + self:GetForward() * 512,
        filter = self,
    }

    local result = util.TraceLine( trace )

    if result.Hit and IsValid( result.Entity ) and result.Entity:IsPlayer() then
        self:NextThink( CurTime() + math.Rand( 5, 10 ) )
        self:TakePhoto()

    end

    return true

end

function ENT:Use( activator )
    if not self.GivenPlayerness then
        self.GivenPlayerness = true
        homeless_Playerness( activator, 0.1 )

    else
        homeless_Playerness( activator, 0.005 )

    end
    timer.Simple( 0, function()
        if not IsValid( self ) then return end
        self:TakePhoto()

    end )
end


function ENT:OnTakeDamage( dmg )
    self:TakePhysicsDamage( dmg )
    if dmg:GetDamage() <= 5 then return end
    self.broken = true

end

local GAMEMODE = GAMEMODE or GM
if not GAMEMODE.RandomlySpawnEnt then return end

GAMEMODE:RandomlySpawnEnt( "homeless_radio", 1, 1, 25 )