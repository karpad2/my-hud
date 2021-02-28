local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

if not Iter.settings.streamline_path then
	return
end

local mvec3_ang = mvector3.angle
local mvec3_len = mvector3.length
local mvec3_set = mvector3.set
local mvec3_sub = mvector3.subtract

local tmp_vec1 = Vector3()
local tmp_vec2 = Vector3()

local cur_pos

function CopBrain:search_for_coarse_path(search_id, to_seg, verify_clbk, access_neg)
	local to_pos
	local objective = self._logic_data.objective
	if objective then
		to_pos = objective.pos
		if not to_pos and alive(objective.follow_unit) then
			to_pos = objective.follow_unit:movement():nav_tracker():field_position()
		end
	end

	local params = {
		from_tracker = self._unit:movement():nav_tracker(),
		to_seg = to_seg,
		access = {'walk'},
		id = search_id,
		results_clbk = callback(self, self, 'clbk_coarse_pathing_results', search_id),
		verify_clbk = verify_clbk,
		access_pos = self._logic_data.char_tweak.access,
		access_neg = access_neg,
		to_pos = to_pos
	}
	self._logic_data.active_searches[search_id] = 2

	cur_pos = self._logic_data.m_pos

	managers.navigation:search_coarse(params)

	if cur_pos then
		local cs = managers.navigation._coarse_searches
		local cs_nr = #cs
		if cs_nr > 0 then
			cs[cs_nr].from_pos = cur_pos
		end
		cur_pos = nil
	end

	return true
end

local itr_original_copbrain_clbkcoarsepathingresults = CopBrain.clbk_coarse_pathing_results
function CopBrain:clbk_coarse_pathing_results(search_id, path)
	cur_pos = nil
	if path then
		local streamlined
		local data = self._logic_data
		local my_data = data.internal_data
		local objective = data.objective

		if path.has_navlinks then
			path.has_navlinks = nil
			my_data.itr_direct_to_pos = nil

		elseif objective and objective.pos and managers.groupai:state():whisper_mode() then
			my_data.itr_direct_to_pos = objective.pos

		elseif my_data.itr_direct_to_pos and #path > 2 then
			streamlined = true
			if not managers.navigation:itr_streamline(path, self._SO_access) then
				my_data.itr_direct_to_pos = nil
				path = false
			else
				local path_nr = #path
				path[1][2] = data.m_pos
				path[path_nr][2] = my_data.itr_direct_to_pos
				for i = 1, path_nr - 2 do
					local p1 = path[i][2]
					local p2 = path[i + 1][2]
					mvec3_set(tmp_vec1, p2)
					mvec3_sub(tmp_vec1, p1)
					local dis = mvec3_len(tmp_vec1)
					if dis > 500 then
						local p3 = path[i + 2][2]
						mvec3_set(tmp_vec2, p3)
						mvec3_sub(tmp_vec2, p2)
						if mvec3_ang(tmp_vec1, tmp_vec2) / dis > 0.09 then
							my_data.itr_direct_to_pos = nil
							break
						end
					end
				end
				path[1][2] = nil
				path[path_nr][2] = nil
			end
		end

		if not streamlined and not my_data.itr_direct_to_pos then
			path[1][2] = data.m_pos

			if objective and objective.follow_unit then
				path[#path][2] = objective.follow_unit:position()
			end

			path = managers.navigation:itr_streamline(path, self._SO_access)
		end
	end

	itr_original_copbrain_clbkcoarsepathingresults(self, search_id, path)
end

local itr_original_copbrain_clbkpathingresults = CopBrain.clbk_pathing_results
function CopBrain:clbk_pathing_results(search_id, path)
	itr_original_copbrain_clbkpathingresults(self, search_id, path)
	if path then
		local my_data = self._logic_data.internal_data
		if my_data.coarse_path then
			local walk_action = my_data.advancing
			if walk_action and walk_action:itr_append_next_step(path) then
				self._logic_data.pathing_results[search_id] = nil
				my_data.processing_advance_path = nil
				if my_data.coarse_path_index >= #my_data.coarse_path - 2 then
					if self._logic_data.objective then
						local end_rot = self._logic_data.objective.rot
						if end_rot then
							walk_action._end_rot = end_rot
						end
					end
				end
			end
		end
	end
end
