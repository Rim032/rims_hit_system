if CLIENT == nil then return end

surface.CreateFont( "norm_fontA", {
	font = "Arial",
	extended = false,
	size = ScrH()/5,
	weight = ScrH()/3,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

list.Set("DesktopWindows", "rhs_cMENU", {
    title = "[RHS] Settings",
    icon = "icon64/rhs_svs_icon.png",
    init = function( icon, window )
        rhs_svs_menu()

        net.Start("rhs_get_ply_rank")
        net.SendToServer()
    end
})

local is_user_allowed = false

net.Receive("rhs_send_ply_rank", function(len, ply)
    is_user_allowed = net.ReadBool()
    return is_user_allowed
end)

function rhs_svs_menu()
    if is_user_allowed == true then
        base_frame = vgui.Create( "DFrame" )
        base_frame:SetSize(ScrW()/4.8, ScrH()/4.91)
        base_frame:SetTitle( "" )
        base_frame:MakePopup()
        base_frame:Center()
        base_frame:SetDraggable( true )
        base_frame.Paint = function(self, w, h )
            draw.RoundedBox(8, 0, 0, ScrW()/4.8, ScrH()/4.91, Color(160, 160, 160, 200))
            draw.DrawText("Version: ".. rhs.version, norm_fontA, ScrW()/48, ScrH()/5.4, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
            draw.DrawText("Rim's Hit System Settings Panel", norm_fontA, ScrW()/22.58, ScrW()/165, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
        end

        local arcade_hurt_btn = vgui.Create("DButton", base_frame)
        arcade_hurt_btn:SetText("Arcade Damage")
        arcade_hurt_btn:SetPos(ScrW()/29.54, ScrH()/19.64)
        arcade_hurt_btn:SetSize(ScrW()/6.98, ScrH()/30.86)
        arcade_hurt_btn.DoClick = function()
            net.Start("rhs_arcade_on")
            net.SendToServer(ply)
        end

        local realistic_hurt_btn = vgui.Create("DButton", base_frame)
        realistic_hurt_btn:SetText("Realistic Damage")
        realistic_hurt_btn:SetPos(ScrW()/29.54, ScrH()/11.37)
        realistic_hurt_btn:SetSize(ScrW()/6.98, ScrH()/30.86)
        realistic_hurt_btn.DoClick = function()
            net.Start("rhs_realistic_on")
            net.SendToServer(ply)
        end

        local custom_hurt_btn = vgui.Create("DButton", base_frame)
        custom_hurt_btn:SetText("Custom Damage")
        custom_hurt_btn:SetPos(ScrW()/29.54, ScrH()/8)
        custom_hurt_btn:SetSize(ScrW()/6.98, ScrH()/30.86)
        custom_hurt_btn.DoClick = function()
            net.Start("rhs_custom_on")
            net.SendToServer(ply)
        end

        local custom_hurt_config_btn = vgui.Create("DButton", base_frame)
        custom_hurt_config_btn:SetText("...")
        custom_hurt_config_btn:SetPos(ScrW()/5.57, ScrH()/7.71)
        custom_hurt_config_btn:SetSize(ScrW()/76.8, ScrH()/43.2)
        custom_hurt_config_btn.DoClick = function()
            custom_hurt_config_frame = vgui.Create( "DFrame" )
            custom_hurt_config_frame:SetSize(ScrW()/12.39, ScrW()/2.73)
            custom_hurt_config_frame:SetTitle( "" )
            custom_hurt_config_frame:MakePopup()
            custom_hurt_config_frame:Center()
            custom_hurt_config_frame:SetDraggable( true )
            custom_hurt_config_frame.Paint = function(self, w, h )
                draw.RoundedBox(8, 0, 0, 155, 395, Color(155, 155, 155, 210))

                draw.DrawText("Additional Head DMG", norm_fontA, ScrW()/24, ScrH()/36, Color( 75, 75, 75, 255 ), TEXT_ALIGN_CENTER)
                draw.DrawText("Additional Chest DMG", norm_fontA, ScrW()/24, ScrH()/13.5, Color( 75, 75, 75, 255 ), TEXT_ALIGN_CENTER)
                draw.DrawText("Additional Left Arm DMG", norm_fontA, ScrW()/25.6, ScrH()/8, Color( 75, 75, 75, 255 ), TEXT_ALIGN_CENTER)
                draw.DrawText("Additional Right Arm DMG", norm_fontA, ScrW()/25.6, ScrH()/5.68, Color( 75, 75, 75, 255 ), TEXT_ALIGN_CENTER)
                draw.DrawText("Additional Left Leg DMG", norm_fontA, ScrW()/25.6, ScrH()/4.41, Color( 75, 75, 75, 255 ), TEXT_ALIGN_CENTER)
                draw.DrawText("Additional Right Leg DMG", norm_fontA, ScrW()/25.6, ScrH()/3.6, Color( 75, 75, 75, 255 ), TEXT_ALIGN_CENTER)
            end

            rhs_svs_sub_menu()
        end
    else
        LocalPlayer():PrintMessage(HUD_PRINTTALK, "[RHS]: Can't access. Insuffecient permissions.")
    end
end

function rhs_svs_sub_menu()
    local chc_head_dmg_numW = vgui.Create("DNumberWang", custom_hurt_config_frame)
    chc_head_dmg_numW:SetPos(ScrW()/22.59, ScrH()/24)
    chc_head_dmg_numW:SetSize(ScrW()/42.66, ScrH()/41.54)
    chc_head_dmg_numW:SetMin(0)
    chc_head_dmg_numW:SetMax(65536)
    chc_head_dmg_numW.OnValueChanged = function(self)
        cstm_head_dmg = self:GetValue()

        net.Start("cstm_head_dmg_CHANGED")
            net.WriteInt(cstm_head_dmg, 16)
        net.SendToServer(ply)
    end

    local chc_chest_dmg_numW = vgui.Create("DNumberWang", custom_hurt_config_frame)
    chc_chest_dmg_numW:SetPos(ScrW()/22.59, ScrH()/11.37)
    chc_chest_dmg_numW:SetSize(ScrW()/42.66, ScrH()/41.54)
    chc_chest_dmg_numW:SetMin(0)
    chc_chest_dmg_numW:SetMax(65536)
    chc_chest_dmg_numW.OnValueChanged = function(self)
        cstm_chest_dmg = self:GetValue()

        net.Start("cstm_chest_dmg_CHANGED")
            net.WriteInt(cstm_chest_dmg, 16)
        net.SendToServer(ply)
    end

    local chc_Larm_dmg_numW = vgui.Create("DNumberWang", custom_hurt_config_frame)
    chc_Larm_dmg_numW:SetPos(ScrW()/22.59, ScrH()/7.2)
    chc_Larm_dmg_numW:SetSize(ScrW()/42.66, ScrH()/41.54)
    chc_Larm_dmg_numW:SetMin(0)
    chc_Larm_dmg_numW:SetMax(65536)
    chc_Larm_dmg_numW.OnValueChanged = function(self)
        cstm_Larm_dmg = self:GetValue()

        net.Start("cstm_Larm_dmg_CHANGED")
            net.WriteInt(cstm_Larm_dmg, 16)
        net.SendToServer(ply)
    end

    local chc_Rarm_dmg_numW = vgui.Create("DNumberWang", custom_hurt_config_frame)
    chc_Rarm_dmg_numW:SetPos(ScrW()/22.59, ScrH()/5.27)
    chc_Rarm_dmg_numW:SetSize(ScrW()/42.66, ScrH()/41.54)
    chc_Rarm_dmg_numW:SetMin(0)
    chc_Rarm_dmg_numW:SetMax(65536)
    chc_Rarm_dmg_numW.OnValueChanged = function(self)
        cstm_Rarm_dmg = self:GetValue()

        net.Start("cstm_Rarm_dmg_CHANGED")
            net.WriteInt(cstm_Rarm_dmg, 16)
        net.SendToServer(ply)
    end

    local chc_Lleg_dmg_numW = vgui.Create("DNumberWang", custom_hurt_config_frame)
    chc_Lleg_dmg_numW:SetPos(ScrW()/22.59, ScrH()/4.15)
    chc_Lleg_dmg_numW:SetSize(ScrW()/42.66, ScrH()/41.54)
    chc_Lleg_dmg_numW:SetMin(0)
    chc_Lleg_dmg_numW:SetMax(65536)
    chc_Lleg_dmg_numW.OnValueChanged = function(self)
        cstm_Lleg_dmg = self:GetValue()

        net.Start("cstm_Lleg_dmg_CHANGED")
            net.WriteInt(cstm_Lleg_dmg, 16)
        net.SendToServer(ply)
    end

    local chc_Rleg_dmg_numW = vgui.Create("DNumberWang", custom_hurt_config_frame)
    chc_Rleg_dmg_numW:SetPos(ScrW()/22.59, ScrH()/3.43)
    chc_Rleg_dmg_numW:SetSize(ScrW()/42.66, ScrH()/41.54)
    chc_Rleg_dmg_numW:SetMin(0)
    chc_Rleg_dmg_numW:SetMax(65536)
    chc_Rleg_dmg_numW.OnValueChanged = function(self)
        cstm_Rleg_dmg = self:GetValue()

        net.Start("cstm_Rleg_dmg_CHANGED")
            net.WriteInt(cstm_Rleg_dmg, 16)
        net.SendToServer(ply)
    end

    local chc_disarm_numW = vgui.Create("DCheckBoxLabel", custom_hurt_config_frame)
    chc_disarm_numW:SetPos(ScrW()/76.8, ScrH()/3)
	chc_disarm_numW:SetText("Allow disarming?")
    chc_disarm_numW:SetConVar("cstm_disarm_on")
	--chc_disarm_numW:SetValue(false)	
    chc_disarm_numW:SetTextColor(Color( 75, 75, 75, 255 ))
    --[[chc_disarm_numW.OnChange = function(cstm_disarm_on)
        net.Start("cstm_disarm_on_CHANGED")
            net.WriteBool(cstm_disarm_on)
        net.SendToServer(ply)
    end]]--

    local cstm_limb_arrB = {
        cstm_head_dmg,
        cstm_chest_dmg,
        cstm_Larm_dmg,
        cstm_Rarm_dmg,
        cstm_Lleg_dmg,
        cstm_Rleg_dmg
    }

    local cstm_limb_numW_arrA = {
        chc_head_dmg_numW,
        chc_chest_dmg_numW,
        chc_Larm_dmg_numW,
        chc_Rarm_dmg_numW,
        chc_Lleg_dmg_numW,
        chc_Rleg_dmg_numW
    }

    for f, g in pairs (cstm_limb_arrB) do
        if cstm_limb_arrB[f] ~= 0 then
            cstm_limb_numW_arrA[f]:SetValue(cstm_limb_arrB[f])
        end
    end
end
