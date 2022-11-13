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
modifier_nastya_zoloto = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_nastya_zoloto:IsHidden()
	return false
end

function modifier_nastya_zoloto:IsDebuff()
	return false
end

function modifier_nastya_zoloto:IsStunDebuff()
	return false
end

function modifier_nastya_zoloto:IsPurgable()
	return false
end

function modifier_nastya_zoloto:AllowIllusionDuplicate() -- seems not working
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_nastya_zoloto:OnCreated( kv )
	-- references
	self.base_gold = self:GetAbility():GetSpecialValueFor( "bonus_gold" )
	self.bonus_gold = self:GetAbility():GetSpecialValueFor( "bonus_bonus_gold" )
	self.max_gold = self:GetAbility():GetSpecialValueFor( "bonus_gold_cap" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	if not IsServer() then return end
	if self:GetCaster():IsIllusion() then
		self:Destroy()
		return
	end

	self.actual_stack = 0
	self:CalculateStack()
end

function modifier_nastya_zoloto:OnRefresh( kv )
	-- references
	self.base_gold = self:GetAbility():GetSpecialValueFor( "bonus_gold" )
	self.bonus_gold = self:GetAbility():GetSpecialValueFor( "bonus_bonus_gold" )
	self.max_gold = self:GetAbility():GetSpecialValueFor( "bonus_gold_cap" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	if not IsServer() then return end
	self:CalculateStack()
end

function modifier_nastya_zoloto:OnRemoved()
end

function modifier_nastya_zoloto:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_nastya_zoloto:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_nastya_zoloto:OnDeath( params )
	if not IsServer() then return end
	if params.attacker~=self:GetParent() then return end
	if self:GetCaster():GetTeamNumber()==params.unit:GetTeamNumber() then return end
	if params.unit:IsBuilding() then return end
	if self:GetParent():PassivesDisabled() then return end

	-- gib gold
	local gold = self:GetStackCount()
	PlayerResource:ModifyGold( self:GetParent():GetPlayerOwnerID(), gold, false, DOTA_ModifyGold_Unspecified )

	-- add stack
	self:AddStack()

	-- Play effects
	self:PlayEffects1()
	self:PlayEffects2( gold )
end

--------------------------------------------------------------------------------
-- Helper
function modifier_nastya_zoloto:AddStack()
	self.actual_stack = self.actual_stack + 1
	self:CalculateStack()

	-- add stack
	local modifier = self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_nastya_zoloto_stack", -- modifier name
		{ duration = self.duration } -- kv
	)

	modifier.parent_modifier = self
end
function modifier_nastya_zoloto:RemoveStack()
	self.actual_stack = self.actual_stack - 1
	self:CalculateStack()
end
function modifier_nastya_zoloto:CalculateStack()
	local stack = math.min( self.base_gold + self.actual_stack*self.bonus_gold, self.max_gold )
	self:SetStackCount( stack )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_nastya_zoloto:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), self:GetParent():GetPlayerOwner() )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_nastya_zoloto:PlayEffects2( gold )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_lasthit_msg_gold.vpcf"

	-- get data
	local digit = math.ceil(math.log( gold ))

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), self:GetParent():GetPlayerOwner() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 0, gold, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, digit, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( 255, 255, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end