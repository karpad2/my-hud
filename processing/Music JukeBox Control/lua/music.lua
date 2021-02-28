MusicJukeBoxControl = MusicJukeBoxControl or {}
MusicJukeBoxControl._path = ModPath
MusicJukeBoxControl._data = {}
MusicJukeBoxControl._enabled = true
MusicJukeBoxControl._debug = true
MusicJukeBoxControl.max_tracks_per_page = 20
MusicJukeBoxControl.music_event_categories = {
	default = {
		"music_heist_setup",
		"music_heist_control",
		"music_heist_anticipation",
		"music_heist_assault",
	},
	alesso_setups = {
		"alesso_music_play",
		"alesso_music_cut",
		"alesso_music_fade"
	},
	alesso = {
		"alesso_music_cut",
		"alesso_music_stealth",
		"alesso_music_control",
		"alesso_music_anticipation",
		"alesso_music_assault",
		"alesso_music_hacking_standby",
		"alesso_music_hacking_progress",
		"alesso_music_drop"
	},
	alesso_muffled = {
		"alesso_muffle_1",
		"alesso_muffle_2",
		"alesso_muffle_3",
		"alesso_muffle_4",
		"alesso_muffle_5",
		"alesso_muffle_6",
		"alesso_muffle_7",
		"alesso_muffle_8"
	},
	suspenses = {
		"suspense_1",
		"suspense_2",
		"suspense_3",
		"suspense_4",
		"suspense_5"
	},
	forbidden_music = {
		"kosugi_music",
		"music_dark",
		"music_fish",
		"music_tag",
		"music_xmn",
	},
	opening_safes = {
		"cash_safe_open_01",
		"cash_safe_open_02",
		"cash_safe_open_03",
		"cash_safe_open_04",
		"cash_safe_open_05",
	},
	alesso_crowd = {
		"crowd_light",
		"crowd_medium",
		"crowd_heavy",
		"crowd_crazy",
		"crowd_single_ending"
	}
}

function MusicJukeBoxControl:set_enabled(enable)
	self._enabled = enable
end

function MusicJukeBoxControl:check_if_beardlib_material(track, event)
	if BeardLib and BeardLib.MusicMods then
		for id, music in pairs(BeardLib.MusicMods) do
			if track == id or event == id or managers.music._current_custom_track == id then
				return true
			end
		end
	end
	return false
end

function MusicJukeBoxControl:switch_track(data)
	if Global.music_manager then
	
		local skip_track_check = false
		local current_event = Global.music_manager.current_event
		if not current_event or not current_event:find("music_heist_") then
			current_event = "music_heist_setup"
			skip_track_check = true
		end
		
		if skip_track_check or data.track ~= Global.music_manager.current_track then	
		
			if self:check_if_beardlib_material(data.track, nil)	then
				managers.music._current_custom_track = data.track
			end
			
			
			Global.music_manager.current_track = data.track
			


			
			Global.music_manager.current_event = nil
			
			Global.music_manager.source:stop()
			Global.music_manager.source:set_switch("music_randomizer", data.track)
			MusicJukeBoxControl:post_event(current_event)
		end
		
	end
	self:set_enabled(true)
end

function MusicJukeBoxControl:force_stop_music()
	Global.music_manager.source:stop()
	self:set_enabled(true)
end

function MusicJukeBoxControl:post_event(event)
	if managers.music then
		if not self:check_if_beardlib_material(nil, event) then			
			managers.music._current_custom_track = nil
		end
		managers.music:post_event(event)
	end
	self:set_enabled(true)
end

function MusicJukeBoxControl:post_suspense_event(data)

	local current_event = Global.music_manager.current_event
	local restart = false
	
	if not self._current_forbidden_track or self._current_forbidden_track ~= data.track then
		restart = true
	elseif not current_event:find("suspense_") then
		restart = true
	elseif current_event:find("suspense_") and current_event ~= data.event then
		restart = true
	end
	
	if restart and data.track ~= "none" then
		self:post_event("stop_all_music")
		self:post_event(data.track)
	end
	
	self:post_event(data.event)
end

function MusicJukeBoxControl:post_safe_event(event)
	self:post_event("stop_all_music")
	self:post_event(event)
end

