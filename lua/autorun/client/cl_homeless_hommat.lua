-- CREDIT TO "hall of mirrors effect"
-- by freefilesvirus
-- https://steamcommunity.com/sharedfiles/filedetails/?id=3410951984

local empty = {}
local varName = "homeless_hallofmirrorify"
local validateTimer = "homeless_validatehom"

local relevant = {}
local oldAnythingRelevant = false
local anythingRelevant = false

local function validateTbl()
    timer.Create( validateTimer, 0.1, 1, function()
        local new = {}
        for _, ent in ipairs( relevant ) do
            if IsValid( ent ) and ent:GetNW2Bool( varName, false ) then
                table.insert( new, ent )

            end
        end

        relevant = new
        anythingRelevant = #relevant > 0
        if anythingRelevant and not oldAnythingRelevant then
            hook.Run( "homeless_cl_hommat_start" )

        end
        oldAnythingRelevant = anythingRelevant

    end )
end

-- auto re fresh
for _, ent in ents.Iterator() do
    if ent:GetNW2Bool( varName, false ) then
        table.insert( relevant, ent )

    end
    validateTbl()

end

hook.Add( "EntityNetworkedVarChanged", varName, function( ent, name, old, new )
    if name ~= varName then return end
    if old == new then return end

    if new == true then
        ent.homeless_InHallOfMirrorsTable = true

    else
        ent.homeless_InHallOfMirrorsTable = nil

    end

    if new == true then
        table.insert( relevant, ent )
        ent:CallOnRemove( "homeless_hommat_cleanup", function()
            validateTbl()

        end )
    end
    validateTbl()

end )

do
    local render = render
    local halo = halo
    local STENCILOPERATION_KEEP = STENCILOPERATION_KEEP
    local STENCILCOMPARISONFUNCTION_ALWAYS = STENCILCOMPARISONFUNCTION_ALWAYS
    local STENCILOPERATION_REPLACE = STENCILOPERATION_REPLACE
    local STENCILCOMPARISONFUNCTION_EQUAL = STENCILCOMPARISONFUNCTION_EQUAL

    local relevantAwake

    hook.Add( "homeless_cl_hommat_start", "homeless_setuphommat_hooks", function()
        hook.Add( "Think", "homeless_cl_hommat_awake", function() -- i had no idea the RenderScene and PostDrawOpaqueRenderables hooks were so expensive!
            if not anythingRelevant then hook.Remove( "Think", "homeless_cl_hommat_awake" ) return end
            relevantAwake = false

            for _, ent in ipairs( relevant ) do
                if not IsValid( ent ) then continue end
                if ent:IsDormant() then continue end
                relevantAwake = true
                break

            end
        end )

        local texture = GetRenderTarget( "homeless_ffvGlitchTexture", ScrW(), ScrH() )

        hook.Add( "RenderScene", "homeless_ffvHOMRender", function()
            if not anythingRelevant then hook.Remove( "RenderScene", "homeless_ffvHOMRender" ) return end
            if not relevantAwake then return end

            render.RenderView( empty )
            render.CopyRenderTargetToTexture( texture )

        end )

        hook.Add( "PostDrawOpaqueRenderables", "homeless_ffvHOMDraw", function()
            if not anythingRelevant then hook.Remove( "PostDrawOpaqueRenderables", "homeless_ffvHOMDraw" ) return end
            if not relevantAwake then return end

            render.ClearStencil()
            render.SetStencilWriteMask( 255 )
            render.SetStencilTestMask( 255 )
            render.SetStencilPassOperation( STENCILOPERATION_KEEP )
            render.SetStencilZFailOperation( STENCILOPERATION_KEEP )

            render.SetStencilEnable( true )

            render.SetStencilReferenceValue( 1 )
            render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_ALWAYS )
            render.SetStencilPassOperation( STENCILOPERATION_REPLACE )

            local toDraw = table.Copy( relevant )
            local added = {}

            for _, e in ipairs( toDraw ) do
                if IsValid( e ) and not e:IsDormant() and halo.RenderedEntity() ~= e then
                    if
                        e:GetNW2Bool( "homeless_hallofmirrorify_glitchy", false ) and
                        e:GetPos():Distance( LocalPlayer():GetShootPos() ) > 450 and
                        math.random( 0, 100 ) > math.random( 90, 100 )

                    then
                        continue

                    end
                    e:DrawModel()
                    for _, child in ipairs( e:GetChildren() ) do
                        if not added[child] then
                            added[child] = true
                            table.insert( toDraw, child )

                        end
                    end
                end
            end

            render.SetStencilFailOperation( STENCILOPERATION_KEEP )
            render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
            render.ClearBuffersObeyStencil( 0, 0, 0, 255, true )

            render.DrawTextureToScreen( texture )

            render.SetStencilEnable( false )

        end )

        hook.Add( "InitPostEntity", "homeless_hommat", function()
            if not terminator_Extras then return end
            terminator_Extras.homeless_HomMat = texture

        end )
    end )
end

-- also done on server
hook.Add( "CreateClientsideRagdoll", "homeless_hommat_persist", function( died, rag )
    if not died:GetNW2Bool( varName, false ) then return end
    rag:SetNW2Bool( varName, true )

end )