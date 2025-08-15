
local overlookNookOffsets = {
    -- cardinal directions with a bias downwards
    Vector( 0.7, 0, -0.1 ),
    Vector( -0.7, 0, -0.1 ),
    Vector( 0, 0.7, -0.1 ),
    Vector( 0, -0.7, -0.1 ),

    -- 45 degree directions with a bias downwards
    Vector( -0.35, 0.35, -0.15 ),
    Vector( -0.35, -0.35, -0.15 ),
    Vector( 0.35, 0.35, -0.15 ),
    Vector( 0.35, -0.35, -0.15 ),
}

local vecUp25 = Vector( 0, 0, 25 )
local developer = GetConVar( "developer" )

local function debugPrint( ... )
    if not terminator_Extras.areDebugging then return end
    if developer:GetInt() < 1 then return end
    print( ... )

end

local function abandonOverlook() -- return true to keep thinking, return nil to kill timer
    local overlook = terminator_Extras.homeless_AbandonedOverlook
    if not overlook then return end
    if IsValid( overlook.area ) and not terminator_Extras.areaIsInterruptingSomeone( overlook.area ) then return true end

    local interruptCenter
    local interruptFurnit
    local shelter = overlook.shelter
    local oneValid

    for _, furnit in ipairs( shelter ) do
        if not IsValid( furnit ) then continue end
        if not IsValid( furnit:GetPhysicsObject() ) then continue end
        if not furnit:GetPhysicsObject():IsMotionEnabled() then continue end
        oneValid = true
        local center = furnit:WorldSpaceCenter()
        local posInterrupting = terminator_Extras.posIsInterrupting( center )
        if posInterrupting then
            interruptFurnit = furnit
            interruptCenter = center
            break

        end
    end
    if not oneValid then return end -- kill
    if not ( interruptCenter and IsValid( interruptFurnit ) ) then return true end

    local _, results = terminator_Extras.GetNookScore( interruptCenter + vecUp25, 5000, overlookNookOffsets )
    local longestInd = 0
    local longestTr
    for fraction, trace in pairs( results ) do
        if fraction > longestInd then
            longestInd = fraction
            longestTr = trace

        end
    end

    local dir = terminator_Extras.dirToPos( interruptCenter, longestTr.HitPos )

    local massForce = interruptFurnit:GetPhysicsObject():GetMass()
    local force = dir * massForce * 250
    interruptFurnit:GetPhysicsObject():ApplyForceCenter( force )

    return -- kill timer

end

function homeless_DoOverlooking( dedication )
    terminator_Extras.homeless_AbandonedOverlook = terminator_Extras.homeless_AbandonedOverlook or nil
    if terminator_Extras.homeless_AbandonedOverlook then
        local validCount = 0
        for _, furnit in ipairs( terminator_Extras.homeless_AbandonedOverlook.shelter ) do
            if IsValid( furnit ) then
                validCount = validCount + 1

            end
        end
        if validCount <= dedication then
            terminator_Extras.homeless_AbandonedOverlook = nil
            terminator_Extras.homeless_OccupiedOverlook = nil

        else
            return

        end
    end
    local timerName = "homeless_overlooking"

    local interval = 2

    local desiredCount = math.random( 0, 35 )
    local count = 0

    timer.Create( timerName, interval, 0, function()
        if homeless_IsHomelessActive() then return end

        count = count + 1
        if count < desiredCount then return end

        local occupiedOverlook = terminator_Extras.homeless_OccupiedOverlook
        if not occupiedOverlook then
            --debugPrint( "a1" )
            local randomOverlook = table.Random( terminator_Extras.homeless_Overlooks )
            if not randomOverlook then return end
            if not IsValid( randomOverlook.area ) then return end
            if terminator_Extras.areaIsInterruptingSomeone( randomOverlook.area ) then return end

            terminator_Extras.homeless_OccupiedOverlook = {
                data = randomOverlook,
                interruptCount = 0,
                occupiedCount = 0,
                doneCount = math.random( 2, 12 ),

            }
            --debugPrint( "a" )

        elseif occupiedOverlook.occupiedCount <= occupiedOverlook.doneCount then
            if not IsValid( occupiedOverlook.data.area ) then
                terminator_Extras.homeless_OccupiedOverlook = nil
                return

            end
            if terminator_Extras.areaIsInterruptingSomeone( occupiedOverlook.data.area ) then
                occupiedOverlook.interruptCount = occupiedOverlook.interruptCount + 1
                occupiedOverlook.occupiedCount = occupiedOverlook.occupiedCount + 4
                occupiedOverlook.doneCount = math.Clamp( occupiedOverlook.doneCount + -1, occupiedOverlook.occupiedCount + 1, math.huge )
                --debugPrint( "b1" )
                return

            end
            if occupiedOverlook.interruptCount > occupiedOverlook.doneCount / 2 then
                terminator_Extras.homeless_OccupiedOverlook = nil
                --debugPrint( "b2" )
                return

            end
            occupiedOverlook.occupiedCount = occupiedOverlook.occupiedCount + 1
            --debugPrint( "b" )

        else
            --debugPrint( "c" )
            local sheltDat = {
                overlooking = true,

            }

            local spawned = homeless_SpawnShelterAt( occupiedOverlook.data.area, 10, sheltDat )
            if spawned then
                debugPrint( "spawned an overlook with ", #spawned .. " furniture." )
                local data = {
                    shelter = spawned,
                    area = occupiedOverlook.data.area,
                }
                terminator_Extras.homeless_AbandonedOverlook = data
                terminator_Extras.homeless_OccupiedOverlook = nil
                terminator_Extras.homeless_OverlookPos = occupiedOverlook.data.pos
                timer.Remove( timerName )

                if #spawned <= 1 or math.random( 0, 100 ) < 75 then return end
                timer.Create( "homeless_overlook_abandon", 0.5, 0, function()
                    if not abandonOverlook() then timer.Remove( "homeless_overlook_abandon" ) return end

                end )
            else
                terminator_Extras.homeless_AbandonedOverlook = nil
                terminator_Extras.homeless_OccupiedOverlook = nil

            end
        end
    end )
end