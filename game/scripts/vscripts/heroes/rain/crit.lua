rain_crit = class({})
LinkLuaModifier( "modifier_rain_crit", "heroes/rain/modifier_rain_crit", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function rain_crit:GetIntrinsicModifierName()
	return "modifier_rain_crit"
end
function rain_crit:PlayEffects( location )
	-- Get Resources
	local sound_cast = "rain_crit"
	EmitSoundOn( sound_cast, self:GetCaster() )
end