function MusicJukeBoxControl:post_alesso_event(event)

	local current_event = Global.music_manager.current_event or ""
	local restart = false
	if not MusicJukeBoxControl._alesso_playing then
		restart = true
	end
	
	if event == "alesso_music_cut" then
		restart = false
	end
	
	if restart then
		self:post_event("alesso_music_play")
	end
	
	self:post_event(event)
end


function MusicJukeBoxControl:next_page(data)	
	self:show_tracks_list_menu(data.page, data.list_type)
end


function MusicJukeBoxControl:get_tracks_list(list_type, pd_type)	
	local loc = managers.localization
	local show_tracks = {}
	local tracks, tracks_locked
	local page = 1	
	local is_actually_in_the_menu = game_state_machine:current_state_name() == "menu_main"
	local is_menu_main = false
	
	if list_type then
		if list_type == "music_type_menu" then
			is_menu_main = true
		elseif list_type == "music_type_heists" then
			is_menu_main = false
		end
	else
		is_menu_main = is_actually_in_the_menu
	end
	
	if is_menu_main then   
		tracks, tracks_locked = managers.music:jukebox_menu_tracks()
	else
		tracks, tracks_locked = managers.music:jukebox_music_tracks()
	end
	
	local function _can_list_track(track)
		local is_pdth_track = string.sub(track, 1, 10) == "track_pth_" or string.sub(track, 1, 4) == "pth_"
		local pdth_remixes = {
			track_31 = true,
			track_52 = true,
			track_42 = true,
			track_53 = true,
			track_43 = true,
			track_47_gen = true,
			track_47_flat = true,
			track_63 = true,
			track_35 = true,
			track_24 = true,
			track_55 = true,
		}
		
		local is_pdth_remix = pdth_remixes[track]
		if pd_type == "pdth" then
			return is_pdth_track
		elseif pd_type == "pdth2" then
			return is_pdth_remix
		end
		return not is_pdth_remix and not is_pdth_track
	end
			
			
	for index, track in pairs(tracks) do		
		if _can_list_track(track) then
			if not tracks_locked[track] then
				if show_tracks and show_tracks[page] and #show_tracks[page] > MusicJukeBoxControl.max_tracks_per_page then
					table.insert(show_tracks[page],{
						text = nil
					})
					table.insert(show_tracks[page],{
						is_page = true,
						text = loc:text("jukeboxcontrol_next_page"),
						data = {page = page + 1, list_type = list_type},
						callback = callback(self, self, "next_page"),
					})
					page = page + 1
				end
				show_tracks[page] = show_tracks[page] or {}
				table.insert(show_tracks[page], {
					text = loc:text((is_menu_main and "menu_jukebox_screen_" or "menu_jukebox_") ..track),
					data = is_menu_main and track or {track = track},
					callback = callback(self, self, is_menu_main and "post_event" or "switch_track"),
				})
			end
		end
	end
	
	if not next(show_tracks) then
		return nil
	end
	
	for pg, data in pairs(show_tracks) do
		if pg ~= 1 then 
			if pg == #show_tracks then
				table.insert(show_tracks[pg],{
					text = nil
				})
			end
			table.insert(show_tracks[pg],{
				text = loc:text("jukeboxcontrol_previous_page"),
				data = {page = pg - 1, list_type = list_type},
				callback = callback(self, self, "next_page"),
			})
		end
		table.insert(show_tracks[pg],{
			text = nil,
		})
		table.insert(show_tracks[pg],{
			text = loc:text("jukeboxcontrol_cancel"),
			is_cancel_button = true,
			data = true,
			callback = callback(self, self, "set_enabled")
		})
	end
	
	return show_tracks
end


function MusicJukeBoxControl:clbk_show_tracks_list_menu(data)	
	self:show_tracks_list_menu(1, data.list_type, data.pd_type)
end



