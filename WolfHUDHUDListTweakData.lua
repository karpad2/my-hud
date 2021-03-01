WolfHUDHUDListTweakData = WolfHUDHUDListTweakData or class()
function WolfHUDHUDListTweakData:init()
	----------------------------------------------------------------------------------------------------------------------
	-- WolfHUDDmgPop Tweak Data																								--
	----------------------------------------------------------------------------------------------------------------------
	-- This file enables access to advanced settings, or those I cannot really implement into ingame menus easily.		--
	-- If you want to save those changes, please copy this file to "Payday 2/mods/saves" and edit that copy instead.	--
	-- You will need to take care of that version beeing up to date on your own. 										--
	-- It will not get changed on updates automatically.																--
	-- If you encounter problems, make sure the contents of this file matches the contents of your customized version.	--
	----------------------------------------------------------------------------------------------------------------------

	-- Determines which messages get logged
	self.LOG_MODE = { 
		error = true, 		-- log errors
		warning = true, 	-- log warnings
		info = false, 		-- log infos
		to_console = true 	-- show messages in console (Requires DebugConsole mod)
	}

	-- Color table
	-- 		Add or remove any color you want
	--		'color' needs to be that colors hexadecimal code
	-- 		'name' will be the name it appears in the selection menus
	self.color_table = {
		{ color = 'FFFFFF', name = "white" 			},
		{ color = 'F2F250', name = "light_yellow" 	},
		{ color = 'F2C24E', name = "light_orange" 	},
		{ color = 'E55858', name = "light_red" 		},
		{ color = 'CC55CC', name = "light_purple" 	},
		{ color = '00FF00', name = "light_green" 	},
		{ color = '00FFFF', name = "light_blue" 	},
		{ color = 'BABABA', name = "light_gray" 	},
		{ color = 'FFFF00', name = "yellow" 		},
		{ color = 'FFA500', name = "orange" 		},
		{ color = 'FF0000', name = "red" 			},
		{ color = '800080', name = "purple" 		},
		{ color = '008000', name = "green" 			},
		{ color = '0000FF', name = "blue" 			},
		{ color = '808080', name = "gray" 			},
		{ color = '000000', name = "black" 			},
		{ color = nil, name = "rainbow" 			},
	}

	self:post_init()
end

----------------------------------------- DONT EDIT BELOW THIS LINE!!! ----------------------------------------- DONT EDIT BELOW THIS LINE!!! ----------------------------------------- DONT EDIT BELOW THIS LINE!!! -----------------------------------------

function WolfHUDHUDListTweakData:post_init()
	for _, data in ipairs(self.color_table) do
		if data.name == "rainbow" then
			data.color_func = function(frequency)
				local r = Application:time() * 360 * (frequency or 1)
				local r, g, b = (1 + math.sin(r + 0)) / 2, (1 + math.sin(r + 120)) / 2, (1 + math.sin(r + 240)) / 2
				return Color(r, g, b)
			end
		end
	end
end