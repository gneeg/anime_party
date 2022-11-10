-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
dristch_armored = class({})
LinkLuaModifier( "modifier_dristch_armored", "heroes/dristch/modifier_dristch_armored", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function dristch_armored:GetIntrinsicModifierName()
	return "modifier_dristch_armored"
end