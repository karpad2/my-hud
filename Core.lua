function NepgearsyHUDReborn:Init()
	self.Dev = false
	self.Version = "Final Update ~"
	self.ModVersion = NepgearsyHUDReborn.update_module_data.module.version or self.Version
	self.WaifuSend = false

	self:InitCollabs()
	self:InitTweakData()
	self:InitLocalization()

	self.Initialized = true;
	--self.DiscordInitialized = false;
	--self.HasDiscordCustomStatus = self:GetOption("DiscordRichPresenceCustom") ~= ""
	self:Log("Initialized.")
end

function NepgearsyHUDReborn:InitCollabs()
	self.Creators = {
		[1] = {
			name = "Sora [Fruitbat Factory]",
			steam_id = "76561198111947132",
			action = "Made the code."
		},
		[2] = {
			name = "Matthelzor",
			steam_id = "76561198084015153",
			action = "Made the awesome background of the Control Panel."
		},
		[3] = {
			name = "Luffy",
			steam_id = "76561198075720845",
			action = "Helped with LUA stuff when I needed.\nHe also made the HUD scaling options."
		},
		[4] = {
			name = "=PDTC= Splat",
			steam_id = "76561198085683005",
			action = "Helped with testing stuff."
		},
		[5] = {
			name = "Babyforce",
			steam_id = "76561198053887800",
			action = "Giving me his thoughts and helping."
		},
		[6] = {
			name = "sydch pasha",
			steam_id = "76561198063913184",
			action = "Made the Turkish localization"
		},
		[7] = {
			name = "AldoRaine\ngabsF",
			steam_id = "76561198152040762",
			action = "Made the Portuguese localization"
		},
		[8] = {
			name = "ElReyZero",
			steam_id = "76561198143859174",
			action = "Made the Spanish localization"
		},
		[9] = {
			name = "Blake Langermann",
			steam_id = "76561198015483064",
			action = "Made the Russian localization"
		},
		[10] = {
			name = "=PDTC= Dobby Senpai",
			steam_id = "76561198040053543",
			action = "Helped with finding a sock."
		},
		[11] = {
			name = "Anthony",
			steam_id = "76561198164452807",
			action = "Made the French localization"
		},
		[12] = {
			name = "freaky",
			steam_id = "76561198376903915",
			action = "Made the Romanian localization"
		},
		[13] = {
			name = "Commander Neru",
			steam_id = "76561198090284682",
			action = "Helped with testing."
		},
		[14] = {
			name = "DreiPixel",
			steam_id = "76561197998773513",
			action = "Made the German localization"
		},
		[15] = {
			name = "Hinaomi",
			steam_id = "76561198027102120",
			action = "Made the Thai localization"
		},
		[16] = {
			name = "FR0Z3",
			steam_id = "76561198058215284",
			action = "Made the Simplified Chinese localization"
		},
		[17] = {
			name = "VladTheH",
			steam_id = "76561198149442981",
			action = "Made the Polish localization"
		}
	}
end

