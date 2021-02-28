local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

-- https://steamcommunity.com/app/218620/discussions/14/2245552086118378477/
function PlayerInventory:_do_feedback()
	local t = TimerManager:game():time()
	if not alive(self._unit) or not self._jammer_data or self._jammer_data.t - 0.1 < t then
		self:stop_feedback_effect()
		return
	end

	ECMJammerBase._detect_and_give_dmg(self._unit:position(), nil, self._unit, 2500)

	if self._jammer_data.t - 0.1 > t + self._jammer_data.interval then
		managers.enemy:add_delayed_clbk(self._jammer_data.feedback_callback_key, callback(self, self, '_do_feedback'), t + self._jammer_data.interval)
	else
		managers.enemy:add_delayed_clbk(self._jammer_data.feedback_callback_key, callback(self, self, 'stop_feedback_effect'), self._jammer_data.t)
	end
end
