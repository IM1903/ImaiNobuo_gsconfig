--local variables for API. Automatically generated by https://github.com/simpleavaster/gslua/blob/master/authors/sapphyrus/generate_api.lua 
local materialsystem_find_materials, materialsystem_get_model_materials = materialsystem.find_materials, materialsystem.get_model_materials 
local renderer_load_svg, renderer_circle_outline, renderer_rectangle, renderer_gradient, renderer_circle, renderer_text, renderer_line, renderer_triangle = renderer.load_svg, renderer.circle_outline, renderer.rectangle, renderer.gradient, renderer.circle, renderer.text, renderer.line, renderer.triangle 
local renderer_measure_text, renderer_world_to_screen, renderer_indicator, renderer_texture = renderer.measure_text, renderer.world_to_screen, renderer.indicator, renderer.texture 
local cvar_sdr, cvar_mat_ambient_light_g, cvar_mat_ambient_light_b, cvar_mat_ambient_light_r, cvar_r_modelAmbientMin = cvar.sdr, cvar.mat_ambient_light_g, cvar.mat_ambient_light_b, cvar.mat_ambient_light_r, cvar.r_modelAmbientMin 
local client_world_to_screen, client_draw_rectangle, client_draw_circle_outline, client_userid_to_entindex, client_draw_gradient, client_set_event_callback, client_screen_size, client_trace_bullet, client_draw_indicator, client_draw_text = client.world_to_screen, client.draw_rectangle, client.draw_circle_outline, client.userid_to_entindex, client.draw_gradient, client.set_event_callback, client.screen_size, client.trace_bullet, client.draw_indicator, client.draw_text 
local client_scale_damage, client_get_cvar, client_random_int, client_latency, client_set_clan_tag, client_log, client_timestamp, client_trace_line = client.scale_damage, client.get_cvar, client.random_int, client.latency, client.set_clan_tag, client.log, client.timestamp, client.trace_line 
local client_random_float, client_draw_debug_text, client_delay_call, client_visible, client_exec, client_eye_position, client_set_cvar, client_error_log = client.random_float, client.draw_debug_text, client.delay_call, client.visible, client.exec, client.eye_position, client.set_cvar, client.error_log 
local client_draw_hitboxes, client_draw_circle, client_draw_line, client_camera_angles, client_system_time, client_color_log, client_reload_active_scripts = client.draw_hitboxes, client.draw_circle, client.draw_line, client.camera_angles, client.system_time, client.color_log, client.reload_active_scripts 
local entity_get_player_resource, entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_is_dormant, entity_get_steam64, entity_get_player_name, entity_hitbox_position, entity_get_game_rules, entity_get_all = entity.get_player_resource, entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.is_dormant, entity.get_steam64, entity.get_player_name, entity.hitbox_position, entity.get_game_rules, entity.get_all 
local entity_set_prop, entity_is_alive, entity_get_player_weapon, entity_get_prop, entity_get_players, entity_get_classname = entity.set_prop, entity.is_alive, entity.get_player_weapon, entity.get_prop, entity.get_players, entity.get_classname 
local globals_realtime, globals_absoluteframetime, globals_tickcount, globals_lastoutgoingcommand, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.tickcount, globals.lastoutgoingcommand, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers 
local ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_new_textbox, ui_new_color_picker, ui_new_checkbox, ui_mouse_position, ui_new_listbox, ui_new_multiselect = ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.new_textbox, ui.new_color_picker, ui.new_checkbox, ui.mouse_position, ui.new_listbox, ui.new_multiselect 
local ui_is_menu_open, ui_new_hotkey, ui_set, ui_new_button, ui_set_callback, ui_name, ui_get = ui.is_menu_open, ui.new_hotkey, ui.set, ui.new_button, ui.set_callback, ui.name, ui.get 
local math_ceil, math_tan, math_log10, math_randomseed, math_cos, math_sinh, math_random, math_huge, math_pi, math_max, math_atan2, math_ldexp, math_floor, math_sqrt, math_deg, math_atan, math_fmod = math.ceil, math.tan, math.log10, math.randomseed, math.cos, math.sinh, math.random, math.huge, math.pi, math.max, math.atan2, math.ldexp, math.floor, math.sqrt, math.deg, math.atan, math.fmod 
local math_acos, math_pow, math_abs, math_min, math_sin, math_frexp, math_log, math_tanh, math_exp, math_modf, math_cosh, math_asin, math_rad = math.acos, math.pow, math.abs, math.min, math.sin, math.frexp, math.log, math.tanh, math.exp, math.modf, math.cosh, math.asin, math.rad 
local table_maxn, table_move, table_pack, table_foreach, table_sort, table_remove, table_foreachi, table_unpack, table_getn, table_concat, table_insert = table.maxn, table.move, table.pack, table.foreach, table.sort, table.remove, table.foreachi, table.unpack, table.getn, table.concat, table.insert 
local string_find, string_format, string_rep, string_gsub, string_len, string_gmatch, string_dump, string_match, string_reverse, string_byte, string_char, string_upper, string_lower, string_sub = string.find, string.format, string.rep, string.gsub, string.len, string.gmatch, string.dump, string.match, string.reverse, string.byte, string.char, string.upper, string.lower, string.sub 
--end of local variables 

