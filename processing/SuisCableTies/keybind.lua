--Wait until in-game to run.
if managers.platform:presence() ~= "Playing" then
	return
end

GroupAIStateBase:make_the_call()