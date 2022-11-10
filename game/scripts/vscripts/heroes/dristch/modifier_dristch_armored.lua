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
modifier_dristch_armored = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dristch_armored:IsHidden()
	return true
end

function modifier_dristch_armored:IsDebuff()
	return false
end

function modifier_dristch_armored:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dristch_armored:OnCreated( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
	self.regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
end

function modifier_dristch_armored:OnRefresh( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
	self.regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )	
end

function modifier_dristch_armored:OnRemoved()
end

function modifier_dristch_armored:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dristch_armored:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_dristch_armored:GetModifierConstantHealthRegen()
	if not self:GetParent():PassivesDisabled() then
		return self.regen
	end
end

function modifier_dristch_armored:GetModifierPhysicalArmorBonus()
	if not self:GetParent():PassivesDisabled() then
		return self.armor
	end
end