function MusicJukeBoxControl:clbk_choose_pd_type(data)	
	local options = {
		{
			text = managers.localization:text("jukeboxcontrol_type_pd2"),
			data = {list_type = data.list_type, pd_type = "pd2"},
			callback = callback(self, self, "clbk_show_tracks_list_menu")			
		},
		{
			text = managers.localization:text("jukeboxcontrol_type_pdth"),
			data = {list_type = data.list_type, pd_type = "pdth"},
			callback = callback(self, self, "clbk_show_tracks_list_menu")			
		},
		{
			text = nil,
		},
		{
			text = managers.localization:text("jukeboxcontrol_cancel"),
			is_cancel_button = true,
			data = true,
			callback = callback(self, self, "set_enabled")	
		}
	}
	
	if data.list_type == "music_type_heists" then
		table.insert(options, 3, {
			text = managers.localization:text("jukeboxcontrol_type_pdth2"),
			data = {list_type = data.list_type, pd_type = "pdth2"},
			callback = callback(self, self, "clbk_show_tracks_list_menu")			
		})	
	end
	QuickMenu:new(managers.localization:text("jukeboxcontrol_type_title"), "", options, true)
end

function MusicJukeBoxControl:choose_track_category_options()
	local options = {
		{
			text = managers.localization:text("jukeboxcontrol_music_type_menu"),
			data = {list_type = "music_type_menu"},
			callback = callback(self, self, "clbk_choose_pd_type")			
		},
		{
			text = managers.localization:text("jukeboxcontrol_music_type_heists"),
			data = {list_type = "music_type_heists"},
			callback = callback(self, self, "clbk_choose_pd_type")			
		},
		{
			text = managers.localization:text("jukeboxcontrol_category_forbidden_music"),
			data = "forbidden_music",
			callback = callback(self, self, "choose_forbidden_music"),
		},
		{
			text = nil,
		},
		{
			text = managers.localization:text("jukeboxcontrol_cancel"),
			is_cancel_button = true,
			data = true,
			callback = callback(self, self, "set_enabled")	
		}
	}
	self:set_enabled(false)
	QuickMenu:new(managers.localization:text("jukeboxcontrol_choose_music_category"), "", options, true)
end


function MusicJukeBoxControl:show_tracks_list_menu(page, type, pd_type)	
	self:set_enabled(false)
	local loc = managers.localization
	local page_list = self:get_tracks_list(type, pd_type)

	local str = string.format("jukeboxcontrol_choose_%s_title", type)
	
	QuickMenu:new(loc:text(str), "", page_list and page_list[page] or {}, true)
end

function MusicJukeBoxControl:show_music_events(category)
	if not MusicJukeBoxControl.music_event_categories[category] then
		return
	end

	local override_func_name = {
		alesso = "post_alesso_event",	
		opening_safes = "post_safe_event",	
	}
	
	local func_name = category and override_func_name[category] or "post_event"
	local loc = managers.localization
	local music_types_menu = {}
	for index, name in pairs(MusicJukeBoxControl.music_event_categories[category]) do
		music_types_menu[index] = {
			text = loc:text("jukeboxcontrol_event_"..name),
			data = name,
			callback = callback(self, self, func_name)
		}
	end
	
	music_types_menu[#music_types_menu + 1] = {
		text = nil,
	}

	
	music_types_menu[#music_types_menu + 1] = {
		text = loc:text("jukeboxcontrol_cancel"),
		is_cancel_button = true,
		data = true,
		callback = callback(self, self, "set_enabled")
	}
	
	QuickMenu:new(loc:text("jukeboxcontrol_choose_music_event"), "", music_types_menu, true)
end


function MusicJukeBoxControl:display_suspenses(music_ext)
	local loc = managers.localization
	local music_types_menu = {}	
	for index, name in pairs(MusicJukeBoxControl.music_event_categories.suspenses) do
		music_types_menu[#music_types_menu + 1] = {
			text = loc:text("jukeboxcontrol_event_"..name),
			data = {event = name, track = music_ext},
			callback = callback(self, self, "post_suspense_event")
		}
	end
	
	music_types_menu[#music_types_menu + 1] = {
		text = nil
	}
	
	music_types_menu[#music_types_menu + 1] = {
		text = loc:text("jukeboxcontrol_cancel"),
		is_cancel_button = true,
		data = true,
		callback = callback(self, self, "set_enabled")
	}

	QuickMenu:new(loc:text("jukeboxcontrol_choose_suspense"), music_ext ~= "none" and loc:text("jukeboxcontrol_event_"..music_ext) or "", music_types_menu, true)
end


