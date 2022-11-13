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
nastya_vezuha = class({})
LinkLuaModifier( "modifier_nastya_vezuha", "heroes/nastya/modifier_nastya_vezuha", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nastya_vezuha_proc", "heroes/nastya/modifier_nastya_vezuha_proc", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function nastya_vezuha:GetIntrinsicModifierName()
	return "modifier_nastya_vezuha"
end

--------------------------------------------------------------------------------
-- Item Events
function nastya_vezuha:OnInventoryContentsChanged( params )
	local caster = self:GetCaster()

	-- get data
	local scepter = caster:HasScepter()
	local ability = caster:FindAbilityByName( "ogre_magi_unrefined_fireblast_lua" )

	-- if there's no ability, why bother
	if not ability then return end

	ability:SetActivated( scepter )
	ability:SetHidden( not scepter )

	if ability:GetLevel()~=1 then
		ability:SetLevel( 1 )
	end
end