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
modifier_relt_pencil_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_relt_pencil_debuff:IsHidden()
	return false
end

function modifier_relt_pencil_debuff:IsDebuff()
	return true
end

function modifier_relt_pencil_debuff:IsStunDebuff()
	return false
end

function modifier_relt_pencil_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_relt_pencil_debuff:OnCreated( kv )
	-- references
	self.parent = self:GetParent()

	self.slow = -self:GetAbility():GetSpecialValueFor( "slow_move_pct" )

	if not IsServer() then return end
	
	-- play effects
	local direction = Vector( kv.x, kv.y, 0 ):Normalized()
	self:PlayEffects( direction )
end

function modifier_relt_pencil_debuff:OnRefresh( kv )
end

function modifier_relt_pencil_debuff:OnRemoved()
end

function modifier_relt_pencil_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_relt_pencil_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_relt_pencil_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_relt_pencil_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_relt_pencil_debuff:PlayEffects( direction )
	-- NOTE: Particle doesn't appear, don't know why

	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_debuff.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, 1, direction )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end