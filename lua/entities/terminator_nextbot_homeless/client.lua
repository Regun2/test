
language.Add( "terminator_nextbot_homeless", ENT.PrintName )

local CurTime = CurTime

local tooClose = 300
local wayTooClose = 175
local flattener = Vector( 1, 1, 0.05 )

local sanity = 32000
local saneVec = Vector()
local function setPosSane( ent, pos )
    saneVec.x = math.Clamp( pos.x, -sanity, sanity )
    saneVec.y = math.Clamp( pos.y, -sanity, sanity )
    saneVec.z = math.Clamp( pos.z, -sanity, sanity )
    ent:SetPos( saneVec )

end

local peeped
local plsDraw
local photoing
local stopHijacking
local checkDisposition
local disposition = CreateClientConVar( "cl_ai_disposition", "4", true, true, "For.", -100, 100 )

local nextSend = 0
local interval = 0.001

function ENT:sendSeen()
    if nextSend > CurTime() then return end
    nextSend = CurTime() + interval

    net.Start( "homeless_seen" )
        net.WriteEntity( self )
    net.SendToServer()

end

local nextSendEvil = 0

function ENT:sendEvilSeen()
    if nextSendEvil > CurTime() then return end
    nextSendEvil = CurTime() + interval

    net.Start( "homeless_seen_seen_seen" )
        net.WriteEntity( self )
    net.SendToServer()

end

-- tattle on the nextbot
function ENT:Draw()
    if not plsDraw and not self:IsSolid() then return end
    if not system.HasFocus() then self:DrawModel() return end
    local renderTargeting = render.GetRenderTarget() ~= nil
    if renderTargeting then
        local oldCount = self.DontShowUpCount or 0
        if oldCount > 1 then
            self.DontShowUpCount = self.DontShowUpCount + -0.005
            return

        end
    end

    local myShootPos = self:GetShootPos()
    local screened = myShootPos:ToScreen()
    local width = ScrW()
    local height = ScrH()
    local middleX = width / 2
    local middleY = height / 2

    local toMiddleX = math.abs( screened.x - middleX )
    local toMiddleY = math.abs( screened.y - middleY )

    local looking = ( toMiddleX < width / 10 ) and ( toMiddleY < height / 10 )
    local onscreen = ( toMiddleX < width / 2 ) and ( toMiddleY < height / 2 )

    if renderTargeting then
        if looking then
            self:sendEvilSeen()
            local oldCount = self.DontShowUpCount or 0
            self.DontShowUpCount = oldCount + 5

        elseif onscreen then
            self:sendSeen()

        end
    elseif looking then
        self:sendSeen()

    elseif onscreen then
        local lookCount = self.lookCount or 0
        self.lookCount = lookCount + 1
        if lookCount > math.random( 200, 1500 ) then
            self.lookCount = math.random( 0, 200 )
            self:sendSeen()

        end
    end

    if self.isClose and myShootPos:Distance( LocalPlayer():GetShootPos() ) < wayTooClose then
        self:BackUp()
        self:sendEvilSeen()

        local oldCount = self.DontShowUpCount or 0
        self.DontShowUpCount = oldCount + 1

    end

    self:DrawModel()
    if ( plsDraw or photoing ) and onscreen and terminator_Extras.PosCanSeeComplex( LocalPlayer():GetShootPos(), self:GetShootPos(), { self, LocalPlayer() } ) then
        if self:IsSolid() then
            self:sendEvilSeen()

        else
            peeped = true

        end
    end

    if checkDisposition and disposition:GetInt() then
        self:sendSeen()

    end
end

function ENT:BackUp( tooCloseInt )
    tooCloseInt = tooCloseInt or tooClose

    local push = self:GetShootPos() - LocalPlayer():GetShootPos()
    local pushDir = push:GetNormalized()
    local pushAmnt = tooClose - push:Length()
    pushAmnt = math.Clamp( pushAmnt, 0.01, 0.5 )
    setPosSane( self, self:GetPos() + pushDir * pushAmnt )

end

local volNum = 10
local maxAudibleBudget = 2500
local audibleBudget = maxAudibleBudget

local function windVol( me )
    if audibleBudget > 0 then
        audibleBudget = audibleBudget - 1
        local vol = me.windVolumeMul or 0.01
        return vol * ( audibleBudget / maxAudibleBudget )
    else
        return 0
    end
end

function ENT:AdditionalClientInitialize()
    self.sndsPlaying = {}
    self.tooCloseDist = 200
    local volMul = volNum - LocalPlayer():GetInfoNum( "ai_note_detail", -1 )
    volMul = volMul / volNum
    volMul = volMul * 0.2
    volMul = math.Clamp( volMul, math.Rand( 0.001, 0.009 ), 1 )
    self.windVolumeMul = volMul

end

local winds = {
    "ambient/wind/wasteland_wind.wav",
    "ambient/wind/wind1.wav",
    "ambient/wind/wind_med1.wav",
    "ambient/wind/wind_med2.wav",
    "ambient/wind/wind_rooftop1.wav",
    "homeless/ambiance/coldwind1_loop.wav", -- bro said he knew a spot
    "homeless/ambiance/coldwind2_loop.wav",
    "homeless/ambiance/coldwind3_loop.wav",

}

