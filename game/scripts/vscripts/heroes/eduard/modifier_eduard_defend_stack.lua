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
modifier_eduard_defend_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_eduard_defend_stack:IsHidden()
	return true
end

function modifier_eduard_defend_stack:IsPurgable()
	return false
end

function modifier_eduard_defend_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_eduard_defend_stack:OnDestroy()
	if not IsServer() then return end
	self.parent:RemoveStack()
end