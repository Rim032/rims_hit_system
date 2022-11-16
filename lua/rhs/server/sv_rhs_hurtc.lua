util.AddNetworkString("cstm_head_dmg_CHANGED")
util.AddNetworkString("cstm_chest_dmg_CHANGED")
util.AddNetworkString("cstm_Larm_dmg_CHANGED")
util.AddNetworkString("cstm_Rarm_dmg_CHANGED")
util.AddNetworkString("cstm_Lleg_dmg_CHANGED")
util.AddNetworkString("cstm_Rleg_dmg_CHANGED")
--util.AddNetworkString("cstm_disarm_on_CHANGED")

function rhs_damage_resultC(ply, ply_hg, attacker)
    rhs_custom_val_failsafe()

    cstm_disarm_on_cv = GetConVar("cstm_disarm_on"):GetInt()

    local dmg_info = DamageInfo()
    dmg_info:SetAttacker(attacker)
    dmg_info:SetInflictor(ply)

    if ply_hg == HITGROUP_HEAD then
        ply:SetLastHitGroup(HITGROUP_STOMACH)

        if cstm_head_dmg == nil then return end
        dmg_info:AddDamage(cstm_head_dmg)
        ply:TakeDamageInfo(dmg_info)
    elseif ply_hg == HITGROUP_CHEST then
        ply:SetLastHitGroup(HITGROUP_STOMACH)

        if cstm_chest_dmg == nil then return end
        dmg_info:AddDamage(cstm_chest_dmg)
        ply:TakeDamageInfo(dmg_info)
    elseif ply_hg == HITGROUP_LEFTARM then
        ply:SetLastHitGroup(HITGROUP_STOMACH)

        if cstm_Larm_dmg == nil then return end
        dmg_info:AddDamage(cstm_Larm_dmg)
        ply:TakeDamageInfo(dmg_info)
    elseif ply_hg == HITGROUP_RIGHTARM then
        ply:SetLastHitGroup(HITGROUP_STOMACH)

        if cstm_disarm_on_cv == 0 then
            if cstm_Rarm_dmg == nil then return end
            dmg_info:AddDamage(cstm_Rarm_dmg)
            ply:TakeDamageInfo(dmg_info)
        else
            local actv_wpn = ply:GetActiveWeapon()
            if actv_wpn == NULL then return end
    
            ply:DropWeapon(actv_wpn)
            ply:SetActiveWeapon(null)
        end
    elseif ply_hg == HITGROUP_LEFTLEG then
        ply:SetLastHitGroup(HITGROUP_STOMACH)

        if cstm_Lleg_dmg == nil then return end
        dmg_info:AddDamage(cstm_Lleg_dmg)
        ply:TakeDamageInfo(dmg_info)
    elseif ply_hg == HITGROUP_RIGHTLEG then
        ply:SetLastHitGroup(HITGROUP_STOMACH)

        if cstm_Rleg_dmg == nil then return end
        dmg_info:AddDamage(cstm_Rleg_dmg)
        ply:TakeDamageInfo(dmg_info)
    end
end

function rhs_custom_net_read()
    net.Receive("cstm_head_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if rhs.allowed_ranks[ply:GetUserGroup()] then
            cstm_head_dmg = net.ReadInt(16)
        end
    end)

    net.Receive("cstm_chest_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if rhs.allowed_ranks[ply:GetUserGroup()] then
            cstm_chest_dmg = net.ReadInt(16)
        end
    end)

    net.Receive("cstm_Larm_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if rhs.allowed_ranks[ply:GetUserGroup()] then
            cstm_Larm_dmg = net.ReadInt(16)
        end
    end)

    net.Receive("cstm_Rarm_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if rhs.allowed_ranks[ply:GetUserGroup()] then
            cstm_Rarm_dmg = net.ReadInt(16)
        end
    end)

    net.Receive("cstm_Lleg_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if rhs.allowed_ranks[ply:GetUserGroup()] then
            cstm_Lleg_dmg = net.ReadInt(16)
        end
    end)

    net.Receive("cstm_Rleg_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if rhs.allowed_ranks[ply:GetUserGroup()] then
            cstm_Rleg_dmg = net.ReadInt(16)
        end
    end)

    --[[net.Receive("cstm_disarm_on_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if rhs.allowed_ranks[ply:GetUserGroup()] then
            cstm_disarm_on = net.ReadBool()
        end
    end)]]--
end

function rhs_custom_val_failsafe()
    local cstm_limb_arrA = {
        cstm_head_dmg,
        cstm_chest_dmg,
        cstm_Larm_dmg,
        cstm_Rarm_dmg,
        cstm_Lleg_dmg,
        cstm_Rleg_dmg
    }

    for n, m in pairs (cstm_limb_arrA) do
        if cstm_limb_arrA[n] == nil then
            cstm_limb_arrA[n] = 0
        end
    end

    return cstm_limb_arrA[1], cstm_limb_arrA[2], cstm_limb_arrA[3], cstm_limb_arrA[4],
    cstm_limb_arrA[5], cstm_limb_arrA[6]
end