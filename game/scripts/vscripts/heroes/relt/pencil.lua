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
relt_pencil = class({})
LinkLuaModifier( "modifier_generic_knockback", "generic/modifier_generic_knockback", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_relt_pencil", "heroes/relt/modifier_relt_pencil", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_relt_pencil_debuff", "heroes/relt/modifier_relt_pencil_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function relt_pencil:Precache( context )
	-- PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_hoodwink.vsndevts", context )
	-- PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter.vpcf", context )
	-- PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf", context )
	-- PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_impact.vpcf", context )
	-- PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_target.vpcf", context )
	-- PrecacheResource( "particle", "particles/items_fx/force_staff.vpcf", context )
end

function relt_pencil:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function relt_pencil:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor( "misfire_time" )

	-- add secondary ability if doesn't exist
	if not caster:FindAbilityByName( "relt_pencil_release" ) then
		local ability = caster:AddAbility( "relt_pencil_release" )
		ability:SetLevel( 1 )
	end

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_relt_pencil", -- modifier name
		{
			duration = duration,
			x = point.x,
			y = point.y,
		} -- kv
	)
end

--------------------------------------------------------------------------------
-- Projectile
function relt_pencil:OnProjectileThink_ExtraData( location, ExtraData )
	local sound = EntIndexToHScript( ExtraData.sound )
	if not sound or sound:IsNull() then return end
	sound:SetOrigin( location )
end

function relt_pencil:OnProjectileHit_ExtraData( target, location, ExtraData )
	-- stop projectile sound
	local sound = EntIndexToHScript( ExtraData.sound )
	if not sound or sound:IsNull() then return end
	local sound_projectile = "Hero_Hoodwink.Sharpshooter.Projectile"
	StopSoundOn( sound_projectile, sound )
	UTIL_Remove( sound )

	if not target then return end

	local caster = self:GetCaster()

	-- damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = ExtraData.damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
	}
	ApplyDamage(damageTable)

	-- modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_relt_pencil_debuff", -- modifier name
		{
			duration = ExtraData.duration,
			x = ExtraData.x,
			y = ExtraData.y
		} -- kv
	)

	-- overhead damage info
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
		target,
		ExtraData.damage,
		self:GetCaster():GetPlayerOwner()
	)

	-- Vision
	AddFOWViewer( self:GetCaster():GetTeamNumber(), target:GetOrigin(), 300, 4, false)

	-- play effects
	local direction = Vector( ExtraData.x, ExtraData.y, 0 ):Normalized()
	self:PlayEffects( target, direction )

	return true
end

--------------------------------------------------------------------------------
-- Effects
function relt_pencil:PlayEffects( target, direction )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_impact.vpcf"
	local sound_cast = "Hero_Hoodwink.Sharpshooter.Target"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 0, target:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, target:GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 1, direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end

--------------------------------------------------------------------------------
-- Secondary Ability
relt_pencil_release = class({})
function relt_pencil_release:OnSpellStart()
	-- find modifier
	local mod = self:GetCaster():FindModifierByName( "modifier_relt_pencil" )

	if not mod then 
		return 
	end

	mod:Destroy()
	print("modifier destroyed")
end