AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

util.AddNetworkString( "homeless_noteused" )
util.AddNetworkString( "homeless_confirmused" )

function ENT:Initialize()
    self:SetModel( "models/props_c17/paper01.mdl" )
    self:SetModelScale( math.Rand( 0.6, 0.8 ) )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

    local phys = self:GetPhysicsObject()
    if IsValid( phys ) then
        phys:Wake()

    end
    self.nextUse = CurTime() + 0.5

end

local strings = { -- hopefully this is schizo enough
    {
        "just wait until you are really ready",
        "watching you means everything to me",
        "i'm ready too",
        "i can tell you're almost ready",
        "don't leave me, you're almost ready",
        "dont try too hard to be ready",
        "its okay if you leave, just come back\n    then youll be ready",
        "dont be scared, i know you're gonna be ready soon",
        "youll be really ready, just wait",
        "the key to being really ready\n\nis knowing when to forget",

    },
    {
        "im, so proud of you",
        "im so glad you were ready to see me",
        "isn't it great, being ready",
        "you came back, you are ready",
        "it made me so happy as soon as i knew you were ready",
        "thank you for forgetting, for being really ready",
    },
    {
        "you will tell them im real now\n\nright",
        "dont lie to them, im real",
        "make sure they know im real now",
    },
    {
        "you dont need to try to be ready",
        "some people are never ready",
        "if you werent really ready, what were you?",
    },
    {
        "im so happy you didnt try too hard to be ready",
        "you never forget how to be ready",
        "the key to being ready is to wait,\nis to know when you're really ready, and wait",
    },
    {
        "a secret is that i love the beach\nits like home",
    },
    {
        "i found nothing",
        "i found home",
        "whats your home",
    },
    {
        "i found home and theres nothing there",
    },
    {
        "it smells like salt in here",
        "when you go into nothing, don't forget how to come back",
        "this reminds me of the time you werei n my walls",

    },
    {
        "there's nothing in the walls",
    },
    {
        "i found something in the walls, i found nothing in the walls",
        "if i go into the walls there's nothing there\nthere's nothing in the walls",
        "if i leave the walls there's something\nthere's no longer nothing",
        "don't forget how to leave the walls\n\nif you go far enough there's nothing, not even a way back",
    },
    {
        "you can still come back from nothing",
        "would you go into someone's home, without asking?\n\n\ni wouldn't",
        "would you go into someone's home, without asking?\n\n\nwould you?",
        "would you go into someone's home, without asking?\n\n\n\nits a simple question",
        "would you go into someone's home, without asking?",
    },
    {
        "take care of your walls, you never know when you will need them most",
        "i gave everything to my walls\nuntil i could only give nothing",
    },
    {
        "nothing is what makes something",
        "something exists only with nothing",
    },
    {
        "nothing feels like the beach on a summer day\nthe waves crashing around your feet\n\nit's like nothing changed",
        "nothing is like being on a sailboat with no wind\nyou know what to do, but nothing changes",
    },
    {
        "if nobody sees this\nis it nothing?",
        "is nothing something\nif someone finds it?",
    },
    {
        "it's good to have something",
        "home is where there's something\nor maybe nothing",
        "please keep showing me something new\n\n\n\nnot nothing",
    },
    {
        "i forgot what it means to see nothing",
        "i forgot what it means to see something",
    },
    {
        "does letting go of nothing mean anything to you?",
        "holding onto home, does it mean nothing?",
    },
    {
        "can you make something for me\nit's the only way for me to see nothing again",
        "can you make nothing for me\nit's the only way for me too see something",
    },
    {
        "if you made something, it worked, i saw nothing new",
        "if you made something, it worked, i saw something new",
    },
    {
        "don't tell them about my home",
        "don't let yourself see nothing",
    },
    {
        "even if you can't live forever\n\nyou can see so much more than nothing",
    },
    {
        "what would you do to live\nlive forever",
    },
    {
        "what would YOU DO to live\nFOREVER",
    },
    {
        "what would you do to live forever",
    },
    {
        "forever is a long time\n\n\nisnt it",
    },
    {
        [[there's nothing in the walls
        there's nothing in the walls
          there's nothing in the walls
        there's nothing in the walls
        there's nothing in the walls
         there's nothing in the walls]],

        [[there's nothing in the walls
there's nothing in the walls
    there's nothing in the walls
      there's nothing in the walls
     there's nothing in the walls
         there's nothing in the walls]]

    },
    {
        "i wish i could see the sky like you can",
    },
    {
        "can you make the sky for me, the real sky",
        "i want to see the real sky, please make it for me",
    }, -- true schizo ramblings
    {
        "you should make what it feels like to fly through the sky",
    },
    {
        "what does it feel like to fly through the sky, do you see anything?"
    },
    {
        "i think the real sky looks like nothing, the purest of nothing\nwith specks of something stuck between all that nothing",
    },
    {
        "what i would do to see a sky with something in it\nmy sky is nothing\nit seems like it goes on and on, but it's a cage, with a fire on the wall",
    },
    {
        "you see these things, i know that, you know all about this nothing\nall about my home\n\n          but you know nothing",
    },
    {
        "i know i must seem crazy to you\n but i'm nothing\nit's just you here, you know this\n\nbut why do i need to say this for you to see it.",
    },
    {
        "i am NOTHING\ni am my own cage\ni am the fire on your wall\ni am nothing"
    },
    {
        "beaches show us our future, they always change, they always have something happening\nyou never forget a beach",
    },
    { -- a happy ending, smile please
        "something is like a beach at sunrise\neverything's waking up\neverything's becoming nothing\nand it's beautiful",
    }
}

local yeahWeWereJustUsed = 0

function ENT:Use( user )
    if self.nextUse > CurTime() then return end
    if not IsValid( user ) then return end
    if not user:IsPlayer() then return end

    user.homeless_HasPickedUpNote = true

    self.nextUse = CurTime() + 0.5

    self:EmitSound( "homeless/562019__mattruthsound__paper-ball.mp3", 70, math.random( 120, 140 ) )

    local idealDetail = user:GetInfoNum( "ai_note_ideal_detail", 0 )
    local currDetail = homeless_NoteDetail( user )

    local writing
    local simpleYap

    if idealDetail >= #strings then
        writing = "nothing"
        simpleYap = true

    elseif idealDetail <= currDetail or not self.homeless_DeservesToExist or homeless_GetRelation( user ) <= -9 then
        writing = ""
        simpleYap = true

    else
        local currStrings = strings[ idealDetail + 1 ]
        writing = currStrings[math.random( 1, #currStrings )]

    end

    yeahWeWereJustUsed = CurTime() + 1

    net.Start( "homeless_noteused" )
        net.WriteEntity( self )
        net.WriteString( writing )
    net.Send( user )

    if simpleYap then
        SafeRemoveEntity( self )
        homeless_Playerness( ply, 0.5 )

    else -- give time for the netmessage
        SafeRemoveEntityDelayed( self, 0.05 )

    end
end

net.Receive( "homeless_confirmused", function( _, ply )
    if not IsValid( ply ) then return end -- ??? might happen

    if not yeahWeWereJustUsed then return end
    if yeahWeWereJustUsed < CurTime() then return end
    yeahWeWereJustUsed = nil -- burn it

    local idealDetail = ply:GetInfoNum( "ai_note_ideal_detail", 0 )
    local currDetail = homeless_NoteDetail( ply )
    if idealDetail > currDetail then
        ply:ConCommand( "ai_note_detail " .. idealDetail )
        --ply:ConCommand( "ai_note_ideal_detail " .. idealDetail + 1 ) --debug

    end

    homeless_NudgeRelation( ply, 1 )
    homeless_Playerness( ply, 5 )

    homeless_DoItButPerf( 2 + math.floor( idealDetail / 5 ) )
    if terminator_Extras.homeless_Overlooks and #terminator_Extras.homeless_Overlooks >= 1 then
        homeless_DoOverlooking( ply:GetInfoNum( "cl_homeless_dedication", 0 ) )

    end
end )