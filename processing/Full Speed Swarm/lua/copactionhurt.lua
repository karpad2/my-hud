local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

function CopActionHurt:is_network_allowed(action_desc)
	if not CopActionHurt.network_allowed_hurt_types[action_desc.hurt_type] then
		return false
	end

	if action_desc.allow_network == false then
		return false
	end

	if self._unit:in_slot(managers.slot:get_mask('criminals')) then
		if not managers.groupai:state():is_enemy_converted_to_criminal(self._unit) then
			return false
		end
	end

	return true
end

if Network:is_server() then
	local incr = 0
	local math_randomseed = math.randomseed
	local math_random = math.random
	local math_floor = math.floor
	function CopActionHurt:_pseudorandom(a, b)
		local gpcht = managers.game_play_central._heist_timer
		local at = Application:time()
		local ht = gpcht and at - (gpcht.start_time or 0) + (gpcht.offset_time or 0) or 0

		local mult = 10
		local t = math_floor(ht * mult + 0.5) / mult
		local uid = self._unit:id()

		local seed = (uid ^ (t / 183.62) * 100) % 100000
		math_randomseed(seed)
		local ret = a and b and math_random(a, b) or a and math_random(a) or math_random()

		math_randomseed(incr + (at - math_floor(at)) * 100000000000000)
		incr = incr + 1

		return ret
	end
end
