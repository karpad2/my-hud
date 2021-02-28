local _MusicManager_post_event = MusicManager.post_event
function MusicManager:post_event(event, ...)
	if MusicJukeBoxControl and MusicJukeBoxControl.music_event_categories then
		local specific_heist_tracks = MusicJukeBoxControl.music_event_categories.forbidden_music
		if table.contains(specific_heist_tracks, event) then
			MusicJukeBoxControl._current_forbidden_track = event
		end
		
		if MusicJukeBoxControl._debug then
			log("[MusicManager:post_event]: "..tostring(event))
		end
		
		if event then
			if event == "alesso_music_play" then
				MusicJukeBoxControl._alesso_playing = true
			elseif event == "alesso_music_cut" then
				MusicJukeBoxControl._alesso_playing = false
			elseif event:find("alesso_music_") then
				MusicJukeBoxControl._alesso_playing = true
			elseif not event:find("crowd_") and not event:find("alesso_muffle_") then
				MusicJukeBoxControl._alesso_playing = false
			end
		end
	end
	_MusicManager_post_event(self, event, ...)
end