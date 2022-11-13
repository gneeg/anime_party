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
eduard_patriot = class({})
LinkLuaModifier( "modifier_eduard_patriot", "heroes/eduard/modifier_eduard_patriot", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_eduard_patriot_debuff", "heroes/eduard/modifier_eduard_patriot_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_eduard_patriot_scepter", "heroes/eduard/modifier_eduard_patriot_scepter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function eduard_patriot:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- create aura
	local modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_eduard_patriot", -- modifier name
		{ duration = duration } -- kv
	)

	-- check sister ability
	local ability = caster:FindAbilityByName( "eduard_patriot_end" )
	if not ability then
		ability = caster:AddAbility( "eduard_patriot_end" )
	end

	-- check ability level
	ability:SetLevel( 1 )

	-- give info about modifier
	ability.modifier = modifier

	-- switch ability layout
	caster:SwapAbilities(
		self:GetAbilityName(),
		ability:GetAbilityName(),
		false,
		true
	)

	-- set cooldown
	ability:StartCooldown( ability:GetCooldown( 1 ) )
end

--------------------------------------------------------------------------------
-- Cancel ability
--------------------------------------------------------------------------------
eduard_patriot_end = class({})
function eduard_patriot_end:OnSpellStart()
	-- kill modifier
	self.modifier:End()
	self.modifier = nil
end
