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
eduard_defend = class({})
LinkLuaModifier( "modifier_eduard_defend", "heroes/eduard/modifier_eduard_defend", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_eduard_defend_stack", "heroes/eduard/modifier_eduard_defend_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function eduard_defend:GetIntrinsicModifierName()
	return "modifier_eduard_defend"
end