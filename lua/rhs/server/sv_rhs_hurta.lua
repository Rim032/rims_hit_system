function rhs_damage_resultA(ply, ply_hg)
    if ply_hg == HITGROUP_HEAD then
        ply:Kill()
        ply:SetLastHitGroup(HITGROUP_STOMACH)
    elseif ply_hg == HITGROUP_CHEST then
        ply:SetHealth(ply:Health() - (ply:Health()/6))
        ply:SetLastHitGroup(HITGROUP_STOMACH)
    elseif ply_hg == HITGROUP_RIGHTARM then
        local actv_wpn = ply:GetActiveWeapon()
        if actv_wpn == NULL then return end

        ply:DropWeapon(actv_wpn)
        ply:SetActiveWeapon(null)

        ply:SetLastHitGroup(HITGROUP_STOMACH)
    end
end