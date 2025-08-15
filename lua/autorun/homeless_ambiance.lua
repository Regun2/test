if SERVER then
    AddCSLuaFile()

    util.AddNetworkString( "homeless_misc_ambiance" )

elseif CLIENT then
    local entMeta = FindMetaTable( "Entity" )
    local vecMeta = FindMetaTable( "Vector" )

    local color_red = Color( 255, 0, 0 )
    local vec12kZ = Vector( 0, 0, 12000 )
    local vecUpOff = Vector( 0, 0, 25 )

    local ambianceVar = CreateClientConVar( "cl_homeless_nextmessage", 0, true, true )
    local lastMsgVar = CreateClientConVar( "cl_homeless_lastmessage", 0, true, true )

    local function inWall( pos )
        return bit.band( util.PointContents( pos ), MASK_SOLID_BRUSHONLY ) > 0

    end

    local function IsUnderSkyPos( pos )
        pos = pos + vecUpOff
        -- get the sky
        local skyTraceDat = {
            start = pos,
            endpos = pos + vec12kZ,
            mask = CONTENTS_SOLID,
        }
        local skyTraceResult = util.TraceLine( skyTraceDat )

        if skyTraceResult.HitSky then
            return true

        elseif not skyTraceResult.Hit then
            return true

        else
            return false

        end
    end

    local pitBlackVibe = 0.005
    local darkVibe = 0.08

    local function getVibe( pos )
        local brightness = render.GetLightColor( pos )
        local leng = brightness:Length()
        if leng > darkVibe then return end

        for _, light in ipairs( ents.FindByClass( "gmod_light" ) ) do -- might not be needed? but it was useful when i tested it so
            local lightTbl = entMeta.GetTable( light )
            if not lightTbl.GetOn then continue end -- ???????
            if not lightTbl.GetOn( light ) then continue end

            local lightBrightness = lightTbl.GetBrightness( light )
            if lightBrightness <= 0.5 then continue end

            local lightPos = entMeta.GetPos( light )
            local size = lightTbl.GetLightSize( light )
            size = size + ( -size / 4 )
            local sizeSqr = size ^ 2

            if vecMeta.DistToSqr( lightPos, pos ) > sizeSqr then continue end
            leng = leng + ( lightBrightness / 8 )

        end

        if leng <= pitBlackVibe then
            return "pitchblack"

        elseif leng <= darkVibe then
            return "dark"

        end
    end

    local hour = 3600

    local far = 900

    local TYPE_ENCLOSED = 1
    local TYPE_OPEN = 2

    local ambientSounds = {
        { path = "ambient/creatures/rats1.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/creatures/rats2.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/creatures/rats3.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/creatures/rats4.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/creatures/flies1.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/creatures/flies2.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/creatures/flies3.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/creatures/flies4.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/creatures/flies5.wav", ambType = TYPE_ENCLOSED },
        { path = "doors/door1_stop.wav", ambType = TYPE_ENCLOSED },
        { path = "doors/door_wood_close1.wav", ambType = TYPE_ENCLOSED },
        { path = "doors/door_metal_medium_close1.wav", ambType = TYPE_ENCLOSED },
        { path = "doors/door_metal_thin_close2.wav", ambType = TYPE_ENCLOSED },
        { path = "physics/cardboard/cardboard_cup_impact_hard1.wav", ambType = TYPE_ENCLOSED },
        { path = "physics/cardboard/cardboard_cup_impact_hard2.wav", ambType = TYPE_ENCLOSED },
        { path = "physics/cardboard/cardboard_cup_impact_hard3.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/levels/canals/swamp_bird2.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/levels/streetwar/city_scream3.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/levels/streetwar/building_rubble1.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/levels/streetwar/building_rubble2.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/levels/streetwar/building_rubble3.wav", ambType = TYPE_ENCLOSED },
        { path = "ambient/levels/streetwar/building_rubble4.wav", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/amb1.mp3", ambType = TYPE_ENCLOSED }, -- below from gm_russia
        { path = "homeless/ambiance/amb2.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/beat_door_loud.mp3", ambType = TYPE_ENCLOSED, noCloserThan = far },
        { path = "homeless/ambiance/breathe_scared1.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/breathe_scared2.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/death_breath.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metal1.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metal2.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metal3.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metal4.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metal5.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metal6.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metal7.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metal8.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metal9.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metalhit_far1.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metalhit_far2.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metalhit_far3.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metalhit_far4.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metalhit_far5.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metalhit_far6.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metalhit_far7.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metalhit_far8.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/metalhit_far10.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/scream_far1.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/scream_far2.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/scream_far3.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/talking.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/underground_scream.mp3", ambType = TYPE_ENCLOSED, noCloserThan = far },
        { path = "homeless/ambiance/thumping_1.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/thumping_2.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/thumping_3.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/thumping_4.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/thumping_5.mp3", ambType = TYPE_ENCLOSED },
        { path = "homeless/ambiance/thumping_6.mp3", ambType = TYPE_ENCLOSED },

        { path = "ambient/atmosphere/city_truckpass1.wav", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "ambient/levels/canals/windchime5.wav", ambType = TYPE_OPEN, noCloserThan = 1250 },
        { path = "ambient/levels/forest/peckr1.wav", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "ambient/levels/forest/peckr2.wav", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "player/footsteps/gravel1.wav", ambType = TYPE_OPEN },
        { path = "player/footsteps/gravel4.wav", ambType = TYPE_OPEN },
        { path = "homeless/ambiance/open/WA_TreeCreak_Lite_04.mp3", ambType = TYPE_OPEN, noCloserThan = far }, -- from the isle i think
        { path = "homeless/ambiance/open/WA_TreeCreak_Lite_05.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/WA_TreeCreak_Redwoods_01.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/WA_TreeCreak_Redwoods_03.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/WA_TreeCreak_Redwoods_05.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/WA_TreeCreak_Redwoods_06.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/WA_TreeCreak_Redwoods_07.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/WA_TreeCreak_Redwoods_08.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/WA_TreeCreak_Redwoods_09.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/WA_TreeCreak_Redwoods_10.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-01.mp3", ambType = TYPE_OPEN, noCloserThan = far }, -- Dynamic Prop Ambience 3377516245
        { path = "homeless/ambiance/open/tree_creak-02.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-03.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-04.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-05.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-06.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-07.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-08.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-09.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-10.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-11.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-12.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-13.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_creak-14.mp3", ambType = TYPE_OPEN, noCloserThan = far },
        { path = "homeless/ambiance/open/tree_leaves-01.mp3", ambType = TYPE_OPEN },
        { path = "homeless/ambiance/open/tree_leaves-02.mp3", ambType = TYPE_OPEN },
        { path = "homeless/ambiance/open/tree_leaves-03.mp3", ambType = TYPE_OPEN },
        { path = "homeless/ambiance/open/tree_leaves-05.mp3", ambType = TYPE_OPEN },

    }

    local test = false
    local toPlayTypes = {}

    local function debugPrint( ... )
        if not test then return end
        print( ... )

    end

    hook.Remove( "Think", "homeless_ambiance_do" ) -- auto re fresh!

    function homeless_PrepareAmbiance()
        local nextThink = 0
        hook.Add( "Think", "homeless_ambiance_do", function()
            if nextThink > CurTime() then return end
            nextThink = CurTime() + 0.01

            local osTime = os.time()

            if not test and ambianceVar:GetInt() > osTime then nextThink = CurTime() + 1 return end

            local ply = LocalPlayer()
            local shoot = ply:GetShootPos()

            local dir = ply:GetAimVector()
            if not test then
                dir = -dir

            end

            local offset = ( dir * 0.75 ) + ( VectorRand() * 0.5 )
            offset:Normalize()
            offset = offset * math.random( 500, 1500 )

            local offsetted = shoot + offset

            if inWall( offsetted ) then return end
            local vibe = getVibe( offsetted )

            if vibe ~= "pitchblack" then
                if test and vibe == "dark" then
                    debugoverlay.Cross( offsetted, 10, 5, color_red, true )

                end
                --debugPrint( "too bright" )
                return

            end
            if terminator_Extras.PosCanSee( offsetted, shoot, MASK_SOLID_BRUSHONLY ) then return end
            if terminator_Extras.posIsUnderDisplacement( offsetted ) then return end

            local nookScore = terminator_Extras.GetNookScore( offsetted )
            local desiredType
            if nookScore >= 4 then
                desiredType = TYPE_ENCLOSED

            elseif nookScore <= 2.5 and IsUnderSkyPos( offsetted ) then
                desiredType = TYPE_OPEN

            end
            if not desiredType then debugPrint( "not enclosed or wide open" ) return end

            local toPlayOfType = toPlayTypes[desiredType]

            if not toPlayOfType or #toPlayOfType <= 0 then
                toPlayOfType = {}
                for _, data in ipairs( ambientSounds ) do
                    if data.ambType == desiredType then
                        table.insert( toPlayOfType, data )

                    end
                end
                toPlayTypes[desiredType] = toPlayOfType

            end

            local ind = math.random( 1, #toPlayOfType )
            local potentialPlaying = toPlayOfType[ind]
            local inTheRealTable = nil
            for inRealInd, data in ipairs( ambientSounds ) do
                if data.path == potentialPlaying.path then
                    inTheRealTable = inRealInd
                    break

                end
            end

            if lastMsgVar:GetInt() == inTheRealTable then return end --not twice in a row
            if potentialPlaying.noCloserThan and offsetted:Distance( shoot ) < potentialPlaying.noCloserThan then return end

            local playing = table.remove( toPlayOfType, ind )

            homeless_AllowOneAmbientSound()
            sound.Play( playing.path, offsetted, 84, math.Rand( 98, 102 ), 1 )

            local timeOffset = math.random( hour / 10, hour * 48 )
            debugPrint( timeOffset / hour )

            local nextPlay = osTime + timeOffset
            nextPlay = math.Round( nextPlay )
            ply:ConCommand( "cl_homeless_nextmessage " .. nextPlay )
            ply:ConCommand( "cl_homeless_lastmessage " .. inTheRealTable )

            nextThink = CurTime() + 5

            if test then
                debugoverlay.Cross( offsetted, 10, 5, color_white, true )

            end

            hook.Run( "homeless_postplayambiance" )

        end )
    end

    if test then
        homeless_PrepareAmbiance()

    end

    net.Receive( "homeless_misc_ambiance", function()
        homeless_PrepareAmbiance()

    end )

    timer.Remove( "homeless_ambiancefind" ) -- autoref

    local tension = 0
    local prePeakMax = 85
    local peakNeeded = 100

    timer.Create( "homeless_ambiancefind", 5, 0, function()
        local osTime = os.time()
        if ambianceVar:GetInt() > osTime then return end

        if not terminator_Extras then return end

        local ply = LocalPlayer()
        if not IsValid( ply ) then return end
        if not ply.GetShootPos then return end

        local shoot = ply:GetShootPos()
        local vibe = getVibe( shoot )
        if vibe == "pitchblack" then
            debugPrint( "perfect vibe" )

            timer.Adjust( "homeless_ambiancefind", 1 )
            tension = tension + 1

            if tension > peakNeeded then
                homeless_PrepareAmbiance()
                timer.Remove( "homeless_ambiancefind" )
                tension = 0

            end

        elseif vibe == "dark" then
            timer.Adjust( "homeless_ambiancefind", 1 )
            tension = math.min( tension + 1, prePeakMax )

        else
            tension = math.max( tension + -0.1, 0 )

        end
    end )
end