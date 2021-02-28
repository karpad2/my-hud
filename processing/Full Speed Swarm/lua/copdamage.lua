local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

local cops_to_intimidate = {}
FullSpeedSwarm.cops_to_intimidate = cops_to_intimidate

local fs_original_copdamage_damagemelee = CopDamage.damage_melee
function CopDamage:damage_melee(attack_data, ...)
	if attack_data.variant == 'taser_tased' then
		if self._char_tweak.surrender and self._char_tweak.surrender ~= tweak_data.character.presets.special then
			cops_to_intimidate[self._unit:key()] = TimerManager:game():time()
		end
	end
	return fs_original_copdamage_damagemelee(self, attack_data, ...)
end

local fs_original_copdamage_syncdamagemelee = CopDamage.sync_damage_melee
function CopDamage:sync_damage_melee(variant, ...)
	if variant == 5 then
		if self._char_tweak.surrender and self._char_tweak.surrender ~= tweak_data.character.presets.special then
			cops_to_intimidate[self._unit:key()] = TimerManager:game():time()
		end
	end
	return fs_original_copdamage_syncdamagemelee(self, variant, ...)
end

if Network:is_server() then
	local fs_original_copdamage_die = CopDamage.die
	function CopDamage:die(attack_data)
		fs_original_copdamage_die(self, attack_data)

		local attacker_unit = attack_data.attacker_unit
		if alive(attacker_unit) and attacker_unit:in_slot(managers.slot:get_mask('criminals_no_deployables')) then
			self._unit:unit_data().fs_attacker_pos = attacker_unit:position()
		end
	end
end
