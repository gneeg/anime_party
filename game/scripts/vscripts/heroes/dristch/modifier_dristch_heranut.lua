modifier_dristch_heranut = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dristch_heranut:IsHidden()
	return true
end

function modifier_dristch_heranut:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dristch_heranut:OnCreated( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "blade_dance_crit_chance" )
	self.crit_mult = self:GetAbility():GetSpecialValueFor( "blade_dance_crit_mult" )
end

function modifier_dristch_heranut:OnRefresh( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "blade_dance_crit_chance" )
	self.crit_mult = self:GetAbility():GetSpecialValueFor( "blade_dance_crit_mult" )
end

function modifier_dristch_heranut:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dristch_heranut:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end
function modifier_dristch_heranut:GetModifierPreAttack_CriticalStrike( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		if params.target:GetTeamNumber()==self:GetParent():GetTeamNumber() then
			return
		end

		-- Throw dice
		if RandomInt(0, 100)<self.crit_chance then
			self.record = params.record
			return self.crit_mult
		end
	end
end
function modifier_dristch_heranut:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		if self.record and self.record == params.record then
			self.record = nil

			-- Play effects
			local sound_cast = "Hero_Juggernaut.BladeDance"
			EmitSoundOn( sound_cast, params.target )
		end
	end
end