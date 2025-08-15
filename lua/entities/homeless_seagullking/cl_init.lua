include( "shared.lua" )

local setup

function ENT:Initialize()
    self.Seagulls = {}
    self.NextBigThink = 0
    if not setup then
        setup = true
        CreateMaterial( "homeless_seagullkingmat", "VertexLitGeneric", { ["$basetexture"] = "models/seagull/seagull", ["$treesway"] = 1 } )

    end
    self:SetMaterial( "!homeless_seagullkingmat" )
    self:CallOnRemove( "removeseagulls", function()
        for _, gull in ipairs( self.Seagulls ) do
            SafeRemoveEntity( gull )

        end
    end )
end

function ENT:Draw()
end

function ENT:HideSeagulls()
    for _, gull in ipairs( self.Seagulls ) do
        gull:SetPos( self:LocalToWorld( gull.posOffset ) )
        gull:SetParent( self )
        gull:SetNoDraw( true )

    end
end

function ENT:ShowSeagulls()
    for _, gull in ipairs( self.Seagulls ) do
        gull:SetNoDraw( false )

    end
    self.ScornHidden = nil
end

local function farSounds( ent )
    if math.Rand( 1, 100 ) < 99.9 then return end
    ent:EmitSound( "ambient/levels/coast/seagulls_ambient" .. math.random( 1, 5 ) .. ".wav", 100, math.random( 90, 100 ), 0.25 )

end
local function farSoundsScorn( ent )
    if math.Rand( 1, 100 ) < 99.99 then return end
    ent:EmitSound( "ambient/levels/coast/seagulls_ambient" .. math.random( 1, 5 ) .. ".wav", 110, math.random( 80, 90 ), 0.45 )

end
local function nearSounds( ent )
    if math.random( 1, 100 ) < 75 then return end
    ent:EmitSound( "ambient/creatures/seagull_idle" .. math.random( 1, 3 ) .. ".wav", 80, math.random( 95, 85 ), 1 )

end
local function panicSounds( ent )
    if math.random( 1, 100 ) < 50 then
        if ent.wingFlapping then
            ent.wingFlapping:PlayEx( 1, math.random( 125, 150 ) )

        else
            ent.wingFlapping = CreateSound( ent, "npc/crow/flap2.wav" )
            ent.wingFlapping:SetSoundLevel( 100 )
            ent.wingFlapping:PlayEx( 1, math.random( 125, 150 ) )
            ent:CallOnRemove( "homeless_stopflapping", function( removed )
                if not removed.wingFlapping then return end
                if not removed.wingFlapping:IsPlaying() then return end
                removed.wingFlapping:Stop()

            end )
        end
    else
        ent:EmitSound( "ambient/creatures/seagull_pain" .. math.random( 1, 3 ) .. ".wav", 90, math.random( 90, 100 ), 1 )

    end
end

local function idlingAnims( ent )
    if math.random( 1, 100 ) < 90 then return end
    local seq = "Idle01"
    ent:ResetSequence( seq )
    ent.gullRate = 0.002

    if math.random( 1, 100 ) < 75 then return end
    ent:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )

end

local unrulySequences = {
    "Idle01",
    "Hop",
    "HopB",

}

local function unrulyAnims( ent )
    if math.random( 1, 100 ) < 90 then return end
    local seq = unrulySequences[ math.random( 1, #unrulySequences ) ]
    ent:ResetSequence( seq )
    ent.gullRate = 0.002

    if math.random( 1, 100 ) < 75 then return end
    ent:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )

end

local function takeoffAnims( ent )
    ent:ResetSequence( "Takeoff" )
    ent:SetCycle( 0 )
    ent.gullRate = 0.006

end

local function flyingAnims( ent, vel )
    if math.random( 1, 100 ) < 25 then return end
    ent:ResetSequence( "fly" )

    if math.random( 1, 100 ) < 90 then return end
    ent:SetAngles( vel:GetNormalized():Angle() )
    ent.gullRate = 0.02

end

function ENT:Think()
    if not self.Setup then
        self.Setup = true
        local rad = self:GetModelRadius()
        for _ = 1, 150 do
            local gull = ClientsideModel( "models/seagull.mdl" )
            gull.posOffset = VectorRand() * rad
            gull.gullRate = 0
            gull:SetPos( self:LocalToWorld( gull.posOffset ) )
            gull:SetAngles( AngleRand() )
            gull:SetParent( self )
            table.insert( self.Seagulls, gull )

        end
    end
    local dormant = self:IsDormant()
    local wasDormant = self.WasDormant
    if not dormant and wasDormant then
        self:ShowSeagulls()

    elseif dormant and not wasDormant then
        for _, gull in ipairs( self.Seagulls ) do
            if gull.wingFlapping then
                gull.wingFlapping:FadeOut( 10 )

            end
        end
        self:HideSeagulls()

    end

    self.WasDormant = dormant

    if dormant then return end
    for i, gull in pairs( self.Seagulls ) do
        if not IsValid ( gull ) then table.remove( self.Seagulls, i ) continue end

        local old = gull:GetCycle()
        if not old then continue end

        local cycle = old + gull.gullRate
        if cycle > 1 then cycle = 0 end
        gull:SetCycle( cycle )

    end

    if self.NextBigThink > CurTime() then return end
    self.NextBigThink = CurTime() + math.Rand( 0.1, 0.25 )

    local myPos = self:GetPos()

    local distToGulls = myPos:DistToSqr( LocalPlayer():GetPos() )
    local touched = self:GetFlying()
    local oldTouched = self.OldTouched

    local snd
    local anim

    if terminator_Extras.homeless_Scorned then
        snd = farSoundsScorn
        anim = idlingAnims
        if not self.ScornHidden then
            self.ScornHidden = true
            self:HideSeagulls()

        end

    elseif not touched then
        if oldTouched then
            for _, gull in ipairs( self.Seagulls ) do
                if not gull.wingFlapping then continue end
                if not gull.wingFlapping:IsPlaying() then continue end
                gull.wingFlapping:Stop()

            end
        end
        snd = farSounds
        anim = idlingAnims
        if distToGulls < math.random( 750, 1250 ) ^2 then
            snd = nearSounds
            anim = unrulyAnims

        end
    else
        if not oldTouched then
            anim = takeoffAnims

        else
            anim = flyingAnims

        end
        snd = panicSounds

    end

    self.OldTouched = touched

    if snd then
        for _, gull in ipairs( self.Seagulls ) do
            snd( gull )

        end
    end
    if anim then
        local myVel = self:GetVelocity()
        for _, gull in ipairs( self.Seagulls ) do
            anim( gull, myVel )

        end
    end
end