local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

local fs_original_carrydata_init = CarryData.init
function CarryData:init(unit)
	fs_original_carrydata_init(self, unit)
	if Network:is_client() or self._carry_id and not self:can_explode() then
		unit:set_extension_update_enabled(Idstring('carry_data'), false)
	end
end

local fs_original_carrydata_setpositionandthrow = CarryData.set_position_and_throw
function CarryData:set_position_and_throw(...)
	self._unit:set_extension_update_enabled(Idstring('carry_data'), true)
	self._unit:interaction():register_collision_callbacks()
	fs_original_carrydata_setpositionandthrow(self, ...)
end

function CarryData:_update_teleport(unit, t, dt)
	if self:is_teleporting() then
		self._unit:set_position(self._teleport)
		self._reset_dynamic_bodies = true
		self._teleport = nil
	end

	if self._reset_dynamic_bodies and self._dynamic_bodies then
		for i, body in ipairs(self._dynamic_bodies) do
			body:set_dynamic()
		end
		self._reset_dynamic_bodies = nil
		self._perform_push = true
	end

	if self._perform_push and self._teleport_push then
		self._unit:push(unpack(self._teleport_push))
		self._teleport_push = nil
		self._perform_push = nil
	end
end
