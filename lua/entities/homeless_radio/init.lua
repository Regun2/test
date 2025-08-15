AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

local static = "hl1/ambience/deadsignal2.wav"

function ENT:SetupSongs()
    self.Songs = {
        [1] = static,
        [2] = { static, static, static, static, static,
            "ambient/levels/coast/seagulls_ambient1.wav",
            "ambient/water/lake_water.wav",
            "ambient/water/distant_wave1.wav",
            "ambient/water/distant_wave2.wav",
            "ambient/water/distant_wave3.wav",
        },
        [3] = { static,
            "ambient/levels/coast/seagulls_ambient1.wav",
            "ambient/levels/coast/seagulls_ambient2.wav",
            "ambient/levels/coast/seagulls_ambient3.wav",
            "ambient/levels/coast/seagulls_ambient4.wav",
            "ambient/water/underwater.wav",
            "homeless/ambiance/coldwind1_loop.wav", -- bro said he knew a spot 💀
            "homeless/ambiance/coldwind2_loop.wav",
            "homeless/ambiance/coldwind3_loop.wav",
            "homeless/ambiance/145213__rmutt__oceanwaves-1.mp3",
            "homeless/ambiance/tornado_siren_distant.mp3", -- credit tornado alley
            "homeless/ambiance/siren_broken.mp3", -- ditto
            "homeless/ambiance/eas_alert1.mp3", -- ditto
            "homeless/ambiance/eas_tv.mp3", -- ditto

        }
    }
end

function ENT:Initialize()
    self:SetModel( "models/props_lab/citizenradio.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetSkin( 1 )
    self:SetUseType( SIMPLE_USE )

    local phys = self:GetPhysicsObject()
    if IsValid( phys ) then
        phys:Wake()

    end

    self.takenDamageTimes = 0
    self.nextTakeDamageTime = 0
    self.nextUseTime = 0
    self.audioDSP = 0
    self.audioPitch = 100
    self.RadioBroken = true

    self:SetupSongs()

end

function ENT:OnRemove()
    local filter = RecipientFilter()
    filter:AddAllPlayers()

    self:EmitSound( "ambient/_period.wav", 75, 100, 1, CHAN_ITEM, nil, self.audioDSP, filterAllPlayers )

end

function ENT:playTinny( path, chan, volMul )
    local vol = 0.85
    if path == static then
        vol = 0.45

    end
    if volMul then
        vol = vol * volMul

    end

    local filter = RecipientFilter()
    filter:AddPVS( self:WorldSpaceCenter() )
    filter:AddPAS( self:WorldSpaceCenter() )

    self:EmitSound( path, self.audioLvl, self.audioPitch, vol, chan, nil, self.audioDSP, filterAllPlayers )

end

function ENT:PlaySong()

    local first = homeless_FirstPly()
    local choose = first:GetInfoNum( "cl_homeless_dedication", 0 ) + 1
    local readyness = first:GetInfoNum( "cl_nav_readyness", 0 )
    local ready = IsValid( terminator_Extras.homeless ) or first:GetInfoNum( "cl_homeless_nexthomeless", 0 ) < os.time() or readyness >= 1

    self.homeless_Randoms = nil
    local song
    local volMul = 1
    if ready then
        song = self.Songs[choose]
        if istable( song ) then
            song = song[math.random( 1, #song )]
            if istable( song ) and song.looper then
                volMul = song.volMul
                self.homeless_Randoms = song.randoms
                song = song.looper
                self.nextRandomPlay = CurTime() + 1

            end
        end
    end
    if not song or not isstring( song ) then
        song = static

    end

    self:playTinny( song, CHAN_ITEM, volMul )
    self:SetSkin( 0 )

end

function ENT:TakeDamageRandomizeSong()
    self.audioLvl = 60

    self:EmitSound( "ambient/energy/spark" .. math.random( 1, 6 ) .. ".wav", 60 )
    self.takenDamageTimes = self.takenDamageTimes + 1

    self:EmitSound( "ambient/energy/zap" .. math.random( 1, 3 ) .. ".wav", 60, 100, CHAN_STATIC )
    local target = 55 + ( self.takenDamageTimes % 5 )
    self.audioDSP = target
    self.audioPitch = math.random( 70, 80 )

    self:PlaySong()

end

function ENT:Think()
    local nextRandomPlay = self.nextRandomPlay or 0
    if nextRandomPlay > CurTime() then return end

    local randoms = self.homeless_Randoms
    if not randoms then return end

    local chosen = randoms[math.random( 1, #randoms )]
    if not chosen then return end -- :(

    local dur = SoundDuration( chosen )
    self.nextRandomPlay = CurTime() + dur * math.Rand( 0.5, 1.5 ) + math.Rand( 1, 2 )

    self:playTinny( chosen, CHAN_STATIC )

end


function ENT:PhysicsCollide( data )
    if data.Speed < 500 then return end
    if self:IsPlayerHolding() then return end

    if self.nextTakeDamageTime > CurTime() then return end
    self.nextTakeDamageTime = CurTime() + 1

    if not homeless_FirstPlyLoaded() then return end
    self:TakeDamageRandomizeSong()

end

function ENT:OnTakeDamage( dmg )
    self:TakePhysicsDamage( dmg )

    if self.nextTakeDamageTime > CurTime() then return end
    self.nextTakeDamageTime = CurTime() + 0.1

    if not homeless_FirstPlyLoaded() then return end

    if not self.GivenPlayerness then
        self.GivenPlayerness = true
        homeless_Playerness( dmg:GetAttacker(), 0.5 )

    else
        homeless_Playerness( dmg:GetAttacker(), 0.01 )

    end
    self:TakeDamageRandomizeSong()

end

function ENT:Use( _activator, caller )
    if self.nextUseTime > CurTime() then return end
    self.nextUseTime = CurTime() + 0.1

    if not homeless_FirstPlyLoaded() then return end

    if not self.GivenPlayerness then
        self.GivenPlayerness = true
        homeless_Playerness( caller, 0.5 )

    else
        homeless_Playerness( caller, 0.01 )

    end
    self:TakeDamageRandomizeSong()

end

local GAMEMODE = GAMEMODE or GM
if not GAMEMODE.RandomlySpawnEnt then return end

GAMEMODE:RandomlySpawnEnt( "homeless_radio", 1, 1, 25 )