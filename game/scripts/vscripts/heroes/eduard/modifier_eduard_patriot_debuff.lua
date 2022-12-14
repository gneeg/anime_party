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
modifier_eduard_patriot_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_eduard_patriot_debuff:IsHidden()
	return false
end

function modifier_eduard_patriot_debuff:IsDebuff()
	return true
end

function modifier_eduard_patriot_debuff:IsStunDebuff()
	return false
end

function modifier_eduard_patriot_debuff:IsPurgable()
	return false
end

function modifier_eduard_patriot_debuff:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_eduard_patriot_debuff:OnCreated( kv )
	-- references
	self.rate = self:GetAbility():GetSpecialValueFor( "animation_rate" )

	if not IsServer() then return end
end

function modifier_eduard_patriot_debuff:OnRefresh( kv )
	
end

function modifier_eduard_patriot_debuff:OnRemoved()
end

function modifier_eduard_patriot_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_eduard_patriot_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}

	return funcs
end

function modifier_eduard_patriot_debuff:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

function modifier_eduard_patriot_debuff:GetOverrideAnimationRate()
	return self.rate
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_eduard_patriot_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_NIGHTMARED] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_eduard_patriot_debuff:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_song_debuff.vpcf"
end

function modifier_eduard_patriot_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_eduard_patriot_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_siren_song.vpcf"
end

function modifier_eduard_patriot_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end