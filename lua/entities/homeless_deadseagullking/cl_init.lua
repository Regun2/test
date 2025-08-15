include( "shared.lua" )

local gullsGlobal = {}

function ENT:Initialize()
    self.Gulls = {}

end

function ENT:OnRemove()
    for _, gull in ipairs( self.Gulls ) do
        SafeRemoveEntity( gull )

    end
end

function ENT:Draw()
end

local upOffs = Vector( 0,0,25 )
local pooOffs = Vector( 0,0,-1000 )

function ENT:Think()
    if not self:GetReady() then return end
    if self:IsDormant() then return end
    if not self.Setup then
        self.Setup = true
        local rad = self:GetModelRadius()
        local myPos = self:WorldSpaceCenter()
        for _ = 1, 25 do
            local gull = ClientsideRagdoll( "models/seagull.mdl" )
            gull:SetNoDraw( false )
            gull:DrawShadow( true )
            table.insert( self.Gulls, gull )

            local count = 0
            if #gullsGlobal >= 100 then
                for ind, gullGbl in pairs( gullsGlobal ) do
                    if not IsValid( gullGbl ) then table.remove( gullsGlobal, ind ) continue end
                    count = count + 1
                end
            end
            if count >= 100 then
                for ind, gullGbl in pairs( gullsGlobal ) do
                    SafeRemoveEntity( gullGbl )
                    table.remove( gullsGlobal, ind )
                    count = count + -1
                    if count < math.random( 75, 125 ) then break end
                end
            end
            table.insert( gullsGlobal, gull )

            local radMul = math.Rand( 0.25, 1 )
            if math.random( 1, 100 ) < 25 then
                radMul = math.Rand( 1, 4 )

            end

            local gullsAng = AngleRand()

            local offset = VectorRand()
            offset.z = 0
            offset:Normalize()
            offset = ( offset * rad * radMul ) + upOffs
            local pos = myPos + offset

            for boneInd = 0, gull:GetPhysicsObjectCount() + -1 do
                local obj = gull:GetPhysicsObjectNum( boneInd )
                if not IsValid( obj ) then continue end
                obj:SetPos( pos )
                obj:SetAngles( gullsAng )

            end

            local maxXY = 500
            local pooStart = myPos + Vector( math.random( -maxXY, maxXY ), math.random( -maxXY, maxXY ), math.random( -25, 25 ) )
            util.Decal( "BirdPoop", pooStart, pooStart + pooOffs, self )

        end
        self:SetNextClientThink( math.huge )
        return true

    end
end