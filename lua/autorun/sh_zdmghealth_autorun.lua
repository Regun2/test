AddCSLuaFile()

if not terminator_Extras then return end

local developer = GetConVar( "developer" )
local function debugging()
    if not terminator_Extras.areDebugging then return end
    if developer:GetInt() < 1 then return end
    return true

end

local function debugPrint( ... )
    if not debugging() then return end
    print( ... )

end

local function debugPrintTable( ... )
    if not debugging() then return end
    PrintTable( ... )

end

local IsValid = IsValid

local function escaped( escaper )
    if bit.band( util.PointContents( escaper:GetPos() ), CONTENTS_SOLID ) == 0 then return true end
    return nil

end

local vec_zero = Vector( 0,0,0 )

local function inWall( pos )
    return bit.band( util.PointContents( pos ), MASK_SOLID_BRUSHONLY ) > 0

end

function terminator_Extras.GetVoiceboxDir( pos )
    local dir = pos - vec_zero
    dir:Normalize()
    return dir

end

function terminator_Extras.GetVoiceboxPos( pos, dirOverride )
    local toCreatePos = nil
    -- need uninterrupted segment this long to return pos
    local toConsiderVoid = 24000^2
    local stepSize = 40
    local dir = dirOverride or terminator_Extras.GetVoiceboxDir( pos )

    local oldInWorld = not inWall( pos )
    local comparePos = pos
    local wallCount = 0
    local iter = 1
    local nearestWall

    while iter < 1000 do
        iter = iter + 1

        local offset = iter * stepSize
        toCreatePos = pos + ( dir * offset )

        local currInWorld = not inWall( toCreatePos )

        if oldInWorld and not currInWorld then
            comparePos = toCreatePos
            wallCount = wallCount + 1
            if not nearestWall then
                nearestWall = toCreatePos

            end

        end
        oldInWorld = currInWorld

        if not currInWorld and toCreatePos:DistToSqr( comparePos ) > toConsiderVoid then break end

    end

    local nextToVoid = wallCount <= 1

    return toCreatePos, nextToVoid, nearestWall

end

