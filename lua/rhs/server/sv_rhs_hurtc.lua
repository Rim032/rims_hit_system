util.AddNetworkString("cstm_head_dmg_CHANGED")
util.AddNetworkString("cstm_chest_dmg_CHANGED")
util.AddNetworkString("cstm_Larm_dmg_CHANGED")
util.AddNetworkString("cstm_Rarm_dmg_CHANGED")
util.AddNetworkString("cstm_Lleg_dmg_CHANGED")
util.AddNetworkString("cstm_Rleg_dmg_CHANGED")
--util.AddNetworkString("cstm_disarm_on_CHANGED")

function rhs_damage_resultC(ply, ply_hg)
    rhs_custom_val_failsafe()

    if ply_hg == HITGROUP_HEAD then
        ply:SetHealth(ply:Health() - cstm_head_dmg)
        ply:SetLastHitGroup(HITGROUP_STOMACH)
    elseif ply_hg == HITGROUP_CHEST then
        ply:SetHealth(ply:Health() - cstm_chest_dmg)
        ply:SetLastHitGroup(HITGROUP_STOMACH)
    elseif ply_hg == HITGROUP_LEFTARM then
        ply:SetHealth(ply:Health() - cstm_Larm_dmg)
        ply:SetLastHitGroup(HITGROUP_STOMACH)
    elseif ply_hg == HITGROUP_RIGHTARM then
        ply:SetHealth(ply:Health() - cstm_Rarm_dmg)
        ply:SetLastHitGroup(HITGROUP_STOMACH)
    elseif ply_hg == HITGROUP_LEFTLEG then
        ply:SetHealth(ply:Health() - cstm_Lleg_dmg)
        ply:SetLastHitGroup(HITGROUP_STOMACH)
    elseif ply_hg == HITGROUP_RIGHTLEG then
        ply:SetHealth(ply:Health() - cstm_Rleg_dmg)
        ply:SetLastHitGroup(HITGROUP_STOMACH)
    end
end

function rhs_custom_net_read()
    net.Receive("cstm_head_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if ply:IsSuperAdmin() == true then
            cstm_head_dmg = net.ReadInt(16)
        end
    end)

    net.Receive("cstm_chest_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if ply:IsSuperAdmin() == true then
            cstm_chest_dmg = net.ReadInt(16)
        end
    end)

    net.Receive("cstm_Larm_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if ply:IsSuperAdmin() == true then
            cstm_Larm_dmg = net.ReadInt(16)
        end
    end)

    net.Receive("cstm_Rarm_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if ply:IsSuperAdmin() == true then
            cstm_Rarm_dmg = net.ReadInt(16)
        end
    end)

    net.Receive("cstm_Lleg_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if ply:IsSuperAdmin() == true then
            cstm_Lleg_dmg = net.ReadInt(16)
        end
    end)

    net.Receive("cstm_Rleg_dmg_CHANGED", function(len, ply)
        if IsValid(ply) == false then return end
        if ply:IsSuperAdmin() == true then
            cstm_Rleg_dmg = net.ReadInt(16)
        end
    end)

    --[[net.Receive("cstm_disarm_on_CHANGED", function()
        cstm_disarm_on = net.ReadBool()
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
            cstm_limb_arrA[n] = 1
        end
    end
end