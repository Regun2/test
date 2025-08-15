include( "shared.lua" )

local entMeta = FindMetaTable( "Entity" )
local vecMeta = FindMetaTable( "Vector" )
local CurTime = CurTime
local EyePos = EyePos
local math = math

local gullCount = #ents.FindByClass( "homeless_freegull" )

function ENT:Think()
    local myTbl = entMeta.GetTable( self )
    if entMeta.IsDormant( self ) then
        if myTbl.wingFlapping then
            myTbl.wingFlapping:Stop()
            myTbl.wingFlapping = nil

        end
        return

    end
    local nextThink = myTbl.nextSoundThink or 0
    if nextThink > CurTime() then return end

    local distToEyePos = vecMeta.Distance( entMeta.GetPos( self ), EyePos() )
    if myTbl.GetFlying( self ) then
        if myTbl.wingFlapping then
            myTbl.wingFlapping:PlayEx( 1, math.random( 100, 110 ) )

        else
            myTbl.wingFlapping = CreateSound( self, "npc/crow/flap2.wav" )
            myTbl.wingFlapping:SetSoundLevel( 70 )
            myTbl.wingFlapping:PlayEx( 1, math.random( 100, 110 ) )
            entMeta.CallOnRemove( self, "homeless_stopflapping", function( removed )
                if not removed.wingFlapping then return end
                if not removed.wingFlapping:IsPlaying() then return end
                removed.wingFlapping:Stop()

            end )
        end
        local dsp = 0
        local pitMul = 1
        if myTbl.EternallyScorned then
            pitMul = 0.8
            dsp = 22 -- OUTSIDE L

        elseif LocalPlayer():GetNW2Bool( "homeless_hallofmirrorify", false ) then
            myTbl.nextSoundThink = CurTime() + 5
            return

        end

        if distToEyePos < math.random( 1000, 2000 ) and math.random( 0, 100 ) > 1 then
            self:EmitSound( "ambient/creatures/seagull_idle" .. math.random( 1, 3 ) .. ".wav", 75, math.random( 99, 101 ) * pitMul, 1, CHAN_VOICE, 0, dsp )
            nextThink = CurTime() + math.Rand( 3, 5 )

        elseif gullCount >= 20 and distToEyePos <= 5000 then
            self:EmitSound( "ambient/levels/coast/seagulls_ambient" .. math.random( 1, 5 ) .. ".wav", math.random( 90, 110 ), math.random( 95, 105 ) * pitMul, 1, CHAN_VOICE, 0, dsp )
            nextThink = CurTime() + math.random( 10, 30 )

        elseif distToEyePos > 5000 then
            nextThink = CurTime() + 10

        end
    elseif myTbl.wingFlapping then
        myTbl.wingFlapping:Stop()
        myTbl.wingFlapping = nil

    end

    myTbl.nextSoundThink = nextThink

end

function ENT:Initialize()
    local fps = 1 / FrameTime()
    if fps < 60 then
        self:DrawShadow( false )

    end
    gullCount = gullCount + 1

end

function ENT:OnRemove( fullUpdate )
    if fullUpdate then return end

    gullCount = gullCount - 1

end


