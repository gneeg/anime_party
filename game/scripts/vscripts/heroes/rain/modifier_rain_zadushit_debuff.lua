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
modifier_rain_zadushit_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_rain_zadushit_debuff:IsHidden()
	return false
end

function modifier_rain_zadushit_debuff:IsDebuff()
	return true
end

function modifier_rain_zadushit_debuff:IsStunDebuff()
	return false
end

function modifier_rain_zadushit_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_rain_zadushit_debuff:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "attack_speed_slow_per_stack" )

	if not IsServer() then return end
	self:SetStackCount( 1 )
end

function modifier_rain_zadushit_debuff:OnRefresh( kv )
	if not IsServer() then return end
	self:IncrementStackCount()
end

function modifier_rain_zadushit_debuff:OnRemoved()
end

function modifier_rain_zadushit_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_rain_zadushit_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_rain_zadushit_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.slow * self:GetStackCount()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_rain_zadushit_debuff:GetEffectName()
	-- return "particles/units/heroes/hero_snapfire/hero_snapfire_slow_debuff.vpcf"
	return "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf"
end

function modifier_rain_zadushit_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end