if CLIENT then -- elseif for readability
    local CurTime               = CurTime
    local LocalPlayer           = LocalPlayer
    local _ScrW                 = ScrW
    local _ScrH                 = ScrH
    local surface_SetDrawColor  = surface.SetDrawColor
    local surface_DrawRect      = surface.DrawRect
    local util_PointContents    = util.PointContents

    CreateClientConVar( "cl_homeless_banishment", "0", true, true )
    CreateClientConVar( "cl_homeless_dedication", "0", true, true )
    CreateClientConVar( "cl_homeless_nexthomeless", "0", true, true, "For charity." )
    CreateClientConVar( "cl_nav_readyness", "0", true, true, "For charity." )
    CreateClientConVar( "ai_overridden_enterers", "0", true, true, "For charity." )
    CreateClientConVar( "ai_entrance_initial", "0", true, true, "For charity." )
    CreateClientConVar( "ai_note_ideal_detail", "0", true, true, "For charity." )
    CreateClientConVar( "ai_note_detail", "-1", true, true, "For charity." )

    hook.Add( "InitPostEntity", "homeless_identify_initial_entrance", function()
        if GetConVar( "ai_entrance_initial", 0 ):GetInt() > 1000 then return end
        local current = os.time()
        local week = 604800
        local mul = math.random( 12, 42 )
        local wait = week * mul
        LocalPlayer():ConCommand( "ai_entrance_initial " .. math.Round( current + wait ) )

    end )

    LocalPlayer().isSheltered = nil

    local nextRecieve = 0
    net.Receive( "homeless_emptyness", function()
        if nextRecieve > CurTime() then return end
        if #player.GetAll() > 1 then return end
        nextRecieve = CurTime() + 60

        hook.Add( "Think", "homeless_waituntilready_toempty", function()
            if not system.HasFocus() then return end
            LocalPlayer():ConCommand( "stopsound" )
            LocalPlayer():ConCommand( "snd_restart" )
            hook.Remove( "Think", "homeless_waituntilready_toempty" )

        end )
    end )

    local callingPos

    net.Receive( "homeless_calling", function()
        local starting = net.ReadBool()
        local pos = net.ReadVector()
        local vol = net.ReadFloat()

        callingPos = pos

        if starting then
            sound.Play( "ambient/levels/coast/seagulls_ambient2.wav", callingPos, 125, 74, vol, 131 )
            sound.Play( "ambient/levels/coast/seagulls_ambient1.wav", callingPos, 125, 74, vol, 131 )

            timer.Simple( 6, function()
                sound.Play( "ambient/levels/coast/seagulls_ambient2.wav", callingPos, 130, 80, vol, 131 )
                sound.Play( "ambient/levels/coast/seagulls_ambient3.wav", callingPos, 130, 80, vol, 131 )

            end )
            timer.Simple( 12, function()
                sound.Play( "ambient/levels/coast/seagulls_ambient2.wav", callingPos, 135, 90, vol, 131 )
                sound.Play( "ambient/levels/coast/seagulls_ambient4.wav", callingPos, 135, 90, vol, 131 )

            end )
            timer.Simple( 12 + 12, function()
                sound.Play( "ambient/levels/coast/seagulls_ambient2.wav", callingPos, 140, 90, vol, 131 )
                sound.Play( "ambient/levels/coast/seagulls_ambient5.wav", callingPos, 140, 90, vol, 131 )

            end )
            timer.Simple( 12 + 12 + 12, function()
                sound.Play( "ambient/levels/coast/seagulls_ambient2.wav", callingPos, 145, 90, vol, 131 )
                sound.Play( "ambient/levels/coast/seagulls_ambient3.wav", callingPos, 145, 92, vol, 131 )
                sound.Play( "ambient/levels/coast/seagulls_ambient4.wav", callingPos, 145, 88, vol, 131 )
                sound.Play( "ambient/levels/coast/seagulls_ambient5.wav", callingPos, 145, 95, vol, 131 )

            end )
        end
    end )

    net.Receive( "deafen_thing_shelterednessdefine", function()
        local shelteredState = net.ReadBool()
        LocalPlayer().isSheltered = shelteredState

    end )

    local nextCheck = 0
    local cached

    local function IsSheltered()
        local cur = CurTime()
        if nextCheck > cur then return cached end
        nextCheck = cur + 0.01

        if LocalPlayer().isSheltered ~= true then cached = nil return end
        if LocalPlayer():GetNW2Bool( "deafen_thing_shouldbesheltered", false ) ~= true then cached = nil return end -- make sure nobody exploits this on people!

        cached = true
        return true

    end

    hook.Add( "PreDrawHUD", "deafen_thing_shelterednessitem", function()
        if not IsSheltered() then return end

        local alpha = 230

        if bit.band( util_PointContents( LocalPlayer():GetShootPos() ), CONTENTS_WATER )  ~= 0 then
            alpha = 255

        end

        surface_SetDrawColor( 0, 0, 0, alpha )
        surface_DrawRect( -_ScrW() * 0.5, -_ScrH() * 0.5, _ScrW(), _ScrH() )

    end )

    local skyOverrideMat = Material( "lights/white002" )
    local vecZero = Vector( 0, 0, 0 )
    local skyOverridePos = Vector( 0, 0, 200 )
    local skyOverrideColor = Color( 0, 0, 0 )
    local tiltedVecs = {
        Vector( 0.25, 0, -0.75 ),
        Vector( -0.25, 0, -0.75 ),
        Vector( 0, 0.25, -0.75 ),
        Vector( 0, -0.25, -0.75 ),

    }
    local vecUp = Vector( 0, 0, 1 )

    hook.Add( "PostDraw2DSkyBox", "deafen_thing_shelteredness_overridesky", function()
        if not IsSheltered() then return end

        render.OverrideDepthEnable( true, false ) -- ignore Z to prevent drawing over 3D skybox

        -- Start 3D cam centered at the origin
        cam.Start3D( vecZero, EyeAngles() )
            for _, tiltedVec in ipairs( tiltedVecs ) do
                render.SetMaterial( skyOverrideMat )
                render.DrawQuadEasy( skyOverridePos, tiltedVec, 32000, 32000, skyOverrideColor, 0 )

            end
            render.DrawQuadEasy( -skyOverridePos, vecUp, 32000, 32000, skyOverrideColor, 0 )

        cam.End3D()

        render.OverrideDepthEnable( false, false )

    end )

    local function shelterednessFog( scale )
        if not IsSheltered() then return end

        scale = scale or 1

        render.FogMode( MATERIAL_FOG_LINEAR )
        render.FogStart( 5 * scale )
        render.FogEnd( 800 * scale )
        render.FogMaxDensity( 1 )
        render.FogColor( 0,0,0 )

        return true

    end

    hook.Add( "SetupWorldFog", "deafen_thing_shelterednessfog_world", shelterednessFog )
    hook.Add( "SetupSkyboxFog", "deafen_thing_shelterednessfog_skybox", shelterednessFog )

    local gameMat2 = CreateMaterial( "homeless_cfc_ulx_commands_curse_game_rt_2", "UnlitGeneric", {
        ["$basetexture"] = "_rt_fullframefb",
        ["$ignorez"] = 1,
    } )
    local vectorMeta = FindMetaTable( "Vector" )

    -- flipping
    local function doFlipping()
        terminator_Extras.homeless_vectorToScreen = terminator_Extras.homeless_vectorToScreen or vectorMeta.ToScreen

        local oldToScreen = terminator_Extras.homeless_vectorToScreen
        function vectorMeta:ToScreen()
            local scrPos = oldToScreen( self )
            if not scrPos.visible then return scrPos end

            scrPos.x = ScrW() - scrPos.x

            return scrPos
        end

        hook.Add( "PreDrawViewModels", "homeless_flip", function()
            if not IsSheltered() then return end
            cam.Start2D()
                render.UpdateScreenEffectTexture()

                surface.SetMaterial( gameMat2 )
                surface.SetDrawColor( 255, 255, 255, 255 )
                surface.DrawTexturedRectUV( 0, 0, ScrW(), ScrH(), 1, 0, 0, 1 )
            cam.End2D()
        end )

        local oldYaw
        hook.Add( "CreateMove", "homeless_flip", function( cmd )
            if not IsSheltered() then return end
            local viewAng = cmd:GetViewAngles()

            oldYaw = oldYaw or viewAng.y

            local newYaw = viewAng.y
            local diff = math.NormalizeAngle( newYaw - oldYaw )

            oldYaw = newYaw - diff * 2
            viewAng.y = oldYaw

            cmd:SetViewAngles( viewAng )
            cmd:SetSideMove( -cmd:GetSideMove() )
        end )
    end

    local sadMats = {
        "concrete/concreteceiling001a",
        "concrete/concretefloor002a",
        "concrete/concretefloor013b",
        "concrete/concretefloor031a",
        "concrete/concretewall003a",
        "concrete/concretewall036a",
        "concrete/concretewall073a",
        "concrete/concretewall040d",

    }

    local function mapMats()
        local mapMaterials = {}
        for _, b in ipairs( game.GetWorld():GetBrushSurfaces() ) do
            if not b:IsWater() then
                mapMaterials[b:GetMaterial():GetName()] = true
            end
        end
        return mapMaterials
    end

    local function overrideMaterials()
        local mapMaterials = mapMats()
        local scaleVec = Vector( 1, 1, 1 )
        local offsetVec = Vector( 1, 1, 1 )
        local rotateAng = Angle( 0,0,0 )

        for name in pairs( mapMaterials ) do
            local max = 1
            local min = 0.75
            local minAng = -15
            local maxAng = 15
            local snapAng = true
            if math.random( 1, 100 ) < 25 then
                max = 0.5
                min = 0.1

                minAng = -180
                minAng = 180

            end
            mat = Material( name )
            mat:SetTexture( "$basetexture", sadMats[math.random( 1,#sadMats )] )
            local displacementBlend = mat:GetTexture( "$basetexture2" )
            if displacementBlend and not ( displacementBlend:IsError() or displacementBlend:IsErrorTexture() ) then
                mat:SetTexture( "$basetexture2", sadMats[math.random( 1,#sadMats )] )

            end

            local matrix = mat:GetMatrix( "$basetexturetransform" ) or Matrix()

            local randX = math.Rand( min, max )
            local randY = math.Rand( min, max )
            scaleVec:SetUnpacked( randX, randY, 1 )
            matrix:SetScale( scaleVec )


            randX = math.Rand( min, max )
            randY = math.Rand( min, max )
            offsetVec:SetUnpacked( randX, randY, 1 )
            matrix:Translate( offsetVec )


            local randRotate = math.Rand( minAng, maxAng )
            rotateAng:SetUnpacked( 0, randRotate, 0 )
            if snapAng then
                rotateAng:SnapTo( "y", 15 )

            end
            matrix:Rotate( rotateAng )

            mat:SetMatrix( "$basetexturetransform", matrix )

        end
    end

    local nextRecieve2 = 0
    net.Receive( "deafen_thing_whateva", function()
        if nextRecieve2 > CurTime() then return end
        nextRecieve2 = CurTime() + 5

        LocalPlayer():ConCommand( "stopsound" )

    end )
    local soundsVoid = {
        { gift = nil, duration = 50, pitchmin = 80, pitchmax = 90, dist = 4000 },
        { gift = "vo/breencast/br_collaboration01.wav", duration = 35, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "vo/breencast/br_disruptor05.wav", duration = 15, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "vo/breencast/br_collaboration02.wav", duration = 20, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "vo/breencast/br_collaboration05.wav", duration = 20, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "vo/breencast/br_collaboration03.wav", duration = 14, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "vo/breencast/br_collaboration04.wav", duration = 10, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "vo/breencast/br_collaboration08.wav", duration = 20, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "vo/breencast/br_collaboration06.wav", duration = 10, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "vo/breencast/br_collaboration07.wav", duration = 30, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "vo/breencast/br_collaboration09.wav", duration = 60, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "vo/breencast/br_disruptor08.wav", duration = 45, pitchmin = 85, pitchmax = 95, dist = 8000 },
        { gift = "ambient/levels/streetwar/marching_distant2.wav", duration = 20, pitchmin = 70, pitchmax = 80, dist = 1000 },
        { gift = "ambient/water/water_flow_loop1.wav", duration = 60, pitchmin = 90, pitchmax = 100, dist = 8000 },
        { gift = "ambient/levels/canals/swamp_stereo_frogs_loop1.wav", duration = 60, pitchmin = 70, pitchmax = 80, dist = 6000 },
        { gift = "ambient/levels/coast/seagulls_ambient1.wav", duration = 60, pitchmin = 20, pitchmax = 40, dist = 4000, lvl = 2 },
        { gift = "ambient/levels/coast/seagulls_ambient2.wav", duration = 60, pitchmin = 20, pitchmax = 40, dist = 4000, lvl = 2 },
        { gift = "ambient/levels/coast/seagulls_ambient3.wav", duration = 60, pitchmin = 20, pitchmax = 40, dist = 4000, lvl = 2 },
        { gift = "ambient/levels/coast/seagulls_ambient4.wav", duration = 60, pitchmin = 20, pitchmax = 40, dist = 4000, lvl = 2 },
        { gift = "ambient/levels/coast/seagulls_ambient5.wav", duration = 60, pitchmin = 20, pitchmax = 40, dist = 4000, lvl = 2 },
        { gift = "homeless/music/ambient_music0.mp3", duration = 120, pitchmin = 90, pitchmax = 95, dist = 8000 }, -- goated audio
        { gift = "homeless/ambiance/145213__rmutt__oceanwaves-1.mp3", duration = 70, pitchmin = 90, pitchmax = 100, dist = 8000 },
        { gift = "homeless/music/ambient_music1.mp3", duration = 160, pitchmin = 90, pitchmax = 95, dist = 8000 },
        { gift = "homeless/music/ambient_music2.mp3", duration = 160, pitchmin = 90, pitchmax = 95, dist = 8000 },
    }
    local soundsScorned = {
        { gift = nil, duration = 30, pitchmin = 80, pitchmax = 90, dist = 3000 },
        { gift = "ambient/atmosphere/city_truckpass1.wav", duration = 30, pitchmin = 60, pitchmax = 70, dist = 2000, lvl = 2 },
        { gift = "homeless/music/ambient_music0.mp3", duration = 20, pitchmin = 70, pitchmax = 80, dist = 2000, lvl = 2 }, -- goated audio
        { gift = "plats/tram_motor_start.wav", duration = 12, pitchmin = 30, pitchmax = 40, dist = 2000, lvl = 2 },
        { gift = "plats/elevator_large_stop1.wav", duration = 40, pitchmin = 30, pitchmax = 40, dist = 2000, lvl = 2 },
        { gift = "vehicles/airboat/pontoon_impact_hard2.wav", duration = 5, pitchmin = 30, pitchmax = 40, dist = 1500, lvl = 2 },
        { gift = "vehicles/airboat/pontoon_splash2.wav", duration = 40, pitchmin = 30, pitchmax = 40, dist = 1500, lvl = 2 },
        { gift = "hl1/ambience/port_suckin1.wav", duration = 20, pitchmin = 30, pitchmax = 40, dist = 1500, lvl = 2 },
        { gift = "ambience/wind1.wav", duration = 20, pitchmin = 40, pitchmax = 50, dist = 3000, lvl = 2 },
        { gift = "ambient/atmosphere/city_skybeam1.wav", duration = 20, pitchmin = 60, pitchmax = 70, dist = 3000, lvl = 2 },
        { gift = "ambient/levels/labs/teleport_postblast_winddown1.wav", duration = 20, pitchmin = 60, pitchmax = 70, dist = 4000, lvl = 2 },
        { gift = "ambient/water/water_pump_drainin1.wav", duration = 40, pitchmin = 60, pitchmax = 70, dist = 3000, lvl = 2 },
        { gift = "homeless/music/ambient_music1.mp3", duration = 40, pitchmin = 70, pitchmax = 80, dist = 2000, lvl = 2 },
        { gift = "homeless/ambiance/tornado_siren_distant.mp3", duration = 80, pitchmin = 80, pitchmax = 90, dist = 6000, lvl = 2 }, -- credit tornado alley
        { gift = "homeless/ambiance/siren_broken.mp3", duration = 40, pitchmin = 70, pitchmax = 80, dist = 4000, lvl = 2 }, -- ditto
        { gift = "ambient/wind/wind_moan2.wav", duration = 4, pitchmin = 30, pitchmax = 40, dist = 4000, lvl = 2 },
        { gift = "ambient/wind/windgust_strong.wav", duration = 60, pitchmin = 30, pitchmax = 40, dist = 4000, lvl = 2 },
        { gift = "ambient/levels/coast/seagulls_ambient1.wav", duration = 5, pitchmin = 30, pitchmax = 40, dist = 4000, lvl = 2 },
        { gift = "ambient/levels/coast/seagulls_ambient2.wav", duration = 6, pitchmin = 30, pitchmax = 50, dist = 3000, lvl = 2 },
        { gift = "ambient/levels/coast/seagulls_ambient3.wav", duration = 2, pitchmin = 30, pitchmax = 50, dist = 2500, lvl = 2 },
        { gift = "ambient/levels/coast/seagulls_ambient4.wav", duration = 8, pitchmin = 30, pitchmax = 60, dist = 2000, lvl = 2 },
        { gift = "ambient/levels/coast/seagulls_ambient5.wav", duration = 5, pitchmin = 30, pitchmax = 60, dist = 1500, lvl = 2 },
        { gift = "homeless/music/ambient_music2.mp3", duration = 200, pitchmin = 70, pitchmax = 80, dist = 2000, lvl = 2 },
    }

    local localTimerKey = "dangerous_thing_think_speak"
    timer.Remove( localTimerKey )

    local speaking

    local function beginSpeaking( ply )
        if speaking then return end
        speaking = true

        local step = 0
        local nextGift = 0
        local stepSize = 2
        local interval = 2

        timer.Create( localTimerKey, interval, 0, function()
            if not system.HasFocus() then return end
            step = step + stepSize

            if nextGift > step then return end

            local giftToGive = nil
            debugPrint( "find gift" )

            if escaped( ply ) then
                giftToGive = table.remove( soundsScorned, 1 )

            else
                giftToGive = table.remove( soundsVoid, 1 )

            end

            if not giftToGive then return end

            if isstring( giftToGive.gift ) then

                debugPrint( "play gift", giftToGive.gift )

                local whereToGive = ply:GetVelocity()

                if whereToGive:Length() < 10 then
                    whereToGive = VectorRand()
                end

                whereToGive = whereToGive * Vector( 1, 1, 0 )
                whereToGive:Normalize()

                whereToGive = whereToGive * math.random( giftToGive.dist * 0.7, giftToGive.dist * 1.3 )

                local lvlMul = giftToGive.lvl

                if not lvlMul then
                    lvlMul = 1

                end

                local lvl = giftToGive.dist / 53
                lvl = math.Round( lvl )
                lvl = lvl * lvlMul
                lvl = math.Clamp( lvl, 95, 150 )

                --debugoverlay.Cross( ply:GetPos() + whereToGive, 100, 5, color_white, true )
                --print( giftToGive.gift, ply:GetPos() + whereToGive, lvl, math.random( giftToGive.pitchmin, giftToGive.pitchmax ) )

                homeless_AllowOneAmbientSound()
                sound.Play( giftToGive.gift, ply:GetPos() + whereToGive, lvl, math.random( giftToGive.pitchmin, giftToGive.pitchmax ) )

            end

            nextGift = step + giftToGive.duration
            debugPrint( "next gift", step, nextGift )

        end )
    end

    local allowOne
    function homeless_AllowOneAmbientSound()
        allowOne = true

    end

    local nextRecieve3 = 0
    net.Receive( "deafen_thing_begin", function()
        if nextRecieve3 > CurTime() then return end
        local ply = LocalPlayer()

        if not ply:GetNW2Bool( "is_homeless_thing_target", false ) then return end

        nextRecieve3 = CurTime() + 5

        terminator_Extras.homeless_Scorned = true

        doFlipping()

        overrideMaterials()

        timer.Simple( math.Rand( 1, 8 ), function()
            if timer.Exists( "BlinkLoop" ) then
                timer.Remove( "BlinkLoop" )
                hook.Remove( "HUDPaint", "MarkiHUD" )
                surface.PlaySound( "not_homeless/markbanish.mp3" )

            end
        end )

        hook.Add( "EntityEmitSound", "homeless_realambiance", function( data )
            if allowOne then allowOne = nil return end
            if not data.Entity then return end
            if data.Entity:IsWorld() then return false end

        end )

        hook.Add( "ChatText", "homeless_nochat", function()
            return true

        end )

        hook.Add( "AddDeathNotice", "homeless_deathnotice", function( _victim, _inflictor, _attacker )
            return false

        end )

        local flags = bit.bor( SND_CHANGE_VOL, SND_CHANGE_PITCH )
        local target = LocalPlayer()
        timer.Simple( 1, function()
            if not IsValid( target ) then return end
            if bit.band( util.PointContents( target:GetShootPos() ), CONTENTS_SOLID ) == 0 then return end

            target:EmitSound( "ambient/water/distant_wave1.wav", 100, 80, 1, CHAN_STATIC, flags )
            target:EmitSound( "ambient/water/distant_wave2.wav", 100, 85, 1, CHAN_STATIC, flags )
            target:EmitSound( "ambient/water/distant_wave3.wav", 100, 90, 1, CHAN_STATIC, flags )

            util.ScreenShake( target:GetPos(), 20, 20, 0.75, 300, true )

        end )
        timer.Simple( 8, function()
            if not IsValid( target ) then return end
            if bit.band( util.PointContents( target:GetShootPos() ), CONTENTS_SOLID ) == 0 then return end

            target:EmitSound( "ambient/water/distant_wave1.wav", 100, 60, 1, CHAN_STATIC, flags )
            target:EmitSound( "ambient/water/distant_wave2.wav", 100, 65, 1, CHAN_STATIC, flags )
            target:EmitSound( "ambient/water/distant_wave3.wav", 100, 70, 1, CHAN_STATIC, flags )

            util.ScreenShake( target:GetPos(), 10, 20, 1.5, 300, true )

        end )
        timer.Simple( 17, function()
            if not IsValid( target ) then return end
            if bit.band( util.PointContents( target:GetShootPos() ), CONTENTS_SOLID ) == 0 then return end

            target:EmitSound( "ambient/water/distant_wave1.wav", 100, 30, 1, CHAN_STATIC, flags )
            target:EmitSound( "ambient/water/distant_wave2.wav", 100, 35, 1, CHAN_STATIC, flags )
            target:EmitSound( "ambient/water/distant_wave3.wav", 100, 40, 1, CHAN_STATIC, flags )

            util.ScreenShake( target:GetPos(), 5, 20, 5, 300, true )

        end )
        timer.Simple( 28, function()
            if not IsValid( target ) then return end
            if bit.band( util.PointContents( target:GetShootPos() ), CONTENTS_SOLID ) == 0 then return end

            target:EmitSound( "ambient/water/distant_wave1.wav", 100, 1, 1, CHAN_STATIC, flags )
            target:EmitSound( "ambient/water/distant_wave2.wav", 100, 5, 1, CHAN_STATIC, flags )
            target:EmitSound( "ambient/water/distant_wave3.wav", 100, 10, 1, CHAN_STATIC, flags )

            util.ScreenShake( target:GetPos(), 2, 20, 10, 300, true )

        end )

        beginSpeaking( ply )

        ply:ConCommand( "cl_homeless_nextmessage 1" )
        homeless_PrepareAmbiance()
        hook.Add( "homeless_postplayambiance", "homeless_eternalsounds", function()
            timer.Simple( math.random( 15, 45 ), function()
                if not IsValid( ply ) then return end -- i dont even think this can happen lol
                ply:ConCommand( "cl_homeless_nextmessage 1" )

            end )
        end )
    end )
elseif SERVER then
    util.AddNetworkString( "deafen_thing_whateva" )
    util.AddNetworkString( "deafen_thing_begin" )
    util.AddNetworkString( "deafen_thing_shelterednessdefine" )
    util.AddNetworkString( "homeless_calling" )
    util.AddNetworkString( "homeless_emptyness" )
    util.AddNetworkString( "homeless_asktopeek" )

    -- fallback!
    local recursivePreventExtent = 0

    local function RecursiveSetPreventTransmit( ent, toStop, stopTransmitting )
        if not IsValid( ent ) then return end
        if recursivePreventExtent > 500 then return end
        recursivePreventExtent = recursivePreventExtent + 1

        if ent.SetPreventTransmitReason then
            ent:SetPreventTransmitReason( toStop, stopTransmitting, "homeless_recursive" )

        else
            ent:SetPreventTransmit( toStop, stopTransmitting )

        end

        if not isfunction( ent.GetChildren ) then return end
        local tab = ent:GetChildren()
        for i = 1, #tab do
            RecursiveSetPreventTransmit( tab[ i ], toStop, stopTransmitting )
        end
    end

    local timerKey = "dangerous_thing_think_roll"
    local timerName2 = "dangerous_thing_pulltarget"

    local v = Vector( 80000,80000,80000 )

    local targetCount = 0
    local areTargets = false
    local dangerous_thing_targets = {}
    local startingPos = nil
    local callingPos = nil

    local heedIsOk = 0
    local pull = 0.05
    local defaultPull = pull
    local transgressionScale = 0.25

    local needsBasic = nil

    local blessed

    local function targetsThink()
        local newTargets = {}
        for target, _ in pairs( dangerous_thing_targets ) do
            if not IsValid( target ) then continue end
            newTargets[target] = true

        end
        dangerous_thing_targets = newTargets

        local newTargetCount = table.Count( dangerous_thing_targets )
        if newTargetCount ~= targetCount then
            hook.Run( "homeless_scornedcountchanged", dangerous_thing_targets, newTargetCount, targetCount )

        end
        targetCount = newTargetCount
        areTargets = targetCount >= 1

    end

    local function registerTarget( target )
        if not IsValid( target ) then debugPrint( "invalid registerTarget", target ) return end
        if dangerous_thing_targets[target] then return end
        target.dangerous_thingthink_steps = target.dangerous_thingthink_steps or "start"
        dangerous_thing_targets[target] = true
        target:SetNW2Bool( "is_homeless_thing_target", true )
        targetsThink()

        target:CallOnRemove( "homeless_losttarget", function()
            timer.Simple( 0, function()
                targetsThink()

            end )
        end, "homeless_thing_targets" )

    end

    local function Cleanup()
        timer.Remove( timerName2 )

        for _, ply in player.Iterator() do
            ply.dangerous_thingthink_steps = nil

        end
    end

    Cleanup()

    local function inGoldilocks( ply )
        local pos = ply:GetPos()
        local max = 110000
        local min = 55000

        if math.abs( pos.x ) > max or math.abs( pos.y ) > max or math.abs( pos.z ) > max then
            return nil, 1

        elseif math.abs( pos.x ) < min or math.abs( pos.y ) < min or math.abs( pos.z ) < min then
            return nil, 2

        end

        local xIsGood = math.abs( pos.x ) > min and math.abs( pos.x ) < max
        local yIsGood = math.abs( pos.y ) > min and math.abs( pos.y ) < max
        local zIsGood = math.abs( pos.z ) > min and math.abs( pos.z ) < max
        if xIsGood or yIsGood or zIsGood then
            return true, 0

        end
    end

    local excommunicado

    do
        local excommunicadees

        excommunicado = function( ply )
            local setupPly
            local setupHooks
            ply:CallOnRemove( "homeless_deexcommunicado", function()
                if not excommunicadees then return end -- ????
                excommunicadees[ply] = nil
                if table.Count( excommunicadees ) <= 0 then
                    excommunicadees = nil
                    debugPrint( "excommunicadees_cleanup" )

                end
            end, excommunicadees )

            if excommunicadees and not excommunicadees[ply] then
                setupPly = true

            elseif not excommunicadees then -- dont return and create the hooks
                excommunicadees = {}
                debugPrint( "excommunicadees_create", ply )
                setupPly = true
                setupHooks = true

            end

            if setupPly then
                excommunicadees[ply] = true
                debugPrint( "excommunicadees_add", ply )

            end

            if not setupHooks then return end

            hook.Add( "CanPlayerSuicide", "dangerous_thing_cansuicide_hook", function( suicider )
                if game.IsDedicated() or not excommunicadees then hook.Remove( "CanPlayerSuicide", "dangerous_thing_cansuicide_hook" ) return end
                if excommunicadees[suicider] then return false end

            end )
            hook.Add( "PlayerCanHearPlayersVoice", "dangerous_thing_excommunicado", function( listener, talker )
                if not excommunicadees then hook.Remove( "PlayerCanHearPlayersVoice", "dangerous_thing_excommunicado" ) return end
                if excommunicadees[listener] then return false end
                if excommunicadees[talker] then return false end

            end )
            hook.Add( "PlayerSay", "dangerous_thing_excommunicado_chat", function( speaker )
                if not excommunicadees then hook.Remove( "dangerous_thing_excommunicado_chat" ) return end
                if excommunicadees[speaker] then return false end

            end )

            hook.Add( "CanPlayerEnterVehicle", "dangerous_thing_nocars", function( entering )
                if not excommunicadees then hook.Remove( "CanPlayerEnterVehicle", "dangerous_thing_nocars" ) return end
                if excommunicadees[entering] then return false end

            end )

            hook.Add( "OnEntityCreated", "dangerous_thing_nocreation", function( created )
                if not excommunicadees then hook.Remove( "OnEntityCreated", "dangerous_thing_nocreation" ) return end
                timer.Simple( 0, function()
                    if not IsValid( created ) then return end
                    local creator = created:GetCreator()
                    if not creator and CPPI then
                        creator = created:CPPIGetOwner()

                    end
                    if not IsValid( creator ) then return end

                    if not excommunicadees[creator] then return end
                    SafeRemoveEntity( created )

                end )
            end )

            ply:SetCustomCollisionCheck( true )

            hook.Add( "ShouldCollide", "dangerous_thing_freedom", function( ent1, ent2 )
                if not excommunicadees then hook.Remove( "ShouldCollide", "dangerous_thing_freedom" ) return end
                if excommunicadees[ent1] or excommunicadees[ent2] then return false end

            end )

            hook.Add( "PlayerUse", "dangerous_thing_ghost", function( user )
                if not excommunicadees then hook.Remove( "PlayerUse", "dangerous_thing_ghost" ) return end
                if excommunicadees[user] then return false end

            end )

            hook.Add( "EntityTakeDamage", "dangerous_thing_unharmed", function( target, dmg )
                if not excommunicadees then hook.Remove( "EntityTakeDamage", "dangerous_thing_unharmed" ) return end
                if excommunicadees[target] then
                    local attacker = dmg:GetAttacker()
                    if attacker.EternallyScorned then return end
                    dmg:ScaleDamage( 0.1 )
                    return

                end
                local attacker = dmg:GetAttacker()
                if attacker and excommunicadees[attacker] then
                    dmg:ScaleDamage( 0.1 )
                    return

                end
                local inflictor = dmg:GetInflictor()
                if infictor and excommunicadees[inflictor] then
                    dmg:ScaleDamage( 0.1 )
                    return

                end
            end )
        end
    end

    local notHoldingItUp = 0

    hook.Add( "PlayerDeath", "homeless_holdingitup", function()
        notHoldingItUp = CurTime() + 10

    end )

    local function dontHoldItUp( targ )
        if notHoldingItUp > CurTime() then return end
        if not game.IsDedicated() then return end
        if engine.ActiveGamemode() == "sandbox" then return end

        if not targ:Alive() then return end

        local ratio = 0.35
        local plysTotal = player.GetCount()
        local aliveCount = 0
        for _, ply in player.Iterator() do
            if ply:Alive() then
                aliveCount = aliveCount + 1

            end
        end
        local aliveRatio = aliveCount / plysTotal

        local bite

        if aliveRatio <= ratio then
            bite = 1

        end
        if aliveCount <= 2 and plysTotal >= 10 then
            bite = targ:GetMaxHealth() / 10

        elseif aliveCount <= 4 and plysTotal >= 15 then
            bite = targ:GetMaxHealth() / 20

        end

        if bite then
            local oldHp = targ:Health()
            if oldHp <= 1 then
                targ:Kill()

            end
            local newHealth = oldHp + -bite
            newHealth = math.max( newHealth, 0 )
            targ:SetHealth( newHealth )

        else
            notHoldingItUp = CurTime() + 2.5

        end
    end

    function Homeless_ScornWisdom( target )
        if terminator_Extras.homeless_EasyMode then -- for if scorning is bothering you
            return true

        end
        if dangerous_thing_targets[target] and target.homeless_Scorned then return true end
        return target:GetInfoNum( "cl_homeless_banishment", 0 ) > os.time()

    end

    local function countAsScorned( target, reason )
        if terminator_Extras.homeless_EasyMode then
            return

        end
        if not target:IsPlayer() then return end
        registerTarget( target )
        debugPrint( "countAsScorned", reason )
        excommunicado( target )

        if target.homeless_Scorned then return end

        target.homeless_Scorned = true
        target:SetNW2Bool( "homeless_hallofmirrorify", true )
        target:SetNoTarget( true )

        local ideal = target:GetInfoNum( "ai_note_ideal_detail", 0 )
        local noteReady = ideal <= homeless_NoteDetail( target ) -- only step if they're up to date, don't want them to miss one!
        if noteReady then
            target:ConCommand( "ai_note_ideal_detail " .. ideal + 1 )

        end
    end

    function Homeless_InstantScorn( target )
        if terminator_Extras.homeless_EasyMode then
            return

        end
        if not target:IsPlayer() then return end

        target.dangerous_thingthink_steps = "scorned"
        countAsScorned( target, "instantScorn" )

        target:SetPos( v )

        util.ScreenShake( target:GetPos(), 40, 20, 1, 300, true )

    end

    local function Sheltered( sheltered, bool )
        if not SERVER then return end
        if bool == nil then return end
        net.Start( "deafen_thing_shelterednessdefine" )
            net.WriteBool( bool )
        net.Send( sheltered )
        sheltered:SetNW2Bool( "deafen_thing_shouldbesheltered", bool )

    end

    function Homeless_InstantTransgression( target )
        if terminator_Extras.homeless_EasyMode then
            return

        end
        if not target:IsPlayer() then return end

        Sheltered( target, true )
        timer.Simple( 0.1, function()
            if not IsValid( target ) then return end
            net.Start( "deafen_thing_begin" )
            net.Send( target )

        end )

        target.dangerous_thingthink_steps = "transgressed"
        countAsScorned( target, "instantTransgression" )

    end

    --[[
    timer.Simple( 0, function()
        Homeless_InstantTransgression( Entity(1) )

    end )
    --]]
    --[[
    timer.Simple( 0, function()
        Homeless_InstantScorn( Entity(1) )

    end )
    --]]
    --[[
    timer.Simple( 0, function()
        registerTarget( Entity(1) )

    end )
    --]]

    net.Receive( "homeless_asktopeek", function( _, ply )
        ply.homeless_EarnedPeeker = true

    end )

    local unFlatten = Vector( 0.6, 0.6, 0.8 )

    local function someoneThink( ply, murderer, randsDedication )
        murderer = murderer or ply.homeless_Murderer
        randsDedication = randsDedication or ply:GetInfoNum( "cl_homeless_dedication", 0 )

        local earnedPeeker = ply.homeless_EarnedPeeker
        if not earnedPeeker then
            if math.random( 0, 100 ) >= 50 then return end

            local plyCount = player.GetCount()
            local tooFull = game.MaxPlayers() * 0.5
            local basicallyEmpty = math.min( 4, tooFull + -1 )
            if plyCount >= math.random( basicallyEmpty, tooFull ) then return end

        end
        local tooSoonToPeek = ply.homeless_nextPeeker and ply.homeless_nextPeeker > CurTime()

        local theirPos = ply:GetShootPos()
        local theyreInWall = not util.IsInWorld( theirPos )
        local attach
        local peeker

        local active = homeless_IsHomelessActive()
        local activeBlock = active and not terminator_Extras.homeless_FixingNeighbors and not ply.homeless_Scorned

        if activeBlock then -- do nothing

        elseif terminator_Extras.homeless_FixingNeighbors or murderer then -- please don't murder
            if theyreInWall then
                _, attach = terminator_Extras.GetVoiceboxPos( theirPos )

            elseif not tooSoonToPeek then
                _, peeker = terminator_Extras.GetVoiceboxPos( theirPos )

            end

        elseif theyreInWall then
            if math.random( 0, 100 ) <= ( randsDedication * 20 ) + 5 then
                _, attach = terminator_Extras.GetVoiceboxPos( theirPos ) -- if in the world, and next to the void

            elseif ( math.random( 0, 100 ) < ( randsDedication * 10 ) + 35 ) and not ply.homeless_EarnedPeeker then
                _, ply.homeless_EarnedPeeker = terminator_Extras.GetVoiceboxPos( theirPos )

            end
        elseif not tooSoonToPeek then
            if math.random( 0, 400 ) <= randsDedication then
                _, peeker = terminator_Extras.GetVoiceboxPos( theirPos )

            elseif ply.homeless_EarnedPeeker then
                peeker = true

            end
        end

        if peeker then
            local dir = ( VectorRand() * unFlatten )
            dir:Normalize()

            local trConfig = {
                start = theirPos,
                endpos = theirPos + dir * 10000,
                mask = MASK_SOLID_BRUSHONLY,

            }
            local result = util.TraceLine( trConfig )
            if result.HitSky then return end
            if not result.Hit then return end
            local peekDist = result.HitPos:Distance( theirPos )

            if peekDist < 250 then return end
            if peekDist > 3500 then return end

            ply.homeless_EarnedPeeker = nil
            ply.homeless_nextPeeker = CurTime() + 2
            net.Start( "homeless_peeking_parasite" )
                net.WriteVector( result.HitPos + -( dir * 10 ) )
                net.WriteVector( result.HitNormal )
            net.Send( ply )

        elseif attach then
            net.Start( "homeless_attach_parasite_follower" )
            net.Send( ply )

        end
    end


    local validMoveTypes = {
        [ MOVETYPE_NOCLIP ] = true,
        [ MOVETYPE_VPHYSICS ] = true,
        [ MOVETYPE_WALK ] = true,

    }

    local validObsModes = {
        [ OBS_MODE_NONE ] = true,

    }

    local function findTarget()
        local cur = CurTime()
        for _, ply in player.Iterator() do
            local nextThink = ply.homeless_NextTooFarThink or 0
            if nextThink > cur then continue end
            if dangerous_thing_targets[ply] then continue end

            if ply:IsInWorld() then ply.homeless_NextTooFarThink = cur + 10 continue end
            if not ply:Alive() then ply.homeless_NextTooFarThink = cur + 10 continue end

            local _, transgressionType = inGoldilocks( ply )
            if transgressionType ~= 1 then ply.homeless_NextTooFarThink = cur + 10 continue end -- too far out there

            if homeless_NoteDetail( ply ) > 0 then ply.homeless_NextTooFarThink = cur + 60 continue end

            registerTarget( ply )
            ply.dangerous_thingthink_steps = "scorned"
            countAsScorned( ply, "thinker" )

        end

        local plys = player.GetAll()
        if #plys < 1 then return end

        local randPlayer = plys[ math.random( 1, #plys ) ]
        if not IsValid( randPlayer ) then return end

        local murderer = randPlayer.homeless_Murderer
        local randsDedication = randPlayer:GetInfoNum( "cl_homeless_dedication", 0 )

        someoneThink( randPlayer, murderer, randsDedication )

        local tooSoon = randPlayer:GetInfoNum( "cl_homeless_banishment", 0 ) > os.time()
        if not murderer and tooSoon then return end

        local ready = randsDedication >= 1

        if not murderer then
            if math.random( 0, 100 ) <= 99 then return end
            if math.random( 0, 100 ) <= 98 then return end
            if not ready and ( math.random( 0, 100 ) <= 99 ) then return end

            local noted = randPlayer.homeless_HasPickedUpNote
            if not noted and math.random( 0, 100 ) <= 98 then return end
            if not noted and not ready and ( math.random( 0, 100 ) <= 98 ) then return end

        end

        registerTarget( randPlayer )

    end

    local function manageTarget( targ )
        local step = targ.dangerous_thingthink_steps
        local oldStep = targ.dangerous_thingthink_oldsteps
        local first = step ~= oldStep

        targ.dangerous_thingthink_oldsteps = step

        local aware = targ:Alive() and targ:Health() > 0 and validMoveTypes[ targ:GetMoveType() ] and validObsModes[ targ:GetObserverMode() ]

        if step == "start" then
            startingPos = targ:WorldSpaceCenter()

            if util.IsInWorld( startingPos ) then return end

            local callingPosInt, nextToVoid = terminator_Extras.GetVoiceboxPos( startingPos )
            callingPos = callingPosInt

            if not nextToVoid then return end

            if Homeless_ScornWisdom( targ ) then
                targ.dangerous_thingthink_steps = "heeded"

                net.Start( "homeless_calling", false )
                    net.WriteBool( true )
                    net.WriteVector( callingPos )
                    net.WriteFloat( 0.25 )
                net.Send( targ )

                targ.homeless_EarnedPeeker = true

            else
                heedIsOk = CurTime() + 60

                targ.dangerous_thingthink_steps = "warned"

                net.Start( "homeless_calling", false )
                    net.WriteBool( true )
                    net.WriteVector( callingPos )
                    net.WriteFloat( 1 )
                net.Send( targ )

            end

        elseif step == "warned" then
            if not aware then return end
            if heedIsOk > CurTime() then
                someoneThink( targ )
                timer.Create( timerName2, 0, 0, function()
                    if not IsValid( targ ) then timer.Remove( timerName2 ) return end
                    if heedIsOk < CurTime() then timer.Remove( timerName2 ) return end
                    if targ.dangerous_thingthink_steps ~= "warned" then timer.Remove( timerName2 ) return end
                    local targetsPos = targ:GetPos()

                    local _, nextToVoid = terminator_Extras.GetVoiceboxPos( targetsPos )
                    if not nextToVoid then return end

                    if util.IsInWorld( targetsPos ) then
                        pull = pull + -0.005
                        pull = math.max( pull, defaultPull )
                        return

                    end
                    targ.homeless_EarnedPeeker = true

                    local dir = callingPos - targetsPos
                    dir:Normalize()
                    targ:SetPos( targetsPos + dir * pull )
                    if pull < 0.1 then
                        pull = pull + 0.0001

                    else
                        pull = pull + 0.08

                    end
                end )

                local targetsPos = targ:WorldSpaceCenter()

                if not util.IsInWorld( targetsPos ) then
                    local distToBox = targetsPos:Distance( callingPos ) * 0.25
                    if distToBox < 1500 then
                        targ.dangerous_thingthink_steps = "scorned"
                        countAsScorned( targ, "distToBox" )

                    end
                else
                    local newCallingPos, nextToVoid = terminator_Extras.GetVoiceboxPos( targetsPos )

                    startingPos = targetsPos
                    callingPos = newCallingPos

                    if not nextToVoid then return end

                    net.Start( "homeless_calling", true )
                        net.WriteBool( false )
                        net.WriteVector( callingPos )
                        net.WriteFloat( 1 )
                    net.Send( targ )

                end
            elseif heedIsOk < CurTime() then
                targ.dangerous_thingthink_steps = "heeded"

            else
                -- it never stayed spawned
                targ.dangerous_thingthink_steps = "start"

            end
        elseif step == "scorned" then
            local noteDetail = homeless_NoteDetail( targ )
            local hour = 3600
            local day = 24
            local hours = math.random( day * 5, day * 15 ) + ( noteDetail * hour * 6 )
            local spacing = hour * hours
            if math.random( 0, 100 ) < 50 then
                spacing = spacing * math.random( 1, 6 )

            end
            -- on scorn
            local nextTime = os.time() + spacing
            targ:ConCommand( "cl_homeless_banishment " .. tostring( nextTime ) )
            targ:ConCommand( "cl_homeless_dedication " .. 2 )
            targ:ConCommand( "cl_nav_readyness " .. math.random( 1, 3 ) )
            if math.random( 0, 100 ) < homeless_NoteDetail( targ ) then
                targ:ConCommand( "ai_overridden_enterers " .. math.random( 1, 2 ) )

            end

            net.Start( "deafen_thing_whateva" )
            net.Send( targ )
            targ.dangerous_thingthink_steps = "suffering"

            countAsScorned( targ, "scornedPulled" )

        elseif step == "suffering" then
            if first then
                targ:SetDSP( 16 )
                targ:SetPos( v )

            end
            timer.Simple( 0.1, function()
                if not IsValid( targ ) then return end
                net.Start( "deafen_thing_begin" )
                net.Send( targ )

            end )
            targ.dangerous_thingthink_steps = "drifting"

        elseif step == "drifting" then
            if escaped( targ ) then
                targ.dangerous_thingthink_steps = "transgressed"
                countAsScorned( targ, "transgressed" )
                Sheltered( targ, true )
                return

            end

            targ:SetNoTarget( true )

            local _, transgressionType = inGoldilocks( targ )

            local pos = targ:GetPos()
            local wayBack = ( vec_zero - pos ):GetNormalized()
            local newAngles = -targ:EyeAngles()

            if transgressionType == 1 then
                if needsBasic then
                    targ:SetEyeAngles( wayBack:Angle() )
                    return

                else
                    newAngles:RotateAroundAxis( wayBack, math.random( 100, 200 ) )
                    newAngles.r = 0
                    targ:SetEyeAngles( newAngles )
                    needsBasic = true
                    return

                end
            elseif transgressionType == 2 then
                if needsBasic then
                    targ:SetEyeAngles( ( -wayBack ):Angle() )
                    return

                else
                    newAngles:RotateAroundAxis( wayBack, math.random( 100, 200 ) )
                    newAngles.r = 0
                    targ:SetEyeAngles( newAngles )
                    needsBasic = true
                    return

                end
            end

            needsBasic = nil

            dontHoldItUp( targ )

        elseif step == "transgressed" then
            if first then
                if math.random( 0, 100 ) < 50 then
                    targ:ConCommand( "cl_nav_readyness " .. math.random( 3, 5 ) )

                end
                if math.random( 0, 200 ) < homeless_NoteDetail( targ ) then
                    targ:ConCommand( "ai_overridden_enterers " .. 3 )

                end
                targ:SetNoTarget( true )
                homeless_Playerness( targ, 5 ) -- just to restart the thinker, ply is set as notarget which makes them not the player anymore

            end
            local navAreaCount = navmesh.GetNavAreaCount()
            if navAreaCount >= 1 and #ents.FindByClass( "homeless_freegull_scorned" ) <= 2 then
                if homeless_GetRelation( targ ) > -2 then
                    local nextDecrease = targ.homeless_NextScornedRelationDecrease or 0
                    if nextDecrease < CurTime() then
                        targ.homeless_NextScornedRelationDecrease = CurTime() + 60
                        homeless_NudgeRelation( targ, -1 ) -- get there eventually

                    end
                else
                    local randArea = navmesh.GetNavAreaByID( math.random( 1, navAreaCount ) )
                    if IsValid( randArea ) and randArea:GetCenter():Distance( targ:GetPos() ) > 6000 then
                        local sheep = ents.Create( "homeless_freegull_scorned" )
                        sheep:SetPos( randArea:GetCenter() )
                        sheep.homeless_DeservesToExist = true
                        sheep:Spawn()
                        debugPrint( "sheep", sheep )

                    end
                end
            end

            targ:SetNoTarget( true )

            local filter = RecipientFilter()
            filter:AddPlayer( targ )

            local dust = EffectData()
            dust:SetEntity( targ )
            dust:SetScale( transgressionScale )
            util.Effect( "dangerous_thing_emptiness", dust, nil, filter )

            someoneThink( targ )

            transgressionScale = transgressionScale + 0.005

            if transgressionScale >= 5 then
                transgressionScale = 3

            end

            targ:SetNoTarget( true )

            targ:SetDSP( 25 )
            local shoot = targ:GetShootPos()

            local stuff = ents.FindInSphere( shoot, 150 )
            for _, thing in ipairs( stuff ) do
                if not IsValid( thing ) then continue end
                if thing.homeless_Furniture then continue end
                if thing == targ then continue end
                if thing.IsHomeless then continue end
                if thing.EternallyScorned then continue end
                if thing.homeless_Scorned then continue end
                local parent = thing:GetParent()
                if IsValid( parent ) and parent == targ then continue end

                timer.Simple( math.Rand( 0, 0.25 ), function()
                    if not IsValid( thing ) then return end
                    if not IsValid( targ ) then return end
                    recursivePreventExtent = 0
                    RecursiveSetPreventTransmit( thing, targ, true )

                end )
            end

            if ( not util.IsInWorld( shoot ) or targ:WaterLevel() >= 3 ) and aware then
                targ:SetPos( v )
                targ.dangerous_thingthink_steps = "suffering"

            end

            local impliment = targ:GetWeapon( "weapon_physgun" )
            if impliment then
                SafeRemoveEntity( impliment )

            end

            dontHoldItUp( targ )

        elseif step == "heeded" then
            if first and not blessed then
                blessed = true
                terminator_Extras.homeless_Peep( true )

            end
            someoneThink( targ )

        end
    end

    local wasTarget = nil
    local interval = 0.75

    local function Setup()
        timer.Remove( timerKey )
        timer.Create( timerKey, interval, 0, function()
            if terminator_Extras.homeless_EasyMode then
                timer.Remove( timerKey )
                return

            end
            if areTargets then
                for curr, _ in pairs( dangerous_thing_targets ) do
                    if not IsValid( curr ) then dangerous_thing_targets[curr] = nil continue end
                    manageTarget( curr )
                end
            else
                findTarget()
            end

            if wasTarget and not areTargets then
                Cleanup()

            end
            wasTarget = areTargets

        end )
    end

    Setup()

    hook.Add( "PostCleanupMap", "sv_homeless_shelter_entering", function()
        timer.Simple( interval, Setup )

    end )

    local varName = "homeless_hallofmirrorify"
    -- also done on client
    hook.Add( "CreateEntityRagdoll", "homeless_hommat_persist", function( died, rag )
        if not died:GetNW2Bool( varName, false ) then return end
        rag:SetNW2Bool( varName, true )

    end )
end