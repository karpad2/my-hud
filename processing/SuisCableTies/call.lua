function GroupAIStateBase:make_the_call()
	--if not Network:is_server() then
	--	return
	--end
	
	if call_already_made then
		return
	end

	local my_name = (managers.network and managers.network.account and managers.network.account:username()) or "Offline"
	--local message = my_name .. " called the police."

	managers.groupai:state():on_police_called()
	--managers.chat:send_message(ChatManager.GAME, managers.network.account:username() or "Offline", "[CALL THE POLICE] " .. tostring(message))
	if not call_already_made then call_already_made = true end
	
end
