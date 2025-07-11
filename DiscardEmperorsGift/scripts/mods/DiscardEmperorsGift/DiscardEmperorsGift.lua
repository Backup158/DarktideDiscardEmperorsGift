local mod = get_mod("DiscardEmperorsGift")
local mod_version = "1.0.0"
-- Yes this is unnecessary and feature creep. It should be its own mod. Too bad. Suck my juicy hen.
local heretical_quotes = {
    "I reject the false promises of the carrion god. I shall reap a terrible bounty from the death that I sow in your name, Father Nurgle. Pestilence and death to the weakling Imperium of Man!",
    "Reject the lies of the False Emperor. Embrace your hunger, your lust, your desire. The universe is ours for the taking!",
    "Destroy, for the sake of Destruction! Kill, for the sake of Killing!", -- ? ; Codex: Chaos Space Marines (4th Edition)
    "Death the False Emperor!", -- Sevatar, First Captain of the Night Lords ; Codex: Chaos Space Marines (4th Edition)
    "The minds of gods are not for mortals to know or to judge. Accept that Tzeentch has a place for all of us in his grand scheme, and be happy in the part you have to play.", -- Magnus the Red ; Codex: Chaos Space Marines (4th Edition)
    "In the embrace of the great Nurgle, I am no longer afraid, for with His pestilential favour I have become that which I once most feared: Death.", -- Kulvain Hestarius of the Death Guard ; Codex: Chaos Space Marines (4th Edition)
    "The Imperium is a weak old man, ready and waiting to be broken apart.", -- Lufgt Huron, The Tyrant of Badab ; Codex: Chaos Space Marines (6th Edition)
    "Cast down the idols! Destroy the temples! Slay the priests! Show these fools that they worship nothing more than a rotting corpse!", -- Dark Apostle Harzhan of the Word Bearers; Codex: Chaos Space Marines (4th Edition)
    "I shall reap a terrible bounty from the death that I sow in your name, Father Nurgle...", -- Typhus the Traveler, Herald of Nurgle ; Codex: Chaos Space Marines (6th Edition)
    "There, feel the glory of necrosis, and rejoice! Nurgle loves you!", -- Ulkair, Great Unclean One ; Warhammer 40,000: Dawn of War II - Retribution
    "Sickness, disease, plague and pox, suffering and the slow, living rot. Such wondrous gifts does Nurgle seek to bestow upon the unworthy human cattle of the Imperium. We are merely the vectors by which his virulent beneficence may be spread to the undeserving masses.", -- Urgloth Rotheart, Plague Champion of the Death Guard ; Dark Imperium, Death Guard booklet
    "Let no good deed go unpunished. Let no evil deed go unrewarded.", -- Codex: Chaos Space Marines (4th Edition)
}

-- #############################
-- Requirements
-- #############################
local EndPlayerView = require("scripts/ui/views/end_player_view/end_player_view")
local GearService = require("scripts/managers/data_service/services/gear_service")

-- #############################
-- Helper Functions
-- #############################
-- #######
-- Refresh settings
--  NOT for performance. I just want to save myself from typing mod:get all the time
--  These are globals to easily update from inside functions
-- #######
local function get_settings()
    mod.using_debug_mode = mod:get("enable_debug_mode")
    mod.using_messages_discard = mod:get("enable_messages_discard")
    mod.using_weapons_only = mod:get("enable_weapons_only")
    mod.using_max_level_only = mod:get("enable_max_level_only")
end

-- #######
-- Discard Item
--  scripts/managers/data_service/services/gear_service.lua
-- #######
mod.discard_item = function(id_for_item_to_discard)
    if mod.using_debug_mode then mod:echo("Starting process to discard item. ID: "..tostring(id_for_item_to_discard)) end

    --  Modes: early exits
    --      Exit if not max level
    local player_is_max_level = true
    if mod.using_max_level_only and not player_is_max_level then
        if mod.using_debug_mode then mod:echo("Player is not max level. Not discarding") end
        return
    end
    --      Exit if not weapon
    if mod.using_debug_mode then mod:echo("Item type is "..tostring(mod.gift_type)) end
    local item_is_weapon = true
    if mod.using_weapons_only and not item_is_weapon then
        if mod.using_debug_mode then mod:echo("Item is not weapon (is curio). Not discarding") end
        return
    end

    -- Discards the fool
    if mod.using_messages_discard then mod:echo("+++ HERESY COMMITTED +++") end
    --      even though it's gear_service lol
    local discard_item_promise = GearService:delete_gear(id_for_item_to_discard)
end

-- #########################################
-- Hooks
-- #########################################

-- #######
-- Get ID of Emperor's Gift
--  scripts/ui/views/end_player_view/end_player_view
-- #######
mod:hook_safe(EndPlayerView, "_get_item", function (self, card_reward)
    mod:echo("Haiii!! heyyyy hiiii!!! get item")
    mod.gift_id = card_reward.master_id
    -- Item itself is at MasterItems.get_item(item_id)
    mod.gift_type = item.item_type
    mod.discard_item(mod.gift_id)
end)

mod:hook_safe(EndPlayerView, "_create_card_widget", function (self, index, card_type, card_data)
    mod:echo("Haiii!! heyyyy hiiii!!! _create_card_widget")
    --mod.gift_id = card_reward.master_id
    -- Item itself is at MasterItems.get_item(item_id)
    --mod.gift_type = card_type
   -- mod.discard_item(mod.gift_id)
end)

-- #########################################
-- Event Executions
-- #########################################
--[[
function mod.on_game_state_changed(status, state_name)
    local using_message_of_the_day = mod:get("enable_message_of_the_day")
    local quote_number = math.random(1, #heretical_quotes)
    if mod.using_debug_mode then mod:echo("Heretic quote number: "..tostring(quote_number)) end
    if using_message_of_the_day then mod:notify(heretical_quotes[quote_number]) end
end
mod.on_game_state_changed("exit", "StateMainMenu") -- Upon choosing character
-- tried StateMainMenuTestify. both just load 2 times at the title lol (1 at start, 1 before char select)
]]

function mod.on_all_mods_loaded()
    mod:info("DiscardEmperorsGift v"..mod_version.." loaded uwu nya :3")
    get_settings()

    local using_message_of_the_day = mod:get("enable_message_of_the_day")
    local quote_number = math.random(1, #heretical_quotes)
    if mod.using_debug_mode then mod:echo("Heretic quote number: "..tostring(quote_number)) end
    if using_message_of_the_day then mod:notify(heretical_quotes[quote_number]) end
end

function mod.on_setting_changed()
    get_settings()
    if mod.using_debug_mode then mod:echo("Settings changed") end
end