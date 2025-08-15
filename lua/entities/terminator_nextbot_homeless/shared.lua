AddCSLuaFile()
AddCSLuaFile( "client.lua" )

ENT.Base = "terminator_nextbot"
DEFINE_BASECLASS( ENT.Base )

ENT.PrintName = "HIM"
ENT.name = ENT.PrintName
ENT.Spawnable = false
ENT.Author = "HIM"
ENT.ClassName = "terminator_nextbot_homeless"
ENT.Models = { "models/player/corpse1.mdl" }

ENT.IsHomeless = true

-- black
ENT.PlayerColorVec = Vector( 0, 0, 0 )

function ENT:IsSilentStepping()
    return not self:IsSolid()

end

function ENT:CanProperty()
    return false

end
function ENT:CanTool()
    return false

end

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "IsDecoy" )
    if SERVER then
        self:SetIsDecoy( false )

    end
end

if CLIENT then
    include( "client.lua" )

elseif SERVER then
    include( "server.lua" )

end