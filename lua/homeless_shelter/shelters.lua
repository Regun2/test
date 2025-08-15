local genericGrafittis = {
    "decals/bills01a",
    "decals/bills02a",
    "decals/bills03a",
    "decals/bills04a",
    "decals/bills05a",
    "decals/decalgraffiti001a",
    "decals/decalgraffiti001b",
    "decals/decalgraffiti001c",
    "decals/decalgraffiti001d",
    --"decals/decalgraffiti003a",
    "decals/decalgraffiti005a",
    "decals/decalgraffiti006a",
    "decals/decalgraffiti007a",
    "decals/decalgraffiti008a",
    --"decals/decalgraffiti009a",
    "decals/decalgraffiti010a",
    --"decals/decalgraffiti011a",
    "decals/decalgraffiti012a",
    "decals/decalgraffiti015a",
    "decals/decalgraffiti017a",
    "decals/decalgraffiti018a",
    "decals/decalgraffiti020a",
    "decals/decalgraffiti022a",
    "decals/decalgraffiti023a",
    --"decals/decalgraffiti024a", --born
    --"decals/decalgraffiti025a",
    "decals/decalgraffiti028a",
    "decals/decalgraffiti031a",
    "decals/decalgraffiti036a",
    --"decals/decalgraffiti037a", -- used below
    --"decals/decalgraffiti038a", -- interp
    "decals/decalgraffiti043a",
    "decals/decalgraffiti044a",
    "decals/decalgraffiti046a",
    "decals/decalgraffiti047a",
    "decals/decalgraffiti049a",
    "decals/decalgraffiti050a",
    "decals/decalgraffiti054a",
    --"decals/decalgraffiti056a", -- used below
    --"decals/decalgraffiti059a",
    "decals/decalgraffiti060a",
    "decals/decalgraffiti061a",
    "decals/decalgraffiti062a",
    "homeless/decals/whatwouldyoudotolive",
    "homeless/decals/youare",
    "homeless/decals/not_his/decalgraffiti053a", -- from gm_summit_office
    "homeless/decals/not_his/graffiti_tag_01",
    "homeless/decals/not_his/graffiti_tag_02",
    "homeless/decals/not_his/graffiti_tag_03",
    "homeless/decals/not_his/graffiti_tag_04",
    "homeless/decals/not_his/graffiti_venice_04",
    "homeless/decals/not_his/graffiti_venice_05", -- end from gm_summit_office
    -- "decals/decalstain013a" -- looks barely like a person, cut because it spawns 1 mm off the ground

}

local gulls = {
    "homeless/decals/gull1",
    "homeless/decals/gull2",
    "homeless/decals/gull3",
    "homeless/decals/gull4", -- this one is limited
    "homeless/decals/gull5", -- and this one
    "homeless/decals/gull6", -- aand this one

}

