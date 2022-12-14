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
modifier_vitalik_ne_pidor = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_vitalik_ne_pidor:IsHidden()
	return true
end

function modifier_vitalik_ne_pidor:IsDebuff()
	return false
end

function modifier_vitalik_ne_pidor:IsPurgable()
	return false
end

function modifier_vitalik_ne_pidor:AllowIllusionDuplicate()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_vitalik_ne_pidor:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.block = self:GetAbility():GetSpecialValueFor( "damage_reduction" )
	self.purge = self:GetAbility():GetSpecialValueFor( "damage_cleanse" )
	self.reset = self:GetAbility():GetSpecialValueFor( "damage_reset_interval" )

	if not IsServer() then return end
	self.damage = 0
end

function modifier_vitalik_ne_pidor:OnRefresh( kv )
	-- references
	self.block = self:GetAbility():GetSpecialValueFor( "damage_reduction" )
	self.purge = self:GetAbility():GetSpecialValueFor( "damage_cleanse" )
	self.reset = self:GetAbility():GetSpecialValueFor( "damage_reset_interval" )
end

function modifier_vitalik_ne_pidor:OnRemoved()
end

function modifier_vitalik_ne_pidor:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vitalik_ne_pidor:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}

	return funcs
end

function modifier_vitalik_ne_pidor:OnTakeDamage( params )
	if not IsServer() then return end
	if params.unit~=self.parent then return end
	if self.parent:PassivesDisabled() then return end

	-- only player-based damage
	if not params.attacker:GetPlayerOwner() then return end

	-- start interval
	self:StartIntervalThink( self.reset )

	-- check if purge
	self.damage = self.damage + params.damage
	if self.damage < self.purge then return end
	self.damage = 0

	-- purge
	self.parent:Purge( false, true, false, true, true )

	-- effect
	self:PlayEffects()
end

function modifier_vitalik_ne_pidor:GetModifierPhysical_ConstantBlock()
	if self.parent:PassivesDisabled() then return 0 end
	return self.block
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_vitalik_ne_pidor:OnIntervalThink()
	self:StartIntervalThink( -1 )

	-- reset
	self.damage = 0
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_vitalik_ne_pidor:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge.vpcf"
	local sound_cast = "Hero_Tidehunter.KrakenShell"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end