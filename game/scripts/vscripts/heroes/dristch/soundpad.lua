dristch_soundpad = class({})
LinkLuaModifier( "modifier_dristch_soundpad", "heroes/dristch/modifier_dristch_soundpad", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dristch_soundpad_slow", "heroes/dristch/modifier_dristch_soundpad_slow", LUA_MODIFIER_MOTION_NONE )
	
--------------------------------------------------------------------------------
-- Ability Start
function dristch_soundpad:OnSpellStart()
	-- Effects
	local sound_cast = "Ability.SandKing_Epicenter.spell"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

--------------------------------------------------------------------------------
-- Ability Channeling
-- function dristch_soundpad:GetChannelTime()

-- end

function dristch_soundpad:OnChannelFinish( bInterrupted )
	-- cancel if fail
	if bInterrupted then 
		local sound_cast = "Ability.SandKing_Epicenter.spell"
		StopSoundOn( sound_cast, self:GetCaster() )
		return
	end

	-- unit identifier
	local caster = self:GetCaster()

	-- add modifier
	local duration = self:GetDuration()
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_dristch_soundpad", -- modifier name
		{ duration = duration } -- kv
	)

	-- Effects
	local sound_cast = "Ability.SandKing_Epicenter"
	EmitSoundOn( sound_cast, caster )
end