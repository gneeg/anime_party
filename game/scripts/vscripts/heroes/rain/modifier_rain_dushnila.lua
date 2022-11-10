modifier_rain_dushnila = class({})
--------------------------------------------------------------------------------

function modifier_rain_dushnila:IsDebuff()
	return self:GetParent()~=self:GetAbility():GetCaster()
end

function modifier_rain_dushnila:IsHidden()
	return self:GetParent()==self:GetAbility():GetCaster()
end

function modifier_rain_dushnila:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------

function modifier_rain_dushnila:IsAura()
	if self:GetCaster() == self:GetParent() then
		if not self:GetCaster():PassivesDisabled() then
			return true
		end
	end
	
	return false
end

function modifier_rain_dushnila:GetModifierAura()
	return "modifier_rain_dushnila"
end


function modifier_rain_dushnila:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end


function modifier_rain_dushnila:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_rain_dushnila:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_rain_dushnila:GetAuraRadius()
	return self.aura_radius
end

function modifier_rain_dushnila:GetAuraEntityReject( hEntity )
	return not hEntity:CanEntityBeSeenByMyTeam(self:GetCaster())
end
--------------------------------------------------------------------------------

function modifier_rain_dushnila:OnCreated( kv )
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "presence_radius" )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "presence_armor_reduction" )
end

function modifier_rain_dushnila:OnRefresh( kv )
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "presence_radius" )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "presence_armor_reduction" )
end

--------------------------------------------------------------------------------

function modifier_rain_dushnila:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_rain_dushnila:GetModifierPhysicalArmorBonus( params )
	if self:GetParent() == self:GetCaster() then
		return 0
	end

	return self.armor_reduction
end

--------------------------------------------------------------------------------
