Hooks:PostHook( GuiTweakData , "init" , "cheesewallrandomname" , function( self , params )
	self.crime_net.job_vars = {
		max_active_jobs = 30, --was 10
		active_job_time = 25,
		new_job_min_time = 0.01, --was 1,5
		new_job_max_time = 0.02,
		refresh_servers_time = SystemInfo:platform() == Idstring("PS4") and 10 or 5,
		total_active_jobs = 40,
		max_active_server_jobs = 100
	}
	end)