return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`DiscardEmperorsGift` encountered an error loading the Darktide Mod Framework.")

		new_mod("DiscardEmperorsGift", {
			mod_script       = "DiscardEmperorsGift/scripts/mods/DiscardEmperorsGift/DiscardEmperorsGift",
			mod_data         = "DiscardEmperorsGift/scripts/mods/DiscardEmperorsGift/DiscardEmperorsGift_data",
			mod_localization = "DiscardEmperorsGift/scripts/mods/DiscardEmperorsGift/DiscardEmperorsGift_localization",
		})
	end,
	packages = {},
}
