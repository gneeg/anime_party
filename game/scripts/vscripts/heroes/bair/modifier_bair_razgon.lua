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
modifier_bair_razgon = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bair_razgon:IsHidden()
	return false
end

function modifier_bair_razgon:IsDebuff()
	return false
end

function modifier_bair_razgon:IsStunDebuff()
	return false
end

function modifier_bair_razgon:IsPurgable()
	return false
end

function modifier_bair_razgon:AllowIllusionDuplicate()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bair_razgon:OnCreated( kv )
	-- references
	self.bat = self:GetAbility():GetSpecialValueFor( "base_attack_time" )
	self.health = self:GetAbility():GetSpecialValueFor( "bonus_health" )
	self.health_regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "bonus_mana_regen" )
	self.movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movespeed" )

	if not IsServer() then return end

	-- disjoint & purge
	ProjectileManager:ProjectileDodge( self:GetParent() )
	self:GetParent():Purge( false, true, false, false, false )

	-- play effects
	self:PlayEffects()
end

function modifier_bair_razgon:OnRefresh( kv )
	-- references
	self.bat = self:GetAbility():GetSpecialValueFor( "base_attack_time" )
	self.health = self:GetAbility():GetSpecialValueFor( "bonus_health" )
	self.health_regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "bonus_mana_regen" )
	self.movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movespeed" )

	if not IsServer() then return end

	-- disjoint & purge
	ProjectileManager:ProjectileDodge( self:GetParent() )
	self:GetParent():Purge( false, true, false, false, false )
end

function modifier_bair_razgon:OnRemoved()
end

function modifier_bair_razgon:OnDestroy()
	if not IsServer() then return end

	-- stop effects
	local sound_cast = "Hero_Alchemist.ChemicalRage"
	StopSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bair_razgon:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_bair_razgon:GetModifierBaseAttackTimeConstant()
	return self.bat
end
function modifier_bair_razgon:GetModifierConstantHealthRegen()
	return self.health_regen
end
function modifier_bair_razgon:GetModifierHealthBonus()
	return self.health
end
function modifier_bair_razgon:GetModifierConstantManaRegen()
	return self.mana_regen
end
function modifier_bair_razgon:GetModifierMoveSpeedBonus_Constant()
	return self.movespeed
end
-- --------------------------------------------------------------------------------
-- -- Status Effects
-- function modifier_bair_razgon:CheckState()
-- 	local state = {
-- 		[MODIFIER_STATE_INVULNERABLE] = true,
-- 	}

-- 	return state
-- end

-- --------------------------------------------------------------------------------
-- -- Interval Effects
-- function modifier_bair_razgon:OnIntervalThink()
-- end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bair_razgon:GetHeroEffectName()
	return "particles/units/heroes/hero_alchemist/alchemist_chemical_rage_hero_effect.vpcf"
end

function modifier_bair_razgon:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf"
	local sound_cast = "Hero_Alchemist.ChemicalRage"

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end