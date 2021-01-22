local ref_on_shotAA
local localPlayer
local use_on_shotAA = ui.new_checkbox("AA", "Other", "On shot AA on key")
local on_shotAA_key = ui.new_hotkey("AA", "Other", "\n", true)

local function main()
	localPlayer = entity.get_local_player()

	ref_on_shotAA = ui.reference("AA", "Other", "On shot anti-aim")

	local active_switch = ui.get(use_on_shotAA)
	local active_key = ui.get(on_shotAA_key)

	if localPlayer == nil then return end
	if not entity.is_alive(localPlayer) then return end

	if not active_switch then
		return
	elseif active_key and active_switch then
		ui.set(ref_on_shotAA, true)
		renderer.indicator(123, 194, 21, 255, "OnShot AA")
	elseif active_switch and not active_key then
		ui.set(ref_on_shotAA, false)
		renderer.indicator(255, 115, 134, 255, "OnShot AA")
	end
end

client.set_event_callback("paint", main)
