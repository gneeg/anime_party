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
modifier_dristch_bistro_begat_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dristch_bistro_begat_debuff:IsHidden()
	return false
end

function modifier_dristch_bistro_begat_debuff:IsDebuff()
	return true
end

function modifier_dristch_bistro_begat_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dristch_bistro_begat_debuff:OnCreated( kv )
	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	self.slow = kv.slow
end

function modifier_dristch_bistro_begat_debuff:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dristch_bistro_begat_debuff:OnRemoved()
end

function modifier_dristch_bistro_begat_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_dristch_bistro_begat_debuff:AddCustomTransmitterData()
	-- on server
	local data = {
		slow = self.slow
	}

	return data
end

function modifier_dristch_bistro_begat_debuff:HandleCustomTransmitterData( data )
	-- on client
	self.slow = data.slow
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dristch_bistro_begat_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_dristch_bistro_begat_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end