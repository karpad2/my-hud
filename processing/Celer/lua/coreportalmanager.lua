local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

if FullSpeedSwarm then
	return
end

core:module('CorePortalManager')

function PortalManager:render()
	for _, portal in ipairs(self._portal_shapes) do
		portal:update(TimerManager:wall():time(), TimerManager:wall():delta_time())
	end

	for _, group in pairs(self._unit_groups) do
		group:update(TimerManager:wall():time(), TimerManager:wall():delta_time())
	end

	for _ = 1, 5 do
		local unit_id, unit = next(self._hide_list)
		if alive(unit) then
			unit:set_visible(false)
			self._hide_list[unit_id] = nil
		end
	end

	while table.remove(self._check_positions) do
	end
end
