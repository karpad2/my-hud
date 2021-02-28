local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

_G.FullSpeedSwarm = _G.FullSpeedSwarm or {}
FullSpeedSwarm._path = ModPath
FullSpeedSwarm._data_path = SavePath .. 'full_speed_swarm.txt'
FullSpeedSwarm.in_arrest_logic = {}
FullSpeedSwarm.units_per_navseg = {}
FullSpeedSwarm.call_on_loud = {}
FullSpeedSwarm.custom_mutators = {}
FullSpeedSwarm.final_settings = {}
FullSpeedSwarm.settings_not_saved = {
	'real_elastic',
	'stealthroids'
}
FullSpeedSwarm.settings = {
	task_throughput = 600,
	walking_quality = 1,
	lod_updater = 1,
	optimized_inputs = true,
	fastpaced = false,
	iter_chase = false,
	nervous_game = false,
	improved_tactics = true,
	cop_awareness = false,
	spawn_delay = true,
	slower_but_safer = false, -- to be enabled in mods/saves/full_speed_swarm.txt
	real_elastic = false,
	stealthroids = false,
	tie_stamina_to_lives = false
}

function FullSpeedSwarm:UpdateWalkingQuality()
	CopBase.fs_lod_stage = CopBase['fs_lod_stage_' .. self.settings.walking_quality]
end

local streamlined
function FullSpeedSwarm:GetGameplayOptionsForcedValues()
	local result = {}

	if streamlined == nil then
		streamlined = _G.Iter and _G.Iter.settings.streamline_path or streamlined or false
	end
	if not streamlined then
		result.iter_chase = false
		result.improved_tactics = false
	end

	if self.settings.real_elastic then
		result.cop_awareness = true
		result.improved_tactics = true
		result.fastpaced = true
		result.iter_chase = true
		result.nervous_game = true
		result.tie_stamina_to_lives = true
	end

	if self.settings.stealthroids then
		result.iter_chase = true
	end

	return result
end

function FullSpeedSwarm:CalcMaxTaskThroughput()
	local gstate = managers and managers.groupai and managers.groupai:state()
	if not gstate or not gstate._tweak_data then
		return 600
	end

	local force = gstate:_get_difficulty_dependent_value(gstate._tweak_data.assault.force)
	local force_balance_mul = gstate._tweak_data.assault.force_balance_mul[4]
	return math.ceil(force * force_balance_mul) * 7
end

function FullSpeedSwarm:UpdateMaxTaskThroughput()
	local new_value = self.settings.task_throughput
	if new_value < math.floor(1 / tweak_data.group_ai.ai_tick_rate) then
		new_value = self:CalcMaxTaskThroughput()
	end
	if type(FullSpeedSwarm.UpdateMaxTaskThroughputLocally) == 'function' then
		FullSpeedSwarm:UpdateMaxTaskThroughputLocally(new_value)
	end
end

function FullSpeedSwarm:FinalizeSettings()
	for k in pairs(self.final_settings) do
		self.final_settings[k] = nil
	end

	for k, v in pairs(self.settings) do
		self.final_settings[k] = v
	end

	for k, v in pairs(self:GetGameplayOptionsForcedValues()) do
		self.final_settings[k] = v
	end
end

function FullSpeedSwarm:Load()
	local file = io.open(self._data_path, 'r')
	if file then
		for k, v in pairs(json.decode(file:read('*all')) or {}) do
			self.settings[k] = v
		end
		file:close()
	end

	for _, v in pairs(self.settings_not_saved) do
		self.settings[v] = nil
	end

	self:FinalizeSettings()
end

function FullSpeedSwarm:Save()
	local settings = clone(self.settings)

	for _, v in pairs(self.settings_not_saved) do
		settings[v] = nil
	end

	local file = io.open(self._data_path, 'w+')
	if file then
		file:write(json.encode(settings))
		file:close()
	end
end

FullSpeedSwarm:Load()

function FullSpeedSwarm.metaize_i(tbl)
	local _i = { [0] = 0 }
	local mt = {
		__newindex = function (t, k, v)
			_i[0] = _i[0] + 1
			_i[_i[0]] = v
			rawset(t, k, v)
		end
	}
	setmetatable(tbl, mt)
	return _i
end

core:module('CoreCode')

if _G.FullSpeedSwarm.settings.slower_but_safer then
	function alive(obj)
		local tp = type(obj)
		if tp == 'userdata' or tp == 'table' and type(obj.alive) == 'function' then
			return obj:alive()
		end
		return false
	end
else
	function alive(obj)
		return obj and obj:alive()
	end
end
