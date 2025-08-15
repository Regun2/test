ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Seagull"
ENT.Author = "???"
ENT.Category = "Other"
ENT.Spawnable = false
ENT.AutomaticFrameAdvance = true

ENT.IsFreeGull = true
ENT.BaseFlightSpeed = 300

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", "Flying" )
    self:NetworkVar( "Int", "FlightSpeed" )

end

function ENT:CanTool()
    return false

end

function ENT:CanProperty()
    return false

end

if not terminator_Extras then return end

ENT.PhysgunDisabled = not ( terminator_Extras.areDebugging and GetConVar( "developer" ):GetInt() >= 1 )