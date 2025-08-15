include( "shared.lua" )
local fallbackHeadBone = 10
local rotator = Angle( -89.9, 90, 0 )

local function boneCountFixed( soul ) -- "Entity:GetPhysicsObjectNum - Out of bounds physics object - max 14, got 15 (x28)"
    return soul:GetPhysicsObjectCount() + -1

end

local function soulSetPosSimple( soul, pos )
    for bone = 0, boneCountFixed( soul ) do
        local soulsObj = soul:GetPhysicsObjectNum( bone )
        if IsValid( soulsObj ) then
            soulsObj:SetPos( pos, true )

        end
    end
end

local blend = 0.75

function ENT:Initialize()

    local soul = ClientsideRagdoll( "models/player/corpse1.mdl", RENDERGROUP_OPAQUE )
    if not IsValid( soul ) then return end -- :(
    self.mySoul = soul

    self:CallOnRemove( "homeless_cleanuprag", function()
        if not IsValid( self.mySoul ) then return end
        SafeRemoveEntity( self.mySoul )

    end )
    soulSetPosSimple( soul, self:WorldSpaceCenter() )
    soul:SetNoDraw( false )

    for bone = 0, boneCountFixed( soul ) do
        local soulsObj = soul:GetPhysicsObjectNum( bone )
        if IsValid( soulsObj ) then
            soulsObj:SetMass( 1 )
            soulsObj:SetDragCoefficient( 15 )
            soulsObj:EnableCollisions( false )

        end
    end

    local headPhysBoneId = fallbackHeadBone
    local headBoneId

    local eyes = soul:LookupAttachment( "eyes" )
    if eyes > 0 then
        local attachDat = soul:GetAttachment( eyes )
        headBoneId = attachDat.Bone
        headPhysBoneId = soul:TranslateBoneToPhysBone( headBoneId )

    end

    local headPhysBone = soul:GetPhysicsObjectNum( headPhysBoneId )
    if not IsValid( headPhysBone ) then return end

    if owner == LocalPlayer() then
        soul:ManipulateBoneScale( headBoneId, vec_zero )

    end

    headPhysBone:SetMass( headPhysBone:GetMass() * 10000 ) -- so it pulls the other bones along

    soul.HeadPhysBoneId = headPhysBoneId
    soul.HeadPhysBone = headPhysBone

    function soul.RenderOverride( me )

        render.SetBlend( blend )
        render.ResetModelLighting( -4, -4, -4 )
        me:DrawModel()
        render.SetBlend( 1 )
        render.SetColorModulation( 1, 1, 1 )

    end
end

local function soulGotoPos( soul, pos, ang )
    local headBone = soul.HeadPhysBone
    if not IsValid( headBone ) then return end

    local obj = soul:GetPhysicsObject()
    if IsValid( obj ) and obj:IsAsleep() then
        obj:EnableMotion( true )
        obj:Wake()

    end

    headBone:SetPos( pos )
    headBone:SetAngles( ang + rotator ) -- the angles are wrong but w/e

    return headBone

end

function ENT:Think()
    local pos = self:GetShootPos()
    local ang = self:GetAngles()

    soulGotoPos( self.mySoul, pos, ang )

end

function ENT:Draw()
end

function ENT:DrawTranslucent()
end