local ui_get, ui_set = ui.get, ui.set
local draw_text = client.draw_text
local draw_rectangle = client.draw_rectangle
local width, height = client.screen_size()
local floor = math.floor     

local function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

local function table_indexof(t, e)
    for k,v in pairs(t) do
        if v == e then
            return k
        end
    end
    return nil
end

local table_fire = {}
local table_main = {}
local pitch_tick = {}
local rounds = 0
local animation_boundary = 500

local def_order = {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}
local order = {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}


local menu

local function ordering_save_to_combos()
    for i = 1, 8 do
        ui_set(menu.ord[i], order[i])
    end
end

local function ordering_toleft()
    local index = table_indexof(order, ui_get(menu.ordering_element))
    if index > 1 then
        -- shift
        local ord_minusone = order[index-1]
        order[index-1] = order[index]
        order[index] = ord_minusone
        ordering_save_to_combos()
    end
end

local function ordering_toright()
    local index = table_indexof(order, ui_get(menu.ordering_element))
    if index < 8 then
        -- shift
        local ord_plusone = order[index+1]
        order[index+1] = order[index]
        order[index] = ord_plusone
        ordering_save_to_combos()
    end
end

local function reset_default_ord()
    for i = 1, 8 do
        order[i] = def_order[i]
    end
    ordering_save_to_combos()
end


