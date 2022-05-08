# Install Sound On InteractSound/Client/Sounds And Place File Sound/soundban.ogg

# For Active OpenInventory Command You Need Set On Your Server.cfg This 2 String #

add_ace group.superadmin inventory.openinventory allow
add_ace group.admin inventory.openinventory allow

# Set This On Your Inventory For Command To Work #

RegisterCommand("openinventory", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "inventory.openinventory") then
		local target = tonumber(args[1])
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if targetXPlayer ~= nil then
			TriggerClientEvent("esx_inventoryhud:openPlayerInventory", source, target, targetXPlayer.name)
		else
			TriggerClientEvent("chatMessage", source, "^1" .. _U("no_player"))
		end
	else
		TriggerClientEvent("chatMessage", source, "^1" .. _U("no_permissions"))
	end
end)