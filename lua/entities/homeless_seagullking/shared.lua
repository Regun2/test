ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "???"
ENT.Author = "???"
ENT.Category = "Other"
ENT.Spawnable = false

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "Flying" )
    self:NetworkVar( "Vector", 0, "FlyTarget" )

end

function ENT:CanTool()
    return false

end

function ENT:CanProperty()
    return false

end

if not terminator_Extras then return end

ENT.PhysgunDisabled = not ( terminator_Extras.areDebugging and GetConVar( "developer" ):GetInt() >= 1 )