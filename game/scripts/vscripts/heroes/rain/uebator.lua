rain_uebator = class({})
LinkLuaModifier( "modifier_rain_uebator", "heroes/rain/modifier_rain_uebator", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_bashed_lua", "lua_abilities/generic/modifier_generic_bashed_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function rain_uebator:GetIntrinsicModifierName()
	return "modifier_rain_uebator"
end
