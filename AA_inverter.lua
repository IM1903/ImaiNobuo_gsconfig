local set, get = ui.set, ui.get

local yaw, yaw_slider = ui.reference("aa", "anti-aimbot angles", "yaw")
local body_yaw, body_yaw_slider = ui.reference("aa", "anti-aimbot angles", "body yaw")
local lby_target = ui.reference("aa", "anti-aimbot angles", "lower body yaw target")

local menu = {
    enabled = ui.new_checkbox("aa", "anti-aimbot angles", "Simple AA inverter"),
    inverter = ui.new_hotkey("aa", "anti-aimbot angles", "Simple AA inverter", true),
    color_picker = ui.new_label("aa","anti-aimbot angles","indicator color"),
    ind_color = ui.new_color_picker("aa","anti-aimbot angles","indicator color picker"),
    
}

local r,g,b,a = get(menu.ind_color)

ui.set_callback(menu.enabled, function(self) 
    if get(menu.enabled) then 
        set(body_yaw, "Static")
        set(body_yaw_slider, -180)
        set(lby_target, "Opposite")
    else
        set(body_yaw, "Opposite")
    end
end)

client.set_event_callback("run_command", function(e)
    r,g,b,a = get(menu.ind_color)
    if get(menu.enabled) == false then 
        return 
    end
    if get(menu.inverter) then 
        set(yaw_slider, 7)
        set(body_yaw_slider, 180)
    else
        set(yaw_slider, -10)
        set(body_yaw_slider, -180)
    end
end)

client.set_event_callback("paint", function()

	local scrsize_x, scrsize_y = client.screen_size()
    local center_x, center_y = scrsize_x / 2, scrsize_y / 2
    
    if get(menu.enabled) == false then return end
    if get(body_yaw_slider) == -180 then 
        --renderer.indicator(255, 255,255, 255, "LEFT")
			renderer.text(center_x + 80, center_y, r, g, b, a, "c+", 0, "►")
	elseif get(body_yaw_slider) == 180 then 
        --renderer.indicator(255, 255,255, 255, "RIGHT")
		renderer.text(center_x - 80, center_y, r, g, b, a, "c+", 0, "◄")
    end
end)