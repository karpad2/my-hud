local data = UpgradesTweakData._init_pd2_values
function UpgradesTweakData:_init_pd2_values()
	data(self, tweak_data)

	---STOIC---
	self.values.player.damage_control_passive = {{
		95,--DMG reduced in %.
		6 ---IDK, but 6.25 = 16 seconds DoT, 9 = 12 I think. XD
	}}
	self.values.player.damage_control_auto_shrug = {3}
	
	--self.values.player.escape_taser = {2}
	--self.values.player.extra_ammo_multiplier = {1.5}
	--self.values.player.ap_bullets = {true}
	--self.values.player.run_and_shoot = {true}
end
