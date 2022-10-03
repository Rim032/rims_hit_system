function rhs_damage_resultB(ply, ply_hg)
    if ply_hg == HITGROUP_HEAD then
        ply:SetHealth(ply:Health() - (ply:Health()/3))
        ply:SetLastHitGroup(HITGROUP_STOMACH)
    elseif ply_hg == HITGROUP_CHEST then
        ply:SetHealth(ply:Health() - (ply:Health()/6))
        ply:SetLastHitGroup(HITGROUP_STOMACH)
    end
end