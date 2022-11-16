MsgC(Color(69, 140, 255), "##[Rim's Hit System: Main Initialized]##\n")
MsgC(Color(69, 140, 255), "##[Rim's Hit System Build: " ..rhs.version.. " - " ..rhs.build_date.. "]##\n")

util.AddNetworkString("rhs_arcade_on")
util.AddNetworkString("rhs_realistic_on")
util.AddNetworkString("rhs_custom_on")

util.AddNetworkString("rhs_get_ply_rank")
util.AddNetworkString("rhs_send_ply_rank")

if GetConVar("cstm_disarm_on") == nil then
    CreateConVar("cstm_disarm_on", 0, FCVAR_REPLICATED, "", 0, 1)
end

rhs.realistic_hurt = true
rhs.arcade_hurt = false
rhs.custom_hurt = false

hook.Add("PlayerHurt", "rhs_hurt_hook", function(ply, attacker, hp_left, dmg_taken)
    if ply:LastHitGroup() == nil then return end
    if ply:IsValid() == false then return end
    if ply:Alive() == false then return end
    rhs_net_check()

    ply.ply_hitgroup = ply:LastHitGroup()

    if ply:IsEFlagSet(EFL_NO_DAMAGE_FORCES) == false then
        ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
    end

    if rhs.realistic_hurt == true then
        rhs_damage_resultA(ply, ply.ply_hitgroup, attacker)
    elseif rhs.arcade_hurt == true then
        rhs_damage_resultB(ply, ply.ply_hitgroup, attacker)
    elseif rhs.custom_hurt == true then
        rhs_damage_resultC(ply, ply.ply_hitgroup, attacker)
    end
end)

function rhs_net_check()
    net.Receive("rhs_arcade_on", function(len, ply)
        if IsValid(ply) == false then return end
        if rhs.allowed_ranks[ply:GetUserGroup()] then
            rhs.realistic_hurt = false
            rhs.custom_hurt = false
            rhs.arcade_hurt = true

            print("[RHS]: Arcade damage mode is on.")
        end
    end)

    net.Receive("rhs_realistic_on", function(len, ply)
        if IsValid(ply) == false then return end
        if rhs.allowed_ranks[ply:GetUserGroup()] then
            rhs.arcade_hurt = false
            rhs.custom_hurt = false
            rhs.realistic_hurt = true

            print("[RHS]: Realistic damage mode is on.")
        end
    end)

    net.Receive("rhs_custom_on", function(len, ply)
        if IsValid(ply) == false then return end
        if rhs.allowed_ranks[ply:GetUserGroup()] then
            rhs.arcade_hurt = false
            rhs.realistic_hurt = false
            rhs.custom_hurt = true

            print("[RHS]: Custom damage mode is on.")
        end
    end)

    rhs_custom_net_read()
end

net.Receive("rhs_get_ply_rank", function(len, ply)
    if IsValid(ply) == false then return end
    local is_auth = false
    
    if rhs.allowed_ranks[ply:GetUserGroup()] then
        is_auth = true
    end

    net.Start("rhs_send_ply_rank")
        net.WriteBool(is_auth)
    net.Send(ply)
end)


concommand.Add("rhs_arcade_hrt", function(ply, cmd, args)
    if IsValid(ply) == false then return end
    if rhs.allowed_ranks[ply:GetUserGroup()] then
        rhs.realistic_hurt = false
        rhs.custom_hurt = false
        rhs.arcade_hurt = true

        print("[RHS]: Arcade damage mode is on.")
    end
end)

concommand.Add("rhs_realistic_hrt", function(ply, cmd, args)
    if IsValid(ply) == false then return end
    if rhs.allowed_ranks[ply:GetUserGroup()] then
        rhs.arcade_hurt = false
        rhs.custom_hurt = false
        rhs.realistic_hurt = true

        print("[RHS]: Realistic damage mode is on.")
    end
end)

concommand.Add("rhs_custom_hrt", function(ply, cmd, args)
    if IsValid(ply) == false then return end
    if rhs.allowed_ranks[ply:GetUserGroup()] then
        rhs.arcade_hurt = false
        rhs.realistic_hurt = false
        rhs.custom_hurt = true

        print("[RHS]: Custom damage mode is on.")
    end
end)

concommand.Add("rhs_general_help", function(ply, cmd, args)
    if IsValid(ply) == false then return end
    ply:PrintMessage(HUD_PRINTCONSOLE, "\nFeatures:\n Acrcade mode:\n   *Removes 1/3rd of your health if hit in the head.\n   *Removes 1/6th of your health if hit in the chest.\n")
    ply:PrintMessage(HUD_PRINTCONSOLE, "Realistic mode:\n   *Instant death on headshot.\n   *Removes 1/6th of your health if hit in the chest.\n   *Forces weapon drop if your right arm is hit.\n")
    ply:PrintMessage(HUD_PRINTCONSOLE, "Custom mode:\n   *Custom headshot damage.\n   *Custom chest damage.\n   *Custom left arm damage.\n   *Custom right arm damage.\n   *Custom left leg damage.\n   *Custom right leg damage.\n")
end)

//Charles es una puta bajo y gordo. Tu no tienes dignidad!