AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

local static = "hl1/ambience/deadsignal2.wav"
local oceanside = {
    looper = "ambient/levels/canals/swamp_frogs_loop2.wav",
    volMul = 0.05,
    randoms = {
        "ambient/levels/canals/critter1.wav",
        "ambient/levels/canals/critter2.wav",
        "ambient/levels/canals/critter3.wav",
        "ambient/levels/canals/critter4.wav",
        "ambient/levels/canals/critter5.wav",
        "ambient/levels/canals/critter6.wav",
        "ambient/levels/canals/critter7.wav",
        "ambient/levels/canals/critter8.wav",
        "ambient/water/distant_wave1.wav",
        "ambient/water/distant_wave2.wav",
        "ambient/water/distant_wave3.wav",
        "ambient/levels/canals/shore1.wav",
        "ambient/levels/canals/shore2.wav",
        "ambient/levels/canals/shore3.wav",
        "ambient/levels/canals/shore4.wav",
        "ambient/levels/canals/swamp_bird1.wav",
        "ambient/levels/canals/swamp_bird2.wav",
        "ambient/levels/canals/swamp_bird3.wav",
        "ambient/levels/canals/swamp_bird4.wav",
        "ambient/levels/canals/swamp_bird5.wav",
        "ambient/levels/canals/swamp_bird6.wav",
        "ambient/levels/coast/coastbird1.wav",
        "ambient/levels/coast/coastbird2.wav",
        "ambient/levels/coast/coastbird3.wav",
        "ambient/levels/coast/coastbird4.wav",
        "ambient/levels/coast/coastbird5.wav",
        "ambient/levels/coast/coastbird6.wav",
        "ambient/levels/coast/coastbird7.wav",
        "ambient/levels/coast/seagulls_ambient1.wav",
        "ambient/levels/coast/seagulls_ambient2.wav",
        "ambient/levels/coast/seagulls_ambient3.wav",
        "ambient/levels/coast/seagulls_ambient4.wav",
        "ambient/levels/coast/seagulls_ambient5.wav",
    },
}

local nonlinearity = {
    looper = "ambient/levels/canals/windmill_wind_loop1.wav",
    volMul = 0.05,
    randoms = {
        "ambient/wind/wind_med1.wav",
        "ambient/wind/wind_med2.wav",
        "ambient/wind/wind_snippet2.wav",
        "ambient/wind/wind_snippet3.wav",
        "ambient/wind/wind_snippet4.wav",
        "ambient/wind/wind_snippet5.wav",
        "ambient/wind/wind_hit2.wav",
        "ambient/levels/canals/windchime2.wav",
        "ambient/levels/canals/windchime4.wav",
        "ambient/levels/canals/windchinm5.wav",
        "ambient/levels/canals/windchine4.wav",
        "ambient/levels/canals/windchime2.wav",
        "ambient/levels/canals/windchime4.wav",
        "ambient/levels/canals/windchinm5.wav",
        "ambient/levels/canals/windchine4.wav",
    }
}

function ENT:SetupSongs()
    self.Songs = {
        [1] = { static, static, static, static, static, static, static, static, static, static, static, static, static, static, static, static, static, static, static, static, static, static, static, static,
            nonlinearity

        },
        [2] = { static, static, static, static, static, oceanside, nonlinearity },
        [3] = { static, static, oceanside, nonlinearity,
            {
                looper = "ambient/ambience/waterlap_loop.wav",
                volMul = 0.05,
                randoms = {
                    "ambient/levels/canals/windchime2.wav",
                    "ambient/levels/canals/windchime4.wav",
                    "ambient/levels/canals/windchime5.wav",
                    "ambient/levels/canals/windchine4.wav",
                    "ambient/levels/canals/windchime2.wav",
                    "ambient/levels/canals/windchime4.wav",
                    "ambient/levels/canals/windchime5.wav",
                    "ambient/levels/canals/windchine4.wav",
                }
            },
            { -- not blissful
                looper = "ambient/atmosphere/cave_outdoor1.wav",
                volMul = 0.05,
                randoms = {
                    "ambient/levels/streetwar/building_rubble1.wav",
                    "ambient/levels/streetwar/building_rubble2.wav",
                    "ambient/levels/streetwar/building_rubble3.wav",
                    "ambient/levels/streetwar/building_rubble4.wav",
                    "ambient/levels/streetwar/city_battle1.wav",
                    "ambient/levels/streetwar/city_battle2.wav",
                    "ambient/levels/streetwar/city_battle3.wav",
                    "ambient/levels/streetwar/city_battle4.wav",
                    "ambient/levels/streetwar/city_battle5.wav",
                    "ambient/levels/streetwar/city_battle6.wav",
                    "ambient/levels/streetwar/city_battle7.wav",
                    "ambient/levels/streetwar/city_battle8.wav",
                    "ambient/levels/streetwar/city_battle9.wav",
                    "ambient/levels/streetwar/city_battle10.wav",
                    "ambient/levels/streetwar/city_battle11.wav",
                    "ambient/levels/streetwar/city_battle12.wav",
                    "ambient/levels/streetwar/city_battle13.wav",
                    "ambient/levels/streetwar/city_battle14.wav",
                    "ambient/levels/streetwar/city_battle15.wav",
                    "ambient/levels/streetwar/city_battle16.wav",
                    "ambient/levels/streetwar/city_battle17.wav",
                    "ambient/levels/streetwar/city_battle18.wav",
                    "ambient/levels/streetwar/city_battle19.wav",
                    "ambient/levels/streetwar/apc_distant1.wav",
                    "ambient/levels/streetwar/apc_distant2.wav",
                    "ambient/levels/streetwar/apc_distant3.wav",
                    "ambient/levels/streetwar/city_chant1.wav",
                    "ambient/levels/streetwar/city_riot1.wav",
                    "ambient/levels/streetwar/city_riot2.wav",
                    "ambient/levels/streetwar/city_scream3.wav",
                    "ambient/levels/streetwar/gunship_distant1.wav",
                    "ambient/levels/streetwar/gunship_distant2.wav",
                    "ambient/levels/streetwar/heli_distant1.wav",
                    "ambient/levels/streetwar/marching_distant1.wav",
                    "ambient/levels/streetwar/marching_distant2.wav",
                    "ambient/levels/streetwar/strider_distant1.wav",
                    "ambient/levels/streetwar/strider_distant2.wav",
                    "ambient/levels/streetwar/strider_distant3.wav",
                    "ambient/levels/streetwar/strider_distant_walk1.wav",
                }
            },
        }
    }
end