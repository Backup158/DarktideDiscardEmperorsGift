local mod = get_mod("DiscardEmperorsGift")
local mod_version = "1.0.0"
local heretical_quotes = {
    "I reject the false promises of the carrion god. I shall reap a terrible bounty from the death that I sow in your name, Father Nurgle. Pestilence and death to the weakling Imperium of Man!",
    "Reject the lies of the False Emperor. Embrace your hunger, your lust, your desire. The universe is ours for the taking!",
    "It is the fate of the weak to die unknown, and the destiny of the strong to rule for eternity. Give me glory, or give me death!",
}

-- #######
-- Refresh settings
--  Not for performance. I just want to save myself from typing mod:get all the time
-- #######
function mod.get_settings()
    mod.using_debug_mode = mod:get("enable_debug_mode")
    mod.using_messages_discard = mod:get("enable_messages_discard")
    mod.using_weapons_only = mod:get("enable_weapons_only")
    mod.using_max_level_only = mod:get("enable_max_level_only")
end

-- #######
-- Get ID of Emperor's Gift
-- #######

-- #######
-- Discard Item
-- #######
local discard_item = function(id_for_item_to_discard)
    if using_messages_discard then mod:echo("+++ HERESY COMMITTED +++") end
    local discard_item_promise = Managers.data_service.gear_service:delete_gear(id_for_item_to_discard)
end

function mod.on_all_mods_loaded()
    mod:info("DiscardEmperorsGift v"..mod_version.." loaded uwu nya :3")
    mod.get_settings()
    
    local using_messages_start = mod:get("enable_messages_start")
    local quote_number = math.random(1, #heretical_quotes)
    if using_messages_start then mod:notify(heretical_quotes[quote_number]) end
end

function mod.on_setting_changed()
    mod.get_settings()
end