local note = { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", wallsnap = true }
terminator_Extras.homeless_NoteFurniture = note
terminator_Extras.homeless_NoteShelter = {
    dedication = -1,
    skyagnostic = true,
    furniture = {
        note
    }
}

local lost = { mdl = "models/hunter/misc/sphere025x025.mdl", class = "homeless_lost", pos = Vector( 0, 0, 0 ), ang = Angle( 0, 0, 0 ) }
terminator_Extras.homeless_LostFurniture = lost
terminator_Extras.homeless_LostShelter = {
    dedication = 1,
    minsize = 25,
    notedetail = 2,
    furniture = {
        lost
    }
}

local blemish = { class = "infodecal", pos = 10, ang = Angle( -90, 0, 0 ), keys = { texture = "decals/decalstain005a" } }
local blood = { class = "infodecal", pos = 10, ang = Angle( -90, 0, 0 ), keys = { texture = "decals/bloodstain_002" } }

local bornposter = { class = "infodecal", pos = 40, drop = false, wallsnap = true, facewall = true, keys = { texture = "decals/decalgraffiti024a" } }
local randdecal = { class = "infodecal", pos = 10, drop = false, wallsnap = true, facewall = true, keys = { texture = genericGrafittis }, alwaysLimitGrafitti = true }

local himdecal = { class = "infodecal", pos = 30, drop = false, wallsnap = true, facewall = true, keys = { texture = "homeless/decals/him" } }
local himfadedecal = { class = "infodecal", pos = 30, drop = false, wallsnap = true, facewall = true, keys = { texture = "homeless/decals/him_faded" } }
local realfakedoordecal = { class = "infodecal", pos = Vector( 5, 10, 30 ), drop = false, wallsnap = true, facewall = true, keys = { texture = "homeless/decals/realdoor" } }
local gulldecal = { class = "infodecal", pos = 40, drop = false, wallsnap = true, facewall = true, keys = { texture = gulls } }
local shrinedecal = { class = "infodecal", pos = 10, drop = false, wallsnap = true, facewall = true, keys = { texture = "homeless/decals/shrine" } }
local wallmandecal = { class = "infodecal", pos = 40, drop = false, wallsnap = true, facewall = true, keys = { texture = "homeless/decals/wallman" } }
local enddecal = { class = "infodecal", pos = 60, drop = false, wallsnap = true, facewall = true, keys = { texture = "homeless/decals/end" } }


local trashdecal1 = { class = "infodecal", pos = 15, drop = true, wallsnap = false, facefloor = true, keys = { texture = "decals/trashdecal01a" } }
local trashdecal2 = { class = "infodecal", pos = 15, drop = true, wallsnap = false, facefloor = true, keys = { texture = "decals/trashdecal02a" } }
local trashdecal3 = { class = "infodecal", pos = 15, drop = true, wallsnap = false, facefloor = true, keys = { texture = "decals/trashdecal03a" } }
local trashdecalrand = { class = "infodecal", pos = 30, drop = true, wallsnap = false, facefloor = true, keys = { texture = { "decals/trashdecal01a", "decals/trashdecal02a", "decals/trashdecal03a" } } }

local tiredecal = { class = "infodecal", pos = 15, drop = true, wallsnap = false, facefloor = true, keys = { texture = "decals/decaltiremark001a" } }
local rugdecal = { class = "infodecal", pos = 15, drop = true, wallsnap = false, facefloor = true, keys = { texture = "decals/decalrug001a" } }

local radioOverride = function()
    if math.random( 0, 250 ) <= 8 then return "homeless_radio_bliss" end
    return "homeless_radio"
end

local wasteFenceMat = "models/props_wasteland/wood_fence01a"

terminator_Extras.shelter_DefaultClassOverrides = {
    ["models/props_lab/citizenradio.mdl"]   = radioOverride,
    ["models/maxofs2d/camera.mdl"]          = "homeless_camera",
    ["models/props_c17/paper01.mdl"]        = "homeless_note",

}

terminator_Extras.homeless_Shelters = {
    {
        dedication = 2,
        likessky = true,
        centerpiece = true,
        minsize = 225,
        furniture = {
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", pos = Vector( -1.1, 1.1, 4.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", pos = Vector( -1, -2.6, 59.7 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", pos = Vector( -5.9, -3.7, 79.2 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( 2.4, 12.5, -2.6 ), ang = Angle( 0, -151, 0 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", pos = Vector( -1, 21.3, 88.4 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( -67.4, 26.5, 21 ), ang = Angle( 0.1, 14.8, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( 63, -39.6, 21.1 ), ang = Angle( 0, 123.7, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( 28.4, 58.1, 21.3 ), ang = Angle( -0.1, 69.8, -0.1 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( -29.6, 49.1, 61.7 ), ang = Angle( -0.1, 110.2, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( -20.1, -45.1, 21.3 ), ang = Angle( 0, 138.3, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( 2.3, 1.8, 108.5 ), ang = Angle( -29.2, 79.1, 7.6 ) },
            { mdl = "models/player/charple.mdl", class = "terminator_nextbot_homeless", mdlafter = true, pos = Vector( 80.7, 22.3, 1.2 ), ang = Angle( 0, 2.2, 0 ) },
        }
    },
    {
        dedication = 2,
        centerpiece = true,
        furniture = {
            { mdl = "models/player/charple.mdl", class = "terminator_nextbot_homeless", mdlafter = true, wallsnap = false },
        }
    },
    {
        dedication = 2,
        furniture = {
            blemish,
            blood,
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -13.7, 18.9, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/charple01.mdl", class = "prop_ragdoll", fire = { IgniteLifetime = 45 } },
        }
    },
    {
        dedication = 2,
        furniture = {
            blemish,
            blood,
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -13.7, 18.9, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/charple01.mdl", class = "prop_ragdoll", fire = { IgniteLifetime = 45 } },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -3.2, 25.3, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/charple01.mdl", class = "prop_ragdoll", pos = Vector( -12.1, 14.4, 52.6 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( 8.4, -11.8, 4.7 ), ang = Angle( 89.9, -91.2, 14.5 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( -13.3, -1.3, 4.8 ), ang = Angle( 89.8, -4.4, -14.7 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( 16.9, 20.8, 4.9 ), ang = Angle( 89.9, 153.1, 129.6 ) },
        }
    },

    -- king stuff
    {
        dedication = 2,
        minsize = 100,
        skyagnostic = true,
        centerpiece = true,
        furniture = {
            blood,
            { mdl = "models/hunter/misc/sphere1x1.mdl", class = "homeless_seagullking", pos = Vector( -9.5, 0.3, 106 ), ang = Angle( -44.9, -154.6, 21.8 ) },
            { mdl = "models/humans/charple01.mdl", class = "prop_ragdoll", pos = Vector( -15.1, 6.2, 3.4 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/charple03.mdl", class = "prop_ragdoll", pos = Vector( -4.7, -19.9, 3.9 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 2,
        likessky = true,
        nevercenterpiecefollower = true,
        maxsize = 250,
        furniture = {
            { mdl = "models/hunter/misc/sphere1x1.mdl", class = "homeless_seagullking" },
        }
    },
    {
        dedication = 2,
        likessky = true,
        nevercenterpiecefollower = true,
        maxsize = 250,
        furniture = {
            { mdl = "models/hunter/misc/sphere1x1.mdl", class = "homeless_seagullking" },
        }
    },
    {
        dedication = 2,
        likessky = true,
        centerpiece = true,
        minsize = 175,
        furniture = {
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -8.4, -66.1, 54.3 ), ang = Angle( 0, -90, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( 57.2, 2.6, 56 ), ang = Angle( 0, 3.1, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -7.2, 65.9, 54.7 ), ang = Angle( 0, 94.6, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -75.8, -4.5, 54.8 ), ang = Angle( 0, 178.9, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -8.4, -0.2, 105.9 ), ang = Angle( -87.7, -2.9, -174.8 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( -41.9, 52.6, 119.5 ), ang = Angle( 0.1, 85.4, 2.3 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( -43.4, -46.7, 113.6 ), ang = Angle( 2.3, -6.9, -90.2 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( 21.7, -46.7, 110.7 ), ang = Angle( 87.7, 177.1, 164.6 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( 16.3, 54.1, 112 ), ang = Angle( 79.6, 131.6, 100.7 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", pos = Vector( -10.8, 68.9, 25.4 ), ang = Angle( -2.2, 93.7, -90 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", pos = Vector( 22.2, 74, 66.7 ), ang = Angle( -3.4, 94.6, 0 ) },
            { mdl = "models/hunter/misc/sphere1x1.mdl", class = "homeless_seagullking", pos = Vector( -42.6, 29.2, 25.2 ), ang = Angle( 52.7, 174.8, -41.3 ) },
        }
    },
    {
        dedication = 2,
        likessky = true,
        centerpiece = true,
        minsize = 175,
        furniture = {
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -8.4, -66.1, 54.3 ), ang = Angle( 0, -90, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( 57.2, 2.6, 56 ), ang = Angle( 0, 3.1, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -7.2, 65.9, 54.7 ), ang = Angle( 0, 94.6, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -75.8, -4.5, 54.8 ), ang = Angle( 0, 178.9, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", pos = Vector( -8.4, -0.2, 105.9 ), ang = Angle( -87.7, -2.9, -174.8 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", wallsnap = true, pos = Vector( -41.9, 52.6, 119.5 ), ang = Angle( 0.1, 85.4, 2.3 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", wallsnap = true, pos = Vector( -43.4, -46.7, 113.6 ), ang = Angle( 2.3, -6.9, -90.2 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", wallsnap = true, pos = Vector( 21.7, -46.7, 110.7 ), ang = Angle( 87.7, 177.1, 164.6 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", wallsnap = true, pos = Vector( 16.3, 54.1, 112 ), ang = Angle( 79.6, 131.6, 100.7 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", pos = Vector( -10.8, 68.9, 25.4 ), ang = Angle( -2.2, 93.7, -90 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", pos = Vector( 22.2, 74, 66.7 ), ang = Angle( -3.4, 94.6, 0 ) },
            { mdl = "models/hunter/misc/sphere1x1.mdl", class = "homeless_seagullking", pos = Vector( -42.6, 29.2, 25.2 ), ang = Angle( 52.7, 174.8, -41.3 ) },
        }
    },
    {
        dedication = 2,
        likessky = true,
        centerpiece = true,
        minsize = 225,
        furniture = {
            gulldecal,
            gulldecal,
            { mdl = "models/props_junk/trashdumpster02.mdl", pos = Vector( 4.7, -2, 60.6 ), ang = Angle( 0, 92, -180 ) },
            { mdl = "models/hunter/misc/sphere1x1.mdl", class = "homeless_deadseagullking", pos = Vector( -12.4, 19.9, 12.1 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    -- end king

    {
        dedication = 2,
        likessky = true,
        centerpiece = true,
        minsize = 250,
        furniture = {
            { mdl = "models/props_c17/canister_propane01a.mdl", frozen = true, pos = Vector( 9.3, -51.2, 14 ), ang = Angle( -83.1, -0.1, 89.9 ) },
            { mdl = "models/props_c17/canister_propane01a.mdl", frozen = true, pos = Vector( 39, -52.8, 14.1 ), ang = Angle( -83.1, -0.3, 90.1 ) },
            { mdl = "models/humans/charple03.mdl", class = "prop_ragdoll", pos = Vector( 36.5, 26.9, 104.6 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/charple04.mdl", class = "prop_ragdoll", pos = Vector( 50.1, 34.6, 72.4 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/charple02.mdl", class = "prop_ragdoll", pos = Vector( 53.9, 31.5, 96.4 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( -92.7, -45.9, 5 ), ang = Angle( -89.9, 95.1, -89.6 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -74.4, -79.5, 5.1 ), ang = Angle( -89.8, -58.1, -21.6 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -100.4, -82.2, 5.2 ), ang = Angle( -89.9, -28, -22.7 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -37.6, -99.2, 5.3 ), ang = Angle( -90, 10.9, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -30.6, -72.8, 5.4 ), ang = Angle( -90, 13.2, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -26.7, -73.1, 14 ), ang = Angle( -89.9, 12.8, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -37.5, -96.2, 14.1 ), ang = Angle( -90, 173.9, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -29.8, -86.2, 22.7 ), ang = Angle( -89.8, 82.6, -21.5 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -104.4, -83.5, 14.3 ), ang = Angle( -89.7, 5.5, -96.7 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -87.8, -84.1, 20.1 ), ang = Angle( -65.8, -0.4, -0.1 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -111.1, 28.1, 6 ), ang = Angle( -90, -97.3, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -109.9, 68.1, 6.1 ), ang = Angle( -90, -93.2, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -109.2, 26.8, 14.6 ), ang = Angle( -89.9, -67.9, 152.6 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -109.9, 26.9, 23 ), ang = Angle( -89.9, -32.2, 114.8 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -77.3, 22.6, 6.4 ), ang = Angle( -89.9, 81.9, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -94.7, -50.2, 15 ), ang = Angle( -89.9, 106.8, -119.7 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -89.5, -46.4, 23.4 ), ang = Angle( -89.7, 84.6, -73.9 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -53, -47.8, 6.7 ), ang = Angle( -89.9, 29.2, -43 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -47.7, -48.3, 15.2 ), ang = Angle( -90, -155.4, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -107.2, -9, 6.9 ), ang = Angle( -90, -25.2, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -106.2, -8.6, 15.5 ), ang = Angle( -89.8, -139.6, 118.2 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -109.4, -6.2, 24 ), ang = Angle( -89.6, -99.7, -56.1 ) },
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( 45.5, 44.4, -0.2 ), ang = Angle( 0, -83, 0 ) },
            { mdl = "models/props_c17/furnituredresser001a.mdl", pos = Vector( 43.9, 44.2, 49.4 ), ang = Angle( -82.8, -84.9, -170.4 ) },
            { mdl = "models/props_c17/canister01a.mdl", pos = Vector( 60.3, -77.7, 8.1 ), ang = Angle( -74.4, -179.2, 90 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        centerpiece = true,
        minsize = 250,
        furniture = {
            { mdl = "models/props_c17/fence02a.mdl", pos = Vector( -6, -54.8, 56.4 ), ang = Angle( 0, 1.1, 0 ) },
            { mdl = "models/props_c17/fence02a.mdl", pos = Vector( -59.1, 23.8, 56.5 ), ang = Angle( 0, 90, 0 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( -37.1, -73.3, 4.7 ), ang = Angle( 89.9, 52.3, -57.2 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -33.3, -109.6, 4.8 ), ang = Angle( -89.9, 19.9, -67.2 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -34.8, -109.6, 13.2 ), ang = Angle( -90, -48.1, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -39.9, -28.1, 4.9 ), ang = Angle( -89.7, 108.2, -85.3 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -32.4, -24.7, 13.5 ), ang = Angle( -89.9, 104.1, -101.4 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -43.4, 2.2, 5.2 ), ang = Angle( -90, -141.4, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -43.4, 2.8, 13.8 ), ang = Angle( -90, -143.5, 0 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( -31.3, -26, 22.3 ), ang = Angle( 89.9, 116.4, 0 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( -87.6, -28.1, 5.5 ), ang = Angle( 89.9, 98.3, -89.3 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -25.6, -48.9, 5.5 ), ang = Angle( -89.6, 85.9, 97 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -33.1, -62.5, 14.1 ), ang = Angle( -89.8, 57.7, 160.5 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -31.1, -61.2, 22.6 ), ang = Angle( -89.7, 15.6, -153.9 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -83.1, -1.2, 5.9 ), ang = Angle( -89.9, -80.6, -108 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -83.2, -1.3, 14.3 ), ang = Angle( -89.9, -96.2, -92.5 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -48.4, 0.9, 23.1 ), ang = Angle( -89.9, 54.1, -51.4 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -47.1, 1.1, 31.6 ), ang = Angle( -89.9, 52.6, -51.5 ) },
        }
    },
    {
        dedication = 2,
        centerpiece = true,
        minsize = 175,
        furniture = {
            bornposter,
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -24.2, 48, 0.4 ), ang = Angle( 0, -27.2, 0 ) },
            { mdl = "models/props_wasteland/cafeteria_table001a.mdl", pos = Vector( -68.3, -17.3, 15.9 ), ang = Angle( 0, 1.3, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( 9.9, 74.6, 0.6 ), ang = Angle( 0.1, -64.7, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( 7.2, 45.7, 0.7 ), ang = Angle( 0, -22.3, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( 11.5, 54.4, 18.3 ), ang = Angle( 0.1, 177, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -65.7, 19.6, 32 ), ang = Angle( 0, -2, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -68.4, -61.4, 49.2 ), ang = Angle( 0, -83.3, 180 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( 56.1, 60.5, 1.1 ), ang = Angle( -0.1, -102.5, 0.2 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( 41.4, 37.7, 1.2 ), ang = Angle( 0, 57.3, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( 47.1, 59.7, 18.7 ), ang = Angle( -0.2, -44.3, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -53.1, 63.5, 1.4 ), ang = Angle( -0.1, -29.4, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -55, 64.1, 19 ), ang = Angle( -0.1, -26.9, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", wallsnap = true, class = "homeless_radio", pos = Vector( -16.9, 21.8, 1.7 ), ang = Angle( 0, -44.1, 0 ) },
            { mdl = "models/props_lab/partsbin01.mdl", pos = Vector( -58.6, -55.2, 7.5 ), ang = Angle( -89.6, 175.1, 179.6 ) },
            { mdl = "models/props_c17/tools_wrench01a.mdl", wallsnap = true, pos = Vector( -62.9, -23, 1.8 ), ang = Angle( 0.9, -22.2, -0.3 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 69.5, -69.4, 7.2 ), ang = Angle( 0.5, -72, -0.2 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -80.4, -47.4, 41.2 ), ang = Angle( 0, 2.1, -0.1 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -55.2, -76.1, 41.3 ), ang = Angle( 1.5, -138.7, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = true, pos = Vector( -50.2, -77.5, 4.1 ), ang = Angle( 24.7, 85.6, -90.2 ) },
        }
    },
    {
        dedication = 2,
        centerpiece = true,
        minsize = 175,
        furniture = {
            bornposter,
            { mdl = "models/props_wasteland/cafeteria_table001a.mdl", pos = Vector( -68.8, -20.8, 15.8 ), ang = Angle( 0, -3, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -76, -59.6, 48.7 ), ang = Angle( 0, -1.8, -180 ) },
            { mdl = "models/props_lab/partsbin01.mdl", pos = Vector( -70.4, -65.3, 6.4 ), ang = Angle( -90, 9.4, 0 ) },
            { mdl = "models/props_c17/tools_wrench01a.mdl", wallsnap = true, pos = Vector( 68.7, 24.6, 0.7 ), ang = Angle( 1.7, -119.2, -0.3 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 69.5, -69.4, 6.1 ), ang = Angle( 0.5, -72, -0.2 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -18.7, 43.1, 2.8 ), ang = Angle( -22.8, -95.5, 90 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -36.1, -70.2, 2.9 ), ang = Angle( 63.4, -112.6, -90 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -72.4, 65.8, 1.1 ), ang = Angle( 0, -0.3, -0.1 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -44.7, 65.8, 1.2 ), ang = Angle( -0.1, 2.8, 0.1 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -22.2, 59.9, 1.3 ), ang = Angle( -0.1, 175.1, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( 1.6, 61.6, 18.5 ), ang = Angle( 0, -88.3, 180 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -61.7, 60.5, 19 ), ang = Angle( 0.1, -77.7, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -20.9, 56.5, 19.2 ), ang = Angle( 0, -85.9, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -42.5, 60.9, 36.8 ), ang = Angle( 0, -96, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -23.4, 24.1, 1.7 ), ang = Angle( 0, -13.4, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( 0.8, 32.8, 1.9 ), ang = Angle( 0, 169, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( -0.1, 33.4, 19.6 ), ang = Angle( -0.1, 170.7, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( 42.8, 63.1, 2.2 ), ang = Angle( 0, -79.5, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio", pos = Vector( 27.8, 4, 19.3 ), ang = Angle( 0, 40.2, 179.8 ) },
            { mdl = "models/props_lab/citizenradio.mdl", wallsnap = true, class = "homeless_radio", pos = Vector( 64.2, 47.2, 2.3 ), ang = Angle( 0, -71.4, 0 ) },
        }
    },
    {
        dedication = 2,
        centerpiece = true,
        minsize = 250,
        furniture = {
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -99.3, -99.9, 18.4 ), ang = Angle( 0, 44.4, 0 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( -97.4, -99.2, 34.2 ), ang = Angle( 2.8, 45.1, 0.5 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 104.4, -99.4, 3.3 ), ang = Angle( 3.1, -179.9, 0.2 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 102.4, -70.6, 3.5 ), ang = Angle( 2.9, -173.9, 0.1 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 58.4, 30.4, 3.5 ), ang = Angle( 3.3, -132.5, 0.2 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 40.4, 40.5, 3.6 ), ang = Angle( 3.1, -138.9, 0.2 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 76.5, -0.7, 3.7 ), ang = Angle( 3.2, -153.5, 0.2 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 10.6, 82.9, 3.8 ), ang = Angle( 3.1, -119.3, 0.2 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -57.5, 99.8, 3.9 ), ang = Angle( 3.2, -96.2, 0.2 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -82.3, 104.1, 4 ), ang = Angle( 3.2, -91.7, 0.2 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -99.5, 101.6, 4.1 ), ang = Angle( 3.2, -85.6, 0.2 ) },
        }
    },
    {
        dedication = 2,
        centerpiece = true,
        minsize = 250,
        furniture = {
            blood,
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -75.4, -75.8, 18.4 ), ang = Angle( 0, -135.6, 0 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( -77.3, -76.6, 34.2 ), ang = Angle( 2.8, -134.9, 0.5 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 73, -64.5, 18.6 ), ang = Angle( 0, -42.5, 0 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( 73.8, -66.4, 34.4 ), ang = Angle( 2.8, -41.8, 0.5 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( 82.7, 80.4, 0.9 ), ang = Angle( 1.1, 47, 0.9 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -80.5, 90.3, 11.6 ), ang = Angle( 0, 142.7, 90.2 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( -81.1, 90.4, 22.9 ), ang = Angle( -0.6, 125.9, 0.1 ) },
        }
    },
    {
        dedication = 2,
        centerpiece = true,
        minsize = 250,
        furniture = {
            blood,
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -75.4, -75.8, 18.4 ), ang = Angle( 0, -135.6, 0 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( -77.3, -76.6, 34.2 ), ang = Angle( 2.8, -134.9, 0.5 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 70.7, -67.1, 11.3 ), ang = Angle( -0.1, -47.7, 90 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( 74, -62.4, 22.7 ), ang = Angle( 0.1, -42.5, 1 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -87.7, 97.2, 16.3 ), ang = Angle( 0, 136.1, -179.9 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( -87.2, 99.1, 34.6 ), ang = Angle( 1, 135.1, -0.1 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 76.8, 78.6, 19 ), ang = Angle( 0, 44.4, 0 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( 78.7, 79.3, 34.8 ), ang = Angle( 2.8, 45.1, 0.5 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        furniture = {
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -35.3, -37.8, 11.4 ), ang = Angle( 0, 43.4, -90.1 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( -32.7, -46.1, 22.5 ), ang = Angle( 2.6, 48.3, 0.9 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 54.2, 51.2, 3.3 ), ang = Angle( 3.2, -132.7, 0.3 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 48.1, -48.6, 3.4 ), ang = Angle( 3.3, 172.1, 0.3 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        furniture = {
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -39.8, -39.8, 18.4 ), ang = Angle( 0, 46.2, 0 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( -38, -39, 34.2 ), ang = Angle( 2.8, 46.9, 0.5 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 19.4, 43.6, 3.3 ), ang = Angle( 3.2, -123.4, 0.3 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 43, 36.3, 3.4 ), ang = Angle( 3.3, -135.5, 0.3 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        furniture = {
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -42, -37.2, 18.4 ), ang = Angle( 0, 46.2, 0 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( -40.1, -36.4, 34.2 ), ang = Angle( 2.8, 46.9, 0.5 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 44, 35, 11.6 ), ang = Angle( -0.1, -140.3, -90 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( 43.2, 37.3, 22.7 ), ang = Angle( 0.5, -133.3, 1 ) },
        }
    },
    {
        dedication = 2,
        likessky = true,
        minsize = 125,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -4.3, 5.8, -2.9 ), ang = Angle( 0, -96, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( 36.4, 23.9, 20.6 ), ang = Angle( 0, 1.5, -0.1 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", pos = Vector( -36.3, -37.2, 20.7 ), ang = Angle( -0.1, 0.3, 0.1 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", pos = Vector( -41.7, 39.9, 20.8 ), ang = Angle( 0, 1.4, 0.1 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", pos = Vector( 32.2, -35.4, 20.9 ), ang = Angle( 0.1, -1.4, 0 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", pos = Vector( -5.8, 3.9, 76.7 ), ang = Angle( 0, 0.1, 0 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        minsize = 125,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -17.5, 20.9, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_lab/binderblue.mdl", pos = Vector( -42.3, -27.3, 2.2 ), ang = Angle( -1.4, -30.6, 89.9 ) },
            { mdl = "models/props_lab/binderblue.mdl", pos = Vector( -27.9, -10.2, 2.3 ), ang = Angle( -1.5, -41.2, 90 ) },
            { mdl = "models/props_lab/bindergraylabel01b.mdl", pos = Vector( 22.5, 48.6, 0.9 ), ang = Angle( 0.2, -22.3, -0.3 ) },
            { mdl = "models/props_lab/bindergreenlabel.mdl", pos = Vector( 27.8, -25.2, 6.3 ), ang = Angle( -1.3, -143.3, 109 ) },
            { mdl = "models/props_lab/bindergreenlabel.mdl", pos = Vector( -16.6, -13.8, 2.6 ), ang = Angle( -1.4, -32.6, 90 ) },
            { mdl = "models/props_lab/binderredlabel.mdl", pos = Vector( -11.7, -27.4, 2.4 ), ang = Angle( -1.3, -87.4, -89.7 ) },
            { mdl = "models/props_lab/bindergreenlabel.mdl", pos = Vector( 30, 0.9, 2.8 ), ang = Angle( -1.5, -94.7, 90 ) },
            { mdl = "models/props_lab/bindergreen.mdl", pos = Vector( 14, -15.1, 2.9 ), ang = Angle( -1.4, -65.1, 90 ) },
            { mdl = "models/props_lab/bindergreen.mdl", pos = Vector( 29.2, -57.6, 2.7 ), ang = Angle( -1.6, -17.3, -89.7 ) },
            { mdl = "models/props_lab/bindergraylabel01a.mdl", pos = Vector( 39.4, -55.7, 6.8 ), ang = Angle( -1.6, -98, 92.6 ) },
            { mdl = "models/props_lab/binderblue.mdl", pos = Vector( 29.7, -27.9, 3.2 ), ang = Angle( -1.4, 77, 89.9 ) },
            { mdl = "models/props_c17/furnituredrawer001a_chunk02.mdl", pos = Vector( 18.6, -44, 13.6 ), ang = Angle( -17.5, -19.8, 0.3 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        minsize = 125,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -24.5, 23.8, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_c17/suitcase001a.mdl", pos = Vector( -24.6, -31.4, 6.7 ), ang = Angle( 0, -68.7, 90 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( -9.3, -25.8, 15.6 ), ang = Angle( -0.3, 23, 0 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( 38, 51.5, 15.5 ), ang = Angle( 0.3, -77.3, -0.1 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( 34.1, 35.3, 15.7 ), ang = Angle( 0.2, -80.3, -0.1 ) },
            { mdl = "models/humans/charple04.mdl", class = "prop_ragdoll", pos = Vector( -24.6, 22.1, 42.1 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        furniture = {
            blood,
            { mdl = "models/props_wasteland/laundry_cart002.mdl", pos = Vector( 35.9, -23.1, 22.1 ), ang = Angle( 0, -90.3, 0 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 28.1, -43.6, 11.7 ), ang = Angle( 31.4, 161.9, -153.1 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 40.3, -26.2, 11.3 ), ang = Angle( 2.4, 90.7, 0.1 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 29, -36.6, 11.7 ), ang = Angle( -7.9, 170.6, -77 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 29, -19.3, 11.8 ), ang = Angle( -8.1, 162.9, -76.8 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 39, -18.4, 11.6 ), ang = Angle( 2.2, -173.5, 0 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 46.6, -29.6, 12 ), ang = Angle( -8.2, -97.1, -76.7 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 46.9, -38, 12.1 ), ang = Angle( -8.2, 89.6, -76.6 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 36.2, -43.7, 12.3 ), ang = Angle( 3.5, -29.5, 120.7 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 29.8, -27.7, 12.1 ), ang = Angle( -1.3, 91.8, 2.9 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 39.9, -38.1, 12.4 ), ang = Angle( -8.1, -45.3, -76.5 ) },
            { mdl = "models/gibs/hgibs_spine.mdl", pos = Vector( 23.7, -31, 10.4 ), ang = Angle( 88.2, -90.9, 178.6 ) },
            { mdl = "models/gibs/hgibs_spine.mdl", pos = Vector( 35.7, -29.1, 10.4 ), ang = Angle( -88.3, 100.9, 168.9 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        furniture = {
            { mdl = "models/props_wasteland/laundry_cart002.mdl", pos = Vector( -34.1, 8.5, 21.7 ), ang = Angle( 0, -63.4, 0 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -44.9, 5.7, 10.9 ), ang = Angle( 11.4, 102.2, 5.6 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -31.2, 26.3, 11.6 ), ang = Angle( 0.8, 92.7, 93.7 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -30.6, 5.3, 11.5 ), ang = Angle( 7.5, 140, 104.7 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -36.6, 12.4, 11.4 ), ang = Angle( -8.2, -16.5, -76.6 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -17.3, -6.2, 11.9 ), ang = Angle( -1.4, 159.1, -142.3 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -38, -2.7, 11.8 ), ang = Angle( 42, 115.2, 157.2 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -24.2, -5.9, 12 ), ang = Angle( 52.6, -67.6, -142.2 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -20.5, 2.5, 11.9 ), ang = Angle( 8.8, -75.9, -145.5 ) },
            { mdl = "models/gibs/hgibs_spine.mdl", pos = Vector( -24.8, -12.3, 9.8 ), ang = Angle( -88.3, 26.3, 153 ) },
        }
    },
    {
        dedication = 2,
        minsize = 200,
        furniture = {
            blemish,
            blood,
            bornposter,
            { mdl = "models/props_c17/furnituredresser001a.mdl", mat = wasteFenceMat, pos = Vector( -2.7, -68.1, 41.1 ), ang = Angle( 0, 92.9, 0 ) },
            { mdl = "models/props_c17/furnituredresser001a.mdl", mat = wasteFenceMat, pos = Vector( 76.8, -0.4, 41.2 ), ang = Angle( 0.1, -179.6, 0 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", mat = wasteFenceMat, pos = Vector( -80.1, -3.9, 20.7 ), ang = Angle( 0, 0.4, 0 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", mat = wasteFenceMat, pos = Vector( -1.6, 79.7, 20.8 ), ang = Angle( 0, -90, 0 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", skipchance = 15, pos = Vector( -10.2, 6.7, 53.7 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 200,
        furniture = {
            blemish,
            { mdl = "models/props_c17/furnituredresser001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -2.7, -68.1, 41.1 ), ang = Angle( 0, 92.9, 0 ) },
            { mdl = "models/props_c17/furnituredresser001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 76.8, -0.4, 41.2 ), ang = Angle( 0.1, -179.6, 0 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -80.1, -3.9, 20.7 ), ang = Angle( 0, 0.4, 0 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -1.6, 79.7, 20.8 ), ang = Angle( 0, -90, 0 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", skipchance = 50, pos = Vector( -10.2, 6.7, 53.7 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 200,
        furniture = {
            blemish,
            blood,
            { mdl = "models/props_c17/furnituredrawer001a.mdl", pos = Vector( 70.4, -2.9, 20.5 ), ang = Angle( -0.1, -176.5, -0.1 ) },
            { mdl = "models/props_c17/furnituredresser001a.mdl", pos = Vector( -74.1, -6.1, 41.1 ), ang = Angle( -0.2, 0.6, 0.1 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", pos = Vector( 0.3, 80.1, 20.7 ), ang = Angle( -0.2, -95.1, 0 ) },
            { mdl = "models/props_c17/furnituredrawer003a.mdl", pos = Vector( -17.6, -84.8, 23 ), ang = Angle( -0.3, 89.6, 0.1 ) },
        }
    },
    {
        dedication = 2,
        minsize = 100,
        furniture = {
            blemish,
            { mdl = "models/gibs/furniture_gibs/furniturewooddrawer003a_chunk03.mdl", mat = wasteFenceMat, pos = Vector( 44, 4.8, 0.9 ), ang = Angle( 0.4, -108.5, 0.5 ) },
            { mdl = "models/gibs/furniture_gibs/furniturewooddrawer003a_chunk02.mdl", mat = wasteFenceMat, pos = Vector( 38.4, -0.5, 3.5 ), ang = Angle( 15, -106.4, 0 ) },
            { mdl = "models/gibs/furniture_gibs/furniture_vanity01a_gib01.mdl", mat = wasteFenceMat, pos = Vector( 4.2, 42.6, 2.9 ), ang = Angle( -0.1, -89.3, -0.1 ) },
            { mdl = "models/gibs/furniture_gibs/furnituredrawer002a_gib06.mdl", mat = wasteFenceMat, pos = Vector( -49, 20.1, 1.2 ), ang = Angle( 0.6, -55.8, -0.7 ) },
            { mdl = "models/gibs/furniture_gibs/furniture_chair01a_gib01.mdl", pos = Vector( 1.2, -33.9, 4.8 ), ang = Angle( 13.8, -125.3, 10.1 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        minsize = 125,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -13.7, 18.9, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_wasteland/laundry_basket002.mdl", frozen = true, pos = Vector( -13.9, 20.1, 20.3 ), ang = Angle( 0, -42.2, 0.1 ) },
            { mdl = "models/humans/charple03.mdl", class = "prop_ragdoll", pos = Vector( -12, 23.7, 45.9 ), ang = Angle( 0, 0, 0 ), fire = { IgniteLifetime = 45 } },
        }
    },

    {
        dedication = 2,
        minsize = 150,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_interiors/furniture_shelf01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 56.9, -49.7, 43.7 ), ang = Angle( 0.2, -176.9, 0 ) },
            { mdl = "models/props_c17/furnituredresser001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 16.8, -54.1, 41.2 ), ang = Angle( 0, -89.2, -180 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -41.8, -43, 13 ), ang = Angle( 86.7, -93.5, 0 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 39.2, 10, 18.9 ), ang = Angle( 0, -177.5, 0 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 49.5, 19.2, 51.5 ), ang = Angle( 81, -168.6, 0.2 ) },
            { mdl = "models/props_c17/furnituredrawer002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -15.5, 9.4, 8.8 ), ang = Angle( -85.1, 135.1, -1.4 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 46.7, 59.9, 21 ), ang = Angle( -0.2, 92, 0 ) },
            { mdl = "models/props_junk/cardboard_box003b.mdl", skipchance = 50, pos = Vector( -9.3, 52.9, 8.9 ), ang = Angle( -0.7, 146.5, 0.3 ) },
        }
    },
    {
        dedication = 2,
        minsize = 150,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", wallsnap = true, pos = Vector( 35.9, -35.3, 12.5 ), ang = Angle( 29.4, -87.2, 180 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", wallsnap = true, skin = 1, pos = Vector( 54.9, 31.3, 20.6 ), ang = Angle( 0, -172.7, 0 ) },
            { mdl = "models/props_c17/furnituredresser001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -18.7, 48.6, 27.6 ), ang = Angle( 0, 88, 86.6 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 48.9, 39.7, 53.5 ), ang = Angle( 86.5, 4.4, 0 ) },
            { mdl = "models/props_interiors/furniture_shelf01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -13.1, 22.9, 24.3 ), ang = Angle( -0.2, 87.5, 89.1 ) },
            { mdl = "models/props_interiors/furniture_desk01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -26.7, 38.5, 68.1 ), ang = Angle( -82.7, -125.9, 27 ) },
        }
    },
    {
        dedication = 2,
        minsize = 150,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 37.7, -7, 18.2 ), ang = Angle( -84.4, 179.8, 0.2 ) },
            { mdl = "models/props_c17/furnituretable001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 35.9, 54.5, 19 ), ang = Angle( -0.1, -90.6, -75 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 18, -1.6, 31.4 ), ang = Angle( -0.1, 93.2, 81.6 ) },
            { mdl = "models/props_c17/shelfunit01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 2.4, 50.7, -0.6 ), ang = Angle( 0, -177, -0.1 ) },
            { mdl = "models/props_c17/furnituredrawer002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 37.3, -59.9, 14.5 ), ang = Angle( 0.1, -82.2, -83.1 ) },
            { mdl = "models/props_c17/furniturechair001a.mdl", pos = Vector( 10.5, -2.3, 20.8 ), ang = Angle( 0.2, -149.8, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 150,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", wallsnap = true, skin = 1, pos = Vector( 24.8, 45.4, 20.4 ), ang = Angle( -0.1, -80.7, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", wallsnap = true, skin = 1, pos = Vector( 43.1, -9.7, 20.5 ), ang = Angle( 0, -179.4, 0 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 41.9, 47.7, 60.9 ), ang = Angle( 0, 8.1, 180 ) },
            { mdl = "models/props_interiors/furniture_shelf01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -62.8, 27.2, 24.2 ), ang = Angle( -0.5, 2.4, 89 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -36.2, 46.6, 31.6 ), ang = Angle( -0.2, 179, 81.6 ) },
            { mdl = "models/props_junk/cardboard_box002a.mdl", wallsnap = true, pos = Vector( 14.4, 52.7, 60.6 ), ang = Angle( 0.2, -81.7, -90 ) },
        }
    },
    {
        dedication = 2,
        minsize = 150,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_c17/furnituredresser001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 47, 30.6, 27.4 ), ang = Angle( 0, 177.6, 86.6 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -1.5, 26, 18.6 ), ang = Angle( 84.9, 93.7, 0.6 ) },
            { mdl = "models/props_junk/wood_pallet001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -9.5, 51, 32.4 ), ang = Angle( 73.8, 90.7, -0.1 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", wallsnap = true, skin = 1, pos = Vector( 41.3, -36.7, 20.7 ), ang = Angle( -0.1, 175.4, 0 ) },
        }
    },

    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { mdl = "models/props_c17/furnituretable002a.mdl", mat = wasteFenceMat, pos = Vector( 32.4, 21.9, 18.6 ), ang = Angle( 0, -179.9, 0 ) },
            { mdl = "models/props_junk/cardboard_box002a.mdl", pos = Vector( 32.3, 27, 12.6 ), ang = Angle( 0, -173.5, 0 ) },
            { mdl = "models/props_c17/shelfunit01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 6.7, -39, -0.6 ), ang = Angle( 0, 179.2, 0 ) },
            { mdl = "models/props_interiors/furniture_desk01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -5, 10.7, 20.3 ), ang = Angle( 0, 2, -180 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", skin = 1, pos = Vector( 27.4, 4, 58 ), ang = Angle( 0, -179.8, -0.1 ) },
            { mdl = "models/props_c17/furnituredrawer001a_chunk02.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -54.4, -29.1, 9.4 ), ang = Angle( -1, 153.8, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( 37.7, 30.5, 7.8 ), ang = Angle( 0.1, -96.9, 180 ) },
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", pos = Vector( 34.2, 38.2, 1.3 ), ang = Angle( 0, -1.5, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( -17.4, 39.2, 20.6 ), ang = Angle( 0, 83.6, 0 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -17.2, -24.7, 55.2 ), ang = Angle( 22.3, 51.7, -0.3 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -6.3, -17.9, 31.3 ), ang = Angle( -0.1, 143.2, -81.3 ) },
            { mdl = "models/props_c17/furnituretable001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 31.5, -6.3, 26.7 ), ang = Angle( 14.1, -53.1, -166.9 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -13.9, 34.3, 59.9 ), ang = Angle( 0, -158.5, -161.9 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { mdl = "models/props_interiors/furniture_shelf01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 44.1, -12.2, 23.9 ), ang = Angle( -0.5, 179, 89 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -5.3, -40.1, 18.3 ), ang = Angle( -84.2, 84.6, 0.9 ) },
            { mdl = "models/props_c17/furnituretable001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -7.2, -21.5, 20.4 ), ang = Angle( -77.4, 53.9, 40 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 6.7, -24.1, 32.4 ), ang = Angle( 23.4, -24.7, -25.9 ) },
            { mdl = "models/props_c17/furnituredrawer001a_chunk01.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -39.3, 30.4, -7.8 ), ang = Angle( -1.3, 176.2, 0.2 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( 19.4, -14, 20.4 ), ang = Angle( 0.1, 168.1, 0 ) },
            { mdl = "models/props_interiors/furniture_shelf01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -9.7, 37.2, 24 ), ang = Angle( -0.1, 90.5, 89 ) },
            { mdl = "models/props_junk/cardboard_box003a.mdl", pos = Vector( 15.8, 5.9, 50.5 ), ang = Angle( 0, -156.7, 0 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -39, -22.7, 20.7 ), ang = Angle( 0.1, 171.9, 0 ) },
            { mdl = "models/props_c17/furnituredrawer002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -30.7, -32.6, 57.8 ), ang = Angle( 0, -94.7, -179.9 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            blemish,
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( 26.5, -34.3, 20.4 ), ang = Angle( -0.1, 90.7, 0 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", skin = 1, pos = Vector( 34.5, 20.3, 20.5 ), ang = Angle( 0.1, -177.6, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( 44.2, -10.5, 61.1 ), ang = Angle( -0.2, -175.7, -0.4 ) },
            { mdl = "models/props_c17/shelfunit01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -43.3, -22.2, -0.6 ), ang = Angle( 0.1, -89.9, -0.1 ) },
            { mdl = "models/props_c17/furnituredresser001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -29.4, 41.7, 41.3 ), ang = Angle( 0.1, 87.6, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -42, -10.5, 20.3 ), ang = Angle( 0, -2.7, 180 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -22.9, 42.1, 18.7 ), ang = Angle( 0.1, 89.5, 0 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 34.6, 27.4, 13.8 ), ang = Angle( -79.8, 179, 0 ) },
            { mdl = "models/props_c17/furnituredrawer001a_chunk01.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -30.6, 48.7, 29.4 ), ang = Angle( -1.3, 91.5, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( 32.2, -11.1, 20.4 ), ang = Angle( 0.1, 176.5, 0.1 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -22.8, -31.8, 20.5 ), ang = Angle( 0, -91.2, 0.1 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -30.5, 27.2, 19.3 ), ang = Angle( 0, -1.1, -180 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 2.7, -26.8, 51.8 ), ang = Angle( -0.1, -81.3, -179.9 ) },
        }
    },

    {
        dedication = 2,
        minsize = 100,
        maxsize = 150,
        furniture = {
            { mdl = "models/props_junk/cardboard_box002a.mdl", pos = Vector( -19.5, 25.3, 12.4 ), ang = Angle( 0, -86.5, 0 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 27.9, 13.8, 20.4 ), ang = Angle( 0, -151.8, 0 ) },
            { mdl = "models/props_c17/furnituredrawer002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -7.6, -28.1, 17.1 ), ang = Angle( 0, -151.7, 0 ) },
            { mdl = "models/props_c17/furnituredrawer001a_chunk06.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -20.3, 19.8, 40.2 ), ang = Angle( -20.4, -145.4, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 100,
        maxsize = 150,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", skin = 1, pos = Vector( -8.8, 32.2, 20.4 ), ang = Angle( 0, -89.7, 0 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -11.9, 31.8, 58.7 ), ang = Angle( -84.6, -93.2, 2.6 ) },
            { mdl = "models/props_c17/furnituretable001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -21.2, -18.5, 21.4 ), ang = Angle( 76.4, -139.2, 37.6 ) },
            { mdl = "models/props_c17/furnituredrawer001a_chunk01.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 21.8, -19, -7.8 ), ang = Angle( -1.5, -158.7, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 100,
        maxsize = 150,
        furniture = {
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 27.4, 16.6, 18.3 ), ang = Angle( -84.4, -177.5, 0.1 ) },
            { mdl = "models/props_c17/furnituretable001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -18, 19.6, 20.4 ), ang = Angle( 75, 92.7, 0.9 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -24.6, -23.8, 11.3 ), ang = Angle( 0, 10.9, 180 ) },
        }
    },
    {
        dedication = 2,
        minsize = 100,
        maxsize = 150,
        furniture = {
            { mdl = "models/props_c17/furnituredresser001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 15.7, 18.2, 41 ), ang = Angle( 0, 87.6, 0 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 17, -22.4, 18.7 ), ang = Angle( 0, -86.5, 0 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -19.1, -8.3, 15.8 ), ang = Angle( 90, -176.7, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 100,
        maxsize = 150,
        furniture = {
            blemish,
            { mdl = "models/props_interiors/furniture_shelf01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 20.8, -2.1, 41 ), ang = Angle( -79.1, -56.3, -113.6 ) },
            { mdl = "models/props_interiors/furniture_desk01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -0.6, -9.3, 16.4 ), ang = Angle( 84.6, 123.7, 0 ) },
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -30.4, 26.5, 21 ), ang = Angle( 1.8, 109.2, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 100,
        maxsize = 150,
        furniture = {
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 2, -7.8, 18.5 ), ang = Angle( 85, -51.3, 0.6 ) },
            { mdl = "models/props_c17/furnituretable001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -12.3, 14.5, 21.3 ), ang = Angle( 76.4, 167.5, 37.5 ) },
        }
    },
    {
        dedication = 2,
        minsize = 100,
        maxsize = 150,
        furniture = {
            { mdl = "models/props_c17/furnituredresser001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 8.8, -5.6, 41 ), ang = Angle( 0, 179.7, 0 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -27.2, 2.6, 18.4 ), ang = Angle( -84.4, 179.8, 0.3 ) },
            { mdl = "models/props_c17/furnituredrawer001a_chunk01.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -28.5, -25.1, -4.4 ), ang = Angle( 4.4, -173.2, 6.6 ) },
        }
    },

    {
        dedication = 2,
        maxsize = 125,
        furniture = {
            { mdl = "models/props_c17/furnituretable003a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -19.6, -6.1, 11.1 ), ang = Angle( 0.1, -173.8, -180 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 2.8, -9.1, 19.4 ), ang = Angle( -0.1, 78.5, 1.4 ) },
        }
    },
    {
        dedication = 2,
        maxsize = 125,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", wallsnap = true, skin = 1, pos = Vector( -10.6, 18.5, 20.4 ), ang = Angle( 0.1, -3.1, 0 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", wallsnap = true, skin = 1, pos = Vector( 7.3, -14, 59.3 ), ang = Angle( -2.2, -0.5, 13.3 ) },
        }
    },
    {
        dedication = 2,
        maxsize = 125,
        furniture = {
            { mdl = "models/props_interiors/furniture_shelf01a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -1.3, 14.6, 43.8 ), ang = Angle( 0.3, 0.4, 0 ) },
            { mdl = "models/props_c17/furnituredrawer002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 15.4, -0.4, 14.6 ), ang = Angle( 0.1, 7.8, 84.3 ) },
        }
    },
    {
        dedication = 2,
        maxsize = 125,
        furniture = {
            { mdl = "models/props_c17/furnituredrawer001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( 7.9, -16.1, 12.8 ), ang = Angle( 86.8, -67.6, 0.4 ) },
            { mdl = "models/props_c17/furnituredresser001a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -8.7, 14.3, 41.1 ), ang = Angle( 0, 105.1, 0 ) },
        }
    },
    {
        dedication = 2,
        maxsize = 125,
        furniture = {
            { mdl = "models/props_c17/furnituredrawer003a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -5.5, 17, 7.1 ), ang = Angle( -0.2, -63.4, -89.1 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", wallsnap = true, mat = wasteFenceMat, pos = Vector( -2.2, 14.6, 18.6 ), ang = Angle( 85, -85.9, 0.6 ) },
        }
    },

    {
        dedication = 2,
        likessky = true,
        centerpiece = true,
        minsize = 250,
        furniture = {
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -104.3, 102.4, 48.9 ), ang = Angle( -81.8, 74.4, 16.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -42.4, 83.3, 37.8 ), ang = Angle( -80.6, 179.5, -6.7 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 30.3, 78.1, 34.1 ), ang = Angle( -65.2, -165.3, -75.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -1.1, 67.8, 36.4 ), ang = Angle( -72, 138.9, -29.1 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 81, 33, 39.3 ), ang = Angle( -81.8, 135.9, 16.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 69.2, 66, 30.7 ), ang = Angle( -56.7, -175, -8.5 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -4.9, 31.1, 37.2 ), ang = Angle( -74, 124.1, 9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 57.5, -25.7, 36.9 ), ang = Angle( -72.4, 148.2, 0.8 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 68, -81.9, 38.5 ), ang = Angle( -79.8, 97.1, 28.1 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -29.4, -17.8, 39.8 ), ang = Angle( -81.8, 106, 16.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -85.5, 29.5, 39.9 ), ang = Angle( -81.8, 106, 16.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -87.9, -9.5, 10 ), ang = Angle( -81.8, 149.8, 16.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -61.6, -65.5, 10.1 ), ang = Angle( -81.8, 159.2, 16.9 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 98.2, -38.5, 6.7 ), ang = Angle( -0.7, 81.4, -0.1 ) },
        }
    },
    {
        dedication = 2,
        likessky = true,
        centerpiece = true,
        minsize = 250,
        maxsize = 350,
        furniture = {
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -57, -103.7, 49.1 ), ang = Angle( -82.6, 152.9, 152.4 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -5.7, -63.2, 19.2 ), ang = Angle( -82.6, 176, 152.4 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 31.7, -40.1, 29.1 ), ang = Angle( -82.5, 118.6, -149.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -71.1, -20.5, 30.8 ), ang = Angle( -69.3, -117.4, -8.7 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -11.2, -3.7, 40.2 ), ang = Angle( -75.2, -113.5, -12.8 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -62.7, 25.4, 45.7 ), ang = Angle( -70, -115.3, -42.1 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -95.4, -96.3, 44.5 ), ang = Angle( -84.6, 21.7, 174.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -94.7, -57.1, 49.6 ), ang = Angle( -84.6, -94.2, -174.8 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 63.4, -79.4, 39.7 ), ang = Angle( -84.6, 178.7, -174.8 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", wallsnap = true, pos = Vector( -37.2, 52.7, 4.1 ), ang = Angle( 64.5, -80.3, -90.2 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 98.2, -38.5, 6.7 ), ang = Angle( -0.7, 81.4, -0.1 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        minsize = 125,
        maxsize = 175,
        furniture = {
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -33.5, 34.2, 42.4 ), ang = Angle( -73.8, 137.2, 0.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 24.3, 19.7, 45.6 ), ang = Angle( -73.8, 125.6, 0.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -5.4, -26.2, 38.7 ), ang = Angle( -74.4, 133.1, -164.3 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        minsize = 125,
        maxsize = 175,
        furniture = {
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -28.1, -36, 47 ), ang = Angle( -81.3, -2.2, 135.1 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 26.4, 13.1, 46.8 ), ang = Angle( -70.3, -75, -89.1 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -25.9, 22.7, 27.1 ), ang = Angle( -79.5, -112.2, 93.9 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        minsize = 125,
        maxsize = 175,
        furniture = {
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -28.1, -36, 47 ), ang = Angle( -81.3, -2.2, 135.1 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 29.1, 31.7, 27 ), ang = Angle( -79.5, -142, 93.9 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 25.2, 15.5, 57.1 ), ang = Angle( -79.5, -169.9, 93.9 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        maxsize = 125,
        furniture = {
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 13, -14.2, 46.9 ), ang = Angle( -81.3, 134.9, 135.1 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( -14.6, 19.1, 5.8 ), ang = Angle( -0.7, -12.4, -0.5 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        maxsize = 125,
        furniture = {
            { mdl = "models/props_junk/harpoon002a.mdl", wallsnap = false, frozen = true, pos = Vector( -12, -8.2, 49.8 ), ang = Angle( -84.4, -19.3, -72.5 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        maxsize = 125,
        furniture = {
            { mdl = "models/props_junk/harpoon002a.mdl", wallsnap = false, frozen = true, pos = Vector( 8.4, 16.9, 42.8 ), ang = Angle( -83.5, -110.6, 48.7 ) },
        }
    },

    {
        dedication = 2,
        skyagnostic = true,
        centerpiece = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 30.1, 39.1, 4.5 ), ang = Angle( 89.7, 15, -12.7 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( 21.3, 34.4, 13 ), ang = Angle( -89.9, 55.3, -37.9 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -20.3, 33.8, 4.6 ), ang = Angle( 89.9, -117.4, -100.7 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -21.3, 39.2, 13.2 ), ang = Angle( 89.9, -116.5, -138.4 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -22.3, 39.9, 21.8 ), ang = Angle( 89.8, -100.3, -121.2 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -40.4, 14, 4.9 ), ang = Angle( 89.8, 60.3, -86.8 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -41, 14, 13.5 ), ang = Angle( 89.8, 48, -94.6 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 4.6, 8.9, 5.2 ), ang = Angle( 89.8, 33.2, -12 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -2.6, 8, 13.8 ), ang = Angle( 89.9, 5.2, 115.3 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -5.4, 5.9, 22.2 ), ang = Angle( 89.9, 9.7, 119 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -24.2, -14, 5.5 ), ang = Angle( 89.9, -119.8, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -37.6, 15.8, 22.5 ), ang = Angle( 89.8, 63.5, 99.3 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -36, 18, 31.1 ), ang = Angle( 89.9, 174.3, -113.5 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -34.5, 34.5, 4.4 ), ang = Angle( 89.9, 8.4, 75.1 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -14.1, 40.8, 4.5 ), ang = Angle( 89.9, -135.7, -74 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -16.5, 35.2, 13 ), ang = Angle( 89.9, 170.4, -133.3 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 13.2, 42.9, 4.7 ), ang = Angle( 89.8, -75, 175.3 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 37.3, 45, 4.8 ), ang = Angle( 89.9, 70.9, 138.6 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 38.4, 41.5, 13.3 ), ang = Angle( 89.9, -71.7, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 1.9, 46.6, 13.4 ), ang = Angle( 89.9, -66.1, -8.6 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 23, 46.5, 21.9 ), ang = Angle( 90, 17.7, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -8.3, 35.7, 22 ), ang = Angle( 89.8, 171.9, 173.3 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 15.4, -14, 4.5 ), ang = Angle( 90, -121.3, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 18.1, -11.2, 13.1 ), ang = Angle( 90, 139.6, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 18.2, -12, 21.6 ), ang = Angle( 90, 134.2, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -15, -13.3, 4.9 ), ang = Angle( 90, 54.1, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -4.1, 13.9, 5 ), ang = Angle( 90, 124, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( -3.9, 16, 13.5 ), ang = Angle( 90, 123.1, 0 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        maxsize = 250,
        furniture = {
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 13.6, -14, 4.5 ), ang = Angle( 89.9, 159.7, 25.2 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 18, -17.9, 13 ), ang = Angle( 89.9, -144.8, -28.8 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 17.6, -18.4, 21.5 ), ang = Angle( 90, -115.8, 0 ) },
        }
    },

    {
        dedication = 2,
        minsize = 100,
        furniture = {
            blemish,
            blood,
            { mdl = "models/props_interiors/refrigerator01a.mdl", pos = Vector( 0.7, -3.1, 32 ), ang = Angle( -90, -128.3, 0 ) },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        furniture = {
            blemish,
            blood,
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -13.7, 18.9, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/charple02.mdl", class = "prop_ragdoll", fire = { IgniteLifetime = 35 } },
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        furniture = {
            blemish,
            blood,
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -13.7, 18.9, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/charple03.mdl", class = "prop_ragdoll", fire = { IgniteLifetime = 35 } },
        }
    },
    {
        dedication = 2,
        furniture = {
            blemish,
            blood,
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -13.7, 18.9, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/charple04.mdl", class = "prop_ragdoll", fire = { IgniteLifetime = 35 } },
        }
    },
    {
        dedication = 2,
        furniture = {
            { mdl = function() return "models/props_wasteland/barricade001a_chunk0" .. math.random( 1, 5 ) .. ".mdl" end },
        }
    },
    {
        dedication = 2,
        furniture = {
            { mdl = "models/zombie/classic_legs.mdl", class = "prop_ragdoll" },
        }
    },
    {
        dedication = 2,
        furniture = {
            blemish,
            bornposter,
            { mdl = "models/player/skeleton.mdl", class = "prop_ragdoll" },
        }
    },
    {
        dedication = 2,
        furniture = {
            { mdl = "models/player/skeleton.mdl", class = "prop_ragdoll" },
        }
    },
    {
        dedication = 2,
        furniture = {
            { mdl = "models/gibs/hgibs.mdl", wallsnap = true, facewall = false },
        }
    },
    {
        dedication = 2,
        furniture = {
            { mdl = "models/gibs/hgibs_rib.mdl" },
        }
    },
    {
        dedication = 2,
        furniture = {
            { mdl = "models/gibs/hgibs_scapula.mdl" },
        }
    },
    {
        dedication = 2,
        furniture = {
            { mdl = "models/gibs/hgibs_spine.mdl" },
        }
    },
    {
        dedication = 2,
        furniture = {
            { mdl = "models/weapons/w_357.mdl", class = "weapon_357" },
        }
    },
    {
        dedication = 2,
        furniture = {
            { mdl = "models/props_lab/citizenradio.mdl", wallsnap = true, facewall = false, schizophrenic = 50 },
        }
    },
    {
        dedication = 2,
        minsize = 150,
        maxsize = 350,
        furniture = {
            { class = "infodecal", pos = 50, drop = false, wallsnap = true, keys = { texture = "decals/decal_posters001a" } },
        }
    },
    {
        dedication = 2,
        minsize = 150,
        maxsize = 350,
        furniture = {
            { class = "infodecal", pos = 50, drop = false, wallsnap = true, keys = { texture = "decals/decal_posters002a" } },
        }
    },
    {
        dedication = 2,
        minsize = 150,
        maxsize = 250,
        furniture = {
            { class = "infodecal", pos = 50, drop = false, wallsnap = true, keys = { texture = "decals/decal_posters003a" } },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { class = "infodecal", pos = 30, drop = false, wallsnap = true, keys = { texture = "decals/decalgraffiti056a" }, alwaysLimitGrafitti = true },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { class = "infodecal", pos = 20, drop = false, wallsnap = true, keys = { texture = "decals/decalgraffiti037a" }, alwaysLimitGrafitti = true },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { class = "infodecal", pos = 30, drop = false, wallsnap = true, keys = { texture = "decals/decalgraffiti038a" } },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { class = "infodecal", pos = 20, drop = false, wallsnap = true, keys = { texture = "decals/plaster015a" } },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 200,
        furniture = {
            { class = "infodecal", pos = 30, drop = false, wallsnap = true, keys = { texture = "decals/plaster015a" } },
        }
    },
    {
        dedication = 2,
        minsize = 50,
        maxsize = 200,
        skyagnostic = true,
        furniture = {
            himdecal,
        }
    },
    {
        dedication = 2,
        minsize = 50,
        maxsize = 200,
        skyagnostic = true,
        furniture = {
            himfadedecal,
        }
    },
    {
        dedication = 2,
        linessky = true,
        maxsize = 250,
        furniture = {
            gulldecal,
        }
    },
    {
        dedication = 2,
        maxsize = 250,
        linessky = true,
        furniture = {
            gulldecal,
        }
    },
    {
        dedication = 2,
        minsize = 100,
        maxsize = 250,
        skyagnostic = true,
        furniture = {
            randdecal,
        }
    },
    {
        dedication = 2,
        maxsize = 250,
        furniture = {
            wallmandecal,
        }
    },
    {
        dedication = 2,
        maxsize = 250,
        furniture = {
            wallmandecal,
        }
    },
    {
        dedication = 2,
        maxsize = 250,
        notedetail = 4,
        furniture = {
            enddecal,
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        maxsize = 250,
        notedetail = 2,
        furniture = {
            enddecal,
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        minsize = 125,
        maxsize = 350,
        furniture = {
            shrinedecal,
        }
    },
    {
        dedication = 2,
        skyagnostic = true,
        maxsize = 250,
        furniture = {
            realfakedoordecal,
            trashdecalrand,
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 450,
        furniture = {
            { class = "infodecal", pos = Vector( -55, -55, 55 ), drop = false, wallsnap = true, facewall = true, keys = { texture = "decals/decalgraffiti024a" } },
            { class = "infodecal", pos = Vector( -20, -20, 22 ), drop = false, wallsnap = true, facewall = true, keys = { texture = "decals/decalgraffiti024a" } },
            { class = "infodecal", pos = Vector( 55, 40, 43 ), drop = false, wallsnap = true, facewall = true, keys = { texture = "decals/decalgraffiti024a" } },
            { class = "infodecal", pos = Vector( -55, 40, 61 ), drop = false, wallsnap = true, facewall = true, keys = { texture = "decals/decalgraffiti024a" } },
        }
    },
    {
        dedication = 2,
        minsize = 125,
        maxsize = 450,
        furniture = {
            { class = "infodecal", pos = Vector( -55, -55, 50 ), drop = false, wallsnap = true, keys = { texture = "decals/decalgraffiti024a" } },
            { class = "infodecal", pos = Vector( -21, 20, 28 ), drop = false, wallsnap = true, keys = { texture = "decals/decalgraffiti024a" } },
            { class = "infodecal", pos = Vector( 55, -40, 42 ), drop = false, wallsnap = true, keys = { texture = "decals/decalgraffiti024a" } },
            { class = "infodecal", pos = Vector( -30, -40, 56 ), drop = false, wallsnap = true, keys = { texture = "decals/decalgraffiti024a" } },
        }
    },


    {
        dedication = 1,
        likessky = true,
        centerpiece = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -15.9, -17.2, -4 ), ang = Angle( 0, -24, 0 ) },
            { mdl = "models/props_interiors/furniture_chair03a.mdl", pos = Vector( 29.2, 24, 18.9 ), ang = Angle( 0.1, -103.4, 0 ) },
            { mdl = "models/player/corpse1.mdl", class = "terminator_nextbot_homeless", pos = Vector( 22.7, -11.7, -0.8 ), ang = Angle( 0, -127.4, 0 ) },
        }
    },
    {
        dedication = 1,
        centerpiece = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furniturecouch002a.mdl", pos = Vector( -9.5, -24.1, 19.3 ), ang = Angle( -0.1, 92.2, 0 ) },
            { mdl = "models/props_junk/cardboard_box002a.mdl", pos = Vector( -20.8, 25.7, 12.6 ), ang = Angle( 0, -69.1, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -29.3, 33, 27.1 ), ang = Angle( 69.1, 92.5, 90 ) },
            { mdl = "models/player/corpse1.mdl", class = "terminator_nextbot_homeless", data = { homeless_waiting = true }, pos = Vector( -2, -11.2, 64.6 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        centerpiece = true,
        minsize = 150,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( 45.6, 25.9, 20.5 ), ang = Angle( 0, -177.7, 0 ) },
            { mdl = "models/props_c17/furniturecouch001a.mdl", pos = Vector( -36.6, -17.6, 17.1 ), ang = Angle( -0.1, 10.5, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 15, pos = Vector( 51.3, 24.9, 41.1 ), ang = Angle( -0.2, -164.4, 0.1 ) },
            { mdl = "models/player/corpse1.mdl", class = "terminator_nextbot_homeless", pos = Vector( -44.9, 48.9, 0.4 ), ang = Angle( 0, 5.5, 0 ) },
        }
    },
    {
        dedication = 1,
        centerpiece = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", pos = Vector( 17.7, -24.4, 22 ), ang = Angle( 0, 119.7, 0 ) },
            { mdl = "models/player/corpse1.mdl", class = "terminator_nextbot_homeless", pos = Vector( -37.4, -1.4, 0.2 ), ang = Angle( 0, 62.7, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = true, pos = Vector( 45.4, 42.1, 2.6 ), ang = Angle( -69.4, 47.6, 90 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 19.1, -10, 25.6 ), ang = Angle( 0.1, 106.6, 0 ) },
        }
    },
    {
        dedication = 1,
        centerpiece = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 44.1, 42.8, 15 ), ang = Angle( -0.1, -148.8, 0 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", pos = Vector( -19.8, 3.4, 18.8 ), ang = Angle( 0, 177.9, 0 ) },
            { mdl = "models/props_lab/monitor02.mdl", pos = Vector( -20.3, 21.5, 38 ), ang = Angle( -0.6, -6.8, -0.6 ) },
            { mdl = "models/props_c17/computer01_keyboard.mdl", pos = Vector( -2.8, 20.9, 37.4 ), ang = Angle( -10.6, -0.4, 0 ) },
            { mdl = "models/props_lab/reciever01c.mdl", pos = Vector( -20.5, -14.3, 40.3 ), ang = Angle( -1.1, 6.9, 0.3 ) },
            { mdl = "models/player/corpse1.mdl", class = "terminator_nextbot_homeless", pos = Vector( 26.8, -21.9, 0.6 ), ang = Angle( 0, -166, 0 ) },
        }
    },
    {
        dedication = 1,
        centerpiece = true,
        minsize = 150,
        furniture = {
            { mdl = "models/props_c17/furniturecouch001a.mdl", pos = Vector( 40, 23, 17.2 ), ang = Angle( 0, -160.1, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( -42.9, 6.7, 20.6 ), ang = Angle( 0, 2.8, 0 ) },
            { mdl = "models/props_c17/tv_monitor01.mdl", pos = Vector( -38.2, 21.3, 49.1 ), ang = Angle( 0, 1.4, 0 ) },
            { mdl = "models/props_c17/lamp001a.mdl", pos = Vector( -46.6, -17, 44.5 ), ang = Angle( -29.9, -48.8, 95.3 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", wallsnap = true, pos = Vector( -48.6, -62.1, 4.6 ), ang = Angle( 2.8, 13.4, -1.9 ) },
            { mdl = "models/player/corpse1.mdl", class = "terminator_nextbot_homeless", pos = Vector( -0.2, -0.8, 0.6 ), ang = Angle( 0, -95.7, 0 ) },
        }
    },
    {
        dedication = 1,
        centerpiece = true,
        minsize = 150,
        furniture = {
            { mdl = "models/props_junk/bicycle01a.mdl", pos = Vector( -8.5, 30.7, 22.2 ), ang = Angle( 0, 14, -17.6 ) },
            { mdl = "models/props_interiors/furniture_chair03a.mdl", pos = Vector( -17.8, 46.2, 19.9 ), ang = Angle( -0.2, 117.7, 0 ) },
            { mdl = "models/props_lab/partsbin01.mdl", pos = Vector( -39.7, 2.7, 6.5 ), ang = Angle( -90, 13.2, 0 ) },
            { mdl = "models/props_c17/tools_wrench01a.mdl", pos = Vector( 10, 27.1, 0.8 ), ang = Angle( 0.1, -103.8, -0.1 ) },
            { mdl = "models/props_junk/garbage_carboard002a.mdl", pos = Vector( 48.1, 9.8, 0.7 ), ang = Angle( 0, 11.2, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 46.9, 19.1, 9.6 ), ang = Angle( 1.8, 0, -0.2 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", wallsnap = true, pos = Vector( -44.3, -21.7, 3.9 ), ang = Angle( -69.5, 17.8, -90 ) },
            { mdl = "models/player/corpse1.mdl", class = "terminator_nextbot_homeless", pos = Vector( 18.5, -47.2, 0.8 ), ang = Angle( 0, 107.4, 0 ) },
        }
    },


    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", pos = Vector( -22.2, 19.1, 22 ), ang = Angle( -0.1, -49, 0 ) },
            { mdl = "models/props_junk/garbage_milkcarton001a.mdl", pos = Vector( 6, 53.7, 5.5 ), ang = Angle( -48.6, -4.3, -91.6 ) },
            { mdl = "models/props_lab/harddrive01.mdl", pos = Vector( 30.3, 16.5, 4.6 ), ang = Angle( 0, -166.1, 90 ) },
            { mdl = "models/props_lab/monitor02.mdl", pos = Vector( 37.1, -14, 13 ), ang = Angle( 85.7, -19.8, 178.8 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -2, -11.2, 64.6 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_lab/harddrive01.mdl", pos = Vector( 19.5, -35.9, 4.2 ), ang = Angle( 0, -118.1, -90 ) },
            { mdl = "models/props_lab/monitor02.mdl", pos = Vector( 44.3, -5, 9.3 ), ang = Angle( -10.4, 133.4, -87.7 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -2, -11.2, 64.4 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_interiors/furniture_couch01a.mdl", pos = Vector( -23.9, 6.9, 22.2 ), ang = Angle( 0, -11.4, 0 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 29, 23, 6.1 ), ang = Angle( -0.8, 89.2, -0.5 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", pos = Vector( -18.8, 16.2, 22 ), ang = Angle( 0, -61.8, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -17, 12.1, 58.6 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_c17/suitcase001a.mdl", pos = Vector( 40, -4.9, 6.8 ), ang = Angle( 0, -61.3, -90 ) },
            { mdl = "models/props_junk/garbage_newspaper001a.mdl", pos = Vector( -27.8, -24.3, 2.5 ), ang = Angle( 0.9, -122.2, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/furniturebed001a.mdl", pos = Vector( -16.8, -25.4, 18.7 ), ang = Angle( 0, 161, 0 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( -16, -23.2, 16.3 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -8, -5.8, 70.1 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( 14.6, -5.7, 49.3 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( -15.5, -13.9, 5.8 ), ang = Angle( 0.1, 129.9, -0.2 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( -8.2, -6.3, 3.1 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -6.9, -8.2, 52.2 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 10.5, 32.9, 3.5 ), ang = Angle( 0.2, -8, -0.4 ) },
            { mdl = "models/props_c17/consolebox01a.mdl", pos = Vector( 22.1, 16.3, 0.9 ), ang = Angle( -0.2, -140.9, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( 28.1, 19, 12.2 ), ang = Angle( -1, -139.9, -0.1 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 2.1, 35.9, 15.2 ), ang = Angle( -0.1, -122.1, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -8.5, 6.8, 55.4 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", pos = Vector( -10.2, 15.2, 22 ), ang = Angle( 0, -38.4, 0 ) },
            { mdl = "models/props_junk/wood_crate001a.mdl", pos = Vector( 18.4, -23.5, 20.6 ), ang = Angle( 0, 2.4, 0 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( 24.4, 33.5, 8.8 ), ang = Angle( 0.9, -46.9, 0 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 31.5, -25.9, 43.8 ), ang = Angle( 0, 40.8, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( 6.8, 10, 69.3 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furniturebed001a.mdl", pos = Vector( -0.8, -14.9, 18.7 ), ang = Angle( 0, 0.1, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( 7.4, -14.1, 60.5 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/furnituretable003a.mdl", pos = Vector( 33.3, -16, 11.1 ), ang = Angle( 0, 161.7, 0 ) },
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( -13.8, 19.6, 4.9 ), ang = Angle( 0, 79.5, 0 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( -24.2, 14.5, 11.8 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( 3, -8.7, 17.8 ), ang = Angle( 0, 131.2, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -15.5, 12, 46.5 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( 15.8, -14, 4.8 ), ang = Angle( 0, 110.2, 0 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( 21.5, -20.5, 11.7 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_wasteland/cafeteria_bench001a.mdl", pos = Vector( -47.2, 0.8, 7.7 ), ang = Angle( 88, -0.5, -179.6 ) },
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( -38.4, 32.9, 3.9 ), ang = Angle( 0, -145.4, 0.4 ) },
            { mdl = "models/props_junk/popcan01a.mdl", pos = Vector( -21.5, 49, 4.3 ), ang = Angle( -1.5, 9.1, -0.9 ) },
            { mdl = "models/props_junk/popcan01a.mdl", pos = Vector( -17.2, 50.7, 2.7 ), ang = Angle( 29.1, -150.2, 89.8 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( 15.2, -11.6, 55.7 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/glassbottle01a.mdl", pos = Vector( -19.2, 26.2, 2.7 ), ang = Angle( 22.8, 128.4, -91 ) },
            { mdl = "models/props_junk/glassbottle01a.mdl", pos = Vector( -29.4, 42.3, 2.8 ), ang = Angle( -22.9, -49.3, 91.1 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( 25.9, 36.9, 6.6 ), ang = Angle( -0.8, -27.4, -0.1 ) },
            { mdl = "models/props_junk/terracotta01.mdl", pos = Vector( -35.1, -26.6, 14.9 ), ang = Angle( 0, -25.5, -180 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -37.9, -25.7, 23.5 ), ang = Angle( -0.6, 100.1, 0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 150,
        furniture = {
            { mdl = "models/props_wasteland/cafeteria_table001a.mdl", pos = Vector( 44.5, -1.9, 15.9 ), ang = Angle( -0.1, 4.6, 0 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", pos = Vector( -12.5, 40, 20.6 ), ang = Angle( -0.1, 172.5, 0.1 ) },
            { mdl = "models/props_interiors/pot01a.mdl", pos = Vector( 36.2, 38.2, 36.7 ), ang = Angle( 0, -157.8, 0 ) },
            { mdl = "models/nova/jeep_seat.mdl", pos = Vector( 17.1, -8.6, 8 ), ang = Angle( 75.9, 133, 22.7 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -6.4, -9.9, 68.8 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a.mdl", pos = Vector( 19.6, -24.5, 20.5 ), ang = Angle( 0, 0.7, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( 14.7, 4.3, 65.1 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_interiors/furniture_chair01a.mdl", pos = Vector( -7.5, 14, 21.7 ), ang = Angle( 0, -38.7, 0.2 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 9.8, -31.6, 49.1 ), ang = Angle( 0, -103.3, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( -25.2, -4.5, 3 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 24.1, 21.6, 5.8 ), ang = Angle( -1, 110.4, 0.1 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", wallsnap = true, pos = Vector( 22.5, 9.2, 3.5 ), ang = Angle( 0.1, 116.7, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -19.9, -13.8, 92 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/cardboard_box002a.mdl", pos = Vector( 18, -19, 12.8 ), ang = Angle( 0, 0.6, -0.1 ) },
        }
    },

    -- king stuff
    {
        dedication = 1,
        likessky = true,
        minsize = 175,
        furniture = {
            { mdl = "models/props_c17/fence01a.mdl", pos = Vector( -8.4, -66.1, 54.3 ), ang = Angle( 0, -90, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", pos = Vector( 57.2, 2.6, 56 ), ang = Angle( 0, 3.1, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", pos = Vector( -7.2, 65.9, 54.7 ), ang = Angle( 0, 94.6, 0 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( -69.9, 41.2, 6.1 ), ang = Angle( -0.4, 113.7, -90 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( -58.9, -48.6, 5.9 ), ang = Angle( 89.5, 51.8, -66 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( 32, -41.3, 5.9 ), ang = Angle( 89.8, 168.6, -81.5 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", pos = Vector( -10.7, 69.8, 25 ), ang = Angle( 0, 94.5, -90 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", pos = Vector( 34.7, 37.5, 63.1 ), ang = Angle( 21.2, 3, -0.1 ) },
        }
    },
    {
        dedication = 1,
        notedetail = 1,
        likessky = true,
        nevercenterpiecefollower = true,
        minsize = 212.5,
        furniture = {
            gulldecal,
            gulldecal,
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( 32.5, -31.2, 46.3 ), ang = Angle( 34.1, -178.9, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -11.9, 42, 54.5 ), ang = Angle( -1.9, 89.9, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -35.1, -26.1, 51.3 ), ang = Angle( -45, -178.1, -2 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -7.9, -98.5, 54.7 ), ang = Angle( -1, -94.9, 0 ) },
            { mdl = "models/hunter/misc/sphere1x1.mdl", class = "homeless_deadseagullking", pos = Vector( -5.2, -26.4, 12.4 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/trashdumpster01a.mdl", pos = Vector( -25, 69.8, 25.4 ), ang = Angle( -84.9, -90.1, 0 ) },
            { mdl = "models/props_junk/popcan01a.mdl", wallsnap = true, pos = Vector( 80.8, 92.5, 4.4 ), ang = Angle( 1.7, -1.3, -0.3 ) },
        }
    },
    {
        dedication = 1,
        notedetail = 2,
        likessky = true,
        nevercenterpiecefollower = true,
        furniture = {
            shrinedecal,
            { mdl = "models/hunter/misc/sphere1x1.mdl", wallsnap = false, class = "homeless_deadseagullking" },
        }
    },
    {
        dedication = 1,
        notedetail = 1,
        likessky = true,
        nevercenterpiecefollower = true,
        furniture = {
            gulldecal,
            { mdl = "models/hunter/misc/sphere1x1.mdl", wallsnap = false, class = "homeless_deadseagullking" },
        }
    },
    {
        dedication = 1,
        minsize = 200,
        furniture = {
            { mdl = "models/props_c17/fence01a.mdl", pos = Vector( 59.2, -7.3, 58.4 ), ang = Angle( -1.1, 180, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", pos = Vector( -0.9, 58.5, 58.6 ), ang = Angle( -0.3, 92.9, -0.1 ) },
            { mdl = "models/props_c17/fence01a.mdl", pos = Vector( -8.5, -73, 59 ), ang = Angle( -1, 90.1, 0.4 ) },
            { mdl = "models/props_c17/fence04a.mdl", pos = Vector( -60.4, -13.2, 9 ), ang = Angle( 70.8, 157.4, -20.6 ) },
            { mdl = "models/props_c17/fence04a.mdl", pos = Vector( 3.6, -2.6, 123.1 ), ang = Angle( -64.6, -131.4, 133 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( 14.1, -33.4, 124.8 ), ang = Angle( -9.5, 70, 92.7 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( -28.6, 40.6, 123.2 ), ang = Angle( -70.8, 147.9, 79.1 ) },
        }
    },
    -- end king

    {
        dedication = 1,
        nevercenterpiecefollower = true,
        furniture = {
            { mdl = "models/props_junk/harpoon002a.mdl", wallsnap = false, frozen = true, pos = Vector( -12, -8.2, 49.8 ), ang = Angle( -84.4, -19.3, -72.5 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        nevercenterpiecefollower = true,
        minsize = 100,
        furniture = {
            { mdl = "models/seagull.mdl", class = "npc_seagull", schizophrenic = 100, pos = Vector( -14.3, -22.7, 0.3 ), ang = Angle( 0, 136.6, 0 ) },
        }
    },
    {
        dedication = 1,
        onlycenterpiecefollower = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_lab/kennel_physics.mdl", frozen = true, pos = Vector( -20.4, -15.9, 0.5 ), ang = Angle( 0, 84.6, 0.1 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", pos = Vector( -22.1, -20.5, 26.8 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_c17/furniturebed001a.mdl", pos = Vector( -2.8, 2.8, 21.7 ), ang = Angle( 0, -5.3, 90 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", wallsnap = true, pos = Vector( 21.8, -32.5, 3.6 ), ang = Angle( 0.2, 83.8, -0.7 ) },
        }
    },
    {
        dedication = 1,
        onlycenterpiecefollower = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_lab/kennel_physics.mdl", frozen = true, pos = Vector( 16.2, -19.1, 0.5 ), ang = Angle( -0.1, 84.6, -0.1 ) },
            { mdl = "models/props_c17/furniturebed001a.mdl", pos = Vector( -0.6, 2.7, 21.6 ), ang = Angle( 0, -5.3, 90 ) },
            { mdl = "models/seagull.mdl", class = "npc_seagull", pos = Vector( 16, -21.2, 0.4 ), ang = Angle( 0, 30, 0 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", wallsnap = true, pos = Vector( -30.8, -34, 8.7 ), ang = Angle( 0.2, 77.8, -0.2 ) },
        }
    },

    -- very rare GOAT shelter
    {
        dedication = 1,
        likessky = true,
        centerpiece = true,
        minsize = 625,
        furniture = {
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -2, -48.9, 42.4 ), ang = Angle( -0.7, 8.2, -0.2 ) },
            { mdl = "models/props_c17/streetsign005c.mdl", frozen = true, pos = Vector( -162.4, 256.3, 58.3 ), ang = Angle( -11.2, 117.9, 11.7 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -177.1, 146.9, 137.3 ), ang = Angle( -72.4, 173, -75.5 ) },
            { mdl = "models/props_debris/concrete_cornerpile01a.mdl", frozen = true, pos = Vector( -52.9, 149.1, 39.5 ), ang = Angle( 28.4, -6.7, -14.5 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -280.6, 198.2, 89.4 ), ang = Angle( -66, -113.5, 1.1 ) },
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( -250.1, 226.6, 45 ), ang = Angle( -0.2, -73.2, -0.3 ) },
            { mdl = "models/props_wasteland/prison_heater001a.mdl", frozen = true, pos = Vector( -138, 165.2, 20.6 ), ang = Angle( 1.6, 8.8, 0 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( -159.5, 124.2, 6.8 ), ang = Angle( -0.3, 81.6, 0.2 ) },
            { mdl = "models/props_c17/streetsign003b.mdl", frozen = true, pos = Vector( -154.6, 117.9, 63.6 ), ang = Angle( 8.1, 63.8, 0.3 ) },
            { mdl = "models/props_debris/metal_panelchunk01b.mdl", frozen = true, pos = Vector( -159.3, 263.2, 65.7 ), ang = Angle( -16.1, -148.4, 5.2 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -293, 151.5, 66.8 ), ang = Angle( -61.5, -95.5, 1.9 ) },
            { mdl = "models/props_c17/streetsign004f.mdl", frozen = true, pos = Vector( -155.2, 167.1, 55.4 ), ang = Angle( -33.4, 86.1, 3.8 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -75, 54.4, 56.7 ), ang = Angle( 6.3, -106.7, 23.8 ) },
            { mdl = "models/props_wasteland/controlroom_filecabinet002a.mdl", frozen = true, pos = Vector( -119, 92.1, 36.6 ), ang = Angle( -1, 52.5, 0.1 ) },
            { mdl = "models/props_interiors/furniture_lamp01a.mdl", frozen = true, pos = Vector( -48.6, -15.6, 34.7 ), ang = Angle( 0.1, -138.3, -0.2 ) },
            { mdl = "models/props_trainstation/tracksign03.mdl", frozen = true, pos = Vector( -207.6, 285, 49 ), ang = Angle( -7.4, 97.6, -26.2 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -151.9, 156.2, 33.3 ), ang = Angle( 1.2, 177.1, 0.6 ) },
            { mdl = "models/props_debris/concrete_chunk01c.mdl", frozen = true, pos = Vector( -119.6, 285.2, 25.7 ), ang = Angle( 77.7, 23.1, 20.5 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -144.5, 209.4, 58.5 ), ang = Angle( -0.4, 180, 0.6 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -100.3, 103.4, 34.6 ), ang = Angle( 2, 29.1, 3.3 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -208.4, 273.3, 33.1 ), ang = Angle( 0, -90, 0 ) },
            { mdl = "models/props_c17/signpole001.mdl", frozen = true, pos = Vector( -259.2, 205.7, 105.5 ), ang = Angle( 53, 68.1, 57.8 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", pos = Vector( -268.8, 107.6, 6.6 ), ang = Angle( -0.5, -160.7, -1.8 ) },
            { mdl = "models/props_lab/box01a.mdl", pos = Vector( -159.8, 163.2, 5 ), ang = Angle( 0, 178.3, -0.2 ) },
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", wallsnap = true, pos = Vector( -284.3, 99.4, 11.4 ), ang = Angle( -0.2, 7.3, 0.3 ) },
            { mdl = "models/props_wasteland/controlroom_desk001b.mdl", frozen = true, pos = Vector( -273.1, 171.5, 17.9 ), ang = Angle( -0.3, -7, 0 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", pos = Vector( -274.9, 107.7, 6.9 ), ang = Angle( 0.5, -155.4, 1.1 ) },
            { mdl = "models/props_junk/garbage_plasticbottle003a.mdl", wallsnap = true, pos = Vector( -285.6, 105.8, 14.1 ), ang = Angle( -1, 1.6, 0.5 ) },
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", wallsnap = true, pos = Vector( -163.5, 114.9, 10.5 ), ang = Angle( 0, 169.7, -0.9 ) },
            { mdl = "models/props_vehicles/tire001c_car.mdl", pos = Vector( -165.6, -193.1, 6.3 ), ang = Angle( 90, 118.4, 0 ) },
            { mdl = "models/props_combine/breenclock.mdl", pos = Vector( -280.8, 126.3, 40.2 ), ang = Angle( -0.2, 32.6, -0.2 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", pos = Vector( -269.9, 101.6, 7.4 ), ang = Angle( 1.4, -106, -0.9 ) },
            { mdl = "models/props_junk/plasticcrate01a.mdl", pos = Vector( -277.4, 103, 10.1 ), ang = Angle( 0, 88.8, 0.1 ) },
            { mdl = "models/props_lab/monitor01b.mdl", pos = Vector( -290.3, 161.4, 48.9 ), ang = Angle( -9.4, -11, 0.3 ) },
            { mdl = "models/props_junk/garbage128_composite001a.mdl", frozen = true, pos = Vector( -97.5, -147.4, 5.5 ), ang = Angle( 0, 127.1, 0 ) },
            { mdl = "models/props_c17/computer01_keyboard.mdl", frozen = true, pos = Vector( -260.9, 157.8, 34.3 ), ang = Angle( -10.8, -19.1, 0 ) },
            { mdl = "models/props_wasteland/controlroom_filecabinet001a.mdl", pos = Vector( -269.2, 200.7, 50 ), ang = Angle( -0.3, -37.6, 0.3 ) },
            { mdl = "models/props_junk/garbage_newspaper001a.mdl", pos = Vector( -188.3, 249.3, 4.6 ), ang = Angle( 0.4, -139.3, -0.6 ) },
            { mdl = "models/props_c17/signpole001.mdl", frozen = true, pos = Vector( -265.6, 189.9, 95.3 ), ang = Angle( -62.9, 163.5, 14.9 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -243.1, 205, 111 ), ang = Angle( -68.6, -171.3, -117.1 ) },
            { mdl = "models/props_wasteland/controlroom_storagecloset001a.mdl", frozen = true, pos = Vector( -242.2, -230.3, 46.4 ), ang = Angle( -1.2, -129, 2.7 ) },
            { mdl = "models/props_doors/door03_slotted_left.mdl", frozen = true, pos = Vector( -3.1, -80.2, 55 ), ang = Angle( -0.1, -51.8, 0 ) },
            { mdl = "models/props_debris/concrete_section64floor001c.mdl", frozen = true, pos = Vector( -195.5, 290.9, 65.3 ), ang = Angle( 83.1, 95.9, 0 ) },
            { mdl = "models/props_junk/garbage_plasticbottle002a.mdl", pos = Vector( -270.6, 155.7, 11.5 ), ang = Angle( -48.2, -12.2, -1.7 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", frozen = true, pos = Vector( -169.7, 273.9, 68.8 ), ang = Angle( 0, -90, 0 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", frozen = true, pos = Vector( -94.5, 63.7, 91.9 ), ang = Angle( 2.4, -98.6, -42.2 ) },
            { mdl = "models/props_junk/trashdumpster02b.mdl", frozen = true, pos = Vector( -241.1, -198.9, 63.1 ), ang = Angle( 73.3, -27.7, -78.9 ) },
            { mdl = "models/props_junk/garbage_plasticbottle001a.mdl", pos = Vector( -110.5, -209.5, 34 ), ang = Angle( 6, -41.1, -15 ) },
            { mdl = "models/props_combine/breenchair.mdl", frozen = true, pos = Vector( -91.7, 257, 13.3 ), ang = Angle( -87.1, -78.6, 0 ) },
            { mdl = "models/props_debris/metal_panelchunk01a.mdl", frozen = true, pos = Vector( -252.5, 140.9, 92.7 ), ang = Angle( -55, -152.8, 15.4 ) },
            { mdl = "models/props_docks/dock01_pole01a_128.mdl", frozen = true, pos = Vector( -255.8, 98.8, 65.8 ), ang = Angle( -0.1, -88.8, 0 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -47.1, -155.9, 97.4 ), ang = Angle( 3.4, -28.7, 89.9 ) },
            { mdl = "models/props_lab/desklamp01.mdl", frozen = true, pos = Vector( -266, 124.9, 44 ), ang = Angle( -0.3, 44.5, -0.2 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -100.4, -190.3, 57.3 ), ang = Angle( 1.8, 117.4, -5.3 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", frozen = true, pos = Vector( -134, -201.8, 74.8 ), ang = Angle( 3.2, -61.9, -107.7 ) },
            { mdl = "models/props_interiors/furniture_chair03a.mdl", pos = Vector( -63, 4.4, 22.5 ), ang = Angle( 0, -157.8, 0 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -287.6, 80.3, 20.7 ), ang = Angle( -58.4, -88.8, 1.4 ) },
            { mdl = "models/props_c17/lampshade001a.mdl", pos = Vector( -261.5, 129.4, 9.6 ), ang = Angle( 0, 32, 0 ) },
            { mdl = "models/props_lab/reciever01b.mdl", pos = Vector( -286.3, 160.9, 40.4 ), ang = Angle( -0.8, 6, -0.1 ) },
            { mdl = "models/props_lab/reciever01d.mdl", pos = Vector( -287.4, 178.7, 45.7 ), ang = Angle( -1.1, -22.3, 0.2 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", frozen = true, pos = Vector( -149, -219.8, 70.9 ), ang = Angle( 1.3, 118, 15.3 ) },
            { mdl = "models/props_lab/cactus.mdl", pos = Vector( -44.4, 18.5, 8.6 ), ang = Angle( -0.5, -135.7, -0.1 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -70.1, 45.7, 33.3 ), ang = Angle( 1.3, -129.8, 0.3 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -243.3, 264.6, 69.4 ), ang = Angle( -0.2, 135.5, 0 ) },
            { mdl = "models/props_interiors/pot01a.mdl", pos = Vector( -230.7, 245.6, 49.1 ), ang = Angle( 0, -84.3, 0 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -62.6, 68.7, 25.6 ), ang = Angle( -1.4, 78.1, -90.1 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -40, 6.3, 54.4 ), ang = Angle( 21.7, -163.9, 7.5 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -263.7, 244.6, 45.4 ), ang = Angle( 1.5, 146.8, -5.9 ) },
            { mdl = "models/props_debris/metal_panelchunk01a.mdl", frozen = true, pos = Vector( -270.1, 225.7, 34.9 ), ang = Angle( -2.9, 150.5, 17.5 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", frozen = true, pos = Vector( -64.8, 66.3, 91.5 ), ang = Angle( 2, 81.5, -63.6 ) },
            { mdl = "models/props_c17/fence04a.mdl", frozen = true, pos = Vector( -27.9, -10.7, 53.7 ), ang = Angle( 3.3, -179.7, 0.3 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", frozen = true, pos = Vector( -147.3, 214.1, 75.5 ), ang = Angle( 0.9, -180, -26.8 ) },
            { mdl = "models/props_junk/plasticbucket001a.mdl", pos = Vector( -118.8, -218.1, 10.3 ), ang = Angle( 0.3, -38.9, -1.3 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -192.9, 274.5, 70.2 ), ang = Angle( 0, -90.3, -45 ) },
            { mdl = "models/props_c17/concrete_barrier001a.mdl", frozen = true, skin = 1, pos = Vector( -58.8, -169.4, 1.6 ), ang = Angle( 0, -36.2, 0 ) },
            { mdl = "models/props_debris/tile_wall001a_chunk07.mdl", frozen = true, pos = Vector( -52.8, 122.4, 55 ), ang = Angle( -63.8, -6.5, -27.5 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -212.8, 205.9, 127.6 ), ang = Angle( -68.2, 175.9, -99.6 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -291.9, 101.7, 35.2 ), ang = Angle( 49.6, 91.6, 177.1 ) },
            { mdl = "models/props_debris/metal_panelchunk01b.mdl", frozen = true, pos = Vector( -210.3, 142.2, 117.3 ), ang = Angle( -61.3, -147.2, -51.8 ) },
            { mdl = "models/props_wasteland/controlroom_filecabinet002a.mdl", frozen = true, pos = Vector( -131.3, -233.5, 36.7 ), ang = Angle( -1.6, -62, 0.1 ) },
            { mdl = "models/props_c17/furnituresink001a.mdl", frozen = true, pos = Vector( -243, 192.2, 24.3 ), ang = Angle( -1.5, -13.1, -2.8 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", frozen = true, pos = Vector( -31, 17.1, 64.5 ), ang = Angle( -23.3, 8.2, -16.4 ) },
            { mdl = "models/props_debris/metal_panelchunk01e.mdl", frozen = true, pos = Vector( -210.5, 97.4, 118 ), ang = Angle( -61.8, -152.1, 26.7 ) },
            { mdl = "models/props_junk/garbage_plasticbottle003a.mdl", pos = Vector( -257.3, 114.1, 14.8 ), ang = Angle( 0.2, 4.2, 0.2 ) },
            { mdl = "models/props_junk/garbage_plasticbottle001a.mdl", pos = Vector( -249, 110, 14.8 ), ang = Angle( 0, -4.3, 0 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -168.6, 234.3, 138.3 ), ang = Angle( -80.3, 169.8, 134.4 ) },
            { mdl = "models/props_debris/metal_panelchunk01e.mdl", frozen = true, pos = Vector( -253.4, 130, 92.5 ), ang = Angle( -62.4, 161.6, 32.7 ) },
            { mdl = "models/props_borealis/bluebarrel001.mdl", frozen = true, pos = Vector( -277.8, 204.3, 15.2 ), ang = Angle( -34, 121.2, -90 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", frozen = true, pos = Vector( -109.6, -212.1, 4.2 ), ang = Angle( 64.8, -71.6, 88.2 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -72.8, -191.7, 83.6 ), ang = Angle( 1.7, -53.1, -69.3 ) },
            { mdl = "models/props_interiors/radiator01a.mdl", frozen = true, pos = Vector( -100.6, -213.4, 19.8 ), ang = Angle( -4.1, -38.7, 0.1 ) },
            { mdl = "models/props_c17/furniturestove001a.mdl", frozen = true, pos = Vector( -238, 237, 21.5 ), ang = Angle( 0, -45.5, 0 ) },
            { mdl = "models/props_junk/trafficcone001a.mdl", pos = Vector( -126.6, -200.8, 19.2 ), ang = Angle( 0, 72.1, 0 ) },
            { mdl = "models/props_trainstation/bench_indoor001a.mdl", frozen = true, pos = Vector( -119.7, 43.8, 20.2 ), ang = Angle( 0.3, -112.8, 0 ) },
            { mdl = "models/props_debris/barricade_short02a.mdl", frozen = true, pos = Vector( 24.4, 0.5, 29.4 ), ang = Angle( -0.1, -0.7, 0.2 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -96.4, -203.3, 75.5 ), ang = Angle( 4.4, -63, 22.3 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", wallsnap = true, pos = Vector( -277.1, 183.8, 48.2 ), ang = Angle( -0.1, -32.8, -0.2 ) },
            { mdl = "models/props_junk/popcan01a.mdl", frozen = true, pos = Vector( -267, 167.8, 6.3 ), ang = Angle( -0.9, -100.6, -0.6 ) },
            { mdl = "models/props_wasteland/controlroom_storagecloset001b.mdl", frozen = true, pos = Vector( -134.7, 120, 45 ), ang = Angle( 0.3, -25.6, -0.8 ) },
            { mdl = "models/props_c17/furniturecouch001a.mdl", frozen = true, pos = Vector( -237, -167.3, 18.1 ), ang = Angle( 0, 50.8, 0 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -219.8, 256.7, 117.3 ), ang = Angle( 60.2, -23.7, -15.8 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -243.9, -205.6, 55.3 ), ang = Angle( -0.1, -128.9, 0 ) },
            { mdl = "models/props_junk/garbage_carboard002a.mdl", frozen = true, pos = Vector( -170.7, 85.5, 1.2 ), ang = Angle( -0.1, -155.8, 0.1 ) },
            { mdl = "models/props_junk/shoe001a.mdl", wallsnap = true, pos = Vector( -162.5, 157.2, 9.3 ), ang = Angle( -0.2, 156.9, 0 ) },
            { mdl = "models/props_wasteland/laundry_washer003.mdl", frozen = true, pos = Vector( -110.7, -152.9, 28.9 ), ang = Angle( 0, 35.1, -1.9 ) },
            { mdl = "models/props_junk/garbage_milkcarton001a.mdl", pos = Vector( -174.8, 235.7, 12.4 ), ang = Angle( 0.1, -104.7, 0.1 ) },
            { mdl = "models/props_vehicles/tire001c_car.mdl", pos = Vector( -155.9, -206.8, 15 ), ang = Angle( 55.6, 129.7, 6.6 ) },
            { mdl = "models/props_c17/briefcase001a.mdl", pos = Vector( -184.4, -215.8, 13.3 ), ang = Angle( -0.1, 58.9, 0.1 ) },
            { mdl = "models/props_c17/trappropeller_engine.mdl", frozen = true, pos = Vector( -203.2, -207.7, 18.2 ), ang = Angle( 0, 50.8, -0.2 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -255.1, 244.8, 104.7 ), ang = Angle( -88.4, -114.4, -12 ) },
            { mdl = "models/props_docks/dock01_pole01a_256.mdl", frozen = true, pos = Vector( -151.3, -243.6, 129.3 ), ang = Angle( 0, -180, 0 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( -288.3, 141.8, 46.4 ), ang = Angle( -0.2, -27.3, 0.3 ) },
            { mdl = "models/props_debris/barricade_short03a.mdl", frozen = true, pos = Vector( -97.8, 195.4, 30.1 ), ang = Angle( -1.1, 8.1, 0.4 ) },
            { mdl = "models/props_junk/garbage_metalcan001a.mdl", pos = Vector( -210.2, 241.2, 8.6 ), ang = Angle( 0.6, -58.9, -0.5 ) },
            { mdl = "models/props_lab/harddrive01.mdl", pos = Vector( -256.2, 183.9, 15 ), ang = Angle( 0.3, -18.3, -0.9 ) },
            { mdl = "models/props_vehicles/tire001b_truck.mdl", pos = Vector( -170.8, 86.8, 28.1 ), ang = Angle( -32.1, -164.2, 41.6 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", frozen = true, pos = Vector( -33.6, -8.6, 56.7 ), ang = Angle( 18.5, -167.3, 64.3 ) },
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 3, pos = Vector( -268.7, 158, 12.7 ), ang = Angle( 0, -28.1, 0 ) },
            { mdl = "models/props_lab/jar01a.mdl", pos = Vector( -162.8, 133.2, 12.8 ), ang = Angle( -0.1, -121.8, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -131.4, -214.4, 55.4 ), ang = Angle( -0.1, -62.1, 0 ) },
            { mdl = "models/props_docks/dock01_pole01a_128.mdl", frozen = true, pos = Vector( -250.2, 162.3, 87.8 ), ang = Angle( -90, -95.2, 0 ) },
            { mdl = "models/props_debris/metal_panelchunk02e.mdl", frozen = true, pos = Vector( -266.3, 131.4, 89.8 ), ang = Angle( -55.9, -163.2, 16 ) },
            { mdl = "models/props_debris/metal_panelchunk01d.mdl", frozen = true, pos = Vector( -205.8, 91.7, 112 ), ang = Angle( -58.4, -150.8, -7.5 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( -247.9, 204.2, 10.6 ), ang = Angle( 0, -36.2, 0 ) },
            { mdl = "models/props_junk/plasticbucket001a.mdl", pos = Vector( -164.6, 148.4, 11.7 ), ang = Angle( -0.4, -172.4, 0.2 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", frozen = true, pos = Vector( -136, 151.9, 143.8 ), ang = Angle( -83.7, -163.1, 85.9 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", frozen = true, pos = Vector( -26.5, -42.1, 69.7 ), ang = Angle( 6.1, -152.5, -0.5 ) },
            { mdl = "models/props_c17/fence01b.mdl", frozen = true, pos = Vector( -52.2, -151.7, 55.2 ), ang = Angle( -0.1, -31.6, 0 ) },
            { mdl = "models/props_docks/dock01_pole01a_256.mdl", frozen = true, pos = Vector( -103.2, 124.8, 129.3 ), ang = Angle( -0.3, -10.6, 0.3 ) },
            { mdl = "models/props_docks/dock01_pole01a_256.mdl", frozen = true, pos = Vector( -127.1, 209.8, 133.9 ), ang = Angle( 0.4, 39.8, -0.4 ) },
            { mdl = "models/props_junk/trashdumpster02b.mdl", frozen = true, pos = Vector( -130.2, 224.6, 47.2 ), ang = Angle( 80.6, -0.3, -2.6 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -209.2, 123.9, 122.8 ), ang = Angle( -64, -161.7, -146.3 ) },
            { mdl = "models/props_junk/garbage_carboard002a.mdl", frozen = true, pos = Vector( -138.5, 202.8, 1.6 ), ang = Angle( 0.6, -73.7, -179.9 ) },
            { mdl = "models/props_debris/metal_panel02a.mdl", frozen = true, pos = Vector( -195.7, 182.6, 135.1 ), ang = Angle( -72.1, -164.8, 32.9 ) },
            { mdl = "models/props_c17/fence02a.mdl", frozen = true, pos = Vector( -81.1, 63.6, 57.4 ), ang = Angle( -0.3, -99, 0 ) },
            { mdl = "models/props_lab/reciever01a.mdl", pos = Vector( -282.6, 183.4, 42.3 ), ang = Angle( -0.3, -23.7, 0.1 ) },
            { mdl = "models/props_debris/barricade_short02a.mdl", frozen = true, pos = Vector( -55.4, 97.8, 29.3 ), ang = Angle( 0, 57.6, 0 ) },
            { mdl = "models/props_c17/fence01a.mdl", frozen = true, pos = Vector( -300, -97.7, 55.4 ), ang = Angle( 3.6, 179.5, 0 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -62.2, 51.5, 8.3 ), ang = Angle( 3.2, -36.8, 0.2 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -103.7, 126.1, 264.7 ), ang = Angle( 3.7, 62.9, 1.1 ) },
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -163, -88.1, -2 ), ang = Angle( 0, 19, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -140.9, -48.8, 50 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 425,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnchunk001a.mdl", pos = Vector( -178.1, 48.5, 1.9 ), ang = Angle( -0.3, -73, 19.7 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001e.mdl", pos = Vector( -215, -29.2, -2.2 ), ang = Angle( -10.9, 2.2, -2.4 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001e.mdl", pos = Vector( -161.5, 6.5, -1.9 ), ang = Angle( -10.8, -24.1, -2.8 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001g.mdl", pos = Vector( -74.2, 56.7, -17 ), ang = Angle( -14.8, -91, -19.1 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001k.mdl", pos = Vector( -93, 47.2, -6.9 ), ang = Angle( 16.9, -88.3, 0.7 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001e.mdl", pos = Vector( -58, 91.7, 7.1 ), ang = Angle( -20.4, -93.6, -90.1 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001a.mdl", pos = Vector( -49.8, 8.2, 2.5 ), ang = Angle( 0, -35.8, 19.5 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001g.mdl", pos = Vector( -80, -2.3, -17.1 ), ang = Angle( -15, -29.2, -20 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001f.mdl", pos = Vector( -0.3, 61.7, 0.2 ), ang = Angle( -13.6, -159.8, 0.1 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001c.mdl", pos = Vector( -76.2, -39.4, 0.5 ), ang = Angle( -13.2, -75.2, -0.2 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001e.mdl", pos = Vector( 21.9, 63.4, -1.1 ), ang = Angle( -10.9, -106.6, -2.6 ) },
            { mdl = "models/props_debris/concrete_column001a_chunk03.mdl", pos = Vector( 8.6, -24.5, 5.2 ), ang = Angle( 44.7, -16.5, 87.4 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( -35.8, 10.4, 9.7 ), ang = Angle( -0.5, -96.7, 0.5 ) },
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( -185.1, 24.8, 4.6 ), ang = Angle( -0.1, -46.9, 0.2 ) },
            { mdl = "models/props_junk/plasticbucket001a.mdl", pos = Vector( -120.8, -56.3, 7.9 ), ang = Angle( 0.3, -54, -0.3 ) },
            { mdl = "models/props_c17/furnituredrawer001a_chunk02.mdl", pos = Vector( -190.4, -48.5, 10.3 ), ang = Angle( -1, -69.3, 0 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 425,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnchunk001a.mdl", pos = Vector( -161.4, 53.2, 1.9 ), ang = Angle( -0.1, -39.1, 19.6 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001e.mdl", pos = Vector( -109, 11.9, -2 ), ang = Angle( -10.8, 161.2, -2.8 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001g.mdl", pos = Vector( -72.5, 54.7, -17.2 ), ang = Angle( -14.9, -94.3, -19.3 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001k.mdl", pos = Vector( -85, 38.4, -7.1 ), ang = Angle( 17, -91.4, 0 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001a.mdl", pos = Vector( -49.4, 8.1, 2.3 ), ang = Angle( 0, -35, 19.5 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001g.mdl", pos = Vector( -81.3, -2.4, -17.4 ), ang = Angle( -14.8, -27.1, -20.2 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001f.mdl", pos = Vector( -0.3, 61.7, 0 ), ang = Angle( -13.6, -159.8, 0.1 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001c.mdl", pos = Vector( -74.1, -50.3, 0.5 ), ang = Angle( -12.4, -51.6, -0.1 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001e.mdl", pos = Vector( 21.9, 63.4, -1.3 ), ang = Angle( -10.9, -106.6, -2.6 ) },
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( -185.1, 24.8, 4.2 ), ang = Angle( -0.1, -46.9, 0.2 ) },
            { mdl = "models/props_junk/plasticbucket001a.mdl", pos = Vector( -120.8, -56.3, 7.5 ), ang = Angle( 0.3, -54, -0.3 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( -206.3, -12.9, 16.2 ), ang = Angle( 0, -12.5, 0 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( -190.4, -46.6, 16.4 ), ang = Angle( -0.8, -6.1, 0 ) },
            { mdl = "models/props_trainstation/tracksign02.mdl", pos = Vector( -57.3, 68.3, 15.3 ), ang = Angle( 0, -100.2, 0 ) },
            { mdl = "models/props_junk/garbage_milkcarton001a.mdl", pos = Vector( -44.4, 7, 7 ), ang = Angle( 42.7, 84.7, 89.4 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -117.6, -25.6, 3.8 ), ang = Angle( -66.3, -11, -90 ) },
            { mdl = "models/props_junk/garbage_plasticbottle001a.mdl", pos = Vector( -63.8, -12.7, 6.6 ), ang = Angle( 69, -8, -90 ) },
            { mdl = "models/props_c17/playground_swingset_seat01a.mdl", pos = Vector( 14.9, -22.9, 2 ), ang = Angle( -0.5, -96.4, -1.7 ) },
            { mdl = "models/props_interiors/refrigeratordoor02a.mdl", pos = Vector( 17.7, -69.8, 6 ), ang = Angle( -71.6, 99.6, 180 ) },
            { mdl = "models/props_canal/mattpipe.mdl", pos = Vector( 51.7, -69.9, 3.8 ), ang = Angle( 20, 83.5, -92.1 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001b.mdl", pos = Vector( 101.6, -61.7, -0.2 ), ang = Angle( 8.2, 161.8, 10.4 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001f.mdl", pos = Vector( 128.2, 36.8, 1.5 ), ang = Angle( -13.5, 41.7, 0.1 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunka4.mdl", pos = Vector( 160.3, -22.6, 6.4 ), ang = Angle( 0, -165.7, 0 ) },
            { mdl = "models/props_junk/metalgascan.mdl", pos = Vector( 170.1, 16, 6.7 ), ang = Angle( -89.8, 131.2, -178.6 ) },
            { mdl = "models/props_junk/shovel01a.mdl", pos = Vector( 111.6, 10, 4.3 ), ang = Angle( -87.3, 83.6, -180 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        centerpiece = true,
        minsize = 250,
        furniture = {
            { mdl = "models/props_wasteland/controlroom_storagecloset001b.mdl", frozen = true, pos = Vector( -46.1, 86.7, 43.8 ), ang = Angle( 0.1, -88, 0 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001b.mdl", frozen = true, pos = Vector( -63.6, -97.8, -1.9 ), ang = Angle( 7.9, 90.4, 10 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001a.mdl", frozen = true, pos = Vector( -115.4, -44.2, -6.8 ), ang = Angle( 3.9, 120.7, 26.5 ) },
            { mdl = "models/props_debris/concrete_chunk02a.mdl", frozen = true, pos = Vector( -106.2, -95.9, 3.2 ), ang = Angle( -0.1, 144.5, 0 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001a.mdl", frozen = true, pos = Vector( -84.1, -61.9, 3 ), ang = Angle( -7.4, 160.8, 9.4 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001a.mdl", frozen = true, pos = Vector( -104.9, -63.4, 1.4 ), ang = Angle( -5.8, -135.5, 19.3 ) },
            { mdl = "models/props_junk/trashdumpster02b.mdl", frozen = true, pos = Vector( -28.6, 53.7, 121.1 ), ang = Angle( 0, 91.6, -29.3 ) },
            { mdl = "models/props_junk/trashdumpster02.mdl", frozen = true, pos = Vector( 49.8, 13.5, 64.8 ), ang = Angle( 0, 90, -90 ) },
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -88.4, -77.7, -2.1 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_interiors/refrigerator01a.mdl", frozen = true, pos = Vector( -16.5, -98.1, 18.1 ), ang = Angle( 0, 81.9, 90 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( -4.7, -95.6, 40.6 ), ang = Angle( 0, -173, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a_chunk01.mdl", pos = Vector( 5, -108.5, 37.6 ), ang = Angle( 65, 162.7, 117.6 ) },
            { mdl = "models/props_junk/watermelon01_chunk01c.mdl", pos = Vector( -38.7, -97.4, 38.8 ), ang = Angle( -22.7, 5.1, 55.6 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -42, -93, 6.1 ), ang = Angle( -22.5, -19.1, 90 ) },
            { mdl = "models/props_junk/glassjug01.mdl", pos = Vector( -15, -78.9, 5.1 ), ang = Angle( 78.7, 171.9, 90 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -2.7, -104, 7.1 ), ang = Angle( 2.8, 92.1, 0.1 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( -87.5, 109.4, 10.2 ), ang = Angle( 0.1, 160.1, 0 ) },
            { mdl = "models/props_interiors/furniture_chair03a.mdl", pos = Vector( -45.2, 44.3, 21.5 ), ang = Angle( 0, -101, 0 ) },
            { mdl = "models/props_lab/bindergreen.mdl", pos = Vector( -84.3, 32.8, 8 ), ang = Angle( -1.3, -2.5, -89.9 ) },
            { mdl = "models/props_interiors/furniture_shelf01a.mdl", frozen = true, pos = Vector( -81.8, 52.3, 45.8 ), ang = Angle( 0.3, -1.8, 0.1 ) },
            { mdl = "models/props_junk/cardboard_box004a.mdl", pos = Vector( -81.8, 63.7, 43.7 ), ang = Angle( 0.3, -15, 0 ) },
            { mdl = "models/items/357ammo.mdl", class = "item_ammo_357", pos = Vector( -80.2, 66.5, 23.1 ), ang = Angle( 0.8, -15.7, 0 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( -77, 35.9, 42.6 ), ang = Angle( 0.3, 3, 0.2 ) },
            { mdl = "models/gibs/wood_gib01b.mdl", pos = Vector( -101, 5.5, 3.8 ), ang = Angle( 0, -5.7, -0.1 ) },
            { mdl = "models/gibs/wood_gib01b.mdl", pos = Vector( -104.7, -7.6, 3.9 ), ang = Angle( 0, 4.6, 0.1 ) },
            { mdl = "models/gibs/wood_gib01a.mdl", pos = Vector( -113.4, 9.4, 7 ), ang = Angle( 0.6, -86.1, -1.4 ) },
            { mdl = "models/gibs/wood_gib01d.mdl", pos = Vector( -95.6, 20.5, 3.8 ), ang = Angle( -2.6, -15.5, 10.4 ) },
            { mdl = "models/gibs/wood_gib01c.mdl", pos = Vector( -108.3, -0.4, 4.2 ), ang = Angle( 0, 2.2, -0.2 ) },
            { mdl = "models/gibs/wood_gib01d.mdl", pos = Vector( -109.5, 44.8, 4 ), ang = Angle( -2.4, -116.9, 10 ) },
            { mdl = "models/gibs/furniture_gibs/furniture_vanity01a_gib01.mdl", pos = Vector( -96.5, 90.6, 5.5 ), ang = Angle( 0, -38.6, 0 ) },
            { mdl = "models/gibs/furniture_gibs/furniturewooddrawer003a_chunk02.mdl", pos = Vector( -92.9, 88, 10.1 ), ang = Angle( -4.7, 94.6, 179.3 ) },
            { mdl = "models/gibs/furniture_gibs/furniture_vanity01a_gib01.mdl", pos = Vector( -103.6, 71.9, 10.2 ), ang = Angle( 0.3, -178.6, -20.9 ) },
            { mdl = "models/gibs/furniture_gibs/furnituretable002a_chunk03.mdl", pos = Vector( -106.9, 57.8, 9 ), ang = Angle( -5.2, 167.8, -21.5 ) },
            { mdl = "models/props_junk/trafficcone001a.mdl", pos = Vector( 46.7, -92.1, 8.3 ), ang = Angle( -76.5, -10.6, 180 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( 29.2, 17.1, 29.1 ), ang = Angle( 0, -76.2, 0 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", skin = 1, pos = Vector( 42.9, -34.2, 19.7 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_c17/furniturecouch002a.mdl", pos = Vector( 24.3, 20.1, 31.7 ), ang = Angle( 0, -69.4, 0 ) },
            { mdl = "models/props_interiors/furniture_couch02a.mdl", pos = Vector( 29.8, 70.1, 25.1 ), ang = Angle( 29.4, 97, 180 ) },
            { mdl = "models/props_c17/metalpot001a.mdl", pos = Vector( -45.8, -66.1, 11.1 ), ang = Angle( -0.1, 94.8, 0.1 ) },
            { mdl = "models/props_junk/gascan001a.mdl", wallsnap = true, pos = Vector( 51.8, 49.3, 135.7 ), ang = Angle( 90, 137, 0 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 71.4, 84.4, 137.1 ), ang = Angle( 0, 21.2, 0 ) },
            { mdl = "models/props_junk/garbage_newspaper001a.mdl", wallsnap = true, pos = Vector( 86.4, -45.7, 133.6 ), ang = Angle( 0.8, -2.3, 0 ) },
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", wallsnap = true, pos = Vector( 10.1, -53.6, 133.4 ), ang = Angle( 0.2, 4.8, 0.3 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        centerpiece = true,
        minsize = 250,
        furniture = {
            { mdl = "models/props_wasteland/controlroom_storagecloset001b.mdl", frozen = true, pos = Vector( -45.8, 86.7, 43.9 ), ang = Angle( 0, -88.1, 0 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001b.mdl", frozen = true, pos = Vector( -63.6, -97.8, -1.7 ), ang = Angle( 7.9, 90.4, 10 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001a.mdl", frozen = true, pos = Vector( -115.4, -44.2, -6.5 ), ang = Angle( 3.9, 120.7, 26.5 ) },
            { mdl = "models/props_debris/concrete_chunk02a.mdl", frozen = true, pos = Vector( -106.2, -95.9, 3.6 ), ang = Angle( -0.1, 144.5, 0 ) },
            { mdl = "models/props_debris/concrete_spawnchunk001a.mdl", frozen = true, pos = Vector( -84.1, -61.9, 3.5 ), ang = Angle( -7.4, 160.8, 9.4 ) },
            { mdl = "models/props_junk/trashdumpster02b.mdl", drop = false, pos = Vector( -21.4, 26.8, 57.8 ), ang = Angle( -23.7, 155.8, -27 ) },
            { mdl = "models/props_junk/trashdumpster02.mdl", frozen = true, pos = Vector( 49.8, 13.5, 65.5 ), ang = Angle( 0, 90, -90 ) },
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -86.3, -78.1, -2.2 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_interiors/refrigerator01a.mdl", frozen = true, pos = Vector( -16.5, -98.1, 19 ), ang = Angle( 0, 81.9, 90 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( -4.7, -95.6, 41.4 ), ang = Angle( 0, -173, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a_chunk01.mdl", wallsnap = true, pos = Vector( 4.8, -108.3, 38.5 ), ang = Angle( 64.8, 161, 117.4 ) },
            { mdl = "models/props_interiors/furniture_chair03a.mdl", pos = Vector( -37.1, -22.9, 10.6 ), ang = Angle( -3.2, 168.8, -93.3 ) },
            { mdl = "models/props_lab/bindergreen.mdl", pos = Vector( -98.4, -9.5, 3.8 ), ang = Angle( 7.7, -22.9, -72.7 ) },
            { mdl = "models/props_interiors/furniture_shelf01a.mdl", pos = Vector( -81.7, 50.3, 45.2 ), ang = Angle( 0.3, 2.3, 0 ) },
            { mdl = "models/props_junk/cardboard_box004a.mdl", pos = Vector( -80.2, 64.4, 43.1 ), ang = Angle( 0.3, 9.4, 0 ) },
            { mdl = "models/gibs/wood_gib01c.mdl", wallsnap = true, pos = Vector( -104.9, -2.7, 3 ), ang = Angle( 0.1, 4.5, 0 ) },
            { mdl = "models/gibs/wood_gib01d.mdl", wallsnap = true, pos = Vector( -104.1, 46.5, 2.8 ), ang = Angle( -2.7, -134, 10.6 ) },
            { mdl = "models/gibs/furniture_gibs/furnituretable002a_chunk03.mdl", wallsnap = true, pos = Vector( -108.8, 58.2, 2.9 ), ang = Angle( 0.1, -177.9, 0 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", skin = 1, pos = Vector( 26, -40.7, 14.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_c17/metalpot001a.mdl", pos = Vector( -45.5, -66.2, 9.4 ), ang = Angle( -0.3, 94.9, -0.2 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 67.9, 112.7, 7.9 ), ang = Angle( 0, -9.8, 0 ) },
            { mdl = "models/props_junk/garbage_newspaper001a.mdl", wallsnap = true, pos = Vector( -25.9, -51.7, 11.6 ), ang = Angle( -43.5, 120.2, -7.2 ) },
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", wallsnap = true, pos = Vector( 39.8, -60.6, 133 ), ang = Angle( -3.3, -44, -3.4 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        centerpiece = true,
        minsize = 150,
        furniture = {
            { mdl = "models/props_junk/trashdumpster02b.mdl", drop = false, pos = Vector( -46.9, -1.5, 44.4 ), ang = Angle( -68.3, 1.6, 0 ) },
            { mdl = "models/props_junk/trashdumpster02b.mdl", drop = false, pos = Vector( -16.9, 0.2, 88.9 ), ang = Angle( 0, -1.6, 0 ) },
            { mdl = "models/props_wasteland/controlroom_filecabinet002a.mdl", pos = Vector( 47.7, 45, 35.4 ), ang = Angle( 0, -75.7, 0 ) },
            { mdl = "models/props_wasteland/controlroom_filecabinet001a.mdl", pos = Vector( -21.3, -47.4, 14.2 ), ang = Angle( 0, -0.1, 0 ) },
            { mdl = "models/props_wasteland/controlroom_filecabinet001a.mdl", pos = Vector( 4.7, -40.8, 14.3 ), ang = Angle( 0, 93.6, 0 ) },
            { mdl = "models/props_wasteland/controlroom_filecabinet001a.mdl", pos = Vector( -7, -40.4, 41.9 ), ang = Angle( 0, 97.8, 0.3 ) },
            { mdl = "models/props_wasteland/controlroom_filecabinet002a.mdl", pos = Vector( 34.9, -45.2, 35.8 ), ang = Angle( 0, -6.6, 0 ) },
            { mdl = "models/props_interiors/refrigerator01a.mdl", frozen = true, pos = Vector( -15.9, 47.7, 38 ), ang = Angle( 0, 90, 0 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", frozen = true, pos = Vector( -29.5, 3.5, 11.1 ), ang = Angle( 0, 0.5, 0 ) },
            { mdl = "models/props_lab/harddrive02.mdl", pos = Vector( -31.9, 20.8, 32.5 ), ang = Angle( 0.1, -8.5, -0.3 ) },
            { mdl = "models/props_lab/harddrive01.mdl", wallsnap = true, pos = Vector( 15.9, 56.3, 4.8 ), ang = Angle( 0, -57.6, -90 ) },
            { mdl = "models/props_lab/monitor02.mdl", pos = Vector( -30.6, -7.7, 22.9 ), ang = Angle( -0.6, 8.7, -0.6 ) },
            { mdl = "models/props_lab/reciever01a.mdl", pos = Vector( -24.6, 0.1, 4.4 ), ang = Angle( 0.6, 0.7, -0.1 ) },
            { mdl = "models/props_lab/reciever01b.mdl", pos = Vector( 9.6, -39.7, 36.1 ), ang = Angle( -89.8, 18.2, -13.1 ) },
            { mdl = "models/props_trainstation/payphone_reciever001a.mdl", pos = Vector( -15, 32.3, 26.3 ), ang = Angle( 14.1, -168.3, -89.9 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -10.7, 29.1, 9.7 ), ang = Angle( 0.4, -23.6, -0.1 ) },
            { mdl = "models/props_rooftop/satellitedish02.mdl", frozen = true, pos = Vector( -21.3, 73.6, 92.3 ), ang = Angle( -19.1, 96, 19.1 ) },
            { mdl = "models/props_lab/citizenradio.mdl", class = "homeless_radio_bliss", pos = Vector( 19.9, 36.2, 1.7 ), ang = Angle( -0.1, -72.4, 0 ) },
            { mdl = "models/props_lab/monitor01b.mdl", pos = Vector( -16.2, 46.6, 66.4 ), ang = Angle( -7.9, 101.8, 0 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( -11.5, 43.9, 11.9 ), ang = Angle( 0, 111.9, 0 ) },
            { mdl = "models/props_lab/reciever01d.mdl", pos = Vector( -7.6, 41, 36.9 ), ang = Angle( -1, 110.2, 0 ) },
            { mdl = "models/props_lab/reciever01c.mdl", pos = Vector( -23, 56.2, 37 ), ang = Angle( -1, 27.1, 0 ) },
            { mdl = "models/props_junk/garbage_metalcan001a.mdl", pos = Vector( -6.7, 41.1, 52.3 ), ang = Angle( 0, 90.1, 0 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 52.5, -19.6, 7.5 ), ang = Angle( -0.7, 11.5, -0.5 ) },
            { mdl = "models/props_junk/garbage_takeoutcarton001a.mdl", wallsnap = true, pos = Vector( -12, -56.8, 80.1 ), ang = Angle( -3.2, 48.3, 84.5 ) },
            bornposter,
            trashdecalrand,
        }
    },
    {
        dedication = 1,
        onlycenterpiecefollower = true,
        skyagnostic = true,
        minsize = 250,
        furniture = {
            { mdl = "models/props_interiors/furniture_chair01a.mdl", pos = Vector( -81.5, 58.1, 9.9 ), ang = Angle( -88.1, -78.2, -4.8 ) },
            { mdl = "models/props_interiors/furniture_chair01a.mdl", pos = Vector( -52.3, 57.5, 12 ), ang = Angle( -72.1, -83.5, 102.4 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( -61.8, -1.7, 15.3 ), ang = Angle( 0, -90.6, -0.1 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( -28.8, 81.5, -4 ), ang = Angle( -87.1, 112.5, 179.8 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 46.1, 10, 15.3 ), ang = Angle( -0.1, -92.2, 0 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 5.9, 94.3, 15.4 ), ang = Angle( -0.1, -78.7, 0 ) },
            { mdl = "models/nova/chair_plastic01.mdl", pos = Vector( -3.6, 52.5, 11.6 ), ang = Angle( 0, -133.1, 85.3 ) },
            { mdl = "models/nova/chair_office01.mdl", pos = Vector( -6.2, -89.6, 12.1 ), ang = Angle( -81.1, 62.4, 0.9 ) },
            { mdl = "models/nova/chair_office01.mdl", pos = Vector( 25.2, -100.4, 0.8 ), ang = Angle( 0.1, -137.1, 0.1 ) },
            { mdl = "models/nova/chair_wood01.mdl", pos = Vector( -95.9, -19.2, 0.8 ), ang = Angle( 0.1, -88.6, 0 ) },
            { mdl = "models/nova/chair_wood01.mdl", pos = Vector( -85.4, -48, 9.3 ), ang = Angle( 0.6, -66.3, 90.2 ) },
            { mdl = "models/nova/chair_wood01.mdl", pos = Vector( -69.9, -42.5, 1.1 ), ang = Angle( 0, -117.6, 0 ) },
            { mdl = "models/nova/chair_office01.mdl", pos = Vector( 18.5, 38.7, 1.2 ), ang = Angle( -0.1, -72.4, 0 ) },
            { mdl = "models/nova/chair_office01.mdl", pos = Vector( 32.4, 44.6, 35.6 ), ang = Angle( -17.3, -67.6, 50.1 ) },
            { mdl = "models/nova/chair_office01.mdl", pos = Vector( -10.8, 57.8, 32.8 ), ang = Angle( 4.3, -142, 89.6 ) },
            { mdl = "models/nova/chair_plastic01.mdl", pos = Vector( -24, 5.4, 12.6 ), ang = Angle( 0, -132.1, 92.8 ) },
            { mdl = "models/nova/chair_plastic01.mdl", pos = Vector( -88.8, -89.7, 1.6 ), ang = Angle( -0.2, -172.6, 0.1 ) },
            { mdl = "models/nova/chair_plastic01.mdl", pos = Vector( -95.2, -65.5, 12.9 ), ang = Angle( 86.2, 176.2, 166.7 ) },
            { mdl = "models/nova/chair_plastic01.mdl", pos = Vector( -24.8, -96.4, 22 ), ang = Angle( 0.1, 103.3, -128.7 ) },
            { mdl = "models/nova/chair_wood01.mdl", pos = Vector( 64.4, -106.3, 1.8 ), ang = Angle( 0.1, -31.2, 0 ) },
            { mdl = "models/nova/chair_wood01.mdl", pos = Vector( 81.4, -81.7, 2 ), ang = Angle( 0, -30.4, 0 ) },
            { mdl = "models/nova/chair_wood01.mdl", pos = Vector( 101.6, -54.5, 21.6 ), ang = Angle( -0.2, -15.8, -132.7 ) },
            trashdecalrand,
        }
    },
    {
        dedication = 1,
        centerpiece = true,
        likessky = true,
        minsize = 225,
        furniture = {
            { mdl = "models/props_vehicles/trailer002a.mdl", pos = Vector( -11.9, -55.5, 47.3 ), ang = Angle( 0.1, 178.9, 90.1 ) },
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( 42.8, -16.9, 11.1 ), ang = Angle( 10.8, 89.1, 0.5 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( 46.6, -18.3, 39.8 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 5, pos = Vector( -42.6, -20.8, 8.1 ), ang = Angle( 3.1, 26.7, -5.8 ) },
            { mdl = "models/props_junk/metalbucket02a.mdl", wallsnap = true, pos = Vector( -39.8, 77.7, 8.4 ), ang = Angle( 0, 149.4, 180 ) },
        }
    },
    {
        dedication = 1,
        minsize = 225,
        likessky = true,
        furniture = {
            { mdl = "models/props_vehicles/trailer002a.mdl", pos = Vector( -11.8, 137.4, 47.6 ), ang = Angle( 0.1, 178.4, 87.9 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( 41.4, 276.8, 6.8 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 8, wallsnap = true, class = "homeless_radio", pos = Vector( -47.3, 236.2, 0.6 ), ang = Angle( 0.2, 18.3, 0.2 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunka.mdl", pos = Vector( 44.4, 178.4, 12.1 ), ang = Angle( 13.5, 95.7, -1.6 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunkb3.mdl", wallsnap = true, pos = Vector( 67.4, 233.4, 4.2 ), ang = Angle( -1.8, 152.6, 0 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunka4.mdl", wallsnap = true, pos = Vector( -27.7, 285.1, 4.6 ), ang = Angle( 0, 36.6, -0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_wasteland/cafeteria_table001a.mdl", pos = Vector( -1.6, 38.2, 15.7 ), ang = Angle( 0, -88.5, 0 ) },
            { mdl = "models/props_c17/chair_office01a.mdl", pos = Vector( 39.3, -2.1, 0.6 ), ang = Angle( 0, 17.6, 0 ) },
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", pos = Vector( -42.7, 26.4, 33 ), ang = Angle( 0, -146.8, 0 ) },
            { mdl = "models/props_c17/pulleywheels_small01.mdl", pos = Vector( -42, 17.1, 4.8 ), ang = Angle( 89.8, 45.9, 156.9 ) },
            { mdl = "models/props_c17/oildrumchunk01e.mdl", pos = Vector( 42.5, 40.3, 2.6 ), ang = Angle( 63.9, -92, -60.2 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunka1.mdl", pos = Vector( 34.6, 27.4, 33 ), ang = Angle( -87.8, -118.4, -3.3 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( -37, 59.3, 15.1 ), ang = Angle( -0.1, -74.9, 0 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 0.5, 63.9, 13.7 ), ang = Angle( -4.4, -89.6, -92 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 45.4, 51, 15.3 ), ang = Angle( -0.1, -164.9, 0 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 27.5, -3.2, 15.4 ), ang = Angle( -0.1, 60.6, 0 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( -37.9, 27.9, 25 ), ang = Angle( 77.9, -60.7, 178.7 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 18.4, 22.2, 15.6 ), ang = Angle( 0, 161.7, 0 ) },
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", wallsnap = true, pos = Vector( -42.6, -50.9, 2.3 ), ang = Angle( 0.3, 134.4, -0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/cardboard_box001a.mdl", pos = Vector( 23.5, -27.1, 12.4 ), ang = Angle( 0.1, -177.1, 0 ) },
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", pos = Vector( 14.2, -28.2, 26.3 ), ang = Angle( 0, 105.3, -0.1 ) },
        }
    },
    {
        dedication = 1,
        skyagnostic = true,
        nevercenterpiecefollower = true,
        minsize = 100,
        maxsize = 150,
        furniture = {
            { mdl = "models/props_junk/gascan001a.mdl", skipchance = 50, pos = Vector( 18.4, -29.4, 4.4 ), ang = Angle( -89.9, 96.8, 51 ) },
            { mdl = "models/props_c17/paper01.mdl", skipchance = 50, class = "homeless_note", pos = Vector( 15.2, -29.1, 10.3 ), ang = Angle( 0.2, 40.3, -0.3 ) },
        }
    },
    {
        dedication = 1,
        disposition = 1,
        likessky = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/signpole001.mdl", frozen = true, pos = Vector( 7.8, -28.3, -9.4 ), ang = Angle( 6.9, 59.4, -10.7 ) },
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", frozen = true, pos = Vector( -4.6, -12.4, 75.1 ), ang = Angle( 76.5, 135.5, -4.4 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/signpole001.mdl", frozen = true, pos = Vector( 11.4, -26.4, -20.4 ), ang = Angle( 6.9, 106.5, -5 ) },
        }
    },
    {
        dedication = 1,
        skyagnostic = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", wallsnap = true, pos = Vector( 27.7, -34, 1.7 ), ang = Angle( 0, 78, -0.1 ) },
            { mdl = "models/props_junk/glassbottle01a.mdl", wallsnap = true, pos = Vector( -34.5, -39, 2 ), ang = Angle( 18.3, 53.5, 91.6 ) },
        }
    },

    -- rain catchers
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 175,
        furniture = {
            { mdl = "models/props_borealis/bluebarrel001.mdl", frozen = true, pos = Vector( -30.5, 46.6, 14.1 ), ang = Angle( -75.1, -90, 89.5 ) },
            { mdl = "models/props_wasteland/laundry_cart001.mdl", frozen = true, pos = Vector( 2.8, 5.4, 49 ), ang = Angle( -3.8, -89.9, -0.4 ) },
            { mdl = "models/props_wasteland/laundry_cart001.mdl", frozen = true, pos = Vector( -43.4, 5.7, 51.1 ), ang = Angle( -3.8, -89.9, -0.4 ) },
            { mdl = "models/props_pipes/pipe01_lcurve01_long.mdl", frozen = true, pos = Vector( -39.9, 51, 29.6 ), ang = Angle( 43.7, -159.9, 76.5 ) },
            { mdl = "models/props_pipes/pipe01_scurve01_long.mdl", frozen = true, pos = Vector( -18.9, 43.9, 30.8 ), ang = Angle( -48, 119, -81 ) },
            { mdl = "models/props_c17/furniturewashingmachine001a.mdl", frozen = true, pos = Vector( -44.8, -29.9, 22.9 ), ang = Angle( -0.1, 85.7, -0.1 ) },
            { mdl = "models/props_wasteland/laundry_cart002.mdl", frozen = true, pos = Vector( -0.9, -27.1, 16.6 ), ang = Angle( 0, -176.5, -89.9 ) },
            { mdl = "models/props_trainstation/tracksign02.mdl", frozen = true, pos = Vector( 16.2, 39.7, 14.8 ), ang = Angle( -0.1, -38.6, 0 ) },
            { mdl = "models/props_interiors/pot02a.mdl", wallsnap = true, pos = Vector( 70, -71.5, 4.3 ), ang = Angle( -0.1, 89.3, 0.7 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 175,
        furniture = {
            { mdl = "models/props_borealis/bluebarrel001.mdl", frozen = true, pos = Vector( -32.7, 44.7, 14.5 ), ang = Angle( -82.4, -103.8, 90 ) },
            { mdl = "models/props_wasteland/laundry_cart001.mdl", frozen = true, pos = Vector( -43.4, 5.1, 42 ), ang = Angle( -3.8, -89.9, -0.4 ) },
            { mdl = "models/props_pipes/pipe01_lcurve01_long.mdl", frozen = true, pos = Vector( -36.3, 53.8, 25.2 ), ang = Angle( 54.5, 179, 50.5 ) },
            { mdl = "models/props_c17/furniturecouch002a.mdl", frozen = true, pos = Vector( -40.5, -30.4, 10.3 ), ang = Angle( 46.4, -128.8, 180 ) },
            { mdl = "models/props_interiors/pot01a.mdl", wallsnap = true, pos = Vector( 71.8, 72.1, 5.9 ), ang = Angle( 0.3, -76.4, 0.3 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 175,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( 50, -36.8, 7.9 ), ang = Angle( 0, 179.6, 0 ) },
            { mdl = "models/props_wasteland/laundry_basket002.mdl", pos = Vector( 51.8, 47.8, 22.4 ), ang = Angle( 0, -112.8, 0 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( -6.4, 52.9, 8.7 ), ang = Angle( 0.9, -157.7, -0.9 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunka1.mdl", wallsnap = true, pos = Vector( -61.2, -60, 1.8 ), ang = Angle( 88.7, -115.3, 178.5 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 38.8, 39.9, 3.3 ), ang = Angle( -0.2, 27.4, -0.4 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( -1.5, 47.4, 3.4 ), ang = Angle( -0.2, 177.5, -0.4 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( -21.6, 33.1, 3.5 ), ang = Angle( -0.2, 137.7, -0.4 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 32.1, 12.9, 3.6 ), ang = Angle( -0.1, -175.4, -0.3 ) },
            { mdl = "models/props_junk/plasticcrate01a.mdl", wallsnap = true, facewall = true, pos = Vector( 34.2, -18.5, 8.4 ), ang = Angle( -0.1, -177.6, -0.1 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( -11.2, 12.6, 3.4 ), ang = Angle( -0.3, 86.4, 0.7 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 44.2, -31.6, 3.4 ), ang = Angle( 0, 167.1, 0.1 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 14.2, 53.2, 3.5 ), ang = Angle( -0.2, -72.2, -0.5 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 175,
        furniture = {
            { mdl = "models/props_wasteland/laundry_cart001.mdl", pos = Vector( -46.6, 26.1, 20.1 ), ang = Angle( 0, -88.7, -0.1 ) },
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", wallsnap = true, pos = Vector( 55.3, 63, 8.8 ), ang = Angle( 0.3, -35.4, -0.3 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 175,
        furniture = {
            { mdl = "models/props_wasteland/laundry_cart001.mdl", pos = Vector( 30.2, 42.4, 20 ), ang = Angle( 0, 0.5, 0 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", pos = Vector( 26.9, 50.8, 18.1 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 175,
        furniture = {
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( -27.6, 70.3, 3.5 ), ang = Angle( 0.2, -89.9, -0.1 ) },
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( -61.6, 63.8, 7.9 ), ang = Angle( 0.1, -3.2, 0 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( -66.7, 6.1, 8.8 ), ang = Angle( -0.6, -72, 0.6 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 175,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( 44.5, 49.9, 7.9 ), ang = Angle( 0.1, -157.6, 0 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( -16.5, 57.7, 8.6 ), ang = Angle( 0.7, -33.2, -0.7 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 49.4, 15.9, 3.5 ), ang = Angle( -0.2, 69, -0.4 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( -34.5, -32.5, 7.9 ), ang = Angle( 0, -156.7, 0 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( 10.1, -36.2, 8.5 ), ang = Angle( 0.5, -83, -0.5 ) },
            { mdl = "models/props_lab/binderblue.mdl", wallsnap = true, pos = Vector( 47.8, 51.6, 2.3 ), ang = Angle( -1.1, -88.7, 90 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( 36.2, 35.9, 7.9 ), ang = Angle( 0, -152, 0 ) },
            { mdl = "models/props_junk/terracotta01.mdl", pos = Vector( -16.3, 37, 0.5 ), ang = Angle( 0.7, -84.9, 0 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( -10.7, 30.1, 8.6 ), ang = Angle( -0.6, -80.4, 0.6 ) },
            { mdl = "models/props_junk/terracotta01.mdl", pos = Vector( 48.4, 39.1, 0.6 ), ang = Angle( 0.4, -100, 0 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl" },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( 29.8, -37.8, 8.5 ), ang = Angle( 0.3, 146.8, 0.5 ) },
            { mdl = "models/props_junk/cardboard_box004a.mdl", pos = Vector( -17.9, 4.3, 4.7 ), ang = Angle( -0.8, 147.4, -1.3 ) },
        }
    },
    -- end rain catchers

    {
        dedication = 1,
        onlycenterpiecefollower = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furniturebed001a.mdl", pos = Vector( -1.9, 40.3, 17.8 ), ang = Angle( 0.9, -173.1, -180 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", pos = Vector( -5.5, 40.2, 28.3 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( 26.4, 3.4, 3.6 ), ang = Angle( 0.8, -106.6, 0.8 ) },
        }
    },
    {
        dedication = 1,
        minsize = 150,
        furniture = {
            { mdl = "models/props_c17/furniturearmchair001a.mdl", skin = 2, pos = Vector( -68.4, 7.5, 0.7 ), ang = Angle( 0, -13.5, -0.1 ) },
            { mdl = "models/props_c17/furniturearmchair001a.mdl", skin = 2, pos = Vector( 13.4, -62.2, -18.2 ), ang = Angle( 0, 93.8, 89.8 ) },
            { mdl = "models/props_c17/furnituretable001a.mdl", pos = Vector( 12.3, 16, 18.6 ), ang = Angle( 0, 178.3, 0 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 2.7, 23, 40.5 ), ang = Angle( 0, -123.2, -0.1 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 40.5, -6.2, 3.9 ), ang = Angle( 31.3, 83.7, 90 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( 40.1, 34.5, -2.9 ), ang = Angle( 0, -7, 0 ) },
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( -21.5, -19.8, 4.9 ), ang = Angle( 0, -100.1, 0 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunka.mdl", pos = Vector( -15.7, -19.3, 13.2 ), ang = Angle( -0.1, -83, -2 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunka4.mdl", pos = Vector( -54.9, -15.7, 13 ), ang = Angle( -0.1, -83, 0.2 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunka3.mdl", pos = Vector( -30, -5.7, 15.6 ), ang = Angle( 0.9, -175.2, 0.1 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            bornposter,
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( 26.4, -32.4, -2.9 ), ang = Angle( 0, 18, 0 ) },
            { mdl = "models/gibs/furniture_gibs/furniture_vanity01a_gib01.mdl", pos = Vector( -30.8, 1.8, 2.7 ), ang = Angle( -0.1, 59.6, 0 ) },
            { mdl = "models/gibs/furniture_gibs/furniture_chair01a_gib01.mdl", pos = Vector( -46.1, -17.4, 5.2 ), ang = Angle( 0.1, 134.6, 2.5 ) },
            { mdl = "models/gibs/furniture_gibs/furnituretable002a_chunk08.mdl", pos = Vector( -39.3, -16.8, 6.9 ), ang = Angle( 10.8, 1, -88.4 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( 19.6, 29.2, 20.5 ), ang = Angle( 0, -97.3, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 20, pos = Vector( 27.9, 34.6, 40.9 ), ang = Angle( 0, -102.6, -0.2 ) },
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -33.7, -32.5, -2.7 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_wasteland/controlroom_chair001a.mdl", pos = Vector( 36.3, -16.2, 20.8 ), ang = Angle( -0.1, -166.3, 0.1 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        furniture = {
            bornposter,
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -12.6, -10.5, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/gibs/wood_gib01a.mdl", pos = Vector( -14, 24.1, 2 ), ang = Angle( -0.2, -3, 1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        likessky = true,
        onlycenterpiecefollower = true,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( 24.6, -11.4, -2.9 ), ang = Angle( 0, -24, 0 ) },
            { mdl = "models/gibs/wood_gib01b.mdl", pos = Vector( -46.4, -22.3, 1.6 ), ang = Angle( 0.1, 66.6, 0.1 ) },
            { mdl = "models/gibs/wood_gib01a.mdl", pos = Vector( -38.5, -23.2, 4.1 ), ang = Angle( -4.5, 150.8, 0.9 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 150,
        furniture = {
            { mdl = "models/props_wasteland/controlroom_desk001b.mdl", pos = Vector( 38, -5.7, 17 ), ang = Angle( -0.3, 177.2, 0 ) },
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( 20.2, 3.2, -2.8 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_interiors/pot01a.mdl", pos = Vector( 27.7, 6.3, 39.5 ), ang = Angle( -0.2, 145.9, 0.1 ) },
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( 37.8, -36.7, 37.6 ), ang = Angle( 0.3, 50.9, 0.2 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( -54.1, -54.5, 15.5 ), ang = Angle( 0, 46.1, 0.2 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", wallsnap = true, pos = Vector( -34.5, 35.7, 4.7 ), ang = Angle( 1.7, 76.3, -1.2 ) },
            { mdl = "models/props_junk/garbage_metalcan001a.mdl", wallsnap = true, pos = Vector( -21.6, 36.8, 4.7 ), ang = Angle( 0.7, 87.3, 1.8 ) },
            { mdl = "models/props_junk/garbage_metalcan001a.mdl", wallsnap = true, pos = Vector( -21.5, 29.7, 4.8 ), ang = Angle( 0.8, -162.4, 1.8 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", pos = Vector( 47.6, 38.9, 38.7 ), ang = Angle( 0.1, 57.1, 0.2 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -16.5, 24.6, -3 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_wasteland/controlroom_chair001a.mdl", pos = Vector( 41.2, -20.9, 20.7 ), ang = Angle( 0, 133.7, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle002a.mdl", pos = Vector( 20.8, -34.4, 9.2 ), ang = Angle( 0.9, -142.4, -0.5 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        likessky = true,
        onlycenterpiecefollower = true,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -21.9, 21.8, -2.9 ), ang = Angle( 0, -80, 0 ) },
            { mdl = "models/props_c17/signpole001.mdl", frozen = true, pos = Vector( -24.4, -44.9, -24.3 ), ang = Angle( -45, -88.1, 0 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 24.1, -33.3, 11.7 ), ang = Angle( 0, 81.6, -90 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", pos = Vector( 21.3, -31.6, 45.7 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 175,
        furniture = {
            { mdl = "models/props_lab/kennel_physics.mdl", pos = Vector( 54.4, 50.1, 0.6 ), ang = Angle( 0, -86.7, 0 ) },
            { mdl = "models/props_lab/kennel_physics.mdl", pos = Vector( 8, 48, 0.6 ), ang = Angle( 0, -84.6, 0 ) },
            { mdl = "models/props_lab/kennel_physics.mdl", pos = Vector( -34.8, 45.8, 0.7 ), ang = Angle( 0, -91.8, 0 ) },
            { mdl = "models/props_lab/kennel_physics.mdl", pos = Vector( -45.6, -9.4, 25.3 ), ang = Angle( 0, -19.1, 105.6 ) },
            { mdl = "models/props_c17/furniturebed001a.mdl", pos = Vector( 42.3, 5.6, 21.7 ), ang = Angle( 0, -178.3, -90 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", pos = Vector( 7.6, 46.1, 20.8 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/seagull.mdl", class = "prop_ragdoll", pos = Vector( 52.1, 46.9, 22 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", wallsnap = true, pos = Vector( 55.2, -24.8, 4.9 ), ang = Angle( 2, -92.8, -1.3 ) },
            { mdl = "models/props_junk/garbage_metalcan001a.mdl", wallsnap = true, pos = Vector( -67.8, 31.3, 3.2 ), ang = Angle( 20.4, -65.5, -90.3 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 63.7, -47.7, 12.3 ), ang = Angle( 0, 169.8, -90 ) },
            { mdl = "models/props_junk/garbage_takeoutcarton001a.mdl", pos = Vector( 63.3, -39.3, 9.3 ), ang = Angle( 0, -161.2, 1.3 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = true, pos = Vector( 76.6, -60.9, 9.7 ), ang = Angle( 2.2, 178, 0 ) },
            trashdecalrand,
        }
    },
    {
        dedication = 1,
        minsize = 125,
        onlycenterpiecefollower = true,
        furniture = {
            { mdl = "models/props_junk/wheebarrow01a.mdl", schizophrenic = 50, pos = Vector( 8.8, 18.4, 16.9 ), ang = Angle( 0.7, 26.1, 0 ) },
            { mdl = "models/props_junk/watermelon01_chunk01c.mdl", pos = Vector( 21.7, 23.3, 26.1 ), ang = Angle( -13, 18, 52.5 ) },
            { mdl = "models/props_junk/watermelon01_chunk01b.mdl", pos = Vector( 9.1, 14.9, 29.7 ), ang = Angle( -23.2, -153.7, -167.5 ) },
            { mdl = "models/props_junk/watermelon01_chunk01a.mdl", pos = Vector( 22.1, 27.8, 38.4 ), ang = Angle( -3.2, 26.8, 32 ) },
        }
    },
    {
        dedication = 1,
        onlycenterpiecefollower = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/cardboard_box001a.mdl", pos = Vector( 18.2, 17.6, 12.5 ), ang = Angle( 0, -140, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 20, pos = Vector( 19.1, 15.8, 25.1 ), ang = Angle( 0, -126.4, 0 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_wasteland/controlroom_chair001a.mdl", pos = Vector( 25.8, 25.8, 19.4 ), ang = Angle( 0, -125.7, -0.2 ) },
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -15.9, -17.2, -3.9 ), ang = Angle( 0, -24, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        notedetail = 2,
        furniture = {
            { mdl = "models/props_interiors/bathtub01a.mdl", pos = Vector( 1.4, -9.3, 21.6 ), ang = Angle( 4.4, -136.7, -180 ) },
            { mdl = "models/gibs/hgibs.mdl", skipchance = 50, pos = Vector( 4.4, -0.2, 3.2 ), ang = Angle( 1.1, -135.4, -0.6 ) },
        }
    },
    {
        dedication = 1,
        minsize = 150,
        furniture = {
            { mdl = "models/props_wasteland/cafeteria_table001a.mdl", pos = Vector( 41.2, 0.7, 15.9 ), ang = Angle( 0, -179.6, 0 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", pos = Vector( -8.7, 41.6, 20.6 ), ang = Angle( 0, 178.9, 0 ) },
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( 44.3, -46.8, 34.8 ), ang = Angle( 0, -145.9, 0 ) },
            { mdl = "models/weapons/w_357.mdl", class = "weapon_357", pos = Vector( 25.5, -53.1, 33.3 ), ang = Angle( 8.2, -16, 76.5 ) },
            { mdl = "models/weapons/w_crowbar.mdl", class = "weapon_crowbar", pos = Vector( 45.7, -38.5, 32.8 ), ang = Angle( -0.7, -2.7, 51.7 ) },
            { mdl = "models/items/boxsrounds.mdl", class = "item_ammo_pistol", pos = Vector( 41.5, 49.9, 32.1 ), ang = Angle( 0, 1.3, 0 ) },
            { mdl = "models/items/boxmrounds.mdl", class = "item_ammo_smg1", pos = Vector( -1.9, 54.2, 46.9 ), ang = Angle( -87.2, 23.5, 22.1 ) },
            { mdl = "models/props_junk/cardboard_box004a.mdl", wallsnap = true, pos = Vector( 5.5, -58.5, 5.2 ), ang = Angle( -0.6, 163.2, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", wallsnap = true, pos = Vector( 16.6, -53.1, 3.4 ), ang = Angle( -5.5, 89.7, 91.7 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( -36.8, -47.6, 15.3 ), ang = Angle( 0, 45.4, 0.1 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a_chunk02.mdl", pos = Vector( 20, 16.8, -0.1 ), ang = Angle( 69.4, 69.8, 93.6 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a_chunk01.mdl", wallsnap = true, pos = Vector( 45.6, 35.7, 3 ), ang = Angle( 62.9, 78.2, -115.3 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a_chunk03.mdl", wallsnap = true, pos = Vector( -44.5, 47.7, 8.9 ), ang = Angle( -0.8, 49.7, 0.9 ) },
        }
    },
    {
        dedication = 1,
        minsize = 175,
        furniture = {
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( 54.6, -27.1, 5.2 ), ang = Angle( -89.7, 1.1, 78.3 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( -50.1, -91.2, 5.9 ), ang = Angle( -0.3, -177.2, -90 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( 39.8, -63.2, 11.7 ), ang = Angle( 0.4, 97.6, -0.2 ) },
            { mdl = "models/props_junk/garbage_carboard002a.mdl", wallsnap = true, pos = Vector( 24.3, 26.3, 0.8 ), ang = Angle( -0.5, -108.1, 179.8 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( 29.4, 47.6, 0.9 ), ang = Angle( -0.2, -107.7, -0.1 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 26.2, -49.4, 6.2 ), ang = Angle( -0.6, 11.6, -1.3 ) },
            { mdl = "models/props_vehicles/carparts_tire01a.mdl", wallsnap = true, pos = Vector( 5.5, -69.2, 6.1 ), ang = Angle( 0, -31.7, -90 ) },
            { mdl = "models/props_vehicles/carparts_door01a.mdl", wallsnap = true, pos = Vector( -71.3, 36.1, 20.8 ), ang = Angle( 0.8, 90.4, -2.7 ) },
        }
    },
    {
        dedication = 1,
        centerpiece = true,
        minsize = 200,
        furniture = {
            { mdl = "models/props_junk/garbage_carboard001a.mdl", pos = Vector( -9.1, -45.8, 1.1 ), ang = Angle( -0.1, 97.8, -0.3 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 27.5, 26.1, 2.5 ), ang = Angle( -64.6, 20.7, -90 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( 36.2, -12.5, 12.8 ), ang = Angle( 0, 90, 0 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( -51.4, -20.4, 11.9 ), ang = Angle( 0, 22.4, -0.6 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( -46.2, -71.5, 12 ), ang = Angle( -0.1, -163.1, 0 ) },
            { mdl = "models/props_junk/cinderblock01a.mdl", pos = Vector( 44, -55.5, 12.1 ), ang = Angle( 0.5, -86.3, 0.5 ) },
            { mdl = "models/props_junk/garbage_carboard002a.mdl", pos = Vector( -47.1, 17.4, 1.4 ), ang = Angle( 0.2, -164.6, 180 ) },
            { mdl = "models/props_vehicles/car002b_physics.mdl", drop = false, pos = Vector( -1.9, -41.2, 45 ), ang = Angle( -1.1, -170, -1.9 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( -27.4, 9.2, 20.4 ), ang = Angle( 0, -0.8, 0 ) },
            { mdl = "models/props_lab/reciever01a.mdl", pos = Vector( -29.8, 35.2, 44 ), ang = Angle( 0.2, -47.2, -0.1 ) },
            { mdl = "models/props_lab/partsbin01.mdl", wallsnap = true, pos = Vector( 7.9, 27.8, 13.8 ), ang = Angle( -0.3, -29.3, -0.1 ) },
            { mdl = "models/props_junk/meathook001a.mdl", pos = Vector( -17.8, -2.6, 42.8 ), ang = Angle( 89.5, 99.8, 29.7 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -35.3, -38.7, 18.8 ), ang = Angle( 0, 2.2, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_lab/reciever01a.mdl", pos = Vector( 6.5, -36.5, 43.8 ), ang = Angle( 0.2, 73.1, 0 ) },
            { mdl = "models/props_c17/furniturechair001a.mdl", pos = Vector( 31.2, -25.4, 46.5 ), ang = Angle( 62, 67.5, 179.9 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( 13.6, -24.2, 20.7 ), ang = Angle( 0, 89, 0 ) },
            { mdl = "models/props_junk/cardboard_box003b.mdl", wallsnap = true, pos = Vector( 27.1, 16.5, 8.5 ), ang = Angle( 0, 99.6, -0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -3.6, -33, 11.4 ), ang = Angle( 0.2, -2.9, -90 ) },
            { mdl = "models/props_c17/furnituretable002a.mdl", pos = Vector( -9.3, -28.8, 18.6 ), ang = Angle( 0, 90.5, -0.1 ) },
            { mdl = "models/props_c17/furnituredrawer002a.mdl", pos = Vector( -28.7, 6.9, 17.8 ), ang = Angle( 4.9, 5.2, 0 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( 6.2, -33.9, 40.8 ), ang = Angle( -89.2, 14.5, -69.6 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            blemish,
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( -20.1, -37.1, 20.6 ), ang = Angle( 0, 88.8, 0 ) },
            { mdl = "models/props_c17/furnituredresser001a.mdl", pos = Vector( 37.3, -7.7, 27.6 ), ang = Angle( 0, 176.7, 86.6 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( -20, 9, 3.4 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( -2.4, -18.9, 52.7 ), ang = Angle( -3.3, 92, -8.1 ) },
            { mdl = "models/props_junk/glassbottle01a.mdl", wallsnap = true, pos = Vector( 5.4, 46.9, 7.3 ), ang = Angle( 0.4, 163.4, 0.1 ) },
            { mdl = "models/props_junk/garbage_glassbottle002a.mdl", pos = Vector( 13.9, 39.6, 9.5 ), ang = Angle( 0.9, 159.9, -0.3 ) },
            { mdl = "models/props_junk/garbage_glassbottle002a.mdl", pos = Vector( 28.3, 43.9, 9.6 ), ang = Angle( 0.3, 34.9, -1 ) },
            { mdl = "models/props_junk/garbage_metalcan001a.mdl", pos = Vector( 7.3, 32.5, 4.8 ), ang = Angle( 1.3, 149.1, 2.2 ) },
            { mdl = "models/props_junk/garbage_glassbottle002a_chunk01.mdl", wallsnap = true, pos = Vector( -12.3, 38.7, 4.7 ), ang = Angle( -36.3, 120.4, 89.9 ) },
        }
    },
    {
        dedication = 1,
        minsize = 175,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( -45.9, 20.4, 20.6 ), ang = Angle( 0, -1.2, 0 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( 0.5, 19.2, 3.1 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( -30.3, 0.7, 45.4 ), ang = Angle( 0, 2.6, 0 ) },
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( -19.8, -43.9, 20.8 ), ang = Angle( 0, 90.5, 0 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", wallsnap = true, pos = Vector( 32.3, -54.4, 9 ), ang = Angle( 0.7, 5.6, -0.5 ) },
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( 10.3, -50.2, 44.5 ), ang = Angle( 0.1, 55.9, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            blemish,
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( -37.1, 20.2, 20.5 ), ang = Angle( 0, -1.2, 0 ) },
            { mdl = "models/props_c17/furnituredresser001a.mdl", pos = Vector( -7.3, -36.3, 27.6 ), ang = Angle( 0, 86.9, 86.6 ) },
            { mdl = "models/props_junk/garbage_glassbottle002a_chunk01.mdl", pos = Vector( 41.9, 13.7, 4.2 ), ang = Angle( -87, 40.5, 81.9 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a_chunk01.mdl", pos = Vector( 47.3, -14.5, 3 ), ang = Angle( 21.1, 116, -102.2 ) },
            { mdl = "models/props_junk/glassjug01_chunk01.mdl", pos = Vector( 49.6, -27.9, 4.4 ), ang = Angle( -0.8, 57.5, -0.4 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunka.mdl", pos = Vector( -6.6, -7.2, 53.3 ), ang = Angle( 15.9, 109.6, 0.3 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunkb3.mdl", pos = Vector( 31.4, 6.1, 2.2 ), ang = Angle( 88.5, 71.7, 0.2 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( -14.7, -15.9, 4.8 ), ang = Angle( 0, 19.1, 0 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( -22.4, -21, 29.2 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_wasteland/cafeteria_bench001a.mdl", pos = Vector( 1.5, 47.4, 7.7 ), ang = Angle( 87.8, -89.7, -179.8 ) },
            { mdl = "models/props_junk/propanecanister001a.mdl", pos = Vector( -36.7, 27.9, 7.3 ), ang = Angle( 66.9, 83.6, 90 ) },
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( 45.1, 28.7, 4 ), ang = Angle( 0.2, 133.9, 0.1 ) },
            { mdl = "models/props_junk/garbage_milkcarton001a.mdl", pos = Vector( -6.8, 39.5, 6.2 ), ang = Angle( 43, -115, 91.8 ) },
            { mdl = "models/props_junk/popcan01a.mdl", pos = Vector( 49.1, 19.3, 4.5 ), ang = Angle( 3.3, -78.6, -0.1 ) },
            { mdl = "models/props_junk/popcan01a.mdl", pos = Vector( 41, 15.6, 4.6 ), ang = Angle( 3.9, -68.9, -0.2 ) },
            { mdl = "models/props_junk/popcan01a.mdl", pos = Vector( 48.2, 12.2, 4.7 ), ang = Angle( 1.3, 150.3, -2.5 ) },
        }
    },
    {
        dedication = 1,
        minsize = 175,
        furniture = {
            { mdl = "models/props_wasteland/cafeteria_table001a.mdl", pos = Vector( 61.7, -13.7, 16.8 ), ang = Angle( 0.1, -179.8, 0 ) },
            { mdl = "models/props_wasteland/prison_sinkchunk001e.mdl", pos = Vector( 47.1, -70.5, 22.7 ), ang = Angle( 0.2, -150.6, 0.1 ) },
            { mdl = "models/props_c17/furnitureshelf001b.mdl", skin = 2, wallsnap = true, pos = Vector( 53.7, 30, 2.9 ), ang = Angle( 0.2, -86.4, 0.2 ) },
            { mdl = "models/props_c17/trappropeller_lever.mdl", pos = Vector( 53.2, -56.4, 32.5 ), ang = Angle( 0, -106.4, 2.3 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 48, -14.2, 40 ), ang = Angle( 0, 113.2, -0.1 ) },
            { mdl = "models/props_junk/glassjug01.mdl", pos = Vector( 52.2, 22.5, 32 ), ang = Angle( 0, 91.2, -0.1 ) },
            { mdl = "models/props_junk/glassjug01.mdl", pos = Vector( 57.7, 31.4, 32.1 ), ang = Angle( 0, -56.3, 0.1 ) },
            { mdl = "models/props_wasteland/prison_sinkchunk001e.mdl", pos = Vector( 56.8, -66.1, 23.5 ), ang = Angle( -0.6, -109.5, 0 ) },
            { mdl = "models/props_c17/furnitureshelf001b.mdl", skin = 1, wallsnap = true, pos = Vector( 63.7, 26, 1.5 ), ang = Angle( 0.1, -106.5, 0 ) },
            { mdl = "models/props_c17/furnitureshelf001b.mdl", skin = 1, wallsnap = true, pos = Vector( 63.7, 26, 2.5 ), ang = Angle( 0.2, -86.4, 0.1 ) },
            { mdl = "models/props_lab/bindergraylabel01b.mdl", pos = Vector( 61.4, -50.5, 33.9 ), ang = Angle( -1.7, -65.7, -89.9 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/furniturestove001a.mdl", pos = Vector( -29.1, -31.2, 20.5 ), ang = Angle( 0, 0.1, 0 ) },
            { mdl = "models/props_interiors/refrigerator01a.mdl", pos = Vector( 8.1, 28, 16.7 ), ang = Angle( 89.7, 91.9, 88.5 ) },
            { mdl = "models/props_junk/garbage_takeoutcarton001a.mdl", pos = Vector( 36.1, 37.3, 3.9 ), ang = Angle( 0, -4.1, 82.1 ) },
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", pos = Vector( 20.9, 34.1, 4 ), ang = Angle( 90, -89.1, 0 ) },
            { mdl = "models/props_junk/garbage_milkcarton001a.mdl", pos = Vector( -16.8, 29.2, 6.3 ), ang = Angle( -42.2, -176.5, 89.9 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", pos = Vector( -2.3, 35.7, 3.7 ), ang = Angle( -22.7, -167.6, 90.1 ) },
            { mdl = "models/props_debris/metal_panel01a.mdl", pos = Vector( -51.1, -2.5, 25.3 ), ang = Angle( 9.2, 0.3, 90.1 ) },
            { mdl = "models/props_junk/wood_pallet001a_chunka1.mdl", pos = Vector( -25, 3.4, 4.7 ), ang = Angle( 0.4, 70.5, 179.9 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/furniturebed001a.mdl", pos = Vector( 5.6, -37.4, 18.7 ), ang = Angle( 0, 174.8, 0 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( 5.8, -34.2, 16.4 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", pos = Vector( 32.5, 9.4, 20.7 ), ang = Angle( 0, 84, -0.1 ) },
            { mdl = "models/props_junk/metal_paintcan001a.mdl", pos = Vector( 1.1, -4.2, 7.4 ), ang = Angle( 0, 128.3, -0.3 ) },
        }
    },

    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", pos = Vector( 21.3, 16.6, 7.9 ), ang = Angle( 0, 179.4, 0 ) },
            { mdl = "models/props_junk/glassbottle01a.mdl", pos = Vector( 26.5, 24, 8.2 ), ang = Angle( 1.4, -172.2, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 25.6, 18.8, 9.9 ), ang = Angle( 0, 178.9, -0.1 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 17.6, 24.9, 10 ), ang = Angle( 0.1, -83.7, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 18.2, 13.1, 3.8 ), ang = Angle( 67.3, -13.5, 89.9 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 2, pos = Vector( -33, 28, 7.9 ), ang = Angle( 0, -142.3, 0 ) },
            { mdl = "models/props_junk/propanecanister001a.mdl", wallsnap = true, pos = Vector( 21.9, 40.9, 11.5 ), ang = Angle( 0.8, -149.2, 0.8 ) },
            { mdl = "models/props_junk/propanecanister001a.mdl", wallsnap = true, pos = Vector( 41.1, 31.9, 11.5 ), ang = Angle( -0.3, 172.5, -0.2 ) },
            { mdl = "models/props_junk/plasticbucket001a.mdl", pos = Vector( -32.7, 26.8, 8.1 ), ang = Angle( 0, -99.7, 0 ) },
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 2, pos = Vector( -6.1, 36.4, 8.3 ), ang = Angle( -0.4, 91.6, 0.2 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 4, pos = Vector( -25.3, 1.7, 7.9 ), ang = Angle( -0.1, 43.9, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( -24.2, 7.3, 10.1 ), ang = Angle( 1.3, -27.7, 1 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( -27.7, -1.5, 10.2 ), ang = Angle( -0.1, -27.5, 0.1 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -18.4, -0.6, 7.3 ), ang = Angle( 48.6, -53, -0.6 ) },
            { mdl = "models/props_junk/garbage_glassbottle002a.mdl", pos = Vector( -22.3, -6.1, 10.5 ), ang = Angle( 0, 75.5, -0.1 ) },
            { mdl = "models/props_junk/garbage_glassbottle002a.mdl", pos = Vector( -30.6, 5.1, 10.6 ), ang = Angle( -1.2, 76.3, 0.6 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 4, pos = Vector( 23.3, 18.2, 7.9 ), ang = Angle( 0, 64.7, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( 18.2, 19.7, 4.2 ), ang = Angle( -66.8, -62.5, 89.9 ) },
            { mdl = "models/props_junk/garbage_glassbottle002a.mdl", pos = Vector( 27.9, 17.2, 10.3 ), ang = Angle( 0.2, 115.6, -0.2 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = true, pos = Vector( -31.7, 23.7, 7.1 ), ang = Angle( 0, 76.2, -2.4 ) },
        }
    },

    {
        dedication = 1,
        disposition = 4,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 3, pos = Vector( 21.3, 16.6, 7.9 ), ang = Angle( 0, 179.4, 0 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( 24.9, 14.1, 2.9 ), ang = Angle( -0.1, 24.3, -90 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( 15.3, 10.9, 6.2 ), ang = Angle( 0, -179.4, 125.6 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( 24.2, 6.3, 7.4 ), ang = Angle( 40.3, -3.1, 0 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( 19.4, 18, 3.2 ), ang = Angle( -90, 98.5, 0 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( 25.8, 6.7, 7.9 ), ang = Angle( -0.8, 116.8, 179.2 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( 22.8, 20.8, 3.4 ), ang = Angle( -90, -75.4, 0 ) },
        }
    },
    {
        dedication = 1,
        disposition = 4,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( 12.5, -14.9, 7.8 ), ang = Angle( 0, 121.7, 0 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( 15.2, -13.8, 6.3 ), ang = Angle( -34.6, -14.5, 60.8 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( 9.2, -14.3, 7.6 ), ang = Angle( 0.2, 31.4, -43.4 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( 16.7, -11.7, 8.7 ), ang = Angle( -15, 3.6, -46.3 ) },
            { mdl = "models/healthvial.mdl", class = "item_healthvial", pos = Vector( 13.2, -14.9, 13.8 ), ang = Angle( -14.2, -66.6, 95.7 ) },
        }
    },
    {
        dedication = 1,
        disposition = 4,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = "?", pos = Vector( 0 + 25, 9.4 + 25, 8 ), ang = Angle( -0.1, -91.8, 0 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( 1.6 + 25, 13.4 + 25, 1.8 ), ang = Angle( 0, -8.1, -0.1 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( 8.5 + 25, 12.2 + 25, 1.9 ), ang = Angle( 0, 6.1, -0.1 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( -3.9 + 25, 5.8 + 25, 2 ), ang = Angle( 0.7, -27.3, 0.8 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( 7.5 + 25, 4.5 + 25, 2.1 ), ang = Angle( -0.3, -17.5, 0.1 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( 2.1 + 25, 7.1 + 25, 12.2 ), ang = Angle( -0.6, -107.4, 180 ) },
            { mdl = "models/items/boxsrounds.mdl", class = "item_ammo_pistol", pos = Vector( -20, 15.5, 4 ), ang = Angle( 88.9, -60.3, 178.1 ) },
        }
    },
    {
        dedication = 1,
        disposition = 3,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = "?", pos = Vector( -17, -17.1, 7.9 ), ang = Angle( 0.1, -162.5, 0.1 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( -17.7, -26.1, 1.7 ), ang = Angle( -0.1, 2.9, -0.2 ) },
            { mdl = "models/healthvial.mdl", class = "item_healthvial", pos = Vector( -17.4, -20.1, 3.5 ), ang = Angle( -45.6, 3.2, -89.1 ) },
        }
    },
    {
        dedication = 1,
        disposition = 3,
        nevercenterpiecefollower = true,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", pos = Vector( -16.3, -14.5, 7.8 ), ang = Angle( 0.1, 74.7, 179.7 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( -10.2, -19.9, 0.6 ), ang = Angle( 1, 0, -1.2 ) },
        }
    },
    {
        dedication = 1,
        disposition = 2,
        nevercenterpiecefollower = true,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( -16.1, -11.3, 7.9 ), ang = Angle( 0, -49.7, 179.9 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( -17.2, -20.2, 2.8 ), ang = Angle( 0, -27.1, -90 ) },
        }
    },
    {
        dedication = 1,
        disposition = 1,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = "?", pos = Vector( 0 + 25, 9.4 + 25, 8 ), ang = Angle( -0.1, -91.8, 0 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( 1.6 + 25, 13.4 + 25, 1.8 ), ang = Angle( 0, -8.1, -0.1 ) },
            { mdl = "models/items/battery.mdl", class = "item_battery", pos = Vector( 8.5 + 25, 12.2 + 25, 1.9 ), ang = Angle( 0, 6.1, -0.1 ) },
        }
    },
    {
        dedication = 1,
        disposition = 1,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 3, pos = Vector( 21.3, 16.6, 7.9 ), ang = Angle( 0, 179.4, 0 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( 24.9, 14.1, 2.9 ), ang = Angle( -0.1, 24.3, -90 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( 15.3, 10.9, 6.2 ), ang = Angle( 0, -179.4, 125.6 ) },
        }
    },
    {
        dedication = 1,
        disposition = 1,
        nevercenterpiecefollower = true,
        furniture = {
            { mdl = "models/props_junk/cardboard_box003a.mdl" },
        }
    },
    {
        dedication = 1,
        disposition = 1,
        nevercenterpiecefollower = true,
        furniture = {
            { mdl = "models/props_junk/cardboard_box003b.mdl", pos = Vector( 19.8, -25.2, 13.2 ), ang = Angle( -75.2, 95.4, -7 ) },
        }
    },

    {
        dedication = 1,
        minsize = 225,
        furniture = {
            { mdl = "models/buggy.mdl", pos = Vector( -22.1, 6.8, -11.4 ), ang = Angle( 0, 87.8, 1.4 ) },
            { mdl = "models/props_c17/trappropeller_engine.mdl", pos = Vector( 32.6, 59.5, 17.4 ), ang = Angle( 0.1, 121.7, -0.1 ) },
            { mdl = "models/props_c17/tools_wrench01a.mdl", pos = Vector( 8.5, 51.2, 0.6 ), ang = Angle( 0.9, 115.8, -0.2 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( -27.4, -25.5, 9.3 ), ang = Angle( -1.9, -90, 0.3 ) },
            { mdl = "models/props_lab/partsbin01.mdl", pos = Vector( -46.3, 65.7, 14 ), ang = Angle( 0.6, 84.6, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 175,
        furniture = {
            { mdl = "models/props_wasteland/laundry_cart001.mdl", pos = Vector( -46.6, 26.1, 20.1 ), ang = Angle( 0, -88.7, -0.1 ) },
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", wallsnap = true, pos = Vector( 55.3, 63, 8.8 ), ang = Angle( 0.3, -35.4, -0.3 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", class = "prop_physics", pos = Vector( 0, -35, 30 ), ang = Angle( 0, 93, 0 ), wallsnap = true },
            { mdl = "models/props_interiors/pot01a.mdl", class = "prop_physics", pos = Vector( 10, 20, 20 ), wallsnap = true },
            { mdl = "models/props_junk/garbage_bag001a.mdl", class = "prop_physics", pos = Vector( -10, 20, 20 ), wallsnap = true },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furniturechair001a.mdl", pos = Vector( -26.4, -13.7, 20.4 ), ang = Angle( -0.1, 42.3, -0.1 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", pos = Vector( 18.3, 8.9, 11.2 ), ang = Angle( 0, 174.2, 0 ) },
            { mdl = "models/props_c17/tv_monitor01.mdl", pos = Vector( 24.6, 19.6, 30.5 ), ang = Angle( 0, -135.7, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( 18.1, -3.6, 31 ), ang = Angle( 0.9, 143.1, 0.9 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/furniturechair001a.mdl", pos = Vector( -3.9, 30.6, 20.4 ), ang = Angle( 0, -28.1, 0 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", pos = Vector( 37.2, 2.3, 11.2 ), ang = Angle( 0, 165.6, 0 ) },
            { mdl = "models/props_c17/tv_monitor01.mdl", pos = Vector( 30.8, -7.9, 30.5 ), ang = Angle( 0, 124.6, 0 ) },
            { mdl = "models/props_junk/watermelon01_chunk01b.mdl", pos = Vector( 39.5, 18.7, 25.1 ), ang = Angle( 17.2, 133.5, -35.3 ) },
            { mdl = "models/props_junk/popcan01a.mdl", pos = Vector( 12.4, -15.2, 4.3 ), ang = Angle( -2, 140.9, -3.3 ) },
            { mdl = "models/props_junk/garbage_glassbottle002a_chunk02.mdl", pos = Vector( -23.1, 35.4, -2.3 ), ang = Angle( 12.8, 169.4, -39.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 32.9, -45.7, 15.1 ), ang = Angle( -0.1, 88.8, 0.1 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", pos = Vector( 11.5, -4.2, 11.1 ), ang = Angle( 0, -44.7, 0 ) },
            { mdl = "models/props_lab/partsbin01.mdl", pos = Vector( -18.3, 32.1, 13.8 ), ang = Angle( 0, -50.3, 0 ) },
            { mdl = "models/props_c17/tv_monitor01.mdl", pos = Vector( -17.3, 31.7, 35.4 ), ang = Angle( -0.4, -52.5, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", wallsnap = true, pos = Vector( 19.8, 34, 3.4 ), ang = Angle( 20.8, 45.5, -90.7 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", wallsnap = true, facewall = false, pos = Vector( -50.3, -7, 15.2 ), ang = Angle( 0, 18.5, 0 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", pos = Vector( 30.3, 23.2, 11.3 ), ang = Angle( 0, 177, 0 ) },
            { mdl = "models/props_lab/partsbin01.mdl", pos = Vector( -41, 27.4, 13.8 ), ang = Angle( -0.2, -86.9, 0 ) },
            { mdl = "models/props_c17/tv_monitor01.mdl", pos = Vector( 28.6, 27.6, 30.6 ), ang = Angle( 0.2, -163.2, 0 ) },
            { mdl = "models/props_junk/glassbottle01a.mdl", pos = Vector( -38.5, 28.5, 33.9 ), ang = Angle( -0.5, -75.3, -0.6 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( 29.8, 41.1, 8 ), ang = Angle( 0, 45.7, 180 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", wallsnap = true, pos = Vector( -29.5, 31.3, 13.8 ), ang = Angle( -79.8, 0.1, 0 ) },
            { mdl = "models/props_c17/tv_monitor01.mdl", pos = Vector( -12.3, 37.1, 7.7 ), ang = Angle( -89.9, 92.3, -144.2 ) },
            { mdl = "models/props_junk/garbage_carboard002a.mdl", wallsnap = true, pos = Vector( 5.9, 6.5, 1 ), ang = Angle( -0.2, 113.7, -180 ) },
            { mdl = "models/props_wasteland/prison_sinkchunk001e.mdl", pos = Vector( -5.8, 34.1, 6.6 ), ang = Angle( 0, -30.3, -0.1 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 25.3, 51.2, 24.5 ), ang = Angle( -0.9, -3, -0.9 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/furniturearmchair001a.mdl", pos = Vector( -28, -78.1, 0.8 ), ang = Angle( 0.1, 39.3, 0 ) },
            { mdl = "models/props_c17/oildrum001.mdl", pos = Vector( -32.3, 29.2, 0.7 ), ang = Angle( 0, 14, 0 ) },
            { mdl = "models/props_c17/furnituretable001a.mdl", pos = Vector( 12.7, -9.5, 18.7 ), ang = Angle( 0, -170.7, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( 22, -10.9, 37.8 ), ang = Angle( 0, -157.9, 0 ) },
            { mdl = "models/props_junk/garbage_carboard002a.mdl", pos = Vector( -46.5, -11, 0.7 ), ang = Angle( -0.3, -50.3, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -11.1, -27.5, 72 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/furniturearmchair001a.mdl", pos = Vector( -28, -78.1, 0.8 ), ang = Angle( 0.1, 39.3, 0.1 ) },
            { mdl = "models/props_c17/oildrum001.mdl", pos = Vector( -32.3, 29.2, 0.7 ), ang = Angle( 0, 14, 0 ) },
            { mdl = "models/props_c17/furnituretable001a.mdl", pos = Vector( 12.7, -9.3, 18.7 ), ang = Angle( 0, -170.7, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( 22, -10.7, 37.7 ), ang = Angle( -0.1, -158, 0 ) },
            { mdl = "models/props_junk/garbage_carboard002a.mdl", pos = Vector( -46.5, -11, 0.7 ), ang = Angle( -0.3, -50.3, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a.mdl", pos = Vector( -19.8, -19, 20.5 ), ang = Angle( 0, 13, 0 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( -5.3, 25.2, 3.2 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( 21.7, -24.1, 6 ), ang = Angle( 1, 20.5, -0.2 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 9.2, -22.5, 3.6 ), ang = Angle( -0.2, 26.6, -0.4 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( 12.5, -13.2, 9.3 ), ang = Angle( -0.1, 18.6, 0.1 ) },
        }
    },{
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/cardboard_box003a.mdl", pos = Vector( 30.2, -7.3, 10.1 ), ang = Angle( -0.1, -77.4, 0 ) },
            { mdl = "models/props_junk/cardboard_box003a.mdl", pos = Vector( 31, -44.5, 10.2 ), ang = Angle( -0.3, 13, 0 ) },
            { mdl = "models/props_junk/cardboard_box003a.mdl", pos = Vector( 30.3, -16.6, 24.7 ), ang = Angle( -0.1, -19.4, -0.2 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( 36, -41.9, 23.2 ), ang = Angle( 0.4, -136.2, -0.3 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/cardboard_box003a.mdl", wallsnap = true, pos = Vector( 47.6, -40.8, 10.2 ), ang = Angle( 0, 156.9, -0.1 ) },
            { mdl = "models/props_junk/cardboard_box003a.mdl", pos = Vector( 41.1, 56.6, 10.3 ), ang = Angle( 0, -89.7, 0 ) },
            { mdl = "models/props_junk/cardboard_box003b.mdl", pos = Vector( 46.8, 27.1, 8.6 ), ang = Angle( 0.1, -88.5, 0 ) },
            { mdl = "models/props_junk/cardboard_box004a.mdl", pos = Vector( 47.7, 26.1, 20.9 ), ang = Angle( 2.5, -146, -7.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 175,
        furniture = {
            { mdl = "models/props_wasteland/cafeteria_table001a.mdl", pos = Vector( 59.1, -24.7, 15.9 ), ang = Angle( 0, -180, 0 ) },
            { mdl = "models/props_junk/metal_paintcan001b.mdl", pos = Vector( 55.4, -48.5, 7.1 ), ang = Angle( -0.2, -137.3, 0.1 ) },
            { mdl = "models/props_junk/metal_paintcan001a.mdl", pos = Vector( 62.1, -64.1, 38.3 ), ang = Angle( 0.2, -135.9, -0.2 ) },
            { mdl = "models/props_junk/glassjug01.mdl", pos = Vector( 60.4, 10.3, 31.8 ), ang = Angle( -1.9, 14.6, -0.7 ) },
            { mdl = "models/props_junk/metal_paintcan001b.mdl", wallsnap = true, pos = Vector( 64.4, -62.2, 7.4 ), ang = Angle( -0.1, 158.6, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furnituretable001a.mdl", pos = Vector( -10.8, -23, 18.5 ), ang = Angle( 0, 23.6, 0 ) },
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( -27, 15.7, 15.3 ), ang = Angle( 0.1, -18.5, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( -7.5, -31, 37.7 ), ang = Angle( 0, 70.6, 0 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", pos = Vector( -11.7, -12.3, 22 ), ang = Angle( 0, 24.8, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -6.3, 0.2, 25.5 ), ang = Angle( 0.3, 15.6, 0.3 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", pos = Vector( 9.1, -13.2, 21.9 ), ang = Angle( 0, 100.2, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = true, pos = Vector( -28.4, 27.3, 8.6 ), ang = Angle( -0.4, 104, 0 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", pos = Vector( 7.5, -6.7, 21.9 ), ang = Angle( 0, 167.1, 0 ) },
            { mdl = "models/props_junk/glassbottle01a.mdl", pos = Vector( 0.3, -13.8, 18.7 ), ang = Angle( 24.7, 112.8, -91.1 ) },
            { mdl = "models/props_junk/garbage_takeoutcarton001a.mdl", wallsnap = true, pos = Vector( -27.5, 30.6, 4 ), ang = Angle( -81.7, 162.7, -0.6 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", pos = Vector( 7.3, -6.9, 21.9 ), ang = Angle( 0, 167.1, 0 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( 11.2, -7.7, 3.4 ), ang = Angle( -0.7, 19.9, 2.7 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( -4.5, -14.4, 20.3 ), ang = Angle( -1.5, 137.3, -0.1 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", pos = Vector( 9.1, -13.2, 21.9 ), ang = Angle( 0, 100.2, 0 ) },
            { mdl = "models/props_junk/garbage_metalcan001a.mdl", pos = Vector( 16.3, -5.8, 21 ), ang = Angle( 0, 123.7, -0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_interiors/furniture_chair01a.mdl", pos = Vector( -5.4, 31.9, 21.5 ), ang = Angle( 0, -68.1, 0 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( -7.9, 33.3, 5.9 ), ang = Angle( 0.2, -46.3, 1.2 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( -17.7, 11.1, 3.5 ), ang = Angle( -0.2, -102.5, -0.3 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/furnituretable003a.mdl", pos = Vector( -33.3, 16, 11.1 ), ang = Angle( 0, -18.3, 0 ) },
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( 13.8, -19.7, 4.9 ), ang = Angle( 0, -100.5, 0 ) },
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( 23.4, -14.5, 11.8 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( -3.1, 8.7, 17.7 ), ang = Angle( -0.2, -48.8, 0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( -3.4, -19.2, 3.1 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( -25.2, 18.3, 0.6 ), ang = Angle( 0, -40.6, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 37.6, -4.5, 15.2 ), ang = Angle( 0.1, -164.1, -0.1 ) },
            { mdl = "models/props_c17/furnituretable003a.mdl", pos = Vector( -10.3, 24.9, 11.2 ), ang = Angle( -0.1, -87.7, 0 ) },
            { mdl = "models/props_junk/garbage_newspaper001a.mdl", pos = Vector( -24.6, 19.5, 24.2 ), ang = Angle( 0.7, -112.6, 0 ) },
            { mdl = "models/props_junk/garbage_milkcarton001a.mdl", pos = Vector( 2.6, 26.2, 30.4 ), ang = Angle( -0.9, -111.6, -0.5 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( 1.7, 20.3, 3.1 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_lab/monitor01b.mdl", pos = Vector( 8.8, -22, 6.2 ), ang = Angle( -7.8, 92.1, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = true, pos = Vector( -2.6, -19.8, 8.8 ), ang = Angle( 1.3, -163.3, 2.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furniturecouch002a.mdl", pos = Vector( -16.3, -15.1, 19.2 ), ang = Angle( 0, 46, 0 ) },
            { mdl = "models/props_junk/garbage_takeoutcarton001a.mdl", pos = Vector( 14, -39.1, 3.8 ), ang = Angle( 0.2, 124.3, 81.5 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 13.6, 1.9, 21.6 ), ang = Angle( 51, -89.8, -178.7 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furnituretable003a.mdl", pos = Vector( 22.6, -11.9, 11.1 ), ang = Angle( 0, 163.2, -0.1 ) },
            { mdl = "models/props_c17/tv_monitor01.mdl", pos = Vector( 23.1, -19.4, 30.4 ), ang = Angle( 0.4, 131.4, 0.2 ) },
            { mdl = "models/props_interiors/furniture_chair01a.mdl", pos = Vector( -18.3, 22.9, 21.7 ), ang = Angle( 0, -42.7, 0.1 ) },
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", wallsnap = true, pos = Vector( -22.3, -2.9, 9.1 ), ang = Angle( 1.2, -92.7, -1.3 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/player/police.mdl", class = "player", pos = Vector( -78.3, -77.2, 42.9 ), ang = Angle( 0, 48.7, 0 ) },
            { mdl = "models/props_junk/pushcart01a.mdl", pos = Vector( -13.4, 20.9, 22 ), ang = Angle( 0, 174.2, -93.7 ) },
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 2, pos = Vector( -24.9, 12.8, 8.2 ), ang = Angle( 0, 78.3, -180 ) },
            { mdl = "models/props_junk/watermelon01_chunk01c.mdl", wallsnap = true, pos = Vector( 0.1, 16.1, 5.3 ), ang = Angle( 15, -11.5, -110.7 ) },
            { mdl = "models/props_junk/watermelon01_chunk02b.mdl", pos = Vector( -31.2, 10.3, -0.3 ), ang = Angle( 2.2, -143.4, 20.9 ) },
            { mdl = "models/props_junk/glassjug01_chunk02.mdl", pos = Vector( -26.1, 25.3, 1.9 ), ang = Angle( -24.1, 9.8, 11 ) },
            { mdl = "models/props_junk/glassjug01_chunk03.mdl", pos = Vector( -1.3, 5.9, 1.9 ), ang = Angle( -33.7, -0.5, 2.3 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( 19.6, 29.2, 20.5 ), ang = Angle( 0, -97.3, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( 27.9, 34.6, 40.9 ), ang = Angle( 0, -102.6, -0.2 ) },
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -33.7, -32.5, -2.7 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_wasteland/controlroom_chair001a.mdl", pos = Vector( 36.3, -16.2, 20.8 ), ang = Angle( -0.1, -166.3, 0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( 11.5, 22.4, 20.6 ), ang = Angle( 0, -94, 0 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -34.4, 34.5, 18.5 ), ang = Angle( 0, -88, -0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( 18.7, -31.2, 20.5 ), ang = Angle( 0, 91.4, 0.1 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -29.8, -38.9, 18.5 ), ang = Angle( 0, 94, -0.2 ) },
            { mdl = "models/props_junk/cardboard_box004a.mdl", wallsnap = true, facewall = false, pos = Vector( 51.2, 47.6, 4.8 ), ang = Angle( -0.4, -173.4, 0.9 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 2, -46.1, 18.4 ), ang = Angle( 0, 88.4, 0 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", pos = Vector( 35.8, -32.3, 20.7 ), ang = Angle( 0, 89.5, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 39.7, 0.1, 18.4 ), ang = Angle( 0, 90.7, 0 ) },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", pos = Vector( 35.8, -32.3, 20.7 ), ang = Angle( 0, 89.5, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( -20.8, -8.9, 20.4 ), ang = Angle( 0, -6.9, 0 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( -18.8, -14.8, 51.8 ), ang = Angle( -0.1, -11.3, -90 ) },
        }
    },
    {
        dedication = 1,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 49.9, -22, 15.2 ), ang = Angle( 0.1, 160.4, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( 27.6, 32.3, 0.6 ), ang = Angle( 0.1, -118.5, 0.2 ) },
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -34.3, 22, -2.7 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 2.7, -20.4, 18.5 ), ang = Angle( 0, 0.4, 0 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( 1.9, -20.9, 34.2 ), ang = Angle( 2.6, 93.8, 0.6 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 24.8, -24.5, 18.4 ), ang = Angle( 0, -61.2, 0.1 ) },
            { mdl = "models/maxofs2d/camera.mdl", pos = Vector( 24.3, -22.9, 34.2 ), ang = Angle( 3.6, 133.3, 0.4 ) },
            { mdl = "models/props_interiors/furniture_chair03a.mdl", pos = Vector( -30.6, 26.3, 20 ), ang = Angle( 0.3, -41.9, -0.1 ) },
        }
    },

    {
        dedication = 1,
        minsize = 125,
        maxsize = 175,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( -21.3, -29.9, 20.6 ), ang = Angle( 0, -86.1, 0 ) },
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( -26.1, 12.5, 29.4 ), ang = Angle( 0.1, 179.9, -139.4 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        maxsize = 150,
        furniture = {
            { mdl = "models/props_junk/wood_crate002a.mdl", pos = Vector( 30.8, -1, 20.6 ), ang = Angle( 0, 2.4, 0 ) },
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( -10.8, 1.7, 27.6 ), ang = Angle( 0, -87.7, -139.2 ) },
        }
    },
    {
        dedication = 1,
        minsize = 150,
        maxsize = 200,
        furniture = {
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( 14.8, 22, 4.8 ), ang = Angle( 0, -179.4, -0.1 ) },
            { mdl = "models/props_lab/filecabinet02.mdl", pos = Vector( 28.1, 33, 24.1 ), ang = Angle( 0, -178.9, -0.4 ) },
        }
    },
    {
        dedication = 1,
        minsize = 150,
        maxsize = 200,
        furniture = {
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( 15.3, 21.4, 4.8 ), ang = Angle( 0, -179.2, 0 ) },
            { mdl = "models/props_wasteland/prison_shelf002a.mdl", pos = Vector( 31.3, 1, 27 ), ang = Angle( 0, -179.1, 0.2 ) },
        }
    },
    {
        dedication = 1,
        minsize = 150,
        maxsize = 200,
        furniture = {
            { mdl = "models/props_junk/wood_pallet001a.mdl", pos = Vector( 17.9, 11.2, 4.8 ), ang = Angle( 0, -175.1, 0 ) },
            { mdl = "models/props_junk/gascan001a.mdl", pos = Vector( 29.7, -7.6, 13.1 ), ang = Angle( 90, -167.7, 0 ) },
            { mdl = "models/props_c17/tv_monitor01.mdl", wallsnap = true, pos = Vector( 4.4, 21.6, 16.2 ), ang = Angle( -89.7, -50.5, -147.9 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_pallet001a.mdl", wallsnap = true, pos = Vector( -29, -8.2, 37.9 ), ang = Angle( 0, 90.1, 80.2 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wheebarrow01a.mdl", wallsnap = true, pos = Vector( -29, 11.7, 15.1 ), ang = Angle( 1.7, 73.9, 80.6 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_junk/cardboard_box003a.mdl", wallsnap = true ,facewall = false, pos = Vector( 17.5, -27, 10.2 ), ang = Angle( 0.1, 92.3, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", wallsnap = true, pos = Vector( -22.4, 27.3, 9 ), ang = Angle( -0.1, 0.9, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/cardboard_box002a.mdl", pos = Vector( -1.9, 36.7, 12.4 ), ang = Angle( 0.1, -1, 0 ) },
            { mdl = "models/props_junk/cardboard_box001a.mdl", pos = Vector( 40.5, -2.1, 12.7 ), ang = Angle( 0, 1.3, 0 ) },
            { mdl = "models/props_junk/cardboard_box003b.mdl", pos = Vector( 41.9, -2.2, 33.1 ), ang = Angle( 0, -2.6, 0 ) },
            { mdl = "models/props_junk/cardboard_box001b.mdl", pos = Vector( 33.7, 36.1, 14.3 ), ang = Angle( 0, 3.1, 0 ) },
        }
    },
    {
        dedication = 1, -- dust2
        notedetail = 3,
        furniture = {
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", skin = 1, pos = Vector( -0.3, -2.2, -1.6 ), ang = Angle( -21.7, 146.6, -90.7 ) },
            { mdl = "models/props_junk/garbage_plasticbottle001a.mdl", wallsnap = true, pos = Vector( -18.7, -20.4, 2.9 ), ang = Angle( 32.7, 24.6, -84.9 ) },
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 1, skipchance = 75, pos = Vector( -35.5, 11.5, 8.7 ), ang = Angle( 81.6, -165.7, 21.2 ) },
            { mdl = "models/props_junk/plasticbucket001a.mdl", wallsnap = true, pos = Vector( -12, 18.4, 3.6 ), ang = Angle( 20.1, -94, 83.6 ) },
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", skipchance = 50, pos = Vector( -13.8, 31.2, 0.2 ), ang = Angle( 0.6, -96.2, -94.5 ) },
            { mdl = "models/props_junk/plasticcrate01a.mdl", wallsnap = true, skipchance = 50, pos = Vector( 6.5, -13.8, 3.9 ), ang = Angle( -1.2, 131.1, 1.3 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", wallsnap = true, skin = 1, pos = Vector( 27.4, -10.8, -1.2 ), ang = Angle( 68.8, 99.7, -88.6 ) },
        }
    },
    {
        dedication = 1, -- dust2
        notedetail = 2,
        furniture = {
            { mdl = "models/props_junk/garbage_plasticbottle001a.mdl", pos = Vector( 6.6, -15, 5.1 ), ang = Angle( 67.3, 125.8, 88.9 ) },
            { mdl = "models/props_junk/plasticbucket001a.mdl", wallsnap = true, skipchance = 50, pos = Vector( -18.3, -7.8, 6.9 ), ang = Angle( -22.1, -83.8, 89.3 ) },
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", pos = Vector( -26.9, 6.5, 3.6 ), ang = Angle( -0.2, 94, 89.7 ) },
            { mdl = "models/props_junk/plasticcrate01a.mdl", wallsnap = true, pos = Vector( 0.1, 15.1, 9.7 ), ang = Angle( 89.8, 11, 94.8 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", wallsnap = true, skin = 1, pos = Vector( 14.8, 27.9, 3.8 ), ang = Angle( -22.5, -174.5, -90.2 ) },
        }
    },
    {
        dedication = 1, -- dust2
        notedetail = 1,
        furniture = {
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", skin = 1, pos = Vector( -16, 7.5, 2.8 ), ang = Angle( 64.1, -22.3, 90.4 ) },
            { mdl = "models/props_junk/garbage_plasticbottle001a.mdl", wallsnap = true, pos = Vector( -29.3, -16.4, 4.6 ), ang = Angle( 22.1, 26.9, -90.6 ) },
            { mdl = "models/props_junk/plasticbucket001a.mdl", wallsnap = true, skipchance = 50, pos = Vector( -17.2, 20.5, 6.8 ), ang = Angle( 23.3, -92.1, 89.9 ) },
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", pos = Vector( -20.1, 31.2, 3.1 ), ang = Angle( -0.7, -97.6, -89.3 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", wallsnap = true, skin = 1, pos = Vector( -0.6, 2.4, 3.5 ), ang = Angle( -66.8, 36.1, 88.5 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_junk/cardboard_box003b.mdl", wallsnap = true, pos = Vector( -17.5, -19.5, 8.3 ), ang = Angle( -0.3, 110.4, 0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 175,
        furniture = {
            { mdl = "models/props_junk/trashdumpster02b.mdl", pos = Vector( -44.6, 17.4, 2.2 ), ang = Angle( 0, -2.5, 0.1 ) },
            { mdl = "models/props_junk/garbage_metalcan002a.mdl", wallsnap = true, pos = Vector( 47.1, 77.2, 4.2 ), ang = Angle( 2.2, -4.4, -0.8 ) },
        }
    },


    {
        dedication = 1,
        likessky = true,
        nevercenterpiecefollower = true,
        furniture = {
            { mdl = "models/seagull.mdl", class = "npc_seagull", schizophrenic = 100, wallsnap = false },
        }
    },
    {
        dedication = 1,
        likessky = true,
        nevercenterpiecefollower = true,
        furniture = {
            { mdl = "models/props_trainstation/trashcan_indoor001a.mdl", schizophrenic = 100, schizobarelyappear = true, wallsnap = false },
        }
    },
    {
        dedication = 1,
        likessky = true,
        nevercenterpiecefollower = true,
        furniture = {
            trashdecal1,
            { mdl = "models/props_trainstation/trashcan_indoor001b.mdl", schizophrenic = 100, schizobarelyappear = true, wallsnap = false },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            blood,
            { mdl = "models/seagull.mdl", class = "prop_ragdoll" },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", wallsnap = true, facewall = false, pos = Vector( 22.1, 13.6, 7.9 ), ang = Angle( -0.1, -178.4, 0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 175,
        furniture = {
            { mdl = "models/props_wasteland/cafeteria_table001a.mdl", wallsnap = true, facewall = false },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/bicycle01a.mdl", wallsnap = true, pos = Vector( 7.7, 3.6, 6 ), ang = Angle( 0.1, -141, 77.2 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch02a.mdl", wallsnap = true, pos = Vector( 1.7, 4.1, 12.6 ), ang = Angle( 29.4, 90.1, -180 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_c17/furniturearmchair001a.mdl", pos = Vector( -8.8, -13.9, 41 ), ang = Angle( 21.4, 110.6, -180 ) },
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", pos = Vector( 14, 9, 1.3 ), ang = Angle( -0.6, 26.5, -0.3 ) },
            { mdl = "models/props_c17/briefcase001a.mdl", wallsnap = true, skipchance = 50, pos = Vector( -27.1, 26.1, 9.2 ), ang = Angle( 0.3, 53.1, -0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furniturearmchair001a.mdl", wallsnap = true, pos = Vector( 24.1, 41.9, 41 ), ang = Angle( 21.4, -50.2, 179.7 ) },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_interiors/furniture_couch01a.mdl", wallsnap = true, pos = Vector( -0.3, -0.9, 12.1 ), ang = Angle( 32, 42, 180 ) },
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", wallsnap = true, pos = Vector( -32.9, -34.4, 8.9 ), ang = Angle( 1.2, 156, -1.3 ) },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_junk/watermelon01_chunk01a.mdl" },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_junk/watermelon01_chunk01b.mdl" },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_junk/watermelon01_chunk01c.mdl" },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_junk/garbage_newspaper001a.mdl", pos = Vector( -19.4, -8.1, 2.2 ), ang = Angle( 0.8, 6.3, -0.2 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( 14.4, 23.3, 5.8 ), ang = Angle( -0.7, 11.8, -0.5 ), wallsnap = true },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_junk/bicycle01a.mdl" },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_interiors/Furniture_Couch02a.mdl" },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_wasteland/prison_sink001b.mdl" },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_wasteland/prison_padlock001a.mdl" },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/pushcart01a.mdl", pos = Vector( 4.4, -0.9, 21.9 ), ang = Angle( 0, 0.1, -93.8 ), wallsnap = true },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 4.4, -0.9, 40 ), wallsnap = true, facewall = false },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 4.4, -0.9, 40 ), wallsnap = true, facewall = true },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_wasteland/controlroom_chair001a.mdl", wallsnap = true, facewall = false },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_wasteland/controlroom_chair001a.mdl", wallsnap = true, facewall = true },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_c17/furniturewashingmachine001a.mdl", pos = Vector( 12.2, 4.6, 35 ), wallsnap = true, facewall = false },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_c17/furnituredrawer002a.mdl", pos = Vector( 12.2, 4.6, 8.3 ), ang = Angle( 84.8, -160.9, -0.5 ), wallsnap = true },
        }
    },
    {
        dedication = 1,
        furniture = {
            { mdl = "models/props_c17/furniturearmchair001a.mdl", pos = Vector( -21, -35.6, -18.2 ), ang = Angle( 0, 112.2, 89.8 ), wallsnap = true },
        }
    },
    {
        dedication = 1,
        minsize = 100,
        furniture = {
            { mdl = function() return "models/props_wasteland/barricade001a_chunk0" .. math.random( 1, 5 ) .. ".mdl" end },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/wood_pallet001a.mdl" },
        }
    },


    {
        dedication = 1,
        skyagnostic = true,
        furniture = {
            himdecalfaded,
        }
    },
    {
        dedication = 1,
        skyagnostic = true,
        furniture = {
            gulldecal,
        }
    },
    {
        dedication = 1,
        furniture = {
            wallmandecal,
        }
    },
    {
        dedication = 1,
        notedetail = 2,
        furniture = {
            enddecal,
        }
    },
    {
        dedication = 1,
        furniture = {
            { class = "infodecal", pos = 10, drop = false, wallsnap = true, facewall = true, keys = { texture = "decals/decalgraffiti038a" } },
        }
    },
    {
        dedication = 1,
        minsize = 125,
        notedetail = 2,
        skyagnostic = true,
        furniture = {
            shrinedecal,
        }
    },
    {
        dedication = 1,
        minsize = 125,
        furniture = {
            realfakedoordecal,
            trashdecalrand,
        }
    },
    {
        dedication = 1,
        likessky = true,
        randomlychoose1 = true,
        furniture = {
            trashdecal1,
            trashdecal2,
            trashdecal3,
        }
    },


    {
        dedication = 0,
        centerpiece = true,
        furniture = {
            { mdl = "models/player/corpse1.mdl", class = "terminator_nextbot_homeless", wallsnap = false, pos = Vector( -3.4, 2.5, 0.1 ), ang = Angle( 0, -152.6, 0 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( 0, 30, 0 ) },
            { mdl = "models/Humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( 0, 0, 30 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll" },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( -4.6, -10.7, 3.1 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( -3.3, -13.3, 60 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/garbage_plasticbottle003a.mdl", pos = Vector( -17.1, 9.7, 11.4 ), ang = Angle( 0.1, -75.6, 0 ) },
            { mdl = "models/humans/corpse1.mdl", class = "prop_ragdoll", pos = Vector( 6.7, -4.8, 41.8 ), ang = Angle( 0, 0, 0 ) },
        }
    },

    {
        dedication = 0,
        likessky = true,
        nevercenterpiecefollower = true,
        minsize = 200,
        furniture = {
            trashdecal1,
            { mdl = "models/props_trainstation/trashcan_indoor001a.mdl", schizophrenic = 100, schizobarelyappear = true, wallsnap = false },
        }
    },
    {
        dedication = 0,
        likessky = true,
        nevercenterpiecefollower = true,
        minsize = 200,
        furniture = {
            { mdl = "models/props_trainstation/trashcan_indoor001b.mdl", schizophrenic = 100, schizobarelyappear = true, wallsnap = false },
        }
    },
    {
        dedication = 0,
        likessky = true,
        nevercenterpiecefollower = true,
        furniture = {
            { mdl = "models/seagull.mdl", class = "npc_seagull", schizophrenic = 100, wallsnap = false },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_c17/furnituremattress001a.mdl", class = "prop_ragdoll", pos = Vector( -4.6, -10.7, 3.1 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 0,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/trashbin01a.mdl", pos = Vector( 10.7, 48.4, 11.6 ), ang = Angle( -0.2, -91.9, 87.7 ) },
            { mdl = "models/props_junk/garbage_newspaper001a.mdl", pos = Vector( -48.7, 38.3, 2.3 ), ang = Angle( 0.8, -54.3, 0.2 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 26.3, 20.9, 5.9 ), ang = Angle( -0.5, -105.5, -0.3 ) },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a.mdl", wallsnap = true, pos = Vector( -17.3, -17.4, 20.4 ), ang = Angle( 0.2, 2.2, -0.2 ) },
            { mdl = "models/props_junk/trashbin01a.mdl", pos = Vector( -25.5, 22.5, 20.5 ), ang = Angle( 0.3, -6.1, -0.2 ) },
        }
    },
    {
        dedication = 0,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/garbage_newspaper001a.mdl", pos = Vector( -46.1, 46.8, 2.1 ), ang = Angle( 0.7, -23.2, -0.1 ), wallsnap = true },
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( 42.1, -36.4, 5.8 ), ang = Angle( -0.5, -10.2, -1.1 ), wallsnap = true },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a_chunk09.mdl", pos = Vector( -13.9, 21.3, 2.4 ), ang = Angle( -3.9, 74.7, 0 ), wallsnap = true },
            { mdl = "models/props_junk/wood_crate001a_chunk01.mdl", pos = Vector( 23.1, -14.9, 1.7 ), ang = Angle( 0, 72.8, -0.1 ) },
            { mdl = "models/props_junk/wood_crate001a_chunk02.mdl", pos = Vector( 20.4, 20.1, 6.6 ), ang = Angle( -0.1, -178.3, -89.9 ) },
            { mdl = "models/props_junk/wood_crate001a_chunk01.mdl", pos = Vector( -29.7, -25, 1.9 ), ang = Angle( 0, 5, 0 ) },
            { mdl = "models/props_junk/wood_crate001a_chunk04.mdl", pos = Vector( 34.1, 10.9, 6.1 ), ang = Angle( -86, 3.6, -149.5 ) },
            { mdl = "models/props_c17/metalpot002a.mdl", pos = Vector( 16.9, 25.9, 10.9 ), ang = Angle( 9.1, -34.5, -178.6 ) },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a_chunk09.mdl", pos = Vector( 13.1, -27.7, 2.4 ), ang = Angle( -4, 31.4, 0 ), wallsnap = true },
            { mdl = "models/props_junk/wood_crate001a_chunk02.mdl", pos = Vector( -12.6, 14.7, 15.9 ), ang = Angle( -0.1, 32.2, 0.2 ) },
            { mdl = "models/props_junk/wood_crate001a_chunk04.mdl", pos = Vector( 30.6, 33.4, 1 ), ang = Angle( 88.1, 31.5, 2.5 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a_chunk05.mdl", pos = Vector( 8.1, 11.4, 1 ), ang = Angle( 0, -6.2, 0.4 ), wallsnap = true },
            { mdl = "models/props_junk/wood_crate001a_chunk04.mdl", pos = Vector( -7, 4, 3.4 ), ang = Angle( -87.1, -104.2, 89.1 ), wallsnap = true },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a_chunk02.mdl", pos = Vector( -32.6, -23.4, 15.7 ), ang = Angle( 0, 85.3, 0 ), wallsnap = true },
            { mdl = "models/props_junk/wood_crate001a_chunk03.mdl", pos = Vector( 18, 25.3, 1.5 ), ang = Angle( -0.1, 177.6, -90.2 ), wallsnap = true },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a_chunk04.mdl", pos = Vector( -27.1, -23.6, 0.8 ), ang = Angle( 88.1, 90.4, 0.9 ), wallsnap = true },
            { mdl = "models/props_junk/wood_crate001a_chunk05.mdl", pos = Vector( 21.7, 22.1, 1.1 ), ang = Angle( -0.1, 95.7, 1.4 ), wallsnap = true },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a_chunk06.mdl" },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_pallet001a_chunka.mdl" },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/cardboard_box001a.mdl", pos = Vector( -18.2, -24.4, 12.5 ), ang = Angle( 0, 76.2, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( -16.7, -16.9, 35.1 ), ang = Angle( -89.9, 59.5, 0 ) },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( -23.4, -11.6, 28 ), ang = Angle( -0.1, 42.1, 0 ) },
            { mdl = "models/props_junk/cardboard_box002a.mdl", pos = Vector( -19.1, -12.1, 12.7 ), ang = Angle( 0, -0.7, 0 ) },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_debris/metal_panel02a.mdl", pos = Vector( -4.5, -21.4, 5.1 ), ang = Angle( -87.1, -3.9, 0.8 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, class = "homeless_radio", pos = Vector( -15.2, -24.9, 9.8 ), ang = Angle( -0.4, 81.2, -2.7 ) },
        }
    },
    {
        dedication = 0,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/chair02a.mdl", pos = Vector( 18.8, -35.7, -4.3 ), ang = Angle( -87.1, -104.1, -179.1 ) },
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, pos = Vector( -32.4, 23.5, 17.7 ), ang = Angle( 0, -122.2, -180 ) },
            { mdl = "models/props_junk/shoe001a.mdl", pos = Vector( 8, 7.3, 5.6 ), ang = Angle( -0.2, -146.4, -0.1 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_lab/citizenradio.mdl", schizophrenic = 10, wallsnap = true, facewall = false },
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", pos = Vector( 21.8, -34.4, 1.9 ), ang = Angle( 0.3, -162.8, -0.5 ), wallsnap = true },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_debris/metal_panel02a.mdl", wallsnap = true, pos = Vector( 14, -11.6, 5.3 ), ang = Angle( -87, -7.9, 10 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_c17/metalpot001a.mdl" },
        }
    },
    {
        dedication = 0,
        minsize = 125,
        furniture = {
            { mdl = "models/props_c17/tv_monitor01.mdl", pos = Vector( 25.3, 34, 8.4 ), ang = Angle( 0, -69.4, -0.1 ) },
            { mdl = "models/props_junk/garbage_newspaper001a.mdl", pos = Vector( -7.6, 13, 2.2 ), ang = Angle( 0.8, -3.4, 0.1 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( -19.1, -21.2, 5.8 ), ang = Angle( 0, 159.7, -0.1 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 20.8, -17.9, 2.6 ), ang = Angle( -21.5, 48.5, 90 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_lab/monitor01b.mdl", pos = Vector( 15.5, -14.4, 6 ), ang = Angle( -7.4, 157.4, 0 ), facewall = false, wallsnap = true },
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl", pos = Vector( -8.6, 9.2, 20.6 ), ang = Angle( 0.1, -155.3, 0 ), wallsnap = true },
        }
    },
    {
        dedication = 0,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -31.3, 17.9, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_interiors/pot02a.mdl", pos = Vector( 9.6, 28.5, 3.7 ), ang = Angle( -0.6, 67, 0.3 ) },
            { mdl = "models/props_interiors/pot01a.mdl", pos = Vector( 7.6, 16.1, 5.6 ), ang = Angle( 0.1, 57.7, 0 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", wallsnap = true, facewall = false, pos = Vector( -12, 20.7, 7.9 ), ang = Angle( 0, 74.8, 0 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( 22, 19.4, 8.6 ), ang = Angle( 0, -50.8, 0 ) },
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( 30.1, 1.8, 8.7 ), ang = Angle( -0.1, 3.3, 0 ) },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/terracotta01.mdl", wallsnap = true, pos = Vector( 34.7, 40.4, 0.3 ), ang = Angle( 0.1, -23.5, 0 ) },
            { mdl = "models/props_junk/terracotta01.mdl", wallsnap = true, pos = Vector( 38.8, 17.2, 0.4 ), ang = Angle( 0.1, -106, 0 ) },
        }
    },
    {
        dedication = 0,
        likessky = true,
        onlycenterpiecefollower = true,
        minsize = 100,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -13.9, -12.6, -2.9 ), ang = Angle( 0, -32, 0 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/maxofs2d/light_tubular.mdl", class = "gmod_light" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_interiors/pot02a.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/trafficcone001a.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_lab/monitor01b.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_lab/box01b.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_c17/streetsign001c.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_canal/mattpipe.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/PopCan01a.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/garbage_glassbottle002a.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/cardboard_box004a.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/cardboard_box003b.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/PlasticCrate01a.mdl", pos = Vector( 0, 0, 25 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 0, 0, 35 ) }
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 2, pos = Vector( -23.4, 13.7, 7.9 ), ang = Angle( -0.1, 1.9, 0.1 ) },
            { mdl = "models/props_junk/plasticbucket001a.mdl", pos = Vector( -23.3, 12.5, 7.9 ), ang = Angle( 0, -14, 0.2 ) },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/cardboard_box004a.mdl", wallsnap = true, pos = Vector( -1.5, 36.9, 4.5 ), ang = Angle( 0.7, 3.1, 0.7 ) },
            { mdl = "models/props_junk/cardboard_box004a.mdl", wallsnap = true, pos = Vector( 33.4, 29.5, 4.6 ), ang = Angle( 0.3, -97, -0.1 ) },
        }
    },
    {
        dedication = 0,
        minsize = 100,
        furniture = {
            { mdl = "models/props_junk/wood_pallet001a.mdl", wallsnap = true, pos = Vector( 7.1, -21.9, 32.4 ), ang = Angle( 74.6, 89.1, -0.1 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", facewall = false },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/garbage_milkcarton002a.mdl", facewall = false },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/garbage_milkcarton001a.mdl", facewall = false },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", facewall = false },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_c17/frame002a.mdl", skin = "?", pos = Vector( -3.8, 0.7, 0.9 ), ang = Angle( -89.9, 42, 173.5 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_c17/frame002a.mdl", skin = "?", pos = Vector( -12.7, 3.2, 16.2 ), ang = Angle( -23.1, -98, 0 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_c17/furnituredrawer001a_shard01.mdl", wallsnap = true, pos = Vector( -17.9, -18.7, 0.7 ), ang = Angle( 58.4, -177, -87.3 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/metalbucket01a.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/Gibs/HGIBS_rib.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/shoe001a.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_c17/suitcase_passenger_physics.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_c17/briefcase001a.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_c17/frame002a.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/weapons/w_slam.mdl", class = "weapon_slam" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/wood_crate001a_damagedmax.mdl" },
        }
    },
    {
        dedication = 0,
        furniture = {
            { mdl = "models/props_junk/flare.mdl" },
        }
    },
    {
        dedication = 0,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/garbage_coffeemug001a_chunk01.mdl", wallsnap = true, pos = Vector( 24.2, -34.1, 3.4 ), ang = Angle( 0.1, 77, 0.7 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a_chunk02.mdl", wallsnap = true, pos = Vector( 15.5, -33.5, -1.3 ), ang = Angle( -0.5, -64.6, -74.8 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a_chunk03.mdl", wallsnap = true, pos = Vector( 3.8, -26.3, 0.1 ), ang = Angle( 78.7, -170.6, -166.7 ) },
        }
    },
    {
        dedication = 0,
        minsize = 125,
        furniture = {
            { mdl = "models/props_junk/garbage_coffeemug001a_chunk01.mdl", pos = Vector( 24.2, -34.1, 3.4 ), ang = Angle( 0.1, 77, 0.7 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a_chunk02.mdl", pos = Vector( 15.5, -33.5, -1.3 ), ang = Angle( -0.5, -64.6, -74.8 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a_chunk03.mdl", pos = Vector( 3.8, -26.3, 0.1 ), ang = Angle( 78.7, -170.6, -166.7 ) },
        }
    },
    {
        dedication = 0,
        furniture = {
            rugdecal,
        }
    },
    {
        dedication = 0,
        minsize = 200,
        likessky = true,
        furniture = {
            tiredecal,
        }
    },

    {
        dedication = -1,
        notedetail = 1,
        furniture = {
            note,
            trashdecal1,
        }
    },
    {
        dedication = -1,
        notedetail = 0,
        furniture = {
            note,
        }
    },
    {
        dedication = -1,
        likessky = true,
        furniture = {
            gulldecal,
        }
    },
    {
        dedication = -1,
        likessky = true,
        furniture = {
            gulldecal,
        }
    },
    {
        dedication = -1,
        skyagnostic = true,
        furniture = {
            bornposter,
        }
    },
    {
        dedication = -1,
        minsize = 125,
        skyagnostic = true,
        furniture = {
            randdecal,
        }
    },
    {
        dedication = -1,
        likessky = true,
        randomlychoose1 = true,
        furniture = {
            trashdecal1,
            trashdecal2,
            trashdecal3,
        }
    },
    {
        dedication = -1,
        skyagnostic = true,
        minsize = 125,
        furniture = {
            { class = "infodecal", pos = 45, drop = false, wallsnap = true, facewall = true, keys = { texture = "decals/decalgraffiti024a" } },
        }
    },
    {
        dedication = -1,
        furniture = {
            { mdl = "models/props_junk/metalgascan.mdl", facewall = false },
        }
    },
    {
        dedication = -1,
        furniture = {
            { mdl = "models/props_junk/gascan001a.mdl", facewall = false },
        }
    },
    {
        dedication = -1,
        furniture = {
            { mdl = "models/props_junk/gascan001a.mdl", wallsnap = true, pos = Vector( -10.4, 18.9, 4.5 ), ang = Angle( 89.5, -72.1, -58.9 ) },
        }
    },
    {
        dedication = -1,
        minsize = 100,
        notedetail = 10,
        nevercenterpiecefollower = true,
        skyagnostic = true,
        furniture = {
            { mdl = "models/mossman.mdl", class = "npc_tf2_ghost", skipchance = 75, schizophrenic = 100, pos = Vector( 0.8, -9, 0.1 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = -1,
        minsize = 100,
        notedetail = 20,
        nevercenterpiecefollower = true,
        skyagnostic = true,
        furniture = {
            { mdl = "models/mossman.mdl", class = "npc_tf2_ghost", skipchance = 50, schizophrenic = 100, pos = Vector( 0.8, -9, 0.1 ), ang = Angle( 0, 0, 0 ) },
        }
    },
}

terminator_Extras.homeless_LookoutLeftovers = {
    {
        dedication = 2,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/hunter/misc/sphere025x025.mdl", class = "homeless_lost", pos = Vector( 0, 0, 0 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/hunter/misc/sphere025x025.mdl", class = "homeless_lost", pos = Vector( 0, 0, 0 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 50,
        notedetail = 3,
        overlooker = true,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -13.7, 18.9, -2.9 ), ang = Angle( 0, 0, 0 ) },
            { mdl = "models/props_wasteland/laundry_basket002.mdl", frozen = true, pos = Vector( -13.9, 20.1, 20.3 ), ang = Angle( 0, -42.2, 0.1 ) },
            { mdl = "models/humans/charple03.mdl", class = "prop_ragdoll", pos = Vector( -12, 23.7, 45.9 ), ang = Angle( 0, 0, 0 ), fire = { IgniteLifetime = 45 } },
        }
    },
    {
        dedication = 2,
        minsize = 50,
        notedetail = 3,
        overlooker = true,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", frozen = true, pos = Vector( 2.1, -0.7, -3 ), ang = Angle( 0, -116, 0 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( 11.7, -10.4, 51.4 ), ang = Angle( -79, 136.4, 3.3 ) },
            { mdl = "models/props_junk/harpoon002a.mdl", frozen = true, pos = Vector( -4.5, 9.7, 51.3 ), ang = Angle( -88, -85.3, -55 ) },
        }
    },
    {
        dedication = 2,
        minsize = 75,
        notedetail = 4,
        overlooker = true,
        furniture = {
            blood,
            { mdl = "models/hunter/misc/sphere075x075.mdl", class = "homeless_seagullking", pos = Vector( -10.7, 8.2, 48.2 ), ang = Angle( -54.4, 84.7, -22.4 ) },
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -1.6, -1.8, 3.1 ), ang = Angle( 5.4, 77.5, 1.8 ) },
        }
    },
    {
        dedication = 2,
        minsize = 25,
        overlooker = true,
        furniture = {
            blood,
            { mdl = "models/gibs/hgibs.mdl", pos = Vector( -1.4, 2.7, 3.1 ), ang = Angle( 4.2, -4.2, 2.1 ) },
            { mdl = "models/seagull.mdl", class = "npc_seagull", pos = Vector( -2.6, 2.7, 6.6 ), ang = Angle( 0, -126.6, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 75,
        overlooker = true,
        furniture = {
            { mdl = "models/hunter/misc/sphere1x1.mdl", class = "homeless_deadseagullking", pos = Vector( -1.8, 0.2, 12 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 2,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_c17/signpole001.mdl", frozen = true, pos = Vector( 2.3, -2, -0.4 ), ang = Angle( 3, 157.9, 2.1 ) },
        }
    },


    {
        dedication = 1,
        minsize = 75,
        overlooker = true,
        furniture = {
            { mdl = "models/props_c17/suitcase001a.mdl", pos = Vector( 5.2, -10.7, 6.5 ), ang = Angle( 0.2, -177, 90.3 ) },
            { mdl = "models/props_c17/trappropeller_lever.mdl", pos = Vector( -5.8, -15.2, 13.8 ), ang = Angle( -0.8, 49.1, 2 ) },
        }
    },

    {
        dedication = 1,
        minsize = 75,
        notedetail = 2,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_carboard002a.mdl", frozen = true, pos = Vector( 6.5, -22.7, 0.3 ), ang = Angle( 0, 94.6, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", pos = Vector( -0.6, -23.7, 0.9 ), ang = Angle( 0, 97.8, 0 ) },
            { mdl = "models/props_junk/glassjug01.mdl", pos = Vector( -20.8, -24.4, 0.6 ), ang = Angle( 0, 66, 0 ) },
            { mdl = "models/props_junk/garbage_metalcan001a.mdl", wallsnap = true, pos = Vector( -27.9, 21.4, 2.5 ), ang = Angle( 24.8, -13.1, 90.6 ) },
            { mdl = "models/props_junk/glassbottle01a.mdl", pos = Vector( -8.3, -24.9, 25.2 ), ang = Angle( 2.5, 36.9, 0.2 ) },
            rugdecal,
        }
    },
    {
        dedication = 1,
        minsize = 75,
        notedetail = 1,
        overlooker = true,
        furniture = {
            { mdl = "models/props_debris/concrete_spawnplug001a.mdl", class = "homeless_campfire", pos = Vector( -15, 18, -3 ), ang = Angle( 0, -126, 0 ) },
            { mdl = "models/props_wasteland/controlroom_chair001a.mdl", pos = Vector( 15.1, -16.8, 20.5 ), ang = Angle( 0, 118.8, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 75,
        notedetail = 4,
        overlooker = true,
        furniture = {
            { mdl = "models/props_wasteland/controlroom_chair001a.mdl", pos = Vector( -12, 9.7, 20.4 ), ang = Angle( 0, -73, -0.1 ) },
            { mdl = "models/props_c17/oildrum001.mdl", pos = Vector( 16, 16.6, 0.5 ), ang = Angle( 0, -94.3, 0 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( 21.5, 13, 48.9 ), ang = Angle( -0.1, 167.1, -0.2 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = true, pos = Vector( 28.2, -20.4, 8.8 ), ang = Angle( -0.3, -145.6, -0.3 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        notedetail = 2,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 2, pos = Vector( -11.3, 1.5, 7.9 ), ang = Angle( 0, -176.9, 0 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( -16.1, -4.5, 2.9 ), ang = Angle( -90, 80.6, 0 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( -16.7, -0.8, 3 ), ang = Angle( -89.7, 169.9, 105.1 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( -14.9, -0.5, 3.1 ), ang = Angle( -89.9, -176.2, -80.8 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( -6.7, -4.8, 8.2 ), ang = Angle( 0.4, 79.6, -0.1 ) },
            { mdl = "models/props_c17/furniturechair001a.mdl", pos = Vector( 12.4, 13.1, 20.7 ), ang = Angle( 0, -91, -0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        notedetail = 2,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/flare.mdl", pos = Vector( -4.4, 1.4, 1.6 ), ang = Angle( 87.8, -160.6, 89.6 ) },
            { mdl = "models/props_c17/furniturechair001a.mdl", pos = Vector( 12.4, 13.1, 20.3 ), ang = Angle( 0, -91, -0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        notedetail = 1,
        overlooker = true,
        furniture = {
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", pos = Vector( -4.6, 1.3, 1.5 ), ang = Angle( 0.1, -43.6, 0 ) },
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( -6.8, -5, 8 ), ang = Angle( 0, 38.5, -180 ) },
            { mdl = "models/props_junk/garbage_metalcan001a.mdl", pos = Vector( -5.1, -15.3, 19.6 ), ang = Angle( 1, 158.9, -0.6 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -1.4, -10.1, 24.2 ), ang = Angle( -1.2, 166.6, -1.2 ) },
            { mdl = "models/props_junk/garbage_bag001a.mdl", wallsnap = true, pos = Vector( 23, -11.7, 6.1 ), ang = Angle( 0, -86, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        notedetail = 2,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/plasticcrate01a.mdl", pos = Vector( 12, 10.5, 7.9 ), ang = Angle( 0, 102, 0 ) },
            { mdl = "models/props_c17/furniturechair001a.mdl", pos = Vector( -12.1, 1.4, 3.9 ), ang = Angle( 47.6, -82.2, 179.6 ) },
            { mdl = "models/maxofs2d/camera.mdl", class = "homeless_camera", pos = Vector( 14.1, 8.4, 1.7 ), ang = Angle( 2.8, 2.5, 0.4 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        notedetail = 4,
        overlooker = true,
        furniture = {
            { mdl = "models/props_interiors/furniture_chair03a.mdl", pos = Vector( -12.9, 6.3, 19.7 ), ang = Angle( 0.2, -67.5, 0 ) },
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 4, pos = Vector( 14.4, 9, 13.3 ), ang = Angle( 0.6, -87.9, 89.8 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( 17.3, 7.7, 3 ), ang = Angle( 2.3, 158.7, 90.1 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 13.1, 7, 10 ), ang = Angle( -0.4, 136.1, -0.2 ) },
            { mdl = "models/maxofs2d/camera.mdl", class = "homeless_camera", pos = Vector( 14.1, 4.2, 26.6 ), ang = Angle( 4, -132.6, -0.3 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        notedetail = 4,
        overlooker = true,
        furniture = {
            trashdecalrand,
            { mdl = "models/props_interiors/furniture_chair03a.mdl", pos = Vector( 9, -11.2, 19.7 ), ang = Angle( 0.1, 161.2, 0 ) },
            { mdl = "models/props_junk/plasticcrate01a.mdl", skin = 4, pos = Vector( 11.5, 15.3, 13.3 ), ang = Angle( 0.6, -46.7, 89.7 ) },
            { mdl = "models/props_junk/flare.mdl", pos = Vector( 14.3, 17.1, 3 ), ang = Angle( -0.6, -154.2, 89.5 ) },
            { mdl = "models/maxofs2d/camera.mdl", class = "homeless_camera", pos = Vector( 10, 16.7, 26.7 ), ang = Angle( 0.6, -172.5, 0.2 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a_chunk01.mdl", wallsnap = true, pos = Vector( -19.3, -12.2, 3 ), ang = Angle( -62.7, -1, -115.7 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        notedetail = 1,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( 8.2, -2, 7.9 ), ang = Angle( 0, 13.2, 180 ) },
            { mdl = "models/props_c17/paper01.mdl", class = "homeless_note", pos = Vector( 9.1, -2.4, 1.5 ), ang = Angle( 0, 18.7, 0 ) },
            { mdl = "models/props_interiors/pot01a.mdl", pos = Vector( -15.1, -15.6, 5.6 ), ang = Angle( -0.4, 93, 0.2 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a_chunk01.mdl", pos = Vector( 6.1, -10.2, 17.7 ), ang = Angle( -57.9, 64.4, 89.8 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a_chunk02.mdl", wallsnap = true, pos = Vector( 8.1, -3.2, 14.1 ), ang = Angle( 0.3, 154.5, -75.5 ) },
            { mdl = "models/props_junk/garbage_coffeemug001a_chunk03.mdl", wallsnap = true, pos = Vector( -22.6, 14.2, 3.7 ), ang = Angle( 0.7, -116, -0.6 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        overlooker = true,
        furniture = {
            { mdl = "models/props_interiors/furniture_chair03a.mdl", pos = Vector( -12, -7.8, 19.7 ), ang = Angle( 0, 30.5, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( 8.1, -14, 8.9 ), ang = Angle( -0.1, -85.1, 0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        overlooker = true,
        furniture = {
            { mdl = "models/props_c17/chair_stool01a.mdl", pos = Vector( 16, -11.7, -1.7 ), ang = Angle( 0, -86.3, 0 ) },
            { mdl = "models/props_lab/citizenradio.mdl", pos = Vector( -3.1, 15.5, 14.6 ), ang = Angle( 0, -51, 90 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -5.3, 8.5, 37.1 ), ang = Angle( -0.3, -178.1, -0.6 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( -15.1, 5.5, 8.5 ), ang = Angle( -0.2, 127.1, -179.5 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = true, pos = Vector( 15.6, -15.4, 8.5 ), ang = Angle( 0.2, -97.1, -0.2 ) },
            { mdl = "models/props_junk/glassbottle01a.mdl", pos = Vector( -12.1, -13.7, 2.2 ), ang = Angle( 67.1, -90.9, -92.6 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/metalbucket02a.mdl", pos = Vector( -6.7, -5.5, 7.9 ), ang = Angle( 0, 38.1, -180 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = true, pos = Vector( -11.9, 20.3, 2.4 ), ang = Angle( -23.6, 105.5, 90.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_coffeemug001a.mdl", pos = Vector( -14.1, 18.2, 3.2 ), ang = Angle( -0.5, -17.2, -1 ) },
            { mdl = "models/props_interiors/furniture_chair03a.mdl", pos = Vector( -4.5, -4.2, 19.8 ), ang = Angle( 0, 45.6, 0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        overlooker = true,
        furniture = {
            { mdl = "models/props_lab/citizenradio.mdl", pos = Vector( -20.9, 12.1, 14.5 ), ang = Angle( 0, -88.3, -90 ) },
            { mdl = "models/props_c17/chair02a.mdl", wallsnap = true, pos = Vector( -3.3, -6.4, 21.6 ), ang = Angle( 51, 31.6, -178.9 ) },
            { mdl = "models/props_junk/glassjug01.mdl", pos = Vector( -8.2, 10.6, 29 ), ang = Angle( 0, -75, 0.1 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        overlooker = true,
        furniture = {
            { mdl = "models/props_interiors/furniture_chair03a.mdl" },
        }
    },
    {
        dedication = 1,
        minsize = 25,
        notedetail = 4,
        overlooker = true,
        furniture = {
            { mdl = "models/props_interiors/pot01a.mdl" },
        }
    },
    {
        dedication = 1,
        minsize = 25,
        notedetail = 2,
        overlooker = true,
        furniture = {
            { mdl = "models/hunter/misc/sphere025x025.mdl", class = "homeless_lost", pos = Vector( 0, 0, 0 ), ang = Angle( 0, 0, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        overlooker = true,
        furniture = {
            { mdl = "models/props_c17/furniturechair001a.mdl", pos = Vector( 3.7, 9.1, 20.3 ), ang = Angle( 0.1, -141.5, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/metalbucket01a.mdl", pos = Vector( 5.5, -3.4, 8.5 ), ang = Angle( 0.1, 70.9, 179.8 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( 8.3, 8.7, 8.6 ), ang = Angle( -0.1, -156.8, -0.2 ) },
        }
    },
    {
        dedication = 1,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = true, pos = Vector( -1.1, -3.1, 2.3 ), ang = Angle( 20.7, 97.8, -90 ) },
            { mdl = "models/props_junk/garbage_glassbottle002a.mdl", pos = Vector( 6.3, 5.9, 8.9 ), ang = Angle( -0.2, -166.3, -0.8 ) },
        }
    },
    {
        dedication = 1,
        minsize = 50,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/watermelon01_chunk01c.mdl", pos = Vector( 3.7, -6, 3.5 ), ang = Angle( -2.1, 104.6, 42.7 ) },
            { mdl = "models/seagull.mdl", class = "npc_seagull", pos = Vector( -6.8, 3.4, 3.5 ), ang = Angle( 0, -18, 0 ) },
        }
    },
    {
        dedication = 1,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/seagull.mdl", class = "npc_seagull", schizophrenic = 75 },
        }
    },
    {
        dedication = 1,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/plasticbucket001a.mdl", pos = Vector( 5.2, 0.4, 6.6 ), ang = Angle( 0, -81, 0 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -7.7, 11.2, 8.6 ), ang = Angle( 0.2, -94.6, -0.2 ) },
        }
    },


    {
        dedication = 0,
        minsize = 50,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_glassbottle002a.mdl", pos = Vector( 15.6, 13.9, 8.9 ), ang = Angle( -0.3, 177.8, -0.5 ) },
        }
    },
    {
        dedication = 0,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_glassbottle003a_chunk01.mdl", wallsnap = true, pos = Vector( -2.2, -3.1, 2.6 ), ang = Angle( 63.4, -33.7, -116.4 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a_chunk03.mdl", wallsnap = true, pos = Vector( 5.9, -5.3, 8.3 ), ang = Angle( -1.4, -141.3, -0.6 ) },
            { mdl = "models/props_junk/garbage_glassbottle003a_chunk02.mdl", pos = Vector( 4.2, 3.7, -0.3 ), ang = Angle( 65.1, -111, 87.5 ) },
        }
    },
    {
        dedication = 0,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", pos = Vector( -6.9, 4.3, 2.3 ), ang = Angle( -64.8, 152.8, 90 ) },
        }
    },
    {
        dedication = 0,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/glassbottle01a.mdl", pos = Vector( -2, -4.3, 1.9 ), ang = Angle( 19.2, 121.3, -91 ) },
        }
    },
    {
        dedication = 0,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_bag001a.mdl", pos = Vector( -4.3, -0.2, 5.6 ), ang = Angle( -0.6, -68.8, 0.1 ) },
        }
    },
    {
        dedication = 0,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/glassjug01.mdl", pos = Vector( 5.8, -5.2, 0.3 ), ang = Angle( 0, -73.3, 0 ) },
        }
    },
    {
        dedication = 0,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/popcan01a.mdl" },
        }
    },
    {
        dedication = 0,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_glassbottle001a.mdl", pos = Vector( 4.3, -5.5, 8.8 ), ang = Angle( 0, -121.5, 0.1 ) },
        }
    },
    {
        dedication = 0,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_c17/metalpot001a.mdl", pos = Vector( 2.1, -1.7, 7.2 ), ang = Angle( 1, 52.4, 179.8 ) },
        }
    },
    {
        dedication = 0,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_interiors/pot02a.mdl" },
        }
    },
    {
        dedication = 0,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_takeoutcarton001a.mdl", pos = Vector( 6.7, -8.2, 5.8 ), ang = Angle( 0.3, -172.7, 0.6 ) },
        }
    },


    {
        dedication = -1,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_glassbottle003a.mdl", wallsnap = false, pos = Vector( 6, 5.7, 8.5 ), ang = Angle( 0.2, -168, -0.1 ) },
        }
    },
    {
        dedication = -1,
        minsize = 25,
        overlooker = true,
        furniture = {
            { mdl = "models/props_junk/garbage_takeoutcarton001a.mdl", pos = Vector( 5.6, -6.4, 3.5 ), ang = Angle( 82.3, 175.4, 0.3 ) },
        }
    },
}

if PathFinderSystem then
    local gpsHintShelter = {
        dedication = -1,
        furniture = {
            { class = "pathfinder_gps", mdl = "models/weapons/w_slam.mdl" },
        }
    }
    table.insert( terminator_Extras.homeless_Shelters, gpsHintShelter )

end

terminator_Extras.decalShelterIndexes = {}

for sheltersIndex, shelter in ipairs( terminator_Extras.homeless_Shelters ) do
    local wasADecal
    local wasANotDecal
    local sheltersFurniture = shelter.furniture
    for _, furniture in ipairs( sheltersFurniture ) do
        if furniture.class == "infodecal" then
            wasADecal = true

        else
            wasANotDecal = true

        end
    end
    local moreThanOne = #sheltersFurniture > 1 and not shelter.randomlychoose1
    if wasADecal and not wasANotDecal and not moreThanOne then
        table.insert( terminator_Extras.decalShelterIndexes, sheltersIndex )

    end
end