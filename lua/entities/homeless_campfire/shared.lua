ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "His Fire"
ENT.Author = "???"
ENT.Category = "Other"
ENT.Spawnable = false

function ENT:SetupDataTables()
    self:NetworkVar( "Float", 1, "Fuel" )

end

ENT.PhysgunDisabled = true
function ENT:CanProperty()
    return false

end
function CanTool()
    return false

end