function NepgearsyHUDReborn:InitTweakData()
	self.StarringColors = {
		"NepgearsyHUDReborn/Color/White",
		"NepgearsyHUDReborn/Color/Red",
		"NepgearsyHUDReborn/Color/Green",
		"NepgearsyHUDReborn/Color/Blue",
		"NepgearsyHUDReborn/Color/Purple",
		"NepgearsyHUDReborn/Color/Yellow",
		"NepgearsyHUDReborn/Color/Orange",
		"NepgearsyHUDReborn/Color/Pink",
		"NepgearsyHUDReborn/Color/Fushia",
		"NepgearsyHUDReborn/Color/Cyan",
		"NepgearsyHUDReborn/Color/Blue_Ocean",
		"NepgearsyHUDReborn/Color/Red_Fushia"
	}

	if self.Dev then table.insert(self.StarringColors, "DEV") end -- hi :3

	self.CPColors = deep_clone(self.StarringColors)
	self.CPBorderColors = deep_clone(self.StarringColors)

	self.AssaultBarFonts = {
		"NepgearsyHUDReborn/Fonts/Normal",
		"NepgearsyHUDReborn/Fonts/Eurostile",
		"NepgearsyHUDReborn/Fonts/PDTH"
	}

	self.PlayerNameFonts = {
		"NepgearsyHUDReborn/Fonts/Eurostile",
		"NepgearsyHUDReborn/Fonts/Normal",
		"NepgearsyHUDReborn/Fonts/PDTH"
	}

	self.InteractionFonts = deep_clone(self.PlayerNameFonts)

	self.HealthColor = {
		"NepgearsyHUDReborn/Color/White",
		"NepgearsyHUDReborn/Color/Green",
		"NepgearsyHUDReborn/Color/Red",
		"NepgearsyHUDReborn/Color/Orange",
		"NepgearsyHUDReborn/Color/Yellow",
		"NepgearsyHUDReborn/Color/Cyan",
		"NepgearsyHUDReborn/Color/Blue_Ocean",
		"NepgearsyHUDReborn/Color/Blue",
		"NepgearsyHUDReborn/Color/Purple",
		"NepgearsyHUDReborn/Color/Pink",
		"NepgearsyHUDReborn/Color/Fushia",
		"NepgearsyHUDReborn/Color/Red_Fushia"
	}

	self.ArmorColor = deep_clone(self.HealthColor)
	self.ObjectiveColor = deep_clone(self.StarringColors)
	self.InteractionColor = deep_clone(self.StarringColors)

	self.HealthStyle = {
		"NepgearsyHUDReborn/HealthStyle/Thin",
		"NepgearsyHUDReborn/HealthStyle/Vanilla"
	}

	self.StatusNumberType = {
		"NepgearsyHUDReborn/StatusNumberType/Health_Counter",
		"NepgearsyHUDReborn/StatusNumberType/Shield_Counter",
		"NepgearsyHUDReborn/StatusNumberType/HealthShieldCombined",
		"NepgearsyHUDReborn/StatusNumberType/None"
	}

	self.TeammateSkinsCollectionLegacy = {
		"default",
		"community",
		"pd2",
		"suguri",
		"hdn",
		"plush",
		"persona",
		"kiniro",
		"other"
	}

	self.TeammateSkinsCollection = {
		default = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/DefaultHeader",
		pd2 = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/Pd2Header",
		community = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/CommunityHeader",
		hdn = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/HDNHeader",
		suguri = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/SuguriHeader",
		plush = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/PlushHeader",
		persona = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/PersonaHeader",
		kiniro = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/KiniroHeader",
		other = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/OtherHeader"
	}

	self.TeammateSkins = {
		{ author = "Sora", collection = "default", name = "Default", texture = "NepgearsyHUDReborn/HUD/Teammate", wide_counterpart = "NepgearsyHUDReborn/HUD/WideTeammateSkins/default" },
		{ author = "Sora", collection = "default", name = "Default Thin", texture = "NepgearsyHUDReborn/HUD/TeammateThin" },
		{ author = "you", collection = "default", name = "Custom", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/custom/your_texture" },
		{ author = "Sora", collection = "hdn", name = "Neptune", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/neptune_1" },
		{ author = "Sora", collection = "hdn", name = "Nepgear", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/nepgear_1" },
		{ author = "Sora", collection = "hdn", name = "Nepgear & Uni", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/nepgear_uni_1" },
		{ author = "Sora", collection = "hdn", name = "The Maid Team", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/maid_1" },
		{ author = "Sora", collection = "hdn", name = "Rom & Ram", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/rom_ram_1" },
		{ author = "Sora", collection = "hdn", name = "Histoire", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/histoire_1" },
		{ author = "Sora", collection = "suguri", name = "Suguri & Others", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/suguri_1" },
		{ author = "Sora (xd)", collection = "suguri", name = "Sora", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/sora_1", wide_counterpart = "NepgearsyHUDReborn/HUD/WideTeammateSkins/suguri/sora" },
		{ author = "Sora", collection = "other", name = "Eclipse", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/eclipse_1" },
		{ author = "Sora", collection = "other", name = "OwO", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/owo_1" },
		{ author = "Sora", collection = "hdn", name = "Orange Heart", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/orange_heart_1", wide_counterpart = "NepgearsyHUDReborn/HUD/WideTeammateSkins/hdn/orange_heart" },
		{ author = "Sora", collection = "hdn", name = "5pb", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/5pb_1" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_1" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_2" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_3", wide_counterpart = "NepgearsyHUDReborn/HUD/WideTeammateSkins/plush/plush_3" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_4" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_5" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_6" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_7" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_8" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_9" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_10" },
		{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_11" },
		{ author = "Sora", collection = "hdn", name = "Nepgear & Neptune", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/nepgear_neptune_1" },
		{ author = "Sora", collection = "hdn", name = "Blanc", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/blanc_1" },
		{ author = "Sora", collection = "other", name = "Hatsune Miku", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/miku_1" },
		{ author = "Sora", collection = "other", name = "Kurumi (School Live)", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/shovi_1" },
		{ author = "t0rkoal_", collection = "community", name = "Tamamo", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/tamamo" },
		{ author = "Sora", collection = "hdn", name = "Orange Heart", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/orange_heart_2" },
		{ author = "t0rkoal_", collection = "community", name = "Astolfo", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/astolfo" },
		{ author = "t0rkoal_", collection = "community", name = "Chibi Sydney", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/chibi_sydney" },
		{ author = "t0rkoal_", collection = "community", name = "Breaking News", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/breaking_news" },
		{ author = "Commander Neru", collection = "persona", name = "Aigis", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Aigis" },
		{ author = "Commander Neru", collection = "persona", name = "Akihiko Sanada", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Akihiko_Sanada" },
		{ author = "Commander Neru", collection = "persona", name = "Chidori Yoshino", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Chidori_Yoshino" },
		{ author = "Commander Neru", collection = "persona", name = "Elizabeth", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Elizabeth" },
		{ author = "Commander Neru", collection = "persona", name = "Fuuka Yamagishi", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Fuuka_Yamagishi" },
		{ author = "Commander Neru", collection = "persona", name = "Jin Shirato", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Jin_Shirato" },
		{ author = "Commander Neru", collection = "persona", name = "Junpei Iori", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Junpei_Iori" },
		{ author = "Commander Neru", collection = "persona", name = "Ken Amada", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Ken_Amada" },
		{ author = "Commander Neru", collection = "persona", name = "Koromaru", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Koromaru" },
		{ author = "Commander Neru", collection = "persona", name = "Minato Arisato", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Minato_Arisato" },
		{ author = "Commander Neru", collection = "persona", name = "Mitsuru Kirijo", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Mitsuru_Kirijo" },
		{ author = "Commander Neru", collection = "persona", name = "Shinjiro Aragaki", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Shinjiro_Aragaki" },
		{ author = "Commander Neru", collection = "persona", name = "Takaya Sakagi", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Takaya_Sakagi" },
		{ author = "Commander Neru", collection = "persona", name = "Yukari Takeba", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Yukari_Takeba" },
		{ author = "Commander Neru", collection = "persona", name = "Minako Arisato", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Minako_Arisato" },
		{ author = "Commander Neru", collection = "persona", name = "Minato Shadow", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Minato_Shadow" },
		{ author = "Sora", collection = "suguri", name = "Sora (2)", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/sora_2" },
		{ author = "Sora", collection = "pd2", name = "Dallas", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/dallas" },
		{ author = "Sora", collection = "pd2", name = "Wolf", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/wolf" },
		{ author = "Sora", collection = "pd2", name = "Chains", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/chains" },
		{ author = "Sora", collection = "pd2", name = "Hoxton", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/hoxton" },
		{ author = "Sora", collection = "pd2", name = "Houston", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/houston" },
		{ author = "Sora", collection = "pd2", name = "John Wick", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/jw" },
		{ author = "Sora", collection = "pd2", name = "Clover", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/clover" },
		{ author = "Sora", collection = "pd2", name = "Dragan", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/dragan" },
		{ author = "Sora", collection = "pd2", name = "Jacket", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/jacket" },
		{ author = "Sora", collection = "pd2", name = "Bonnie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/bonnie" },
		{ author = "Sora", collection = "pd2", name = "Sokol", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/sokol" },
		{ author = "Sora", collection = "pd2", name = "Jiro", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/jiro" },
		{ author = "Sora", collection = "pd2", name = "Bodhi", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/bodhi" },
		{ author = "Sora", collection = "pd2", name = "Jimmy", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/jimmy" },
		{ author = "Sora", collection = "pd2", name = "Sydney", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/sydney" },
		{ author = "Sora", collection = "pd2", name = "Rust", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/rust" },
		{ author = "Sora", collection = "pd2", name = "Scarface", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/scarface" },
		{ author = "Sora", collection = "pd2", name = "Sangres", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/sangres" },
		{ author = "Sora", collection = "pd2", name = "Duke", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/duke" },
		{ author = "Sora", collection = "pd2", name = "Joy", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/joy" },
		{ author = "t0rkoal_", collection = "community", name = "Aniday 2", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/aniheat" },
		{ author = "t0rkoal_", collection = "community", name = "cs_office", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/cs_office" },
		{ author = "t0rkoal_", collection = "community", name = ":csd2smile:", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/csd2smile" },
		{ author = "t0rkoal_", collection = "community", name = "Nightingale", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/florence" },
		{ author = "t0rkoal_", collection = "community", name = "Gudako", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/gacha" },
		{ author = "t0rkoal_", collection = "community", name = "Solo Jazz", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/jazz" },
		{ author = "t0rkoal_", collection = "community", name = "Super Shorty", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/madshorty" },
		{ author = "t0rkoal_", collection = "community", name = "Goro's Jacket", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/majimasnakeskin" },
		{ author = "t0rkoal_", collection = "community", name = "Shots Fired", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/neondeath" },
		{ author = "t0rkoal_", collection = "community", name = "Signal Lost", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/outage" },
		{ author = "t0rkoal_", collection = "community", name = "Astolfo Wink", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/tagwink" },
		{ author = "t0rkoal_", collection = "community", name = "Miko", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/tamamo_redux" },
		{ author = "t0rkoal_", collection = "community", name = "Armed Youmu", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/youmu_gun" },
		{ author = "t0rkoal_", collection = "community", name = "All You Need", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/416" },
		{ author = "t0rkoal_", collection = "community", name = "Minimal Saber", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/artoria" },
		{ author = "t0rkoal_", collection = "community", name = "Wow", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/doge" },
		{ author = "t0rkoal_", collection = "community", name = "Long IDW", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/idw" },
		{ author = "t0rkoal_", collection = "community", name = "Jeanne", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/jeanne" },
		{ author = "t0rkoal_", collection = "community", name = "Feeder", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/mp7" },
		{ author = "t0rkoal_", collection = "community", name = "Nero", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/nero" },
		{ author = "t0rkoal_", collection = "community", name = "Vector", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/vector" },
		{ author = "t0rkoal_", collection = "community", name = "Vector (2)", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/vector_ii" },
		{ author = "Sora", collection = "other", name = "NZ75", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/nz75" },
		{ author = "Sora", collection = "plush", name = "Sora's Plush", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_sora" },
		{ author = "RJC9000", collection = "other", name = "Magician", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/magician" },
		{ author = "RJC9000", collection = "other", name = "Miko", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/miko" },
		{ author = "Sora", collection = "default", name = "PAYDAY Borders", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/defaults/TeammateBorder" },
		{ author = "kruiserdb", collection = "community", name = "Philia Salis", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Phillia_Salis_1" },
		{ author = "kruiserdb", collection = "community", name = "Philia Salis", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Phillia_Salis_2" },
		{ author = "kruiserdb", collection = "community", name = "Philia Salis", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Phillia_Salis_3" },
		{ author = "kruiserdb", collection = "community", name = "Yume & Laura", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Yume__Laura" },
		{ author = "kruiserdb", collection = "community", name = "Cheetahmen", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Cheetahman" },
		{ author = "kruiserdb", collection = "community", name = "Signalize!", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Signalize" },
		{ author = "kruiserdb", collection = "community", name = "Behemoth", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Behemoth" },
		{ author = "kruiserdb", collection = "community", name = "Sakuraba Laura", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Sakuraba_Laura_1" },
		{ author = "kruiserdb", collection = "community", name = "Sakuraba Laura", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Sakuraba_Laura_2" },
		{ author = "kruiserdb", collection = "community", name = "Sakuraba Laura", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Sakuraba_Laura_3" },
		{ author = "Joltin135", collection = "community", name = "'The Forgotten Skin'", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/community/joltin" },
		{ author = "Kinrade", collection = "community", name = "Corey", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/community/corey" },
		{ author = "gabsF", collection = "community", name = "Twinkle", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/community/twinkle" },
		{ author = "Syphist", collection = "community", name = "Earth Chan", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/earth_chan" },
		{ author = "Syphist", collection = "kiniro", name = "Alice", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/kinmoza_alice" },
		{ author = "Syphist", collection = "kiniro", name = "Aya", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/kinmoza_aya" },
		{ author = "Syphist", collection = "kiniro", name = "Karen", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/kinmoza_karen" },
		{ author = "Syphist", collection = "kiniro", name = "Shinobu", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/kinmoza_shinobu" },
		{ author = "Syphist", collection = "kiniro", name = "Yoko", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/kinmoza_yoko" },
		{ author = "Syphist", collection = "community", name = "Minecraft Dirt", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/mc_dirt" },
		{ author = "Syphist", collection = "community", name = "Sans", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/sans" },
		{ author = "Syphist", collection = "community", name = "Windows XP Bliss", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/winxp_bliss" },
		{ author = "_Direkt", collection = "community", name = "Hannibal Buress", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/community/whyyoubooingme" },
		{ author = "Sora", collection = "suguri", name = "Suguri", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/sugu_2" },
		{ author = "Sora", collection = "suguri", name = "Suguri & Hime", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/sugu_hime" },
		{ author = "Sora", collection = "suguri", name = "Sora (Military)", dev = true, texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/sora_m_1" },
		{ author = "Sora", collection = "default", name = "Rounded", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/defaults/rounded_default" },
		{ author = "Sora", collection = "default", name = "No Frame", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/defaults/no_frame" },
		{ author = "Sora", collection = "default", name = "Golden Frame", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/defaults/golden_frame" },
		{ author = "Sora", collection = "default", name = "Rainbow", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/defaults/rainbow" },
	}

	self.TeammatePanelStyles = {
		"nepgearsy_hud_reborn_default",
		"nepgearsy_hud_reborn_sora_wide",
		"nepgearsy_hud_reborn_none"
	}

	--self.DiscordRichPresenceTypes = {
	--	"NepgearsyHUDReborn/Discord/DefaultType",
	--	"NepgearsyHUDReborn/Discord/KillTracker"
	--}
end

function NepgearsyHUDReborn:GetTeammateSkinBySave()
	local skin_id = self:GetOption("TeammateSkin")
	local is_wide = self:IsTeammatePanelWide()
	
	if is_wide then
		if self.TeammateSkins[skin_id] then
			if self.TeammateSkins[skin_id].wide_counterpart then
				return self.TeammateSkins[skin_id].wide_counterpart
			else
				return self.TeammateSkins[1].wide_counterpart
			end
		end

		return self.TeammateSkins[1].wide_counterpart
	end

	if self.TeammateSkins[skin_id] then
		return self.TeammateSkins[skin_id].texture
	end

	return self.TeammateSkins[1].texture
end

function NepgearsyHUDReborn:GetTeammateSkinID()
	return self:GetOption("TeammateSkin")
end

function NepgearsyHUDReborn:GetTeammateSkinById(id)
	local is_wide = self:IsTeammatePanelWide()
	
	if is_wide then
		if self.TeammateSkins[tonumber(id)] then
			if self.TeammateSkins[tonumber(id)].wide_counterpart then
				return self.TeammateSkins[tonumber(id)].wide_counterpart
			else
				return self.TeammateSkins[1].wide_counterpart
			end
		end

		return self.TeammateSkins[1].wide_counterpart
	end

	if self.TeammateSkins[tonumber(id)] then
		return self.TeammateSkins[tonumber(id)].texture
	end

	return self.TeammateSkins[1].texture
end

function NepgearsyHUDReborn:HasSteamAvatarsEnabled()
	return self:GetOption("EnableSteamAvatars")
end

function NepgearsyHUDReborn:GetInteractionColorBySave()
	local saved_id = self:GetOption("InteractionColor")

	return self:StringToColor("interaction_color", saved_id)
end

function NepgearsyHUDReborn:GetTeammateStyleBySave()
	local saved_id = self:GetOption("TeammatePanelStyle")
	return self.TeammatePanelStyles[saved_id]
end

function NepgearsyHUDReborn:IsTeammatePanelWide()
	if self:GetTeammateStyleBySave() == "nepgearsy_hud_reborn_sora_wide" then
		return true
	end

	return false
end

function NepgearsyHUDReborn:HasInteractionEnabled()
	return self:GetOption("EnableInteraction")
end

function NepgearsyHUDReborn:TeammateRadialIDToPath(id, type)
	local tritp = {}

	for i = 1, 12 do
		tritp[i] = {}
	end

	tritp[1]["Health"] = "NepgearsyHUDReborn/HUD/Health"
	tritp[2]["Health"] = "NepgearsyHUDReborn/HUD/HealthGreen"
	tritp[3]["Health"] = "NepgearsyHUDReborn/HUD/HealthRed"
	tritp[4]["Health"] = "NepgearsyHUDReborn/HUD/HealthOrange"
	tritp[5]["Health"] = "NepgearsyHUDReborn/HUD/HealthYellow"
	tritp[6]["Health"] = "NepgearsyHUDReborn/HUD/HealthCyan"
	tritp[7]["Health"] = "NepgearsyHUDReborn/HUD/HealthBlueOcean"
	tritp[8]["Health"] = "NepgearsyHUDReborn/HUD/HealthBlue"
	tritp[9]["Health"] = "NepgearsyHUDReborn/HUD/HealthPurple"
	tritp[10]["Health"] = "NepgearsyHUDReborn/HUD/HealthPink"
	tritp[11]["Health"] = "NepgearsyHUDReborn/HUD/HealthFushia"
	tritp[12]["Health"] = "NepgearsyHUDReborn/HUD/HealthRedFushia"

	tritp[1]["Armor"] = "NepgearsyHUDReborn/HUD/Shield"
	tritp[2]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldGreen"
	tritp[3]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldRed"
	tritp[4]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldOrange"
	tritp[5]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldYellow"
	tritp[6]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldCyan"
	tritp[7]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldBlueOcean"
	tritp[8]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldBlue"
	tritp[9]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldPurple"
	tritp[10]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldPink"
	tritp[11]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldFushia"
	tritp[12]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldRedFushia"

	return tritp[id][type]
end

function NepgearsyHUDReborn:StringToColor(module, id)
	local stc = {}
	stc["starring"] = {}
	stc["starring"][1] = Color.white
	stc["starring"][2] = Color.red
	stc["starring"][3] = Color.green
	stc["starring"][4] = Color.blue
	stc["starring"][5] = Color("9800ff")
	stc["starring"][6] = Color.yellow
	stc["starring"][7] = Color("ff6e00")
	stc["starring"][8] = Color("ffa3f5")
	stc["starring"][9] = Color("ff00e3")
	stc["starring"][10] = Color("00ffff")
	stc["starring"][11] = Color("2f5ab7")
	stc["starring"][12] = Color("ff006e")
	stc["starring"][13] = Color(1, 0.63, 0.58, 0.95)

	stc["cpcolor"] = deep_clone(stc["starring"])
	stc["cpcolor"][1] = Color.black

	stc["cpbordercolor"] = deep_clone(stc["starring"])
	stc["objective_color"] = deep_clone(stc["starring"])
	stc["interaction_color"] = deep_clone(stc["starring"])

	stc["numeral_status_color"] = {}
	stc["numeral_status_color"][1] = Color("ffffff")
	stc["numeral_status_color"][2] = Color("2dc43c")
	stc["numeral_status_color"][3] = Color("d8022d")
	stc["numeral_status_color"][4] = Color("ff6e00")
	stc["numeral_status_color"][5] = Color("ffe100")
	stc["numeral_status_color"][6] = Color("06ddda")
	stc["numeral_status_color"][7] = Color("068edd")
	stc["numeral_status_color"][8] = Color("2149ff")
	stc["numeral_status_color"][9] = Color("b014ff")
	stc["numeral_status_color"][10] = Color("fcc9ff")
	stc["numeral_status_color"][11] = Color("f000ff")
	stc["numeral_status_color"][12] = Color("ff0090")

	return stc[module][id]
end

function NepgearsyHUDReborn:InitLocalization()
	self.LocalizationTable = {}
	self.Localization = {
		[1] = {
			localized_name = "NepgearsyHUDReborn/Localization/English",
			path = "english.txt"
		},
		[2] = {
			localized_name = "NepgearsyHUDReborn/Localization/Turkish",
			path = "turkish.txt"
		},
		[3] = {
			localized_name = "NepgearsyHUDReborn/Localization/Portuguese",
			path = "portuguese.txt"
		},
		[4] = {
			localized_name = "NepgearsyHUDReborn/Localization/Spanish",
			path = "spanish.txt"
		},
		[5] = {
			localized_name = "NepgearsyHUDReborn/Localization/Russian",
			path = "russian.txt"
		},
		[6] = {
			localized_name = "NepgearsyHUDReborn/Localization/French",
			path = "french.txt"
		},
		[7] = {
			localized_name = "NepgearsyHUDReborn/Localization/Romanian",
			path = "romanian.txt"
		},
		[8] = {
			localized_name = "NepgearsyHUDReborn/Localization/German",
			path = "german.txt"
		},
		[9] = {
			localized_name = "NepgearsyHUDReborn/Localization/Thai",
			path = "thai.txt"
		},
		[10] = {
			localized_name = "NepgearsyHUDReborn/Localization/SimplifiedChinese",
			path = "chinese.txt"
		},
		[11] = {
			localized_name = "NepgearsyHUDReborn/Localization/Polish",
			path = "polish.txt"
		}
	}

	for i, localization in ipairs(self.Localization) do
		table.insert(self.LocalizationTable, localization.localized_name)
	end
end

function NepgearsyHUDReborn:InitDiscord()
	if not self:GetOption("UseDiscordRichPresence") then
		self:Log("User disabled Custom Rich Presence, skip")
		return
	end

	if not self.DiscordInitialized then
		self:Log("Setting up Custom Discord Rich Presence")

		local player_level = managers.experience:current_level()
		local player_rank = managers.experience:current_rank()
		local is_infamous = player_rank > 0
		local level_string = player_level > 0 and ", " .. (is_infamous and managers.experience:rank_string(player_rank) .. "-" or "") .. tostring(player_level) or ""
		
		Discord:set_large_image("payday2_icon", "PAYDAY 2")
		Discord:set_small_image("sora_hud", "Sora's HUD Reborn " .. self.Version)
		
		if self:GetOption("DRPAllowTimeElapsed") then
			Discord:set_start_time_relative(0)
		else
			Discord:set_start_time(0)
		end

		self.DiscordInitialized = true
	end
end

function NepgearsyHUDReborn:SetDiscordPresence(title, desc, allow_time_relative, reset, reset_image)
	if not self:GetOption("UseDiscordRichPresence") then
		return
	end

	if not self.HasDiscordCustomStatus then
		Discord:set_status(tostring(desc), tostring(title))
	else
		Discord:set_status(tostring(self:GetOption("DiscordRichPresenceCustom")), "")
	end

	if reset and allow_time_relative and self:GetOption("DRPAllowTimeElapsed") then
		Discord:set_start_time_relative(0)
	else
		Discord:set_start_time(0)
	end

	if reset_image then
		--Discord:set_large_image("payday2_icon", "PAYDAY 2")
	end
end

function NepgearsyHUDReborn:SetLargeImage(key, text)
	--Discord:set_large_image(key, text)
end

function NepgearsyHUDReborn:IsKillTrackerPresence()
	--return self:GetOption("DiscordRichPresenceType") == 2
end

function NepgearsyHUDReborn:GetForcedLocalization()
	local Chosen = self:GetOption("ForcedLocalization")
	local Folder = self.ModPath .. "Localization/"

	if not self.Localization[Chosen] then
		self:Error("Can't load a localization file if there's no ID for it! Returning english.")
		return Folder .. self.Localization[1].path
	end

	for i, localization in ipairs(self.Localization) do
		if i == Chosen then
			return Folder .. localization.path
		end
	end
end

function NepgearsyHUDReborn:InitMenu()
	MenuCallbackHandler.NepgearsyHUDRebornMenu = ClassClbk(NepHudMenu, "SetEnabled", true)
    MenuHelperPlus:AddButton({
        id = "NepgearsyHUDRebornMenu",
        title = "NepgearsyHUDRebornMenu",
        node_name = "blt_options",
        callback = "NepgearsyHUDRebornMenu"
    })
end

function NepgearsyHUDReborn:Log(text, ...)
	log("[NepgearsyHUDReborn] LOG : " .. text, ...)
end

function NepgearsyHUDReborn:DebugLog(text, ...)
	if not self.Dev then
		return
	end

	log("[NepgearsyHUDReborn] DEVLOG : " .. text, ...)
end

function NepgearsyHUDReborn:Error(text, ...)
	log("[NepgearsyHUDReborn] ERROR : " .. text, ...)
end

function NepgearsyHUDReborn:GetOption(option_name)
	return NepgearsyHUDReborn.Options:GetValue(option_name)
end

function NepgearsyHUDReborn:SetOption(option_name, value)
	return NepgearsyHUDReborn.Options:SetValue(option_name, value)
end

-- Init NepHook functions based on Luffy's one. Hug to you if you read this :satanialove:
NepHook = NepHook or {}

function NepHook:Post(based_class, based_func, content)
	local concat_id = tostring(based_func) .. "_PostHook"
	Hooks:PostHook(based_class, based_func, concat_id, content)
end

function NepHook:Pre(based_class, based_func, content)
	local concat_id = tostring(based_func) .. "_PreHook"
	Hooks:PreHook(based_class, based_func, concat_id, content)
end

if Hooks then
	Hooks:Add("MenuManagerPopulateCustomMenus", "InitNepHudMenu", callback(NepgearsyHUDReborn, NepgearsyHUDReborn, "InitMenu"))

	Hooks:Add("LocalizationManagerPostInit", "PostInitLocalizationNepHud", function(loc)
		loc:load_localization_file( NepgearsyHUDReborn:GetForcedLocalization() )
	end)

	Hooks:Add("SetupInitManagers", "PostInitManager_ExecutionDiscord", function()
		--NepgearsyHUDReborn:InitDiscord()
	end)
end


if not _G.WolfHUDHUDList then
	_G.WolfHUDHUDList = {}
	WolfHUDHUDList.mod_path = ModPath
	WolfHUDHUDList.save_path = SavePath
	WolfHUDHUDList.settings_path = WolfHUDHUDList.save_path .. "HUDListV2.json"
	--WolfHUDHUDList.tweak_file = "WolfHUDHUDListTweakData.lua"
	
	WolfHUDHUDList.settings = {}
	WolfHUDHUDList.tweak_data = {}

	function WolfHUDHUDList:Reset()
		local default_lang = "english"
		for _, filename in pairs(file.GetFiles(self.mod_path .. "Localization/")) do
			local str = filename:match('^(.*).json$')
			if str and Idstring(str) and Idstring(str):key() == SystemInfo:language():key() then
				default_lang = str
				break
			end
		end

		WolfHUDHUDList.settings = {
			LANGUAGE 								= default_lang,
			HUDList = {
				ENABLED	 								= true,
				ORIGNIAL_HOSTAGE_BOX                    = false,				
				right_list_height_offset				= 50,
				left_list_height_offset					= 60,
				buff_list_height_offset					= 90,
				mui_buff_fix							= false,
				right_list_scale						= 1,
				left_list_scale							= 1,
				buff_list_scale							= 1,
				right_list_progress_alpha 				= 0.4,
				left_list_progress_alpha 				= 0.4,
				buff_list_progress_alpha 				= 1.0,
				list_color	 							= "white",		--Left and Right List font color
				list_color_bg	 						= "black",		--Left and Right List BG color
				civilian_color 							= "white", 		--EnemyCounter Civillian and Hostage icon color
				thug_color 								= "white",		--EnemyCounter Thug and Mobster icon color
				enemy_color 							= "white",		--EnemyCounter Cop and Specials icon color
				special_color 							= "white",
				LEFT_LIST = {
					show_timers 							= true,     --Drills, time locks, hacking etc.
					show_ammo_bags							= true,  	--Deployables (ammo)
					show_doc_bags							= true,  	--Deployables (doc bags)
					show_first_aid_kits						= false,	--Deployables (first_aid_kits)
					show_body_bags							= true,  	--Deployables (body bags)
					show_grenade_crates						= true,  	--Deployables (grenades)
					show_sentries 							= true,   	--Deployable sentries
					show_ecms 								= true,		--Active ECMs
					show_ecm_retrigger 						= true,  	--Countdown for players own ECM feedback retrigger delay
					show_minions 							= true,  	--Converted enemies, type and health
						show_own_minions_only				= true,	--Only show player-owned minions
					show_pagers 							= true,  	--Show currently active pagers
					show_tape_loop 							= true,  	--Show active tape loop duration
				},
				RIGHT_LIST = {
					show_enemies 							= true,		--Currently spawned enemies
						aggregate_enemies 					= false,  	--Don't split enemies on type; use a single entry for all
					show_turrets 							= true,    	--Show active SWAT turrets
					show_civilians 							= true,  	--Currently spawned, untied civs
					show_hostages 							= true,   	--Currently tied civilian and dominated cops
						aggregate_hostages					= false,
					show_minion_count 						= true,     --Current number of jokered enemies
					show_pager_count 						= true,		--Show number of triggered pagers (only counts pagers triggered while you were present)
					show_cam_count							= true,
					show_bodybags_count						= true,
					show_corpse_count						= false,
					show_loot 								= true,     --Show spawned and active loot bags/piles (may not be shown if certain mission parameters has not been met)
						aggregate_loot		 				= false, 	--Don't split loot on type; use a single entry for all
						separate_bagged_loot		 		= true,     --Show bagged loot as a separate value
						show_potential_loot					= false,
					show_special_pickups 					= true,    	--Show number of special equipment/items
					SHOW_PICKUP_CATEGORIES = {
					        keycard                             = true,
						crowbar                             = true,
						planks                              = true,
						mission_pickups 					= true,
						collectables 						= true,
						valuables 							= true,
					}

				},
				BUFF_LIST = {
					show_buffs 								= true,     --Active effects (buffs/debuffs). Also see HUDList.BuffItemBase.IGNORED_BUFFS table to ignore specific buffs that you don't want listed, or enable some of those not shown by default					
					damage_increase							= true,
					damage_reduction						= true,
					melee_damage_increase					= true,
					passive_health_regen 					= true,
					total_dodge_chance 						= true,
					PLAYER_ACTIONS = {
					        anarchist_armor_regeneration            = false,
					        standard_armor_regeneration             = false,
					        weapon_charge                           = false,
					        melee_charge                            = true,
					        reload                                  = true,
					        interact                                = true,
					},      
					MASTERMIND_BUFFS = {
						forced_friendship					= true,
						aggressive_reload_aced				= true,
						ammo_efficiency						= true,
						combat_medic						= true,
						combat_medic_passive				= false,
						hostage_taker						= false,
						inspire								= true,
						painkiller							= false,
						partner_in_crime					= false,
						quick_fix							= false,
						uppers								= true,
						inspire_debuff						= true,
						inspire_revive_debuff				= true,
					},
					ENFORCER_BUFFS = {
						bulletproof							= true,
						bullet_storm						= true,
						die_hard							= false,
						overkill							= false,
						underdog							= false,
						bullseye_debuff						= true,
					},
					TECHNICIAN_BUFFS = {
						lock_n_load							= true,
					},
					GHOST_BUFFS = {
						dire_need							= true,
						second_wind							= true,
						sixth_sense							= true,
						unseen_strike						= true,
					},
					FUGITIVE_BUFFS = {
						berserker							= true,
						bloodthirst_basic					= false,
						bloodthirst_aced					= true,
						desperado							= true,
						frenzy			 					= false,
						messiah								= true,
						running_from_death					= true,
						swan_song							= false,
						trigger_happy						= false,
						up_you_go							= false,
					},
					PERK_BUFFS = {
						armor_break_invulnerable			= true,
						anarchist_armor_recovery_debuff		= true,
						ammo_give_out_debuff				= true,
						armorer								= true,
						biker								= true,
						chico_injector						= false,
						close_contact						= true,
						crew_chief							= true,
						damage_control_debuff 				= false,
						delayed_damage 						= true,
						hostage_situation					= false,
						medical_supplies_debuff				= true,
						grinder								= true,
						tooth_and_claw						= true,
						life_drain_debuff					= true,
						melee_stack_damage					= false,
						overdog								= false,
						maniac								= false,
						muscle_regen						= false,
						pocket_ecm_jammer 					= true,
						pocket_ecm_kill_dodge 				= false,
						sicario_dodge 						= true,
						smoke_screen_grenade 				= true,
						sociopath_debuff					= true,
						tag_team 							= true,
						yakuza								= false,
					},
					GAGE_BOOSTS = {
						invulnerable_buff					= true,
						life_steal_debuff					= true,
					},
					AI_SKILLS = {
						crew_inspire_debuff 				= true,
						crew_throwable_regen 				= true,
						crew_health_regen 					= false,
					},
				},
			},
		}
	end

	function WolfHUDHUDList:print_log(...)
		local LOG_MODES = self:getTweakEntry("LOG_MODE", "table", {})
		local params = {...}
		local msg_type, text = table.remove(params, #params), table.remove(params, 1)
		if msg_type and LOG_MODES[tostring(msg_type)] then
			if type(text) == "table" or type(text) == "userdata" then
				local function log_table(userdata)
					local text = ""
					for id, data in pairs(userdata) do
						if type(data) == "table" then
							log( id .. " = {")
							log_table(data)
							log("}")
						elseif type(data) ~= "function" then
							log( id .. " = " .. tostring(data) .. "")
						else
							log( "function " .. id .. "(...)")
						end
					end
				end
				if not text[1] or type(text[1]) ~= "string" then
					log(string.format("[WolfHUDHUDList] %s:", string.upper(type(msg_type))))
					log_table(text)
					return
				else
					text = string.format(unpack(text))
				end
			elseif type(text) == "function" then
				msg_type = "error"
				text = "Cannot log function... "
			elseif type(text) == "string" then
				text = string.format(text, unpack(params or {}))
			end
			text = string.format("[WolfHUDHUDList] %s: %s", string.upper(msg_type), text)
			log(text)
			if LOG_MODES.to_console and con and con.print and con.error then
				local t = Application:time()
				text = string.format("%02d:%06.3f\t>\t%s", math.floor(t/60), t%60, text)
				if tostring(msg_type) == "info" then
					con:print(text)
				else
					con:error(text)
				end
			end
		end
	end

	function WolfHUDHUDList:Load()
		local corrupted = false
		local file = io.open(self.settings_path, "r")
		if file then
			local function parse_settings(table_dst, table_src, setting_path)
				for k, v in pairs(table_src) do
					if type(table_dst[k]) == type(v) then
						if type(v) == "table" then
							table.insert(setting_path, k)
							parse_settings(table_dst[k], v, setting_path)
							table.remove(setting_path, #setting_path)
						else
							table_dst[k] = v
						end
					else
						self:print_log("Error while loading, Setting types don't match (%s->%s)", self:SafeTableConcat(setting_path, "->") or "", k or "N/A", "error")
						corrupted = corrupted or true
					end
				end
			end

			local settings = json.decode(file:read("*all"))
			parse_settings(self.settings, settings, {})
			file:close()
		else
			self:print_log("Error while loading, settings file could not be opened (" .. self.settings_path .. ")", "error")
		end
		if corrupted then
			self:Save()
			self:print_log("Settings file appears to be corrupted, resaving...", "error")
		end
	end

	function WolfHUDHUDList:Save()
		if table.size(self.settings or {}) > 0 then
			local file = io.open(self.settings_path, "w+")
			if file then
				file:write(json.encode(self.settings))
				file:close()
			else
				self:print_log("Error while saving, settings file could not be opened (" .. self.settings_path .. ")", "error")
			end
		else
			self:print_log("Error while saving, settings table appears to be empty...", "error")
		end
	end

	function WolfHUDHUDList:createDirectory(path)
		local current = ""
		path = Application:nice_path(path, true):gsub("\\", "/")

		for folder in string.gmatch(path, "([^/]*)/") do
			current = Application:nice_path(current .. folder, true)

			if not self:DirectoryExists(current) then
				if SystemFS and SystemFS.make_dir then
					SystemFS:make_dir(current)
				elseif file and file.CreateDirectory then
					file.CreateDirectory(current)
				end
			end
		end

		return self:DirectoryExists(path)
	end

	function WolfHUDHUDList:DirectoryExists(path)
		if SystemFS and SystemFS.exists then
			return SystemFS:exists(path)
		elseif file and file.DirectoryExists then
			log("")	-- For some weird reason the function below always returns true if we don't log anything previously...
			return file.DirectoryExists(path)
		end
	end

	function WolfHUDHUDList:getVersion()
        local mod = BLT and BLT.Mods:GetMod(WolfHUDHUDList.identifier or "")
		return tostring(mod and mod:GetVersion() or "(n/a)")
	end

	function WolfHUDHUDList:SafeTableConcat(tbl, str)
		local res
		for i = 1, #tbl do
			local val = tbl[i] and tostring(tbl[i]) or "[nil]"
			res = res and res .. str .. val or val
		end
		return res
	end

	function WolfHUDHUDList:getSetting(id_table, default)
		if type(id_table) == "table" then
			local entry = self.settings
			for i = 1, #id_table do
				entry = entry[id_table[i]]
				if entry == nil then
					self:print_log("Requested setting doesn't exists!  (id='" .. self:SafeTableConcat(id_table, "->") .. "', type='" .. (default and type(default) or "n/a") .. "') ", "error")
					return default
				end
			end
			return entry
		end
		return default
	end

	function WolfHUDHUDList:setSetting(id_table, value)
		local entry = self.settings
		for i = 1, (#id_table-1) do
			entry = entry[id_table[i]]
			if entry == nil then
				return false
			end
		end

		if type(entry[id_table[#id_table]]) == type(value) then
			entry[id_table[#id_table]] = value
			return true
		end
	end

	function WolfHUDHUDList:getColorSetting(id_table, default, ...)
		local color_name = self:getSetting(id_table, default)
		return self:getColor(color_name, ...) or default and self:getColor(default, ...)
	end

	function WolfHUDHUDList:getColorID(name)
		if self.tweak_data and type(name) == "string" then
			for i, data in ipairs(self:getTweakEntry("color_table", "table")) do
				if name == data.name then
					return i
				end
			end
		end
	end

	function WolfHUDHUDList:getColor(name, ...)
		if self.tweak_data and type(name) == "string" then
			for i, data in ipairs(self:getTweakEntry("color_table", "table")) do
				if name == data.name then
					return data.color and Color(data.color) or data.color_func and data.color_func(...) or nil
				end
			end
		end
	end

	function WolfHUDHUDList:getTweakEntry(id, val_type, default)
		local value = self.tweak_data[id]
		if value ~= nil and (not val_type or type(value) == val_type) then
			return value
		else
			if default == nil then
				if val_type == "number" then -- Try to prevent crash by giving default value
					default = 1
				elseif val_type == "boolean" then
					default = false
				elseif val_type == "string" then
					default = ""
				elseif val_type == "table" then
					default = {}
				end
			end
			self.tweak_data[id] = default
			self:print_log("Requested tweak_entry doesn't exists!  (id='" .. id .. "', type='" .. tostring(val_type) .. "') ", "error")
			return default
		end
	end

	function WolfHUDHUDList:getCharacterName(character_id, to_upper)
		local name = character_id or "UNKNOWN"
		local character_names = self:getTweakEntry("CHARACTER_NAMES", "table", {})
		local name_table = character_names and character_names[character_id]
		if name_table then
			local level_id = managers.job and managers.job:current_level_id() or "default"
			local name_id = name_table[level_id] or name_table.default
			name = to_upper and managers.localization:to_upper_text(name_id) or managers.localization:text(name_id)
		end

		return name
	end

	function WolfHUDHUDList:truncateNameTag(name)
		local truncated_name = name:gsub('^%b[]',''):gsub('^%b==',''):gsub('^%s*(.-)%s*$','%1')
		if truncated_name:len() > 0 and name ~= truncated_name then
			name = utf8.char(1031) .. truncated_name
		end
		return name
	end

	if not WolfHUDHUDList.tweak_path then		-- Populate tweak data
		local tweak_path = string.format("%s%s", WolfHUDHUDList.save_path, WolfHUDHUDList.tweak_file)
		if not io.file_is_readable(tweak_path) then
			tweak_path = string.format("%s%s", WolfHUDHUDList.mod_path, WolfHUDHUDList.tweak_file)
		end
		if io.file_is_readable(tweak_path) then
			dofile(tweak_path)
			WolfHUDHUDList.tweak_data = WolfHUDHUDListTweakData:new()
		else
			WolfHUDHUDList:print_log(string.format("Tweak Data file couldn't be found! (%s)", tweak_path), "error")
		end
	end

	-- Table with all menu IDs
	WolfHUDHUDList.menu_ids = WolfHUDHUDList.menu_ids or {}

	--callback functions to apply changed settings on the fly
	if not WolfHUDHUDList.apply_settings_clbk then
		WolfHUDHUDList.apply_settings_clbk = {
			["HUDList"] = function(setting, value)
				if managers.hud and HUDListManager and setting then
					local list = tostring(setting[1])
					local category = tostring(setting[2])
					local option = tostring(setting[#setting])

					if list == "BUFF_LIST" and category ~= "show_buffs" then
						managers.hud:change_bufflist_setting(option, WolfHUDHUDList:getColor(value) or value)
					elseif list == "RIGHT_LIST" and category == "SHOW_PICKUP_CATEGORIES" then
						managers.hud:change_pickuplist_setting(option, WolfHUDHUDList:getColor(value) or value)
					else
						managers.hud:change_list_setting(option, WolfHUDHUDList:getColor(value) or value)
					end
				end
			end,
		}
	end

	WolfHUDHUDList:Reset()	-- Populate settings table
	WolfHUDHUDList:Load()	-- Load user settings

	do	-- Romove Disabled Updates, so they don't show up in the download manager.
	end


	-- Create Ingame Menus
	do
		dofile(WolfHUDHUDList.mod_path .. "OptionMenus.lua")	-- Menu structure table in seperate file, in order to not bloat the Core file too much.
		local menu_options = WolfHUDHUDList.options_menu_data

		-- Setup and register option menus
		Hooks:Add("MenuManagerSetupCustomMenus", "MenuManagerSetupCustomMenusWolfHUDHUDList", function( menu_manager, nodes )
			local function create_menu(menu_table, parent_id)
				for i, data in ipairs(menu_table) do
					if data.type == "menu" then
						MenuHelper:NewMenu( data.menu_id )
						create_menu(data.options, data.menu_id)
					end
				end
			end
--
			create_menu({menu_options}, BLT and BLT.Mods.Constants:LuaModOptionsMenuID() or "blt_options")
		end)

		--Populate options menus
		Hooks:Add("MenuManagerPopulateCustomMenus", "MenuManagerPopulateCustomMenusWolfHUDHUDList", function(menu_manager, nodes)
			-- Called on setting change
			local function change_setting(setting, value)
				if WolfHUDHUDList:getSetting(setting, nil) ~= value and WolfHUDHUDList:setSetting(setting, value) then
					WolfHUDHUDList:print_log(string.format("Change setting: %s = %s", WolfHUDHUDList:SafeTableConcat(setting, "->"), tostring(value)), "info")	-- Change type back!
					WolfHUDHUDList.settings_changed = true

					local script = table.remove(setting, 1)
					if WolfHUDHUDList.apply_settings_clbk[script] then
						WolfHUDHUDList.apply_settings_clbk[script](setting, value)
					end
				end
			end

			local function add_visible_reqs(menu_id, id, data)
				local visual_clbk_id = id .. "_visible_clbk"
				local enabled_clbk_id = id .. "_enabled_clbk"

				--Add visual callback
				MenuCallbackHandler[visual_clbk_id] = function(self, item)
					for _, req in ipairs(data.visible_reqs or {}) do
						if type(req) == "table" then
							local a = WolfHUDHUDList:getSetting(req.setting, nil)
							if req.equal then
								if a ~= req.equal then
									return false
								end
							elseif type(a) == "boolean" then
								local b = req.invert and true or false
								if a == b then
									return false
								end
							elseif type(a) == "number" then
								local min_value = req.min or a
								local max_value = req.max or a
								if a < min_value or a > max_value then
									return false
								end
							end
						elseif type(req) == "boolean" then
							return req
						end
					end
					return true
				end

				--Add enable callback
				MenuCallbackHandler[enabled_clbk_id] = function(self, item)
					for _, req in ipairs(data.enabled_reqs or {}) do
						if type(req) == "table" then
							local a = WolfHUDHUDList:getSetting(req.setting, nil)
							if req.equal then
								if a ~= req.equal then
									return false
								end
							elseif type(a) == "boolean" then
								local b = req.invert and true or false
								if a == b then
									return false
								end
							elseif type(a) == "number" then
								local min_value = req.min or a
								local max_value = req.max or a
								if a < min_value or a > max_value then
									return false
								end
							end
						elseif type(req) == "boolean" then
							return req
						end
					end
					return true
				end

				--Associate visual callback with item
				local menu = MenuHelper:GetMenu(menu_id)
				for i, item in pairs(menu._items_list) do
					if item:parameters().name == id then
						item._visible_callback_name_list = { visual_clbk_id }
						item._enabled_callback_name_list = { enabled_clbk_id }
						item._create_data = data
						break
					end
				end
			end

			-- Reapply enabled state on all items in the same menu
			local update_visible_clbks = "wolfhud_update_visibility"
			MenuCallbackHandler[update_visible_clbks] = function(self, item)
				local gui_node = item:parameters().gui_node
				if gui_node then
					if item._type ~= "slider" then
						gui_node:refresh_gui(gui_node.node)
						gui_node:highlight_item(item, true)
					end

					for _, row_item in pairs(gui_node.row_items) do
						local option_item = row_item.item
						if option_item._type ~= "divider" and option_item:parameters().name ~= item:parameters().name then
							local enabled = true

							for _, clbk in ipairs(option_item._enabled_callback_name_list or {}) do
								enabled = enabled and self[clbk](self, option_item)
							end

							option_item:set_enabled(enabled)

							gui_node:reload_item(option_item)
						end
					end
				end
			end

			-- item create functions by type
			local create_item_handlers = {
				menu = function(parent_id, offset, data)
					if not table.contains(WolfHUDHUDList.menu_ids, data.menu_id) then
						table.insert(WolfHUDHUDList.menu_ids, data.menu_id)
					end
				end,
				slider = function(menu_id, offset, data, value)
					local id = string.format("%s_%s_slider", menu_id, data.name_id)
					local clbk_id = id .. "_clbk"

					MenuHelper:AddSlider({
						id = id,
						title = data.name_id,
						desc = data.desc_id,
						callback = string.format("%s %s", clbk_id, update_visible_clbks),
						value = value or 0,
						min = data.min_value,
						max = data.max_value,
						step = data.step_size,
						show_value = true,
						menu_id = menu_id,
						priority = offset,
						disabled_color = Color(0.6, 0.6, 0.6),
					})

					--Value changed callback
					MenuCallbackHandler[clbk_id] = function(self, item)
						change_setting(clone(data.value), item:value())
					end

					if data.visible_reqs or data.enabled_reqs then
						add_visible_reqs(menu_id, id, data)
					end
				end,
				toggle = function(menu_id, offset, data, value)
					local id = string.format("%s_%s_toggle", menu_id, data.name_id)
					local clbk_id = id .. "_clbk"

					if data.invert_value then
						value = not value
					end

					MenuHelper:AddToggle({
						id = id,
						title = data.name_id,
						desc = data.desc_id,
						callback = string.format("%s %s", clbk_id, update_visible_clbks),
						value = value or false,
						menu_id = menu_id,
						priority = offset,
						disabled_color = Color(0.6, 0.6, 0.6),
					})

					--Add visual callback
					MenuCallbackHandler[clbk_id] = function(self, item)
						local value = (item:value() == "on") and true or false

						if data.invert_value then
							value = not value
						end

						change_setting(clone(data.value), value)
					end

					if data.visible_reqs or data.enabled_reqs then
						add_visible_reqs(menu_id, id, data)
					end
				end,
				multi_choice = function(menu_id, offset, data, value)
					local id = string.format("%s_%s_multi", menu_id, data.name_id)
					local clbk_id = id .. "_clbk"

					local multi_data = {
						id = id,
						title = data.name_id,
						desc = data.desc_id,
						callback = string.format("%s %s", clbk_id, update_visible_clbks),
						items = data.options,
						value = value,
						menu_id = menu_id,
						priority = offset,
						disabled_color = Color(0.6, 0.6, 0.6),
					}

					do	-- Copy of MenuHelper:AddMultipleChoice (Without ipairs for options)
						local data = {
							type = "MenuItemMultiChoice"
						}
						for k, v in pairs( multi_data.items or {} ) do
							table.insert( data, { _meta = "option", text_id = v, value = k } )
						end

						local params = {
							name = multi_data.id,
							text_id = multi_data.title,
							help_id = multi_data.desc,
							callback = multi_data.callback,
							filter = true,
							localize = multi_data.localized,
						}

						local menu = MenuHelper:GetMenu( multi_data.menu_id )
						local item = menu:create_item(data, params)
						item._priority = multi_data.priority
						item:set_value( multi_data.value or 1 )

						if multi_data.disabled then
							item:set_enabled( not multi_data.disabled )
						end

						menu._items_list = menu._items_list or {}
						table.insert( menu._items_list, item )
					end

					MenuCallbackHandler[clbk_id] = function(self, item)
						change_setting(clone(data.value), item:value())
					end

					if data.add_color_options then
						local menu = MenuHelper:GetMenu(menu_id)
						for i, item in pairs(menu._items_list) do
							if item:parameters().name == id then
								item:clear_options()
								for k, v in ipairs(WolfHUDHUDList:getTweakEntry("color_table", "table") or {}) do
									if data.add_rainbow or v.name ~= "rainbow" then
										local color_name = managers.localization:text("wolfhud_colors_" .. v.name)
										color_name = not color_name:lower():find("error") and color_name or string.upper(v.name)
										local params = {
											_meta = "option",
											text_id = color_name,
											value = v.name,
											localize = false,
											color = Color(v.color),
										}
										if v.name == "rainbow" then
											local rainbow_colors = { Color('FE0E31'), Color('FB9413'), Color('F7F90F'), Color('3BC529'), Color('00FFFF'), Color('475DE7'), Color('B444E4'), Color('F46FE6') }
											params.color = rainbow_colors[1]
											for i = 0, color_name:len() do
												params["color" .. i] = rainbow_colors[(i % #rainbow_colors) + 1]
												params["color_start" .. i] = i
												params["color_stop" .. i] = i + 1
											end
										end

										item:add_option(CoreMenuItemOption.ItemOption:new(params))
									end
								end
								item:_show_options(nil)
								item:set_value(value)
								for __, clbk in pairs( item:parameters().callback ) do
									clbk(item)
								end
								break
							end
						end
					end

					if data.visible_reqs or data.enabled_reqs then
						add_visible_reqs(menu_id, id, data)
					end
				end,
				input = function(menu_id, offset, data)
					local id = string.format("%s_%s_input", menu_id, data.name_id)
					local clbk_id = id .. "_clbk"

					MenuHelper:AddInput({
						id = id,
						title = data.name_id,
						desc = data.desc_id,
						value = tostring(data.value),
						callback = clbk_id,
						menu_id = menu_id,
						priority = offset,
						disabled_color = Color(0.6, 0.6, 0.6),
					})

					MenuCallbackHandler[clbk_id] = function(self, item)
						change_setting(clone(data.value), item:value())
					end

					if data.visible_reqs or data.enabled_reqs then
						add_visible_reqs(menu_id, id, data)
					end
				end,
				button = function(menu_id, offset, data)
					local id = string.format("%s_%s_button", menu_id, data.name_id)
					local clbk_id = data.clbk or (id .. "_clbk")

					MenuHelper:AddButton({
						id = id,
						title = data.name_id,
						desc = data.desc_id,
						callback = clbk_id,
						menu_id = menu_id,
						priority = offset,
						disabled_color = Color(0.6, 0.6, 0.6),
					})

					MenuCallbackHandler[clbk_id] = MenuCallbackHandler[clbk_id] or function(self, item)

					end

					if data.visible_reqs or data.enabled_reqs then
						add_visible_reqs(menu_id, id, data)
					end
				end,
				keybind = function(menu_id, offset, data)
					local id = string.format("%s_%s_keybind", menu_id, data.name_id)
					local clbk_id = data.clbk or (id .. "_clbk")

					MenuHelper:AddKeybinding({
						id = id,
						title = data.name_id,
						desc = data.desc_id,
						connection_name = "",
						binding = "",
						button = "",
						callback = clbk_id,
						menu_id = menu_id,
						priority = offset,
						--disabled_color = Color(0.6, 0.6, 0.6),
					})

					MenuCallbackHandler[clbk_id] = MenuCallbackHandler[clbk_id] or function(self, item)

					end

					if data.visible_reqs or data.enabled_reqs then
						add_visible_reqs(menu_id, id, data)
					end
				end,
				divider = function(menu_id, offset, data)
					local id = string.format("%s_divider_%d", menu_id, offset)

					local item_data = {
						type = "MenuItemDivider"
					}
					local params = {
						name = id,
						no_text = not data.text_id,
						text_id = data.text_id,
						localize = "true",
						size = data.size or 8,
						color = tweak_data.screen_colors.text
					}

					local menu = MenuHelper:GetMenu( menu_id )
					local item = menu:create_item( item_data, params )
					item._priority = offset or 0
					menu._items_list = menu._items_list or {}
					table.insert( menu._items_list, item )
				end,
			}

			-- Populate Menus with their menu items
			local function populate_menu(menu_table, parent_id)
				local item_amount = #menu_table
				for i, data in ipairs(menu_table) do
					local value = data.value and WolfHUDHUDList:getSetting(data.value, nil)
					create_item_handlers[data.type](data.parent_id or parent_id, item_amount - i, data, value)

					if data.type == "menu" then
						populate_menu(data.options, data.menu_id)
					end
				end
			end

			populate_menu({menu_options}, BLT and BLT.Mods.Constants:LuaModOptionsMenuID() or "blt_options")
		end)

		-- Create callbacks and finalize menus
		Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenusWolfHUDHUDList", function(menu_manager, nodes)
			local back_clbk = "wolfhud_back_clbk"
			local focus_clbk = "wolfhud_focus_clbk"
			local reset_clbk = "wolfhud_reset_clbk"

			-- Add menu back callback
			MenuCallbackHandler[back_clbk] = function(node)
				if WolfHUDHUDList.settings_changed then
					WolfHUDHUDList.settings_changed = nil
					WolfHUDHUDList:Save()
					WolfHUDHUDList:print_log("Settings saved!", "info")
				end
			end

			-- Add focus callback
			MenuCallbackHandler[focus_clbk] = function(node, focus)
				if focus then
					for _, option_item in pairs(node._items) do
						if option_item._type ~= "divider" then
							local enabled = true

							for _, clbk in ipairs(option_item._enabled_callback_name_list or {}) do
								enabled = enabled and MenuCallbackHandler[clbk](node.callback_handler, option_item)
							end

							option_item:set_enabled(enabled)
						end
					end
				end
			end

			-- Add reset menu items callback
			MenuCallbackHandler[reset_clbk] = function(self, item)
				local menu_title = managers.localization:text("wolfhud_reset_options_title")
				local menu_message = managers.localization:text("wolfhud_reset_options_confirm")
				local menu_buttons = {
					[1] = {
						text = managers.localization:text("dialog_yes"),
						callback = function(self, item)
							WolfHUDHUDList:Reset()

							for i, menu_id in ipairs(WolfHUDHUDList.menu_ids) do
								local menu = MenuHelper:GetMenu(menu_id)
								if menu then
									for __, menu_item in ipairs(menu._items_list) do
										local setting = menu_item._create_data and clone(menu_item._create_data.value)
										if menu_item.set_value and setting then
											local value = WolfHUDHUDList:getSetting(setting, nil)
											if value ~= nil then
												local script = table.remove(setting, 1)
												if WolfHUDHUDList.apply_settings_clbk[script] then
													WolfHUDHUDList.apply_settings_clbk[script](setting, value)
												end

												if menu_item._type == "toggle" then
													if menu_item._create_data.invert_value then
														value = not value
													end
													value = (value and "on" or "off")
												end

												menu_item:set_value(value)
											end
										end
									end
								end
							end
							managers.viewport:resolution_changed()

							WolfHUDHUDList.settings_changed = true
							WolfHUDHUDList:print_log("Settings resetted!", "info")
						end,
					},
					[2] = {
						text = managers.localization:text("dialog_no"),
						is_cancel_button = true,
					},
				}
				QuickMenu:new( menu_title, menu_message, menu_buttons, true )
			end

			-- Build Menus and add a button to parent menu
			local function finalize_menu(menu_table, parent_id)
				for i, data in ipairs(menu_table) do
					if data.type == "menu" then
						nodes[data.menu_id] = MenuHelper:BuildMenu(data.menu_id, { back_callback = back_clbk, focus_changed_callback = focus_clbk })
						MenuHelper:AddMenuItem(
							nodes[data.parent_id or parent_id],
							data.menu_id,
							data.name_id,
							data.desc_id,
							data.position or i
						)

						finalize_menu(data.options, data.menu_id)
					end
				end
			end

			finalize_menu({menu_options}, BLT and BLT.Mods.Constants:LuaModOptionsMenuID() or "blt_options")
		end)
	end

	--Add localization strings
	Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInitWolfHUDHUDList", function(loc)
        local loc_path = WolfHUDHUDList.mod_path .. "loc/"
		if file.DirectoryExists( loc_path ) then
			loc:load_localization_file(string.format("%s/%s.json", loc_path, WolfHUDHUDList:getSetting({"LANGUAGE"}, "english")))
			loc:load_localization_file(string.format("%s/english.json", loc_path), false)
		else
			WolfHUDHUDList:print_log("Localization folder seems to be missing!", "error")
		end
	end)
end
