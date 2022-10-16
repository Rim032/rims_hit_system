rhs = {}
rhs.version = 1.35
rhs.build_date = "10/16/2022"

if SERVER then
    include("rhs/server/sv_rhs_main.lua")
    include("rhs/server/sv_rhs_hurtA.lua")
    include("rhs/server/sv_rhs_hurtB.lua")
    include("rhs/server/sv_rhs_hurtC.lua")

    MsgC(Color(69, 140, 255), "##[Rim's Hit System: Server Initialized]##\n")
end


if CLIENT then
    AddCSLuaFile("autorun/client/cl_rhs_menu.lua")

    MsgC(Color(69, 140, 255), "##[Rim's Hit System: Client Initialized]##\n")
end

hook.Add("PostGamemodeLoaded", "rhs_sv_backup_load", function()
    timer.Simple(10, function()
        if SERVER then
            include("rhs/server/sv_rhs_main.lua")
            include("rhs/server/sv_rhs_hurtA.lua")
            include("rhs/server/sv_rhs_hurtB.lua")
        
            MsgC(Color(69, 140, 255), "##[Rim's Hit System: Server Initialized]##\n")
        end
    end)
end)