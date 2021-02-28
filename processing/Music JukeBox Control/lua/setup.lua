if SoundSource and not MusicSettupJukeBox then

	local music_sources = {}

	local MusicSoundSource = SoundSource
	if MusicSoundSource and type(MusicSoundSource) == "userdata" then
		MusicSoundSource = getmetatable(MusicSoundSource)
	end



	if MusicSoundSource then
	
		local _create_source = MusicSoundSource.create_source		
		function MusicSoundSource:create_source(source_name, ...)
			local source_created = _create_source(self, source_name, ...)
			if source_name == "music" then
				table.insert(music_sources, self)
			end
			return source_created
		end		
		
	end
	
	
	
	MusicSettupJukeBox = true
end