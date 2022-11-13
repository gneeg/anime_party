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
modifier_bair_terpila = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bair_terpila:IsHidden()
	return self:GetStackCount()<1
end

function modifier_bair_terpila:IsDebuff()
	return false
end

function modifier_bair_terpila:IsPurgable()
	return false
end

-- Optional Classifications
function modifier_bair_terpila:RemoveOnDeath()
	return false
end

function modifier_bair_terpila:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bair_terpila:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.damage_limit = self:GetAbility():GetSpecialValueFor( "damage_limit" )
	self.stack_limit = self:GetAbility():GetSpecialValueFor( "stack_limit" )
	self.duration = self:GetAbility():GetSpecialValueFor( "stack_duration" )
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )

	if not IsServer() then return end
end

function modifier_bair_terpila:OnRefresh( kv )
	-- references
	self.damage_limit = self:GetAbility():GetSpecialValueFor( "damage_limit" )
	self.stack_limit = self:GetAbility():GetSpecialValueFor( "stack_limit" )
	self.duration = self:GetAbility():GetSpecialValueFor( "stack_duration" )	
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
end

function modifier_bair_terpila:OnRemoved()
end

function modifier_bair_terpila:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bair_terpila:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

function modifier_bair_terpila:OnTakeDamage( params )
	if self.parent:PassivesDisabled() then return end
	if self.parent:HasModifier( "modifier_bair_terpila_buff" ) then return end

	if params.unit~=self.parent then return end
	if not params.attacker:IsConsideredHero() then return end

	-- increment stack, refresh duration
	if self:GetStackCount()<self.stack_limit then
		self:IncrementStackCount()

		-- roar
		if self:GetStackCount()==self.stack_limit then
			EmitSoundOn( "Hero_PrimalBeast.Uproar.MaxStacks", self.parent )
		end
	end
	self:SetDuration( self.duration, true )
	self:StartIntervalThink(self.duration)
end

function modifier_bair_terpila:GetModifierPreAttack_BonusDamage()
	return self.damage
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_bair_terpila:OnIntervalThink()
	self:ResetStack()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_bair_terpila:ResetStack()
	self:SetStackCount(0)
end