local function deservesToExist( _, me )
    me.homeless_DeservesToExist = true

end
local function modelMan( _, me )
    me:SetModel( "models/player/corpse1.mdl" )

end
local function modelLost( _, me )
    me:SetModel( "models/player/charple.mdl" )

end
local function ANGRY( _, me )
    me.HomelessFrustration = me.HomelessFrustrationToAnger
    me.TryingToBeHidden = 0

end
local function scornOverride( _, me )
    me.TryingToBeHidden = math.random( -8, -4 )
    me.homeless_IgnoreScornWisdom = true
    function me:homeless_ScornOverride( enemy )
        enemy:TakeDamage( math.huge, self, self )
        timer.Simple( 5, function()
            if not IsValid( me ) then return end
            ANGRY( nil, me )

        end )
    end
    local timerName = "homeless_findnewenemies_" .. me:GetCreationID()
    timer.Create( timerName, 1, 0, function()
        if not IsValid( me ) then timer.Remove( timerName ) return end

        local enemy = me:GetEnemy()

        if IsValid( enemy ) and enemy:Health() > 0 then return end
        me:SetEnemy( nil )

    end )
end

local spawnSet = {
    name = "explorers_glee", -- unique name
    prettyName = "Explorer's Glee",
    description = "An explorer's paradise\njust you, the map, and Nothing.",
    startingBudget = { 4, 16 }, -- so budget isnt 0
    spawnCountPerDifficulty = { 0.02, 0.1 },
    startingSpawnCount = 0,
    maxSpawnCount = 4,
    chanceToBeVotable = 0.5,
    genericSpawnerRate = { 4, 8 }, -- spawn stuff in the map WAY SLOWER
    spawns = {
        {
            hardRandomChance = nil,
            name = "homeless_man",
            prettyName = "???",
            class = "terminator_nextbot_homeless",
            spawnType = "hunter",
            difficultyCost = { 10, 25 },
            countClass = "terminator_nextbot_homeless",
            minCount = { 1 },
            maxCount = { 1 },
            preSpawnedFuncs = { deservesToExist },
            postSpawnedFuncs = { scornOverride, modelMan },
        },
        {
            hardRandomChance = nil,
            name = "homeless_lost_man",
            prettyName = "???",
            class = "terminator_nextbot_homeless",
            spawnType = "hunter",
            difficultyCost = { 100, 150 },
            countClass = "terminator_nextbot_homeless",
            minCount = { 0 },
            maxCount = { 2 },
            preSpawnedFuncs = { deservesToExist },
            postSpawnedFuncs = { scornOverride, ANGRY, modelLost },
        },
    }
}

table.insert( GLEE_SPAWNSETS, spawnSet )
