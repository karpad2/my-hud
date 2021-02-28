Anticrash.cleaners = {}

Anticrash.cleaners.server_secure_loot = function()
	local secured = Global.loot_manager.secured
	for i = #secured, 1, -1 do
		local carry_id = secured[i].carry_id
		if carry_id == 'small_loot' or not tweak_data.carry[carry_id] and not tweak_data.carry.small_loot[carry_id] then
			table.remove(secured, i)
		end
	end
end

Anticrash.cleaners.sync_secure_loot = Anticrash.cleaners.server_secure_loot
