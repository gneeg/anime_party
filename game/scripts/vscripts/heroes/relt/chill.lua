function Chill (keys)
    local caster = keys.caster
    local restoreManaAmount = keys.ability:GetSpecialValueFor("restore_mana")

    caster:GiveMana( restoreManaAmount )
end
