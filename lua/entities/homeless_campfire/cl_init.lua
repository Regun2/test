include( "shared.lua" )

language.Add( "homeless_campfire", ENT.PrintName )

function ENT:Draw()
    self:DrawModel()
end

local dist = 1500^2
function ENT:MaintainSound( path, on, level )
    if not self.sounds then self.sounds = {} end
    if on then
        if not self.sounds[path] then
            self.sounds[path] = CreateSound( self, path )
            self:CallOnRemove( path, function()
                if not self.sounds[path] then return end
                self.sounds[path]:Stop()
                self.sounds[path] = nil

            end )
        end
        if self.sounds[path] and not self.sounds[path]:IsPlaying() then
            self.sounds[path]:SetSoundLevel( level )
            self.sounds[path]:Play()

        end
    elseif self.sounds[path] then
        self.sounds[path]:Stop()
        self.sounds[path] = nil

    end
end

function ENT:Think()
    if self:IsDormant() then return end
    if LocalPlayer():GetShootPos():DistToSqr( self:GetPos() ) > dist then return end
    local myFuel = self:GetFuel()

    local shouldCrackle = myFuel > 0 and myFuel < 75
    self:MaintainSound( "homeless/350757__aerror__campfire.mp3", shouldCrackle, 65 )

    local shouldHeavyCrackle = myFuel >= 45
    self:MaintainSound( "ambient/fire/fire_small1.wav", shouldHeavyCrackle, 70 )

    local shouldFurious = myFuel >= 100
    self:MaintainSound( "ambient/fire/fire_med_loop1.wav", shouldFurious, 75 )

    local shouldFurious2 = myFuel >= 200
    self:MaintainSound( "ambient/fire/fire_big_loop1.wav", shouldFurious2, 83 )

end