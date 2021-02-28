local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

local REACT_COMBAT = AIAttentionObject.REACT_COMBAT
local REACT_SURPRISED = AIAttentionObject.REACT_SURPRISED

local fs_original_teamailogicidle_getpriorityattention = TeamAILogicIdle._get_priority_attention
function TeamAILogicIdle._get_priority_attention(data, attention_objects, reaction_func)
	if attention_objects ~= data.detected_attention_objects then
		return fs_original_teamailogicidle_getpriorityattention(self, data, attention_objects, reaction_func)
	end

	reaction_func = reaction_func or TeamAILogicBase._chk_reaction_to_attention_object
	local best_target, best_target_priority_slot, best_target_priority, best_target_reaction = nil

	local detected_obj_i = data.detected_attention_objects_i
	for i = detected_obj_i[0], 1, -1 do
		local attention_data = detected_obj_i[i]

		if not attention_data.identified then
			-- qued

		elseif attention_data.pause_expire_t then
			if attention_data.pause_expire_t < data.t then
				attention_data.pause_expire_t = nil
			end

		elseif attention_data.stare_expire_t and attention_data.stare_expire_t < data.t then
			local pause = attention_data.settings.pause
			if pause then
				attention_data.stare_expire_t = nil
				attention_data.pause_expire_t = data.t + math.lerp(pause[1], pause[2], math.random())
			end

		else
			local distance = attention_data.dis
			local reaction = reaction_func(data, attention_data, not CopLogicAttack._can_move(data))
			local reaction_too_mild = nil

			if not reaction or best_target_reaction and reaction < best_target_reaction then
				reaction_too_mild = true
			elseif distance < 150 and reaction <= REACT_SURPRISED then
				reaction_too_mild = true
			end

			if not reaction_too_mild then
				local alert_dt = attention_data.alert_t and data.t - attention_data.alert_t or 10000
				local dmg_dt = attention_data.dmg_t and data.t - attention_data.dmg_t or 10000
				local mark_dt = attention_data.mark_t and data.t - attention_data.mark_t or 10000

				if data.attention_obj and data.attention_obj.u_key == attention_data.u_key then
					alert_dt = alert_dt * 0.8
					dmg_dt = dmg_dt * 0.8
					mark_dt = mark_dt * 0.8
					distance = distance * 0.8
				end

				local has_alerted = alert_dt < 5
				local target_priority = distance
				local target_priority_slot = 0
				local is_shielded = attention_data.is_shield and TeamAILogicIdle._ignore_shield(data.unit, attention_data) or nil

				if attention_data.verified then
					local near_threshold = 800
					local near = distance < near_threshold
					local has_damaged = dmg_dt < 2
					local been_marked = mark_dt < 8
					local dangerous_special = attention_data.is_very_dangerous
					target_priority_slot = (dangerous_special or been_marked) and distance < 1600 and 1
						or near and (has_alerted and has_damaged or been_marked or attention_data.is_shield and not is_shielded) and 2
						or near and has_alerted and 3
						or has_alerted and 4
						or 5

					if is_shielded then
						target_priority_slot = math.min(5, target_priority_slot + 1)
					end
				else
					target_priority_slot = has_alerted and 6 or 7
				end

				if is_shielded then
					target_priority = target_priority * 10
				end

				if reaction < REACT_COMBAT then
					target_priority_slot = 10 + target_priority_slot + math.max(0, REACT_COMBAT - reaction)
				end

				if target_priority_slot ~= 0 then
					local best = false

					if not best_target then
						best = true
					elseif target_priority_slot < best_target_priority_slot then
						best = true
					elseif target_priority_slot == best_target_priority_slot and target_priority < best_target_priority then
						best = true
					end

					if best then
						best_target = attention_data
						best_target_priority_slot = target_priority_slot
						best_target_priority = target_priority
						best_target_reaction = reaction
					end
				end
			end
		end
	end

	return best_target, best_target_priority_slot, best_target_reaction
end
