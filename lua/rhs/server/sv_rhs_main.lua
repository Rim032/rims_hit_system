MsgC(Color(69, 140, 255), "##[Rim's Hit System: Main Initialized]##\n")
MsgC(Color(69, 140, 255), "##[Rim's Hit System Build: " ..rhs.version.. " - " ..rhs.build_date.. "]##\n")

util.AddNetworkString("rhs_arcade_on")
util.AddNetworkString("rhs_realistic_on")
util.AddNetworkString("rhs_custom_on")

rhs.realistic_hurt = true
rhs.arcade_hurt = false
rhs.custom_hurt = false

hook.Add("Tick", "rhs_tick_hook", function()
    for k, v in pairs(player.GetAll()) do
        if v:LastHitGroup() == nil then return end
        rhs_net_check()

        if v:IsValid() == true then
            if v:Alive() == true then
                if rhs_damage_detect(v) == true then
                    v.ply_hitgroup = v:LastHitGroup()

                    if rhs.realistic_hurt == true then
                        rhs_damage_resultA(v, v.ply_hitgroup)
                    elseif rhs.arcade_hurt == true then
                        rhs_damage_resultB(v, v.ply_hitgroup)
                    elseif rhs.custom_hurt == true then
                        rhs_damage_resultC(v, v.ply_hitgroup)
                    end
                end
            end
        else
            print("[RHS]: Player is null (ERROR)")
        end
    end
end)

function rhs_net_check()
    net.Receive("rhs_arcade_on", function(len, ply)
        if IsValid(ply) == false then return end
        if ply:IsSuperAdmin() == true then
            rhs.realistic_hurt = false
            rhs.custom_hurt = false
            rhs.arcade_hurt = true

            print("[RHS]: Arcade damage mode is on.")
        end
    end)

    net.Receive("rhs_realistic_on", function(len, ply)
        if IsValid(ply) == false then return end
        if ply:IsSuperAdmin() == true then
            rhs.arcade_hurt = false
            rhs.custom_hurt = false
            rhs.realistic_hurt = true

            print("[RHS]: Realistic damage mode is on.")
        end
    end)

    net.Receive("rhs_custom_on", function(len, ply)
        if IsValid(ply) == false then return end
        if ply:IsSuperAdmin() == true then
            rhs.arcade_hurt = false
            rhs.realistic_hurt = false
            rhs.custom_hurt = true

            print("[RHS]: Custom damage mode is on.")
        end
    end)

    rhs_custom_net_read()
end

function rhs_damage_detect(ply)
    if ply:Health() < ply:GetMaxHealth() then
        return true
    end
end


concommand.Add("rhs_arcade_hrt", function(ply, cmd, args)
    if IsValid(ply) == false then return end
    if ply:IsSuperAdmin() == true then
        rhs.realistic_hurt = false
        rhs.custom_hurt = false
        rhs.arcade_hurt = true

        print("[RHS]: Arcade damage mode is on.")
    end
end)

concommand.Add("rhs_realistic_hrt", function(ply, cmd, args)
    if IsValid(ply) == false then return end
    if ply:IsSuperAdmin() == true then
        rhs.arcade_hurt = false
        rhs.custom_hurt = false
        rhs.realistic_hurt = true

        print("[RHS]: Realistic damage mode is on.")
    end
end)

concommand.Add("rhs_custom_hrt", function(ply, cmd, args)
    if IsValid(ply) == false then return end
    if ply:IsSuperAdmin() == true then
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