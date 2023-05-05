RegisterServerEvent('DragNear')
AddEventHandler('DragNear', function(source)
	if ID == -1 or ID == '-1' then
		if source ~= '' then
			print('^1[#' .. source .. '] ' .. GetPlayerName(source) .. '  -  attempted to drag all players^7')
			DropPlayer(source, '\n[DeerInteractionMenu] Attempting to drag all players')
		else
			print('^1Someone attempted to drag all players^7')
		end

		return
	end
	
	if ID ~= false and ID ~= source then
		TriggerClientEvent('Drag', ID, source)
    end
end)