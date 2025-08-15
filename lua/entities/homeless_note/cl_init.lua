include( "shared.lua" )

function ENT:MatPath()
    return "homeless/note" .. ( self:GetCreationID() % 4 ) + 1 .. ".png"

end

function ENT:Initialize()
    local mat = Material( self:MatPath(), "smooth alphatest vertexlitgeneric nocull" )
    if not mat or mat:IsError() then
        return

    end
    self.homeless_NoteMat = mat

end

function ENT:Draw()
    local mat = self.homeless_NoteMat
    if mat then
        render.MaterialOverride( mat )

    end
    self:DrawModel()
    if mat then
        render.MaterialOverride()

    end
end

local function ShutDownPanel( panel )
    if not panel then return end
    panel:Close()
    surface.PlaySound( "homeless/562019__mattruthsound__paper-ball.mp3" )

end

local function MakeEasyClose( panel ) -- from cfc JID ( my code )
    local clientsMenuKey = input.LookupBinding( "+menu" )
    if clientsMenuKey then
        clientsMenuKey = input.GetKeyCode( clientsMenuKey )
    end

    local clientsUseKey = input.LookupBinding( "+use" )
    if clientsUseKey then
        clientsUseKey = input.GetKeyCode( clientsUseKey )
    end

    panel.nextDeleteThink = CurTime() + 0.25

    function panel:Think()
        -- bail if they open any menu, or press use
        if self.nextDeleteThink > CurTime() then return end
        if input.IsKeyDown( KEY_ESCAPE ) then ShutDownPanel( self ) return end
        if input.IsKeyDown( clientsMenuKey ) or input.IsKeyDown( clientsUseKey ) then
            if self.wasNotPressed then
                ShutDownPanel( self )

            end
            return

        end
        self.wasNotPressed = true
        if not input.IsMouseDown( MOUSE_LEFT ) and not input.IsMouseDown( MOUSE_RIGHT ) then return end

        -- close when clicking off menu
        local myX, myY = self:GetPos()
        local myWidth, myHeight = self:GetSize()
        local mouseX, mouseY = input.GetCursorPos()

        if mouseX < myX or mouseX > myX + myWidth then ShutDownPanel( self ) return end
        if mouseY < myY or mouseY > myY + myHeight then ShutDownPanel( self ) return end

    end

    -- only do this AFTER everything else could error
    panel:MakePopup()
    panel:SetKeyboardInputEnabled( false )

end

local uiScaleVert = ScrH() / 1080
local uiScaleHoris = ScrW() / 1920

function sizeScaled( sizeX, sizeY ) -- from glee
    if sizeX and sizeY then
        return sizeX * uiScaleHoris, sizeY * uiScaleVert

    elseif sizeX then
        return sizeX * uiScaleHoris

    elseif sizeY then
        return sizeY * uiScaleVert

    end
end

-- text in note
local fontData = {
    font = "Paranoid Freak", -- confirmed this falls back okay if font doesnt get sent
    extended = false,
    size = sizeScaled( nil, 40 ),
    weight = 500,
    blursize = 0,
    scanlines = 1,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
}
surface.CreateFont( "homeless_text", fontData )

local postambles = {
    "Weird.",
    "It's blank.",
    "There's nothing on it.",
    "It looks like, maybe a bird?",
    "Looks like a person?",
    "Just random lines.",
    "It's just lines.",
    "It has a weird crude drawing of a bird.",
    "It reminds you of a bird.",
    "It's a stick figure bird.",
    "It's a drawing of something, maybe a bird?",
    "It's a drawing of, probably a person?",
    "It looks like, a person?",
    "It's all black, just black.",
    "There's a drawing of a brick.",
    "It's a drawing of a tree.",
    "It's a drawing of a dead tree.",
    "It's a drawing of a building.",
    "It's a drawing of a chair.",

    "There's a dead bug squished into it.",

    "I can't read this.",
    "It's just spirals.",
    "It's wet.",
    "It's burnt on one corner.",
    "It smells like salt.",
    "It smells like home",
    "It smells like fish",
    "It smells like rotting fish.",
    "It feels sandy.",
    "It's damp.",
    "It's ripped down the middle",
    "It's like it's been folded a hundred times.",
    "It's yellowing.",
    "It's drying out your hand",
    "Is that bird poop on it?",
    "Did you leave it here?",
    "Was this here before?",
    "Did you drop this?"
}


local white = Color( 255, 255, 255 )
local black = Color( 0, 0, 0 )
-- texture credit https://www.vecteezy.com/photo/19925362-close-up-old-torn-paper-on-isolated-white-background

function noteYap( yap )
    yap = yap or postambles[math.random( 1, #postambles )]
    chat.AddText( white, "A piece of paper.\n" .. yap )

end
local replace = {
    [","] = { " " },
    ["you're"] = { "you are", "your" }, -- HIM is bad at grammar ( font doesnt have punctuation )
}
local validChars = " qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM\n"

local function sanitize( str )
    for needle, replacements in pairs( replace ) do
        local replacement = replacements[math.random( 1, #replacements )]
        str = string.Replace( str, needle, replacement )

    end
    local exploded = string.Explode( "", str )
    local valid = {}
    for _, curr in ipairs( exploded ) do
        if string.find( validChars, curr, 1, true ) then
            table.insert( valid, curr )

        end
    end
    local validConcatted = table.concat( valid, "" )
    return validConcatted

end

local base = Vector( 0.25, 0.25, 0.25 )

net.Receive( "homeless_noteused", function()
    local note = net.ReadEntity()
    if not IsValid( note ) then return end

    local text = sanitize( net.ReadString() )
    local mat = Material( note:MatPath(), "smooth alphatest nocull" )

    if not mat or mat:IsError() then
        noteYap()
        return

    end

    if not text or text == "" then
        noteYap()
        return

    end

    if text == "nothing" then
        noteYap( "It just says nothing." )
        return

    end

    local ready

    local panel = vgui.Create( "DFrame" )

    panel:SetSize( sizeScaled( 600, 800 ) )
    panel:SetTitle( "" )
    panel:SetVisible( true )
    panel:SetDraggable( true )

    MakeEasyClose( panel )

    panel:Center()

    panel:ShowCloseButton( false )

    function panel:Paint( w, h )
        if not ready then return end

        local lightColor = render.GetLightColor( LocalPlayer():GetShootPos() )
        lightColor = lightColor * 2
        lightColor = lightColor + base

        local oldColor = self.oldColor
        if oldColor then
            lightColor = LerpVector( math.Rand( 0.01, 0.05 ), oldColor, lightColor )

        end
        self.oldColor = lightColor

        surface.SetDrawColor( Color( 255 * lightColor.x, 255 * lightColor.y, 255 * lightColor.z ) )

        surface.SetMaterial( mat )
        surface.DrawTexturedRect( 0, 0, w, h )

    end

    local paddingW, paddingH = sizeScaled( 50, 100 )
    panel:DockPadding( paddingW, paddingH, paddingW, paddingH )

    local textPanel = vgui.Create( "DLabel", panel )
    textPanel:Dock( TOP )
    textPanel:SetWrap( true )
    textPanel:SetAutoStretchVertical( true )
    textPanel:SetColor( black )
    textPanel:SetFont( "homeless_text" )
    textPanel:SetText( "" )

    LocalPlayer():PrintMessage( HUD_PRINTCONSOLE, text .. "\n" )

    timer.Simple( 0.01, function()
        ready = true
        textPanel:SetText( text )

        net.Start( "homeless_confirmused" )
        net.SendToServer()

    end )
end )