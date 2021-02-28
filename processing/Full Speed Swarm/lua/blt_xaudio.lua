Hooks:Remove('Base_XAudio_MenuSetupUpdate')
Hooks:Remove('Base_XAudio_GameSetupUpdate')
Hooks:Remove('Base_XAudio_GameSetupPausedUpdate')

local function _update_music_volume()
	XAudio._base_gains.music = managers.user:get_setting('music_volume') / 100
end
local function _update_sfx_volume()
	XAudio._base_gains.sfx = managers.user:get_setting('sfx_volume') / 100
end
DelayedCalls:Add('DelayedFSS_update_volume', 0, function()
	managers.user:add_setting_changed_callback('music_volume', _update_music_volume)
	_update_music_volume()
	managers.user:add_setting_changed_callback('sfx_volume', _update_sfx_volume)
	_update_sfx_volume()
end)

local function update(t, dt, paused)
	for _, src in pairs(XAudio._sources) do
		src:update(t, dt, paused)
	end
end

Hooks:Add('MenuUpdate', 'Base_XAudio_MenuSetupUpdate', function(t, dt)
	update(t, dt, false)
end)

Hooks:Add('GameSetupUpdate', 'Base_XAudio_GameSetupUpdate', function(t, dt)
	update(t, dt, false)
end)

Hooks:Add('GameSetupPausedUpdate', 'Base_XAudio_GameSetupPausedUpdate', function(t, dt)
	update(t, dt, true)
end)
