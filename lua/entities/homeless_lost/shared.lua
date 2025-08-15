ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "???"
ENT.Author = "???"
ENT.Category = "Other"
ENT.Spawnable = false

function ENT:CanTool()
    return false

end

function ENT:CanProperty()
    return false

end

function ENT:GetShootPos()
    return self:GetPos()

end