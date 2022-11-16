function rhs_damage_resultA(ply, ply_hg, attacker)
    local dmg_info = DamageInfo()
    dmg_info:SetAttacker(attacker)
    dmg_info:SetInflictor(ply)

    if ply_hg == HITGROUP_HEAD then
        ply:SetLastHitGroup(HITGROUP_STOMACH)
        dmg_info:AddDamage(ply:Health())
        ply:TakeDamageInfo(dmg_info)
    elseif ply_hg == HITGROUP_CHEST then
        ply:SetLastHitGroup(HITGROUP_STOMACH)
        dmg_info:AddDamage(ply:Health()/6)
        ply:TakeDamageInfo(dmg_info)
    elseif ply_hg == HITGROUP_RIGHTARM then
        ply:SetLastHitGroup(HITGROUP_STOMACH)
        local actv_wpn = ply:GetActiveWeapon()
        if actv_wpn == NULL then return end

        ply:DropWeapon(actv_wpn)
        ply:SetActiveWeapon(null)
    end
end