modifier_dristch_mute - class({})

function modifier_dristch_mute:IsHidden()
	return true
end

function modifier_dristch_mute:IsDebuff()
	return true
end

function modifier_dristch_mute:IsPurgable()
	return false
end

function modifier_dristch_mute:AllowIllusionDuplicate()
	return false
end

local enemies = FindUnitsInRadius()

function modifier_dristch_mute:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
	
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_dristch_mute:OnIntervalThink()
	if IsServer() then
		GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.dristch_mute, false )
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), self.light_strike_array_aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then

function modifier_dristch_mute:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.duration = self:GetAbility():GetSpecialValueFor( "AbilityDuration" )
end

function modifier_dristch_mute:OnDestroy( kv )

end

function modifier_dristch_mute:DeclareFunctions()
	local funcs = {
		MODIFIER_STATE_SILENCED,
	}

	return funcs
end
