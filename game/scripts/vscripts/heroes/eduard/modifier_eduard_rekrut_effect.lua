modifier_eduard_rekrut_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_eduard_rekrut_effect:IsHidden()
	return false
end

function modifier_eduard_rekrut_effect:IsDebuff()
	return true
end

function modifier_eduard_rekrut_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_eduard_rekrut_effect:OnCreated( kv )

	self.as_slow = self:GetAbility():GetSpecialValueFor( "attack_bonus_tooltip" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_eduard_rekrut_effect:OnRefresh( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attack_bonus_tooltip" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_eduard_rekrut_effect:OnRemoved()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_eduard_rekrut_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end
function modifier_eduard_rekrut_effect:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end
function modifier_eduard_rekrut_effect:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_eduard_rekrut_effect:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_degen_aura_debuff.vpcf"
end

function modifier_eduard_rekrut_effect:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end