ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Radio"
ENT.Author = "???"
ENT.Category = "Other"
ENT.Spawnable = false

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "Ready" )

end

function ENT:CanTool()
    return false

end

function ENT:CanProperty()
    return false

end

local developer = GetConVar( "developer" )
local physDisabled = true
if terminator_Extras and terminator_Extras.areDebugging and developer:GetInt() >= 1 then
    physDisabled = nil

end

ENT.PhysgunDisabled = physDisabled