menu = {
    enabled = ui.new_checkbox("LUA", "A", "H: Aimbot history"),
    color = ui.new_color_picker("LUA", "A", "H: Logging picker", 16, 22, 29, 160),
    options = ui.new_multiselect("LUA", "A", "H: Options", {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}),
    max_amount = ui.new_slider("LUA", "A", "H: Maximum amount", 2, 10, 5),
    size_x = ui.new_slider("LUA", "A", "H: X offset", 1, width , width / 2, true, "px"),
    size_y = ui.new_slider("LUA", "A", "H: Y offset", 1, height, 80, true, "px"),
    all_flags = ui.new_checkbox("LUA", "A", "H: Draw all flags"),
    ordering = ui.new_checkbox("LUA", "A", "H: Ordering"),
    ordering_element = ui.new_combobox("LUA", "A", "H: Ordering element", {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}),
    to_left = ui.new_button("LUA", "A", "H: To the left", ordering_toleft),
    to_right = ui.new_button("LUA", "A", "H: To the right", ordering_toright),
    reset_ord = ui.new_button("LUA", "A", "H: Reset default order", reset_default_ord),

    -- invisible combos to make it save to the config.
    ord_checkbox = ui.new_checkbox("LUA", "A", "H: Defaults"),
    ord = {
        ui.new_combobox("LUA", "A", "H: Order 1", {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}),
        ui.new_combobox("LUA", "A", "H: Order 2", {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}),
        ui.new_combobox("LUA", "A", "H: Order 3", {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}),
        ui.new_combobox("LUA", "A", "H: Order 4", {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}),
        ui.new_combobox("LUA", "A", "H: Order 5", {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}),
        ui.new_combobox("LUA", "A", "H: Order 6", {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}),
        ui.new_combobox("LUA", "A", "H: Order 7", {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"}),
        ui.new_combobox("LUA", "A", "H: Order 8", {"Id", "Player", "Hitbox", "Hit chance", "Damage", "Backtrack", "Body yaw", "Flags"})
    }
}





local function set_default_ord()
    ui.set_visible(menu.ord_checkbox, false)    

    for i = 1, 8 do
        ui.set_visible(menu.ord[i], false)
        if ui_get(menu.ord_checkbox) then
            order[i] = ui_get(menu.ord[i])
        else 
            ui_set(menu.ord[i], def_order[i])
        end
    end
    ui_set(menu.ord_checkbox, true)
    client.delay_call(0.5, set_default_ord)
end

set_default_ord()

function contains(table, val)
    for i=1,#table do
        if table[i] == val then 
            return true
        end
    end
    return false
end

local draw = {
    id = {
        enable = false,
        size = 35,
        header = "ID",
        draw = function(c, pitch, yaw, data, sum, alpha_modifier)
            if rounds == data.round then 
                draw_text(c, pitch + sum, yaw + 1, 100, 255, 100, 255*alpha_modifier, nil, 70, data.id)
            else 
                draw_text(c, pitch + sum , yaw + 1, 255, 255, 255, 255*alpha_modifier, nil, 70, data.id)
            end
        end
    },

    target = {
        enable = true,
        size = 83,
        header = "PLAYER",
        draw = function(c, pitch, yaw, data, sum, alpha_modifier)
            local max_char = 16
            local width = renderer_measure_text(nil, string_sub(data.nickname, 0, max_char))
            
            local clamped = ""

            while width > 68 do 
                max_char = max_char - 1
                width = renderer_measure_text(nil, string_sub(data.nickname, 0, max_char))
                clamped = "..."
            end
            if data.f_is_dead then 
                draw_text(c, pitch + sum, yaw + 1, 255, 100, 100, 255*alpha_modifier, nil, 70, string_sub(data.nickname, 0, max_char)..clamped)
            else 
                draw_text(c, pitch + sum, yaw + 1, 255, 255, 255, 255*alpha_modifier, nil, 70, string_sub(data.nickname, 0, max_char)..clamped)
            end
        end
    }, 

    hitbox = {
        enable = false,
        size = 102,
        header = "HITBOX",
        draw = function(c, pitch, yaw, data, sum, alpha_modifier)
            draw_text(c, pitch + sum, yaw + 1, 255, 255, 255, 255*alpha_modifier, nil, 70, data.hitbox)
        end
    },

    hit_chance = {
        enable = false,
        size = 56,
        header = "HIT  CHANCE",
        draw = function(c, pitch, yaw, data, sum, alpha_modifier)
            draw_text(c, pitch + sum, yaw + 1, 255, toint(255 * data.hit_chance / 100), toint(255 * data.hit_chance / 100), 255*alpha_modifier, nil, 70, data.hit_chance, "%")
        end
    }, 

    damage = {
        enable = false,
        size = 53,
        header = "DAMAGE",
        draw = function(c, pitch, yaw, data, sum, alpha_modifier)
            draw_text(c, pitch + sum, yaw + 1, 255, 255, 255, 255*alpha_modifier, nil, 70, data.damage)
        end
    },

    backtrack = {
        enable = false,
        size = 37,
        header = "BT",
        draw = function(c, pitch, yaw, data, sum, alpha_modifier)
            draw_text(c, pitch + sum, yaw + 1, 255, 255, 255, 255*alpha_modifier, nil, 70, data.backtrack, "t")
        end
    },

    body_yaw = {
        enable = false,
        size = 56,
        header = "BODY  YAW",
        draw = function(c, pitch, yaw, data, sum, alpha_modifier)
            draw_text(c, pitch + sum, yaw + 1, 255, 255, 255, 255, nil, 70, data.body_yaw, "°")
        end
    },

    flags = {
        enable = false,
        size = 52,
        header = "FLAGS",
        draw = function(c, pitch, yaw, data, sum, alpha_modifier)
            local flags_size = 0
        
            if ui_get(menu.all_flags) then
                local dr, dg, db, da = 96, 96, 96, 127 * alpha_modifier

                if data.f_interpolated then draw_text(c, pitch + sum + flags_size, yaw + 1, 84, 84, 255, 255*alpha_modifier, nil, 70, "I") else draw_text(c, pitch + sum + flags_size, yaw + 1, dr, dg, db, da, nil, 70, "I") end
                flags_size = flags_size + 6

                if data.f_extrapolated then draw_text(c, pitch + sum + flags_size, yaw + 1, 84, 255, 84, 255*alpha_modifier, nil, 70, "E") else draw_text(c, pitch + sum + flags_size, yaw + 1, dr, dg, db, da, nil, 70, "E") end
                flags_size = flags_size + 8

                if data.f_priority then draw_text(c, pitch + sum + flags_size, yaw + 1, 255, 84, 84, 255*alpha_modifier, nil, 70, "H") else draw_text(c, pitch + sum + flags_size, yaw + 1, dr, dg, db, da, nil, 70, "H") end
                flags_size = flags_size + 9
        
                if data.f_bodyaim then draw_text(c, pitch + sum + flags_size, yaw + 1, 255, 165, 0, 255*alpha_modifier, nil, 70, "B") else draw_text(c, pitch + sum + flags_size, yaw + 1, dr, dg, db, da, nil, 70, "B") end
                flags_size = flags_size + 8
        
                if data.f_lagcomp then draw_text(c, pitch + sum + flags_size, yaw + 1, 0, 255, 255, 255*alpha_modifier, nil, 70, "LC") else draw_text(c, pitch + sum + flags_size, yaw + 1, dr, dg, db, da, nil, 70, "LC") end
                flags_size = flags_size + 15
        
                if data.f_pitch then draw_text(c, pitch + sum + flags_size, yaw + 1, 149, 184, 6, 255*alpha_modifier, nil, 70, "P") else draw_text(c, pitch + sum + flags_size, yaw + 1, dr, dg, db, da, nil, 70, "P") end
                flags_size = flags_size + 15
            else 
                if data.f_interpolated then 
                    draw_text(c, pitch + sum + flags_size, yaw + 1, 84, 84, 255, 255*alpha_modifier, nil, 70, "I")
                    flags_size = flags_size + 6
                end
                
                if data.f_extrapolated then 
                    draw_text(c, pitch + sum + flags_size, yaw + 1, 84, 255, 84, 255*alpha_modifier, nil, 70, "E")
                    flags_size = flags_size + 8
                end
                
                if data.f_priority then 
                    draw_text(c, pitch + sum + flags_size, yaw + 1, 255, 84, 84, 255*alpha_modifier, nil, 70, "H")
                    flags_size = flags_size + 9
                end
        
                if data.f_bodyaim then 
                    draw_text(c, pitch + sum + flags_size, yaw + 1, 255, 165, 0, 255*alpha_modifier, nil, 70, "B")
                    flags_size = flags_size + 8
                end
        
                if data.f_lagcomp then 
                    draw_text(c, pitch + sum + flags_size, yaw + 1, 0, 255, 255, 255*alpha_modifier, nil, 70, "LC")
                    flags_size = flags_size + 15
                end
        
                if data.f_pitch then
                    draw_text(c, pitch + sum + flags_size, yaw + 1, 149, 184, 6, 255*alpha_modifier, nil, 70, "P")
                    flags_size = flags_size + 8
                end
            end
        end
    }
}

local function get_ordered_element(i)
    if order[i] == "Id" then
        return draw.id
    elseif order[i] == "Player" then
        return draw.target
    elseif order[i] == "Hitbox" then
        return draw.hitbox
    elseif order[i] == "Hit chance" then
        return draw.hit_chance
    elseif order[i] == "Damage" then
        return draw.damage
    elseif order[i] == "Backtrack" then
        return draw.backtrack
    elseif order[i] == "Body yaw" then
        return draw.body_yaw
    elseif order[i] == "Flags" then
        return draw.flags
    end
end

ui.set_callback(menu.options, function()
    local options = ui_get(menu.options)
    if #options == 0 then
        ui_set(menu.options, "Player")  
    end

    if contains(options, "Id") then draw.id.enable = true else draw.id.enable = false end
    if contains(options, "Player") then draw.target.enable = true else draw.target.enable = false end
    if contains(options, "Hitbox") then draw.hitbox.enable = true else draw.hitbox.enable = false end
    if contains(options, "Hit chance") then draw.hit_chance.enable = true else draw.hit_chance.enable = false end
    if contains(options, "Damage") then draw.damage.enable = true else draw.damage.enable = false end
    if contains(options, "Backtrack") then draw.backtrack.enable = true else draw.backtrack.enable = false end
    if contains(options, "Body yaw") then draw.body_yaw.enable = true else draw.body_yaw.enable = false end
    if contains(options, "Flags") then draw.flags.enable = true else draw.flags.enable = false end
end)
ui_set(menu.options, "Player") 

ui.set_callback(menu.all_flags, function()
    if ui_get(menu.all_flags) then
        draw.flags.size = 67
    else 
        draw.flags.size = 52
    end

end)




local hitgroup_names = { "body", "head", "chest", "stomach", "left arm",
    "right arm", "left leg", "right leg", "neck", "?", "gear" }

--Saving players pitch value
client.set_event_callback("run_command", function(event)
    table_foreach(entity_get_all("CCSPlayer"), function(k, ent)
        local pitch = entity_get_prop(ent, "m_angEyeAngles", 0)
        if pitch_tick[ent] == nil then
            pitch_tick[ent] = {}
        end
    
       if pitch ~= nil then
            pitch_tick[ent][globals_tickcount() % 64] = { tick = globals_tickcount(), ang = pitch }
        end
    end)
end)

client.set_event_callback("aim_fire", function(e)
    if ui_get(menu.enabled) then
        --Creating variables
        local baim_dmg = e.damage
        local baim_hp = entity_get_prop(e.target, "m_iHealth") or 1
        local bodyaim = false
        local ticke = false

        --Checking if shoot should body aim them
        if (baim_dmg >= baim_hp) and (hitgroup_names[e.hitgroup + 1] == "stomach") then 
            bodyaim = true
        end

        --Checking if aimbot was shooting their on shot tick
        if pitch_tick[e.target] ~= nil and hitgroup_names[e.hitgroup + 1] == "head" then
            local sum = 0
            local tick_pitch = nil
            table_foreach(pitch_tick[e.target], function(k, tick)
                if tick.tick == e.tick then
                    tick_pitch = tick.ang
                else
                    sum = sum + tick.ang
                end
            end)

            sum = sum / #pitch_tick[e.target]

            if sum >= 75 and tick_pitch ~= nil and tick_pitch < 80 and tick_pitch > -80 then
                ticke = true
            end
        end

        --Insert into table
        table_fire = {
            ["id"] = e.id,
            ["hit"] = nil,
            ["target"] = e.target,
            ["nickname"] = entity_get_player_name(e.targe),
            ["hitbox"] = hitgroup_names[e.hitgroup + 1] or "?",
            ["hit_chance"] = floor(e.hit_chance * 100 + 0.5 ) / 100,
            ["damage"] = e.damage, 
            ["backtrack"] = e.backtrack / globals_tickinterval(), 
            ["round"] = entity_get_prop(entity.get_game_rules(), "m_totalRoundsPlayed"),
            ["body_yaw"] = math.floor(entity.get_prop(e.target, "m_flPoseParameter", 11) * 120 - 60 ),
            ["f_interpolated"] = e.interpolated,
            ["f_extrapolated"] = e.extrapolated,
            ["f_priority"] = e.high_priority,
            ["f_bodyaim"] = bodyaim,
            ["f_lagcomp"] = e.teleported,
            ["f_pitch"] = ticke,
            ["f_is_dead"] = false,
            ["time_added"] = client_timestamp()
        }
    end
end)

client.set_event_callback("player_hurt", function(e)
    if ui_get(menu.enabled) and client.userid_to_entindex(e.attacker) == entity.get_local_player() then
        --Checking if player_hurt was due to nade
        if e.hitgroup == 0 and table_main[1].id == table_fire.id then 
            return
        end
        
        --Replacing slots?
        for i = 10, 2, -1 do
            table_main[i] = table_main[i-1]
        end

        --Creating variables       
        local hitbox = table_fire.hitbox
        local is_dead = false

        --Checking if player is dead
        if e.health <= 0 then 
            is_dead = true
        end

        --Checking if aimbot hit hitbox in which he fired
        if table_fire.hitbox ~= hitgroup_names[e.hitgroup + 1] then  
            hitbox = hitbox .. "(" .. hitgroup_names[e.hitgroup + 1] .. ")" 
        end 


        --Insert into table
        if client_userid_to_entindex(e.userid) == table_fire.target then 
            table_main[1] = {
                ["id"] = table_fire.id,
                ["hit"] = "hit",
                ["target"] = table_fire.target,
                ["nickname"] = entity_get_player_name(table_fire.target),
                ["hitbox"] = hitbox,
                ["hit_chance"] = table_fire.hit_chance,
                ["damage"] = e.dmg_health, 
                ["backtrack"] = table_fire.backtrack, 
                ["round"] = table_fire.round,
                ["body_yaw"] = table_fire.body_yaw,
                ["f_interpolated"] = table_fire.f_interpolated,
                ["f_extrapolated"] = table_fire.f_extrapolated,
                ["f_priority"] = table_fire.f_priority,
                ["f_bodyaim"] = table_fire.f_bodyaim,
                ["f_lagcomp"] = table_fire.f_lagcomp,
                ["f_pitch"] = table_fire.f_pitch,
                ["f_is_dead"] = is_dead,
                ["time_added"] = table_fire.time_added
            }
        else
            table_main[1] = {
                ["id"] = table_fire.id,
                ["hit"] = "hit",
                ["target"] = client_userid_to_entindex(e.userid),
                ["nickname"] = entity_get_player_name(client_userid_to_entindex(e.userid)),
                ["hitbox"] = hitgroup_names[e.hitgroup + 1],
                ["hit_chance"] = table_fire.hit_chance,
                ["damage"] = e.dmg_health, 
                ["backtrack"] = 0, 
                ["round"] = table_fire.round,
                ["body_yaw"] = math.floor(entity.get_prop(client_userid_to_entindex(e.userid), "m_flPoseParameter", 11) * 120 - 60 ),
                ["f_interpolated"] = false,
                ["f_extrapolated"] = false,
                ["f_priority"] = false,
                ["f_bodyaim"] = false,
                ["f_lagcomp"] = false,
                ["f_pitch"] = false,
                ["f_is_dead"] = is_dead,
                ["time_added"] = table_fire.time_added
            }
        end
    end
end)

client.set_event_callback("aim_miss", function(e)
    if ui_get(menu.enabled) then
        --Replacing slots?
        for i = 10, 2, -1 do
            table_main[i] = table_main[i-1]
        end

        --Creating variables
        local reason = ""

        --Saving reason
        if e.reason == "?"  then
            reason = "unknown"
        elseif e.reason == "spread" then
            reason = "spread"
        elseif e.reason == "prediction error" then
            reason = "prediction"
        elseif e.reason == "death" then
            reason = "death"
        else
            reason = "new"
        end
        
        --Insert into table
        table_main[1] = {
            ["id"] = table_fire.id,
            ["hit"] = reason,
            ["target"] = table_fire.target,
            ["nickname"] = entity_get_player_name(table_fire.target),
            ["hitbox"] = table_fire.hitbox,
            ["hit_chance"] = table_fire.hit_chance,
            ["damage"] = table_fire.damage, 
            ["backtrack"] = table_fire.backtrack, 
            ["round"] = table_fire.round,
            ["body_yaw"] = table_fire.body_yaw,
            ["f_interpolated"] = table_fire.f_interpolated,
            ["f_extrapolated"] = table_fire.f_extrapolated,
            ["f_priority"] = table_fire.f_priority,
            ["f_bodyaim"] = table_fire.f_bodyaim,
            ["f_lagcomp"] = table_fire.f_lagcomp,
            ["f_pitch"] = table_fire.f_pitch,
            ["f_is_dead"] = false,
            ["time_added"] = table_fire.time_added
        }
    end
end)



function drawTable(c, count, x, y, data)
    if data then
        local sum = 0
        local y = y + 4
        local pitch = x + 10
        local yaw = y + 15 + (count * 16)

        local r, g, b = 0, 0, 0

        if data.hit == "hit" then
            r, g, b = 94, 230, 75
        elseif data.hit == "unknown" then
            r, g, b = 255, 0, 0
        elseif data.hit == "spread" then
            r, g, b = 255, 150, 0
        elseif data.hit == "prediction" then
            r, g, b = 255, 255, 0
        elseif data.hit == "death" then
            r, g, b = 118, 171, 255
        elseif data.hit == "new" then
            r, g, b = 255, 255, 255
        end


        draw_rectangle(c, x, yaw, 2, 15, r, g, b, 255)

        local alpha_modifier = (client_timestamp() - data.time_added) / animation_boundary
        if alpha_modifier > 1 then
            alpha_modifier = 1
        end

        for i = 1, 8 do 
            local element = get_ordered_element(i)
            if element.enable then
                element.draw(c, pitch, yaw, data, sum, alpha_modifier)
                sum = sum + element.size
            end
        end

        return (count + 1)
    end
end

client.set_event_callback("paint", function(c)
    if not ui_get(menu.enabled) then
        return
    end

    local x, y, d = ui_get(menu.size_x), ui_get(menu.size_y), 0
    local r, g, b, a = ui_get(menu.color)

    local n = ui_get(menu.max_amount)
    local col_sz = 24 + (16 * (#table_main > n and n or #table_main))

    local header_size = 0
    for id, value in pairs(draw) do
        if value.enable then 
            header_size = header_size + value.size
        end
    end

    x = x - (header_size / 2)

    draw_rectangle(c, x, y, header_size, col_sz, 22, 20, 26, 100)
    draw_rectangle(c, x, y, header_size, 15, r, g, b, a)

    local header_sum = 10

    for j = 1, 8 do
        local element = get_ordered_element(j)
        if element.enable then
            draw_text(c, x + header_sum, y + 3, 255, 255, 255, 255, "-", 70, element.header)
            header_sum = header_sum + element.size
        end
    end

   
    for i = 1, ui_get(menu.max_amount), 1 do
        d = drawTable(c, d, x, y, table_main[i])
    end
end)

local function visibility()
    local rpc = ui_get(menu.enabled)
    ui.set_visible(menu.options, rpc)
    ui.set_visible(menu.max_amount, rpc)
    ui.set_visible(menu.size_x, rpc)
    ui.set_visible(menu.size_y, rpc)
    ui.set_visible(menu.all_flags, rpc)
    ui.set_visible(menu.ordering, rpc)

    local vis = ui_get(menu.ordering)
    ui.set_visible(menu.to_left, vis)
    ui.set_visible(menu.to_right, vis)
    ui.set_visible(menu.ordering_element, vis)
    ui.set_visible(menu.reset_ord, vis)
end

visibility()
ui.set_callback(menu.enabled, visibility)
ui.set_callback(menu.ordering, visibility)

client.set_event_callback("round_freeze_end", function()
rounds = entity.get_prop(entity.get_game_rules(), "m_totalRoundsPlayed")
end)

client.set_event_callback("cs_game_disconnected", function()
    table_fire = {}
    table_main = {}
    pitch_tick = {}
    rounds = 0
end)