local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

local ac_original_huskplayermovement_animclbkspawndroppedmagazine = HuskPlayerMovement.anim_clbk_spawn_dropped_magazine
function HuskPlayerMovement:anim_clbk_spawn_dropped_magazine()
	local status = pcall(ac_original_huskplayermovement_animclbkspawndroppedmagazine, self)
	if not status then
		local peer = managers.network:session():peer_by_unit(self._unit)
		Anticrash:take_action_against_peer(peer, 'anim_clbk_spawn_dropped_magazine')
	end
end
