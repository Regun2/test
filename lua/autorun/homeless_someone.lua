-- https://steamcommunity.com/sharedfiles/filedetails/?id=3350853082
-- credit SOMEONE by puddingheh

if SERVER then
    util.AddNetworkString( "homeless_attach_parasite_follower" )
    util.AddNetworkString( "homeless_peeking_parasite" )

elseif CLIENT then

    local followerVar = CreateClientConVar( "cl_homeless_nextfollower", 0, true, true )

    local pitchBlackMaterial = Material( "lights/white002" ) -- light001 is tf2 mat

    local function inWall( pos )
        return bit.band( util.PointContents( pos ), MASK_SOLID_BRUSHONLY ) > 0

    end

    local function getViewEnt()
        local viewEnt = LocalPlayer():GetViewEntity()
        if IsValid( viewEnt ) then return viewEnt end
        return LocalPlayer()

    end

    local ScrH = ScrH
    local ScrW = ScrW
    local math = math
    local up = Vector( 0, 0, 1 )

    local hour = 3600

    local tolerance
    local figure = terminator_Extras and terminator_Extras.figure or nil

    local hooking
    local currMat
    local doingCamo
    local currType
    local peekerPos
    local currGoalPos
    local upsideDown
    local currSeenCount = 0
    local initialPosInWallTries

    local ambientSounds = {
        "ambient/creatures/rats1.wav",
        "ambient/creatures/rats2.wav",
        "ambient/creatures/rats3.wav",
        "ambient/creatures/rats4.wav",
        "ambient/creatures/flies1.wav",
        "ambient/creatures/flies2.wav",
        "ambient/creatures/flies3.wav",
        "ambient/creatures/flies4.wav",
        "ambient/creatures/flies5.wav",
        "ambient/materials/rock1.wav",
        "ambient/materials/rock2.wav",
        "ambient/materials/rock3.wav",
        "ambient/materials/rock4.wav",
        "ambient/materials/rock5.wav",
        "ambient/water/rain_drip1.wav",
        "ambient/water/rain_drip2.wav",
        "ambient/water/rain_drip3.wav",
        "ambient/water/rain_drip4.wav",
        "ambient/wind/wind_snippet1.wav",
        "ambient/wind/wind_snippet2.wav",
        "ambient/wind/wind_snippet3.wav",
        "ambient/wind/wind_snippet4.wav",
        "ambient/wind/wind_snippet5.wav",
        "physics/cardboard/cardboard_cup_impact_hard1.wav",
        "physics/cardboard/cardboard_cup_impact_hard2.wav",
        "physics/cardboard/cardboard_cup_impact_hard3.wav",

    }

    local pokeOffset = Vector( 0, 0, -50 )
    local function pokeHeadOutOffset()
        if upsideDown then return -pokeOffset end
        return pokeOffset

    end

    local function feltTolerance()
        if doingCamo then
            return tolerance / 5

        end
        return tolerance

    end

    local function runAway()
        if not IsValid( figure ) then return end
        local added = 0
        local theyClose = ( figure:GetPos() + -pokeHeadOutOffset() ):Distance( LocalPlayer():GetShootPos() ) < 300
        if dedicationVar:GetInt() > 0 and not theyClose then -- only do this if they've already been spooked
            added = math.Clamp( 1 - ( feltTolerance() / 5 ), -1, 1 )

        end
        figure.homeless_RunAway = true
        figure.homeless_RunAwayTime = CurTime() + added

    end

    -- Функция для создания черной фигуры с моделью игрока
    local function CreateFigure()
        local ply = LocalPlayer()
        if not IsValid( ply ) then return end

        -- Удаляем предыдущую фигуру, если она существует
        if IsValid( figure ) then
            figure:Remove()
        end

        -- Создаем клиентскую модель с моделью игрока
        figure = ClientsideModel( "models/player/corpse1.mdl" )
        if terminator_Extras then
            terminator_Extras.figure = figure

        end
        figure:SetNoDraw( true )
        figure:SetColor( Color( 0, 0, 0, 255 ) )
        figure:SetRenderMode( RENDERMODE_NORMAL )

        local mirrorWorked = terminator_Extras and terminator_Extras.homeless_HomMat

        if mirrorWorked and tolerance >= math.random( 10, 20 ) then
            figure:SetNW2Bool( "homeless_hallofmirrorify", true )
            figure:SetNW2Bool( "homeless_hallofmirrorify_glitchy", false )
            doingCamo = true
            currMat = nil

        elseif mirrorWorked and tolerance >= math.random( 4, 8 ) then
            figure:SetNW2Bool( "homeless_hallofmirrorify", true )
            figure:SetNW2Bool( "homeless_hallofmirrorify_glitchy", true )
            doingCamo = true
            currMat = nil

        else
            doingCamo = false
            currMat = pitchBlackMaterial

        end

        -- Включаем автоматическое обновление анимации
        figure.AutomaticFrameAdvance = true
        figure.homeless_RunAwayTime = 0
        figure.homeless_RunAwayTimeToBolt = math.Rand( 0.05, 0.1 )
        figure.homeless_ReturnedCount = 0
        figure.homeless_ShoddyRtCamCount = 0
        figure.homeless_Discomfort = 0
        figure.homeless_SawDiscomfort = 0

        figure.RenderOverride = function( self )
            local renderTarget = render.GetRenderTarget()
            local renderTargeting = renderTarget ~= nil
            local viewEnt = getViewEnt()
            local doingViewEnt = viewEnt ~= ply
            local renderingSmart = renderTargeting or doingViewEnt
            if currType == "follower" and not renderingSmart then return end
            local myPos = self:WorldSpaceCenter()
            local myShootPos = self:GetPos() + ( -pokeHeadOutOffset() )

            local blend = 0
            if currGoalPos then
                local noBlendDist = 200
                blend = noBlendDist - currGoalPos:Distance( myPos )
                blend = blend + 200
                blend = blend / noBlendDist
                blend = math.Clamp( blend, 0, 1 )

            end

            if blend > 0.1 and not self.homeless_RunAway and system.HasFocus() then

                local sawTooMuch
                local screened = myPos:ToScreen()
                local width = ScrW()
                local height = ScrH()
                local middleX = width / 2
                local middleY = height / 2
                local amInWall = inWall( myShootPos )

                local toMiddleX = math.abs( screened.x - middleX )
                local toMiddleY = math.abs( screened.y - middleY )

                local divBite = feltTolerance() / 2
                local div = math.Clamp( 18 + -divBite, 1, math.huge )
                if doingViewEnt and terminator_Extras.PosCanSee( viewEnt:WorldSpaceCenter(), myShootPos, MASK_SOLID_BRUSHONLY ) then
                    div = 1

                end

                local looking = not amInWall and ( toMiddleX < ( width / div ) ) and ( toMiddleY < ( height / div ) )
                local canSee = not amInWall and ( toMiddleX < width ) and ( toMiddleY < height )

                if not amInWall and renderTargeting and not looking and ( ( screened.x > width or screened.x < -width ) or ( screened.y > height or screened.y < -height ) ) then
                    self.homeless_ShoddyRtCamCount = self.homeless_ShoddyRtCamCount + 1
                    looking = self.homeless_ShoddyRtCamCount > math.Clamp( 1000 + -feltTolerance() * 25, 10, math.huge )

                end

                if canSee and not doingCamo then
                    figure.homeless_SawDiscomfort = figure.homeless_SawDiscomfort + 1
                    sawTooMuch = figure.homeless_SawDiscomfort > math.Clamp( 100 + -feltTolerance(), 0, 100 )

                end

                if looking or sawTooMuch then
                    runAway()
                    self.homeless_WasSeen = true
                    local path = ambientSounds[math.random( 1, #ambientSounds ) ]
                    self:EmitSound( path, 67, math.random( 80, 95 ) - ( feltTolerance() * 0.5 ), 0.25 )

                end
            end

            render.SetBlend( blend )
            render.SetColorModulation( 0, 0, 0 )
            if currMat then
                render.MaterialOverride( currMat )

            end
            self:DrawModel()
            if currMat then
                render.MaterialOverride( nil )

            end
            render.SetBlend( 1 )
            render.SetColorModulation( 1, 1, 1 )

        end
    end

    local function onDone()
        hooking = false
        if not IsValid( figure ) then return end

        hook.Remove( "PreDrawTranslucentRenderables", "homeless_DrawFigure" )
        hook.Remove( "Think", "homeless_UpdateFigureModel" )

        tolerance = tolerance + 1
        currSeenCount = currSeenCount + 1

        homeless_PrepareAmbiance()
        local msgSpacing = math.random( 0, hour * 0.15 )
        LocalPlayer():ConCommand( "cl_homeless_nextmessage " .. math.Round( os.time() + msgSpacing ) )

        if currType == "follower" then
            upsideDown = nil

            if currSeenCount < math.random( 2, 25 ) then
                tolerance = tolerance + 1
                SafeRemoveEntity( figure )
                local name = "homeless_parasite_reattach"
                local badAngWait = 0
                local time = feltTolerance()
                if math.random( 1, 100 ) > ( 95 - tolerance ) then
                    time = time * math.random( 2, 15 )

                end
                local div = math.Round( 11.25 + time )
                local startingYaw = math.Round( LocalPlayer():GetAngles().yaw / div ) * div
                timer.Create( name, time, 0, function()
                    if math.Round( LocalPlayer():GetAngles().yaw / div ) * div == startingYaw then
                        badAngWait = CurTime() + feltTolerance()
                        return

                    elseif badAngWait > CurTime() then
                        return

                    end
                    doFollower( "follower" )
                    timer.Remove( "homeless_parasite_reattach" )

                end )
                return

            end
            homeless_PrepareAmbiance()

            if figure.homeless_WasSeen then
                local spacing = ( hour * math.random( 6, 24 ) )
                if math.random( 0, 100 ) > 50 then
                    spacing = spacing * math.random( 1, 8 )

                end
                LocalPlayer():ConCommand( "cl_homeless_nextfollower " .. math.Round( math.max( followerVar:GetInt(), os.time() ) + spacing ) )
                timer.Simple( feltTolerance() * math.Rand( 2, 4 ), function()
                    net.Start( "homeless_asktopeek" )
                    net.SendToServer()

                end )

            else
                timer.Simple( feltTolerance() * math.Rand( 0.5, 1.5 ), function()
                    net.Start( "homeless_asktopeek" )
                    net.SendToServer()

                end )
            end
            SafeRemoveEntity( figure )
            currSeenCount = 0

        elseif currType == "peeker" then
            if figure.homeless_WasSeen then
                local spacing = ( hour * math.random( 4, 16 ) )
                LocalPlayer():ConCommand( "cl_homeless_nextfollower " .. math.Round( math.max( followerVar:GetInt(), os.time() ) + spacing ) )

            end
            SafeRemoveEntity( figure )
            if currSeenCount < math.random( 1, 150 ) then
                timer.Simple( feltTolerance() * currSeenCount^1.25, function()
                    net.Start( "homeless_asktopeek" )
                    net.SendToServer()

                end )
            else
                currSeenCount = 0

            end
        end

        peekerPos = nil
        upsideDown = nil
        currGoalPos = nil
        initialPosInWallTries = 0

    end

    hook.Remove( "Think", "homeless_UpdateFigureModel" )

    local function createHooks( figType )
        if hooking then return end
        initialPosInWallTries = 0
        currType = figType
        hooking = true

        if not tolerance then
            tolerance = 1
            local current = os.time()
            local varsValue = followerVar:GetInt()
            if varsValue > current then
                local diff = varsValue - current
                local added = diff / hour
                added = added / 10
                added = math.ceil( added )
                tolerance = tolerance + added

            end
            if not dedicationVar then
                dedicationVar = GetConVar( "cl_homeless_dedication" )

            end
            if dedicationVar:GetInt() <= 0 then -- too early
                tolerance = math.max( tolerance * 2, 10 )

            end
        end

        local ply = LocalPlayer()
        hook.Add( "Think", "homeless_UpdateFigureModel", function()
            if not IsValid( ply ) then return end

            if not IsValid( figure ) then CreateFigure() return end

            local oldPos = figure:GetPos()

            local figureLookAt = getViewEnt()
            if not IsValid( figureLookAt ) or not system.HasFocus() then
                figureLookAt = ply

            end

            local figurePos
            if not figure.homeless_RunAway then
                if currType == "follower" then
                    local pos = ply:GetPos()
                    local dist = math.Clamp( 125 + -( feltTolerance() ^2.5 ), 15, math.huge )
                    local offset = -ply:GetAimVector() * dist
                    figurePos = pos + offset
                    figurePos.z = pos.z
                    local newInWall = inWall( figurePos )
                    local viewEnt = getViewEnt()
                    if viewEnt ~= ply and system.HasFocus() and viewEnt:WorldSpaceCenter():Distance( oldPos + -pokeHeadOutOffset() ) < 200 then
                        figurePos = oldPos

                    elseif newInWall then
                        figurePos = oldPos

                    else
                        tolerance = tolerance + 0.0005

                    end
                    currGoalPos = figurePos
                elseif currType == "peeker" then
                    figurePos = peekerPos + pokeHeadOutOffset()
                    currGoalPos = figurePos

                    local currShoot = oldPos + ( -pokeHeadOutOffset() * 1.1 )
                    local brightness = render.GetLightColor( currShoot )
                    if not doingCamo and not inWall( currShoot ) and brightness:Length() > 0.35 then
                        figure.homeless_Discomfort = figure.homeless_Discomfort + 1

                    elseif ply:GetShootPos():Distance( currShoot ) < 200 then
                        figure.homeless_Discomfort = figure.homeless_Discomfort + 5

                    end

                    if system.HasFocus() and figure.homeless_Discomfort > math.Clamp( 200 -( feltTolerance() * 20 ), 60, math.huge ) then
                        runAway()

                    elseif figure.homeless_Discomfort <= 10 then
                        tolerance = math.Clamp( tolerance + -0.0001, 0, math.huge )

                    end
                end
            else
                local since = CurTime() - figure.homeless_RunAwayTime
                local dist = oldPos:Distance( ply:GetPos() )
                local added = dist / 2000
                local haltTime = ( figure.homeless_RunAwayTimeToBolt + added )
                local sinceFixed = since - haltTime
                if dist < 800 and not upsideDown then
                    haltTime = 0
                    sinceFixed = since -- un-fix

                end
                if sinceFixed > 0 then
                    local offset = ( -figure:GetForward() + -figure:GetUp() * 0.5 ) * ( sinceFixed ^ 3 ) * ( feltTolerance() ^2 )
                    figurePos = oldPos + offset

                    if inWall( figurePos ) then
                        figure.homeless_ReturnedCount = figure.homeless_ReturnedCount + 1

                    end
                    if math.max( math.abs( figurePos.x ), math.abs( figurePos.y ), math.abs( figurePos.z ) ) > 90000 then
                        onDone()

                    elseif figure.homeless_ReturnedCount > 200 then
                        onDone()

                    end
                end
            end
            if figurePos then
                if not figure.homeless_InitialPosInWall then -- we start where we belong
                    local dirOverride = peekerNormal
                    if not dirOverride then
                        local plysAng = ply:GetAngles()
                        plysAng.pitch = 0
                        plysAng.roll = 0
                        dirOverride = ( -plysAng:Forward() + ( VectorRand() * 0.5 ) )
                        dirOverride:Normalize()

                    else
                        dirOverride = -dirOverride

                    end

                    local _, _, nearestWall = terminator_Extras.GetVoiceboxPos( getViewEnt():WorldSpaceCenter(), dirOverride )
                    if nearestWall then
                        figurePos = nearestWall + ( dirOverride * 500 )
                        figure.homeless_InitialPosInWall = true

                    else
                        initialPosInWallTries = initialPosInWallTries + 1

                    end
                    if initialPosInWallTries >= 40 then
                        figure.homeless_InitialPosInWall = true

                    end
                elseif not figure.homeless_GottenToPos then -- make our way out
                    local subtProduct = figurePos - oldPos
                    local dist = subtProduct:Length()
                    if dist <= 5 then
                        figure.homeless_GottenToPos = true

                    end
                    figurePos = oldPos + subtProduct:GetNormalized() * math.Clamp( dist / 200, 1, 200 )

                end
                --debugoverlay.Cross( figurePos, 10, 0.1, color_white, true )
                figure:SetPos( figurePos )

            end

            local subtProductAng = figureLookAt:GetPos() - oldPos
            local dir = subtProductAng
            dir:Normalize()
            local targetAng = dir:Angle()
            targetAng.pitch = 0
            targetAng.roll = 0
            if upsideDown then
                targetAng:RotateAroundAxis( targetAng:Forward(), -180 )

            end
            local targetYaw = targetAng.yaw

            local currYaw = figure:GetAngles().yaw

            local newYaw = math.ApproachAngle( currYaw, targetYaw, ( tolerance^1.15 ) / 2.5 )
            local newAngle = Angle( 0, newYaw, 0 )
            figure:SetAngles( newAngle )


            figure:SetSequence( ply:GetSequence() )
            figure:SetCycle( ply:GetCycle() )
            figure:SetPlaybackRate( ply:GetPlaybackRate() )

            figure:FrameAdvance( FrameTime() )

        end )

        hook.Add( "PreDrawTranslucentRenderables", "homeless_DrawFigure", function( _, _, doingSkybox )
            if doingSkybox then return end
            if doingCamo then return end
            if not IsValid( figure ) then return end

            figure:DrawModel()

        end )
    end
    function doFollower( figType )
        if not terminator_Extras then return end

        local already = #ents.FindByClass( "terminator_nextbot_homeless" ) >= 1
        if already and not terminator_Extras.homeless_Scorned then return end

        createHooks( figType )
        return true

    end
    net.Receive( "homeless_attach_parasite_follower", function()
        doFollower( "follower" )

    end )
    net.Receive( "homeless_peeking_parasite", function()
        if not doFollower( "peeker" ) then return end
        peekerPos = net.ReadVector()
        peekerNormal = net.ReadVector()
        if peekerNormal:Dot( up ) < -0.5 then
            upsideDown = true

        end
    end )

    --doFollower( "follower" )
    --peekerNormal = Vector( 0,0,1 )
    --peekerPos = LocalPlayer():GetEyeTrace().HitPos
    --debugoverlay.Cross( peekerPos, 10, 10, color_white, true )

end