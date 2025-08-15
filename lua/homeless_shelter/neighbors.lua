local fixingNeighbors
local cleanedUp
local theSeagull

function homeless_FixNeighbors()

    if fixingNeighbors then return end
    fixingNeighbors = true
    terminator_Extras.homeless_FixingNeighbors = true

    local function isImmune( ent )
        if ent.homeless_neighbors_immune then return true end
        if ent:GetClass() == "terminator_nextbot_homeless" then return true end

    end

    local function isSeagull( ent )
        if IsValid( theSeagull ) then
            return ent == theSeagull

        else
            return ent:GetClass() == "npc_seagull"

        end
    end

    local function handleSeagull( ent )
        local class

        local first = homeless_FirstPly()
        local detailDo = IsValid( first ) and homeless_NoteDetail( first ) >= 4 and math.random( 0, 100 ) < 15
        local murderDo = IsValid( first ) and first.homeless_Murderer and math.random( 0, 100 ) < 50
        local doKing = detailDo or murderDo
        if doKing then
            class = "homeless_seagullking"

        else
            class = "homeless_freegull"

        end
        theSeagull = ents.Create( class )
        theSeagull.homeless_DeservesToExist = true

        theSeagull:SetPos( ent:GetPos() )

        SafeRemoveEntity( ent )

        theSeagull:Spawn()

    end

    hook.Add( "OnEntityCreated", "homeless_removeneighbors", function( ent )
        if not cleanedUp then return end
        timer.Simple( 0, function()
            if not IsValid( ent ) then return end
            if not ent:IsNPC() and not ent:IsNextBot() then return end
            if isImmune( ent ) then return end
            if isSeagull( ent ) then handleSeagull( ent ) return end
            ent:TakeDamage( math.huge, ent, ent )
            SafeRemoveEntity( ent )

        end )
    end )

    hook.Add( "PlayerSpawnedNPC", "homeless_removeneighbors", function( _, ent )
        if not cleanedUp then return end
        if not ent:IsNPC() and not ent:IsNextBot() then return end
        if isImmune( ent ) then return end
        if isSeagull( ent ) then handleSeagull( ent ) return end
        ent:TakeDamage( math.huge, ent, ent )
        SafeRemoveEntity( ent )

    end )


    hook.Add( "PostCleanupMap", "homeless_removeneighbors", function()
        if cleanedUp then return end
        cleanedUp = true

        local soundscapes = ents.FindByClass( "env_soundscape" )
        local triggerableScapes = ents.FindByClass( "env_soundscape_triggerable" )

        table.Add( soundscapes, triggerableScapes )

        --PrintTable( soundscapes )

        for _, soundscape in ipairs( soundscapes ) do
            SafeRemoveEntity( soundscape )

        end

        timer.Simple( 0.1, function()
            net.Start( "homeless_emptyness" )
            net.Broadcast()

        end )
    end )
end