function MusicJukeBoxControl:choose_forbidden_music()
	local loc = managers.localization
	local music_types_menu = {}
	local steath_tracks, stealth_tracks_locked = managers.music:jukebox_ghost_tracks()
	
	for index, track in pairs(steath_tracks) do
		if track and not stealth_tracks_locked[track] then
			music_types_menu[index] = {
				text = loc:text("menu_jukebox_screen_"..track),
				data = track,
				callback = callback(self, self, "display_suspenses")
			}
		end
	end
	
	music_types_menu[#music_types_menu + 1] = {
		text = nil
	}
	
	music_types_menu[#music_types_menu + 1] = {
		text = loc:text("jukeboxcontrol_cancel"),
		is_cancel_button = true,
		data = true,
		callback = callback(self, self, "set_enabled")
	}

	QuickMenu:new(loc:text("jukeboxcontrol_choose_forbidden_music"), "", music_types_menu, true)
end

function MusicJukeBoxControl:display_music_events_categories(music_types)
	local loc = managers.localization
	local music_types_menu = {}
	
	
	music_types_menu[#music_types_menu + 1] = {
		text = managers.localization:text("jukeboxcontrol_music_type_menu"),
		data = {list_type = "music_type_menu"},
		callback = callback(self, self, "clbk_choose_pd_type")			
	}
	
	music_types_menu[#music_types_menu + 1] = {
		text = managers.localization:text("jukeboxcontrol_music_type_heists"),
		data = {list_type = "music_type_heists"},
		callback = callback(self, self, "clbk_choose_pd_type")			
	}
	
	music_types_menu[#music_types_menu + 1]	= {
		text = managers.localization:text("jukeboxcontrol_category_forbidden_music"),
		data = "forbidden_music",
		callback = callback(self, self, "choose_forbidden_music"),
	}
	
	music_types_menu[#music_types_menu + 1] = {
		text = nil
	}
	
	music_types_menu[#music_types_menu + 1] = {
		text = loc:text("jukeboxcontrol_stop_all_music"),
		data = "stop_all_music",
		callback = callback(self, self, "post_event")
	}
	
	music_types_menu[#music_types_menu + 1] = {
		text = loc:text("jukeboxcontrol_music_uno_fade"),
		data = "music_uno_fade",
		callback = callback(self, self, "post_event")
	}
	
	music_types_menu[#music_types_menu + 1] = {
		text = loc:text("jukeboxcontrol_music_uno_fade_reset"),
		data = "music_uno_fade_reset",
		callback = callback(self, self, "post_event")
	}
	
	
	for index, name in pairs(music_types or {}) do
		music_types_menu[#music_types_menu + 1] = {
			text = loc:text("jukeboxcontrol_category_"..name),
			data = name,
			callback = callback(self, self, "show_music_events"),
		}
	end
	
	music_types_menu[#music_types_menu + 1] = {
		text = loc:text("jukeboxcontrol_category_stealth_events"),
		data = "none",
		callback = callback(self, self, "display_suspenses"),
	}
	
	music_types_menu[#music_types_menu + 1] = {
		text = nil
	}
	
	music_types_menu[#music_types_menu + 1] = {
		text = loc:text("jukeboxcontrol_cancel"),
		is_cancel_button = true,
		data = true,
		callback = callback(self, self, "set_enabled")
	}
	
	QuickMenu:new(loc:text("jukeboxcontrol_title"), "", music_types_menu, true)
end


function MusicJukeBoxControl:switch_music_types()

	self:set_enabled(false)
	local level_id = Global.level_data and Global.level_data.level_id
	local level_data = level_id and tweak_data.levels[level_id]
	local music_id = level_data and level_data.music or "default"
	local categories = {"default", "opening_safes"}
	if level_id == "arena" then
		table.insert(categories, "alesso")
		table.insert(categories, "alesso_muffled")
		table.insert(categories, "alesso_crowd")
	end
	
	self:display_music_events_categories(categories)
	
end


function MusicJukeBoxControl:switch_music_events()
end

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_JukeBoxControl", function( loc )
	loc:load_localization_file(MusicJukeBoxControl._path .. "loc/en.txt")
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_JukeBoxControl", function(menu_manager, nodes)	
	function MenuCallbackHandler.jukeboxcontrol_select_track(this, item)
		if MusicJukeBoxControl._enabled then
			MusicJukeBoxControl:switch_music_types()
		end
	end	
	
	MenuHelper:LoadFromJsonFile(MusicJukeBoxControl._path .. "Menu/menu.txt", MusicJukeBoxControl, MusicJukeBoxControl._data)
end)