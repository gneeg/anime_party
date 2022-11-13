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
nastya_zoloto = class({})
LinkLuaModifier( "modifier_nastya_zoloto", "heroes/nastya/modifier_nastya_zoloto", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nastya_zoloto_stack", "heroes/nastya/modifier_nastya_zoloto_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function nastya_zoloto:GetIntrinsicModifierName()
	return "modifier_nastya_zoloto"
end

-- --------------------------------------------------------------------------------
-- -- Ability Start
-- function nastya_zoloto:OnSpellStart()
-- 	-- unit identifier
-- 	local caster = self:GetCaster()
-- 	local target = self:GetCursorTarget()
-- 	local point = self:GetCursorPosition()

-- 	-- load data
-- 	local value1 = self:GetSpecialValueFor("some_value")

-- 	-- logic

-- end