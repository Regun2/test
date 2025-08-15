AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

local spawnOffs = Vector( 0, 0, 55 )

function ENT:Initialize()

    self:SetModel( "models/hunter/misc/sphere025x025.mdl" )
    self:DrawShadow( false )
    self:SetNoDraw( true )
    self.Speed = 0

    doubtMyOwnExistence( self )

    timer.Simple( 0, function()
        if not IsValid( self ) then return end
        self:SetPos( self:GetPos() + spawnOffs )

    end )

    self.MyBias = VectorRand()

end

function ENT:Think()
    local waker = self.homeless_LostWaker
    local interrupting, ply
    local myShoot = self:GetShootPos()

    if not IsValid( waker ) then
        interrupting, ply = terminator_Extras.posIsInterrupting( myShoot )
        local wait = 5
        if interrupting and ply then
            self.homeless_LostWaker = ply
            homeless_Playerness( ply, 1 )
            local dist = myShoot:Distance( ply:GetShootPos() )
            wait = ply:GetInfoNum( "cl_homeless_dedication", 0 )
            wait = wait + ( homeless_NoteDetail( ply ) / 2 )
            if dist < 500 then
                wait = 0

            end
            self.Speed = -wait
            self.tooCloseDist = dist + -4000
            self.tooCloseDist = math.max( self.tooCloseDist, 1500 )

        end
        if homeless_IsHomelessActive() then SafeRemoveEntity( self ) return end

        self:NextThink( CurTime() + math.Rand( 0, wait / 10 ) )
        return true

    else
        if not util.IsInWorld( myShoot ) and not self.LEAVING then
            local _, nextToVoid = terminator_Extras.GetVoiceboxPos( myShoot )
            if nextToVoid then
                self.LEAVING = true
                self.Speed = self.Speed + 1
                SafeRemoveEntityDelayed( self, 1 )

            end
        end
        self:NextThink( CurTime() )

        local wakersShoot = waker:GetShootPos()
        local distToWaker = myShoot:Distance( wakersShoot )

        self.Speed = self.Speed + 0.005
        local speed = self.Speed

        if distToWaker < self.tooCloseDist then
            self.Speed = self.Speed + 0.005
            speed = speed + ( waker:GetVelocity():Length() * 0.1 )
            self.tooCloseDist = self.tooCloseDist + speed / 4

        end

        local dir = terminator_Extras.dirToPos( wakersShoot, myShoot )
        dir = ( dir * 0.75 ) + ( self.MyBias * 0.25 )
        self:SetAngles( ( -dir ):Angle() )

        if speed <= 0 then return true end
        local vel = dir * speed
        local newPos = self:GetPos() + vel
        self:SetPos( newPos )

        return true

    end
end

function ENT:UpdateTransmitState()
    return TRANSMIT_ALWAYS

end