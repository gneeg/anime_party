eduard_rekrut = class({})
LinkLuaModifier( "modifier_eduard_rekrut", "heroes/eduard/modifier_eduard_rekrut", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_eduard_rekrut_effect", "heroes/eduard/modifier_eduard_rekrut_effect", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function eduard_rekrut:GetIntrinsicModifierName()
	return "modifier_eduard_rekrut"
end