rhs = {}
rhs.version = 1.17
rhs.build_date = "10/3/2022"

if SERVER then
    include("server/sv_rhs_main.lua")
    include("server/sv_rhs_hurtA.lua")
    include("server/sv_rhs_hurtB.lua")
    include("server/sv_rhs_hurtC.lua")

    MsgC(Color(69, 140, 255), "##[Rim's Hit System: Server Initialized]##\n")
end


if CLIENT then
    AddCSLuaFile("autorun/client/cl_rhs_menu.lua")

    MsgC(Color(69, 140, 255), "##[Rim's Hit System: Client Initialized]##\n")
end

hook.Add("PostGamemodeLoaded", "sv_backup_load", function()
    timer.Simple(10, function()
        if SERVER then
            include("server/sv_rhs_main.lua")
            include("server/sv_rhs_hurtA.lua")
            include("server/sv_rhs_hurtB.lua")
        
            MsgC(Color(69, 140, 255), "##[Rim's Hit System: Server Initialized]##\n")
        else
            MsgC(Color(69, 140, 255), "##[Rim's Hit System: Server Initialization FAILED]##")
            MsgC(Color(255, 25, 25), "REPORT THIS BUG ON RHS' ADDON PAGE (INCLUDE THIS IN THE MESSAGE \"SV Alt Ini Fail\")\n")
        end
    end)
end)