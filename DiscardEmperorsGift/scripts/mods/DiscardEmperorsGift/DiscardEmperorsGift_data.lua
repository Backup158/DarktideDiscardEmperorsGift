local mod = get_mod("DiscardEmperorsGift")

local filled_widgets = {}
local widgets_to_add = {
	{
		name = "enable_debug_mode",
		default_status = false, 
	},
	{
		name = "enable_start_message",
		default_status = false, 
	},
	{
		name = "enable_weapons_only",
		default_status = false, 
	},
	{
		name = "enable_max_level_only",
		default_status = true, 
	},
}

local function add_widget_toggle(widgets_table, widget_object)
	widgets_table[#widgets_table + 1] = {
		setting_id = widget_object["name"],
		type = "checkbox",
		default_value = widget_object["default_status"],
	}
end

for _, obj in pairs(widgets_to_add) do
	add_widget_toggle(filled_widgets, obj)
end

return {
	name = "Discard Emperor's Gift",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = { 
		widgets = filled_widgets,
	}
}
