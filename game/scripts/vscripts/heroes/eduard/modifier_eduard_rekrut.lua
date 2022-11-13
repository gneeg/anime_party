modifier_eduard_rekrut = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_eduard_rekrut:IsHidden()
	return true
end

function modifier_eduard_rekrut:IsDebuff()
	return false
end

function modifier_eduard_rekrut:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_eduard_rekrut:IsAura()
	return true
end

function modifier_eduard_rekrut:GetModifierAura()
	return "modifier_eduard_rekrut_effect"
end

function modifier_eduard_rekrut:GetAuraRadius()
	return self.radius
end

function modifier_eduard_rekrut:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_eduard_rekrut:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_eduard_rekrut:GetAuraSearchFlags()
	return 0
end

function modifier_eduard_rekrut:GetAuraDuration()
	return 2
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_eduard_rekrut:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value

	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_eduard_rekrut:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
end

function modifier_eduard_rekrut:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_eduard_rekrut:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_degen_aura.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end