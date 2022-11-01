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
vitalik_ne_pidor = class({})
LinkLuaModifier( "modifier_vitalik_ne_pidor", "heroes/vitalik/modifier_vitalik_ne_pidor", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function vitalik_ne_pidor:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge.vpcf", context )
end

function vitalik_ne_pidor:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function vitalik_ne_pidor:GetIntrinsicModifierName()
	return "modifier_vitalik_ne_pidor"
end