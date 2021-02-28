local old_init = WeaponTweakData.init

function WeaponTweakData:init(tweak_data)
    old_init(self, tweak_data)
	
self.ecp.stats.concealment = 8
self.ecp.stats.damage = 2400
self.ecp.fire_mode_data.fire_rate = 0.6
self.ecp.stats.spread = 17
self.ecp.stats.recoil = 8
self.basset.fire_mode_data.fire_rate = 0.35
self.basset.stats.damage = 60
self.basset.stats.concealment = 25
end
