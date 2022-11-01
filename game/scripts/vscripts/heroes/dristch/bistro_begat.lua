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
dristch_bistro_begat = class({})
LinkLuaModifier( "modifier_dristch_bistro_begat", "heroes/dristch/modifier_dristch_bistro_begat", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dristch_bistro_begat_debuff", "heroes/dristch/modifier_dristch_bistro_begat_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function dristch_bistro_begat:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts", context )
	-- PrecacheResource( "particle", "particles/units/heroes/hero_razor/razor_storm_surge_lua.vpcf", context )
end

function dristch_bistro_begat:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function dristch_bistro_begat:GetIntrinsicModifierName()
	return "modifier_dristch_bistro_begat"
end