local snds = {
    invis = { paths = winds, basePit = 30, reverseMul = 0.2, volume = windVol, lvl = 55 },
    dormant = { paths = winds, basePit = 40, reverseMul = 0.2, volume = 0.08, lvl = 50 },
    speaking = { paths = { "homeless/ambiance/talking.mp3" }, basePit = 100, reverseMul = 0.1, volume = 0.25, lvl = 65 },
    beat = { paths = { "ambient/atmosphere/city_rumble_loop1.wav" }, basePit = 20, reverseMul = 0.05, volume = 1, lvl = 65, shake = 0.25 },
    deepHall = { paths = { "ambient/levels/citadel/drone1lp.wav" }, basePit = 20, reverseMul = 0.05, volume = 1, lvl = 65, shake = 5 }

}

function ENT:Think()
    local localPly = LocalPlayer()
    local localPlysShoot = localPly:GetShootPos()
    local myShootPos = self:GetShootPos()
    local dist = myShootPos:Distance( localPlysShoot )
    local isClose = dist < tooClose
    local reverseClose = tooClose - dist

    self.isClose = isClose

    local sndsToDo = {}

    if self:IsDormant() then
        local jitter = self.homeless_Jitter or 0
        if jitter > CurTime() then
            local scale = math.abs( self.homeless_Jitter - CurTime() ) * 2
            setPosSane( self, self:GetPos() + VectorRand() * scale )

        end
        sndsToDo.dormant = true
        if dist < self.tooCloseDist then
            self.tooCloseDist = self.tooCloseDist + 5
            if math.random( 0, 1000 ) <= 999 then
                self:BackUp( self.tooCloseDist )
                self.homeless_Jitter = math.max( jitter, CurTime() + 0.5 )

            elseif math.random( 0, 100 ) <= 99 then
                local behindOffs = VectorRand() * flattener * math.random( 10, self.tooCloseDist * 1.15 )
                setPosSane( self, localPly:GetPos() + behindOffs )
                self.homeless_Jitter = math.max( jitter + 2, CurTime() + 5 )

            else
                setPosSane( self, self:GetPos() + self:GetPos() )
                self.homeless_Jitter = math.max( jitter, CurTime() + 2 )

            end
        end

    elseif isClose and self:IsSolid() then
        sndsToDo.speaking = true
        sndsToDo.beat = true
        if dist < 100 then
            sndsToDo.deepHall = true

        end
    elseif isClose then
        sndsToDo.invis = true

    end

    for key, data in pairs( snds ) do
        local currPit = data.basePit + ( reverseClose * data.reverseMul )
        if sndsToDo[key] and currPit > 0.05 then -- playing
            if not self.sndsPlaying[key] then
                self.sndsPlaying[key] = CreateSound( localPly, data.paths[math.random( 1, #data.paths )] )
                self.sndsPlaying[key]:PlayEx( 0, data.basePit )

            else
                local volume = data.volume or 0.01
                if isfunction( volume ) then
                    volume = volume( self )

                end
                volume = volume or 0.01 -- TODO: remove if unnecessary 
                self.sndsPlaying[key]:ChangeVolume( volume * ( reverseClose / tooClose ) )
                self.sndsPlaying[key]:ChangePitch( currPit )

            end
            if data.shake then
                util.ScreenShake( localPlysShoot, data.shake * ( reverseClose / tooClose ), 20, 0.1, 500 )

            end
        elseif self.sndsPlaying[key] and self.sndsPlaying[key]:IsPlaying() then
            self.sndsPlaying[key]:Stop()
            self.sndsPlaying[key] = nil

        end
    end
end

function ENT:OnRemove()
    for _, snd in pairs( self.sndsPlaying ) do
        if snd and snd:IsPlaying() then
            snd:Stop()

        end
    end
end

local function RevealThenOldAttack( self )
    photoing = true

    timer.Simple( 0.01, function()
        plsDraw = nil
        photoing = nil
        if peeped then
            stopHijacking = true

        end
    end )

    if stopHijacking then self:homeless_OldPrimaryAttack() return end

    local homeless = ents.FindByClass( "terminator_nextbot_homeless" )

    if #homeless <= 0 then self:homeless_OldPrimaryAttack() return end
    if not IsFirstTimePredicted() then return end

    plsDraw = true
    self:GetOwner():ConCommand( "jpeg" )

end

local function HijackCamera( SWEP )
    if not SWEP then return end
    SWEP.homeless_OldPrimaryAttack = SWEP.homeless_OldPrimaryAttack or SWEP.PrimaryAttack

    SWEP.PrimaryAttack = function( self )
        RevealThenOldAttack( self )

    end
end

HijackCamera( weapons.GetStored( "gmod_camera" ) )
HijackCamera( weapons.GetStored( "selfportrait_camera" ) )