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
rain_zadushit = class({})
LinkLuaModifier( "modifier_rain_zadushit", "heroes/rain/modifier_rain_zadushit", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_rain_zadushit_debuff", "heroes/rain/modifier_rain_zadushit_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function rain_zadushit:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetDuration()

	-- addd buff
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_rain_zadushit", -- modifier name
		{ duration = duration } -- kv
	)
end