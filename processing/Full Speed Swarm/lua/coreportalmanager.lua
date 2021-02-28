local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

core:module('CorePortalManager')

local table_remove = table.remove

function PortalUnitGroup:inside(pos)
	local shapes = self._shapes
	for i = #shapes, 1, -1 do
		if shapes[i]:is_inside(pos) then
			return true
		end
	end
	return false
end

function PortalUnitGroup:update(t, dt)
	local is_inside = false

	local positions = managers.portal:check_positions()
	for i = #positions, 1, -1 do
		is_inside = self:inside(positions[i])
		if is_inside then
			break
		end
	end

	if self._is_inside ~= is_inside then
		self._is_inside = is_inside
		local diff = self._is_inside and 1 or -1
		self:_change_units_visibility(diff)
	end
end

for _, fname in pairs({'init', 'clear', 'clear_unit_groups'}) do
	local f = PortalManager[fname]
	PortalManager[fname] = function(self, ...)
		self.fs_unit_groups = {}
		return f(self, ...)
	end
end

local fs_original_portalmanager_addunitgroup = PortalManager.add_unit_group
function PortalManager:add_unit_group(...)
	local group = fs_original_portalmanager_addunitgroup(self, ...)
	table.insert(self.fs_unit_groups, group)
	return group
end

local fs_original_portalmanager_removeunitgroup = PortalManager.remove_unit_group
function PortalManager:remove_unit_group(name)
	fs_original_portalmanager_removeunitgroup(self, name)

	local unit_groups = self.fs_unit_groups
	for i = #unit_groups, 1, -1 do
		if unit_groups[i]._name == name then
			table.remove(unit_groups, i)
			break
		end
	end
end

function PortalManager:render()
	local tw = TimerManager:wall()
	local t = tw:time()
	local dt =  tw:delta_time()

	local portal_shapes = self._portal_shapes
	for i = #portal_shapes, 1, -1 do
		portal_shapes[i]:update(t, dt)
	end

	local unit_groups = self.fs_unit_groups
	for i = #unit_groups, 1, -1 do
		unit_groups[i]:update(t, dt)
	end

	for _ = 1, 5 do
		local unit_id, unit = next(self._hide_list)
		if alive(unit) then
			unit:set_visible(false)
			self._hide_list[unit_id] = nil
		else
			break
		end
	end

	while table_remove(self._check_positions) do
	end
end

function PortalUnitGroup:_change_visibility(unit, diff)
	if alive(unit) then
		local unit_data = unit:unit_data()
		if type(unit_data) == 'table' then
			local vc = unit_data._visibility_counter
			if vc then
				vc = vc + diff
			else
				vc = diff > 0 and 1 or 0
			end
			unit_data._visibility_counter = vc

			if vc > 0 then
				unit:set_visible(true)
				managers.portal:remove_from_hide_list(unit)
			else
				managers.portal:add_to_hide_list(unit)
			end
		end
	end
end
