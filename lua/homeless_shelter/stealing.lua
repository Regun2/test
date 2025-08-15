
local toSteal
local thinkingFast

local desire = 0
local nextThink = 0
local toStealData = {}
local up = Vector( 0, 0, 1 )

local function thinkLong( cur )
    nextThink = cur + math.Rand( 5, 15 )

end

local function stealThink()
    local cur = CurTime()
    if nextThink > cur then return end
    if player.GetCount() >= 5 then -- too laggy otherwise ?
        nextThink = cur + 60
        return

    end
    if thinkingFast then
        nextThink = cur + 1

    else
        nextThink = cur + 2

    end

    if not IsValid( toSteal ) then
        local theHomeless = terminator_Extras.homeless
        for _, ply in player.Iterator() do

            local scoreAdd = 0.1

            local viewEnt = ply:GetViewEntity()
            local potentialSteal = viewEnt
            if IsValid( potentialSteal ) and potentialSteal ~= ply then
                scoreAdd = 1

            else
                local aimE = ply:GetEyeTrace().Entity
                if IsValid( aimE ) then
                    local rad = aimE:GetModelRadius()
                    if not rad then continue end -- not model based??
                    if rad <= 0 or rad >= 50 then continue end -- if its bigger than a barrel then no steal

                    local lowered = string.lower( aimE:GetClass() )
                    if string.find( lowered, "camera" ) or string.find( lowered, "screen" ) then
                        scoreAdd = 1

                    end
                    potentialSteal = aimE

                end
            end

            if IsValid( potentialSteal ) then
                if potentialSteal == ply then continue end
                if IsValid( theHomeless ) and theHomeless.homeless_PlayerTrackedWhileInvis and theHomeless.homeless_PlayerTrackedWhileInvis > 100 then -- whatever they're doing is working
                    scoreAdd = scoreAdd + 5

                end
                local currData = toStealData[potentialSteal]
                if currData then
                    currData.score = currData.score + scoreAdd

                else
                    thinkingFast = true
                    toStealData[potentialSteal] = {
                        score = 0,
                        valuable = potentialSteal == viewEnt,
                        lastUsed = cur,

                    }
                end
            end
        end

        if ( not IsValid( theHomeless ) ) and math.random( 0, 35 ) > desire then return end -- optimisation AND scarcity

        if table.Count( toStealData ) >= 1 then
            local bestScore = 0
            local bestEnt
            local valuable

            for ent, data in pairs( toStealData ) do
                if not IsValid( ent ) then toStealData[ent] = nil continue end
                if data.score < bestScore then continue end
                if cur - data.lastUsed < 20 then continue end
                local conventional = not IsValid( ent:GetParent() ) and IsValid( ent:GetPhysicsObject() ) and ent:IsSolid()
                if not conventional then continue end
                if terminator_Extras.posIsInterrupting( ent:WorldSpaceCenter() ) then continue end

                bestScore = data.score
                valuable = data.valuable
                bestEnt = ent

            end
            if bestEnt and ( valuable or bestScore >= math.random( 10, 300 ) ) then
                toSteal = bestEnt

            end
        else
            thinkingFast = nil

        end
    else
        if terminator_Extras.posIsInterrupting( toSteal:WorldSpaceCenter() ) then return end
        local scoredShelters = terminator_Extras.homeless_ScoredShelters
        local count = table.Count( scoredShelters )
        if count <= 0 then thinkLong( cur ) return end

        local bestOne = table.maxn( scoredShelters )
        if bestOne <= math.random( 0, desire * 2 ) then thinkLong( cur ) return end

        local bestOnesArea = scoredShelters[bestOne]
        local stashPos = bestOnesArea:GetCenter() + up * 25
        if not util.IsInWorld( stashPos ) then return end

        local potentialPointAt = table.Copy( terminator_Extras.homeless_ExistingShelters[bestOnesArea] )
        local pointAtTarg

        while not pointAtTarg and #potentialPointAt > 0 do
            pointAtTarg = table.remove( potentialPointAt, math.random( 1, #potentialPointAt ) )
            if not IsValid( pointAtTarg ) then
                pointAtTarg = nil

            end
        end

        if terminator_Extras.posIsInterrupting( stashPos ) then return end
        toSteal:SetPos( stashPos )

        if IsValid( pointAtTarg ) then
            local lookingAtOneDir = terminator_Extras.dirToPos( stashPos, pointAtTarg:WorldSpaceCenter() )
            toSteal:SetAngles( lookingAtOneDir:Angle() )

        end

        local obj = toSteal:GetPhysicsObject()
        if IsValid( obj ) then
            obj:EnableMotion( true )
            obj:Wake()

        end

        local minute = 60
        nextThink = cur + math.random( minute * 30, minute * 60 )
        toStealData[toSteal] = nil
        toSteal = nil

    end
end

function homeless_DoStealing( dedication )
    if terminator_Extras.homeless_DoingStealing then return end
    terminator_Extras.homeless_DoingStealing = true
    desire = dedication
    timer.Create( "homeless_find_to_steal", 1, 0, function() -- was think hook, 
        stealThink()

    end )
end