local mod = get_mod("DiscardEmperorsGift")
local mod_version = "1.0.0"
local using_debug_mode
local using_start_message
local using_weapons_only
local using_max_level_only

-- #######
-- Get ID of Emperor's Gift
-- #######

-- #######
-- Discard Item
-- #######
local discard_item = function(id_for_item_to_discard)
    local discard_item_promise = Managers.data_service.gear_service:delete_gear(id_for_item_to_discard)
end

function mod.on_all_mods_loaded()
    mod:info("DiscardEmperorsGift v"..mod_version.." loaded uwu nya :3")

end