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
modifier_vitalik_oskorblenie = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_vitalik_oskorblenie:IsHidden()
	return false
end

function modifier_vitalik_oskorblenie:IsDebuff()
	return true
end

function modifier_vitalik_oskorblenie:IsStunDebuff()
	return false
end

function modifier_vitalik_oskorblenie:IsPurgable()
	return true
end

function modifier_vitalik_oskorblenie:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_vitalik_oskorblenie:OnCreated( kv )
	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )

	if not IsServer() then return end

	-- Start interval
	self:StartIntervalThink( kv.duration )

	-- play effects
	local sound_cast = "Hero_Silencer.LastWord.Target"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_vitalik_oskorblenie:OnRefresh( kv )
	
end

function modifier_vitalik_oskorblenie:OnRemoved()
end

function modifier_vitalik_oskorblenie:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vitalik_oskorblenie:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,

		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_vitalik_oskorblenie:GetModifierProvidesFOWVision()
	return 1
end

function modifier_vitalik_oskorblenie:OnAbilityFullyCast( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end
	if params.ability:IsItem() then return end

	-- silence
	self:Silence()
end
--------------------------------------------------------------------------------
-- Interval Effects
function modifier_vitalik_oskorblenie:OnIntervalThink()
	-- silence
	self:Silence()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_vitalik_oskorblenie:Silence()
	-- add silence
	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_silenced_lua", -- modifier name
		{ duration = self.duration } -- kv
	)

	-- damage
	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	-- play effects
	self:PlayEffects()

	local sound_cast = "Hero_Silencer.LastWord.Target"
	StopSoundOn( sound_cast, self:GetParent() )

	-- destroy
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_vitalik_oskorblenie:GetEffectName()
	return "particles/units/heroes/hero_silencer/silencer_last_word_status.vpcf"
end

function modifier_vitalik_oskorblenie:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_vitalik_oskorblenie:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_silencer/silencer_last_word_dmg.vpcf"
	local sound_cast = "Hero_Silencer.LastWord.Damage"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end