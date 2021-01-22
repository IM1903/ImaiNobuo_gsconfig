local referenceDMG = ui.reference("rage", "Aimbot", "Minimum damage")
local ToolTips = { [0] = "Auto", [1] = "1", [2] = "2", [3] = "3", [4] = "4", [5] = "5", [6] = "6", [7] = "7", [8] = "8", [9] = "9", [10] = "10", [11] = "11", [12] = "12", [13] = "13", [14] = "14", [15] = "15", [16] = "16", [17] = "17", [18] = "18", [19] = "19", [20] = "20", [21] = "21", [22] = "22", [23] = "23", [24] = "24", [25] = "25", [26] = "26", [27] = "27", [28] = "28", [29] = "29", [30] = "30", [31] = "31", [32] = "32", [33] = "33", [34] = "34", [35] = "35", [36] = "36", [37] = "37", [38] = "38", [39] = "39", [40] = "40", [41] = "41", [42] = "42", [43] = "43", [44] = "44", [45] = "45", [46] = "46", [47] = "47", [48] = "48", [49] = "49", [50] = "50", [51] = "51", [52] = "52", [53] = "53", [54] = "54", [55] = "55", [56] = "56", [57] = "57", [58] = "58", [59] = "59", [60] = "60", [61] = "61", [62] = "62", [63] = "63", [64] = "64", [65] = "65", [66] = "66", [67] = "67", [68] = "68", [69] = "69", [70] = "70", [71] = "71", [72] = "72", [73] = "73", [74] = "74", [75] = "75", [76] = "76", [77] = "77", [78] = "78", [79] = "79", [80] = "80", [81] = "81", [82] = "82", [83] = "83", [84] = "84", [85] = "85", [86] = "86", [87] = "87", [88] = "88", [89] = "89", [90] = "90", [91] = "91", [92] = "92", [93] = "93", [94] = "94", [95] = "95", [96] = "96", [97] = "97", [98] = "98", [99] = "99", [100] = "100", [101] = "HP+1", [102] = "HP+2", [103] = "HP+3", [104] = "HP+4", [105] = "HP+5", [106] = "HP+6", [107] = "HP+7", [108] = "HP+8", [109] = "HP+9", [110] = "HP+10", [111] = "HP+11", [112] = "HP+12", [113] = "HP+13", [114] = "HP+14", [115] = "HP+15", [116] = "HP+16", [117] = "HP+17", [118] = "HP+18", [119] = "HP+19", [120] = "HP+20", [121] = "HP+21", [122] = "HP+22", [123] = "HP+23", [124] = "HP+24", [125] = "HP+25", [126] = "HP+26" }
local activePrev, valuePrev = false, nil
local M = {"rage", "Aimbot"}
local menu = {
	useOverride = ui.new_checkbox(M[1], M[2], "Enable damage override"),
	value1Text = ui.new_label(M[1], M[2], "Override value 1"),
	hotkey1 = ui.new_hotkey(M[1], M[2], "value 1 hotkey", true),
	value1 = ui.new_slider(M[1], M[2], "\nvalue 1 slider", 0, 126, 101, true, nil, 1, ToolTips),
	value2Text = ui.new_label(M[1], M[2], "Override value 2"),
	hotkey2 = ui.new_hotkey(M[1], M[2], "value 2 hotkey", true),
	value2 = ui.new_slider(M[1], M[2], "\nvalue 2 slider", 0, 126, 5, true, nil, 1, ToolTips),
}

local function main()
	local active = ui.get(menu.useOverride) and ui.get(menu.hotkey1) or ui.get(menu.useOverride) and ui.get(menu.hotkey2)
	if active then
		if not activePrev then 
			-- Store original damage value
			valuePrev = ui.get(referenceDMG) 
		end
		local val = ui.get(referenceDMG)
		if ui.get(menu.hotkey1) then
			val = ui.get(menu.value1)
		elseif ui.get(menu.hotkey2) then
			val = ui.get(menu.value2)
		end
		renderer.indicator(255, 115, 134, 255, "DMG: " .. ToolTips[val])
		ui.set(referenceDMG, val)
	elseif activePrev then
		if valuePrev ~= nil then
			ui.set(referenceDMG, valuePrev)
			valuePrev = nil
		end
	else
		renderer.indicator(123, 194, 21, 255, "DMG: " .. ToolTips[ui.get(referenceDMG)])
	end
	activePrev = active
end

local function handle_menu()
	local status = ui.get(menu.useOverride)
	if status then
		ui.set_visible(menu.value1Text, status)
		ui.set_visible(menu.hotkey1, status)
		ui.set_visible(menu.value1, status)
		ui.set_visible(menu.value2Text, status)
		ui.set_visible(menu.hotkey2, status)
		ui.set_visible(menu.value2, status)
	else
		ui.set_visible(menu.value1Text, status)
		ui.set_visible(menu.hotkey1, status)
		ui.set_visible(menu.value1, status)
		ui.set_visible(menu.value2Text, status)
		ui.set_visible(menu.hotkey2, status)
		ui.set_visible(menu.value2, status)
	end
end

local function runIt()
	local enabled = ui.get(menu.useOverride)
	handle_menu()
	local callback = enabled and client.set_event_callback or client.unset_event_callback
	callback("paint", main)
end

runIt()
ui.set_callback(menu.useOverride, runIt)
