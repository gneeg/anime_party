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
modifier_bair_usil = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bair_usil:IsHidden()
	return false
end

function modifier_bair_usil:IsDebuff()
	return false
end

function modifier_bair_usil:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bair_usil:OnCreated( kv )
	-- references
	self.movespeed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
	self.resistance = self:GetAbility():GetSpecialValueFor( "status_resistance" )

	if not IsServer() then return end

	-- play effects
	local sound_cast = "Hero_Spirit_Breaker.Bulldoze.Cast"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_bair_usil:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_bair_usil:OnRemoved()
end

function modifier_bair_usil:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bair_usil:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE,
	}

	return funcs
end

function modifier_bair_usil:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end

function modifier_bair_usil:GetModifierStatusResistance()
	return self.resistance
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bair_usil:GetEffectName()
	return "particles/units/heroes/hero_spirit_breaker/spirit_breaker_haste_owner.vpcf"
end

function modifier_bair_usil:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end