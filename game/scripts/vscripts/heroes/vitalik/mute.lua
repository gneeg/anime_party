dristch_mute = class({})
LinkLuaModifier("modifier_dristch_mute", "heroes/dristch/modifier_dristch_mute" LUA_MODIFIER_MOTION_HORIZONTAL)

function dristch_mute:OnSpellStart()
	self.caster = self:GetCaster()
	local point = self:GetCaster():GetOrigin()

	local radius = self:GetSpecialValueFor("radius")
	CreateModifierThinker( self:GetCaster (), self, "modifier_dristch_mute", kv, self:GetCaster():GetTeamNumber(), false )
	




	end