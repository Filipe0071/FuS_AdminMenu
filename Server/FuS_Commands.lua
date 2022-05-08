if FuS_Config.Legacy then
    ESX = exports['es_extended']:getSharedObject()
else
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

-- Check Player For Health And Armor -- 
RegisterCommand('Fusion_Check', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        local playerId = args[1]
        local nomegiocatore = GetPlayerName(playerId)
        local check = 'Name: '..nomegiocatore.. '\nHealth: '..GetEntityHealth(GetPlayerPed(playerId))..'/'..GetEntityMaxHealth(GetPlayerPed(playerId))..'\nArmour:'..GetPedArmour(GetPlayerPed(playerId))..'/'..GetPlayerMaxArmour(playerId)
        TriggerClientEvent('zg-notify:TriggerNotification', source, ""..check.."", FuS_Config.TimeNotify, 'info')
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
    end
end)

-- Bring Player With Menu --
RegisterCommand('bring', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
        local playerId = args[1]
        local coords = GetEntityCoords(GetPlayerPed(source))
        SetEntityCoords(GetPlayerPed(playerId), coords.x + 1.2, coords.y + 1.2, coords.z)
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
	end
end)

-- Goto Player With Menu -- 
RegisterCommand('goto', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
        local playerId = args[1]
        local coords = GetEntityCoords(GetPlayerPed(playerId))
        SetEntityCoords(GetPlayerPed(source), coords.x + 1.2, coords.y + 1.2, coords.z)
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
	end
end)

-- Mute Player -- 
RegisterCommand('muta', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
        local playerId = args[1] 
        TriggerClientEvent("FuS_AdminMenu:MutePlayer", playerId)
    
        TriggerClientEvent("zg-notify:TriggerNotification", source, ""..FuS_Lang["MutesSection_MutedPlayer"].." "..playerId.."", FuS_Config.TimeNotify, "success")
        TriggerClientEvent("zg-notify:TriggerNotification", playerId, ""..FuS_Lang["MutesSection_UHasMuted"].."", FuS_Config.TimeNotify, "info")
    else
        TriggerClientEvent('FuS_Notify:Fusion_Alert', source, FuS_Lang["NameServer"], FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
	end
end)

-- Smute Player -- 
RegisterCommand('smuta', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
        local playerId = args[1]
        TriggerClientEvent("FuS_AdminMenu:UnmutePlayer", playerId)
    
        TriggerClientEvent("zg-notify:TriggerNotification", source, ""..FuS_Lang["MutesSection_UnmutedPlayer"].." "..playerId.."", FuS_Config.TimeNotify, "success")
        TriggerClientEvent("zg-notify:TriggerNotification", playerId, ""..FuS_Lang["MutesSection_UHasUnmuted"].."", FuS_Config.TimeNotify, "info")
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
	end
end)

-- Heal Command -- 
RegisterCommand('heal', function(source, args, ID)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
        TriggerClientEvent("FuS_AdminMenu:HealPlayer", args[1])

        TriggerClientEvent('zg-notify:TriggerNotification', source, ""..FuS_Lang["ReviverSection_HealedName"].." "..GetPlayerName(args[1]).."", FuS_Config.TimeNotify, 'info')
        TriggerClientEvent('zg-notify:TriggerNotification', ID, ""..FuS_Lang["ReviverSection_HealedName"].." "..GetPlayerName(args[1]).."", FuS_Config.TimeNotify, 'info')
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
	end
end)

-- Revive Command -- 
RegisterCommand('rianima', function(source, args, ID)
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        TriggerClientEvent(FuS_Config.Triggers.TriggerRevive, tonumber(args[1]))

        TriggerClientEvent('zg-notify:TriggerNotification', source, ""..FuS_Lang["ReviverSection_RevivedName"].." "..GetPlayerName(args[1]).."", FuS_Config.TimeNotify, 'info')
        TriggerClientEvent('zg-notify:TriggerNotification', source, ""..FuS_Lang["ReviverSection_RevivedName"].." "..GetPlayerName(args[1]).."", FuS_Config.TimeNotify, 'info')
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
    end
end)

-- Revive All Command -- 
RegisterCommand('rianimatutti', function(source, args, ID)
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        if src ~= 0 then
            for a, f in pairs(GetPlayers()) do 
                local xPlayer = ESX.GetPlayerFromId(f)
                if xPlayer then
                    TriggerClientEvent(FuS_Config.Triggers.TriggerRevive, f)
                end
                Citizen.Wait(250)
            end

            TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["ReviverSection_YouRevivedAllServer"], FuS_Config.TimeNotify, 'success')
        end
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
    end
end)

-- Bring All Player -- 
RegisterCommand('bringatutti', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        local coords = GetEntityCoords(GetPlayerPed(source))
        for _, playerId in ipairs(GetPlayers()) do 
            SetEntityCoords(GetPlayerPed(playerId), coords.x + 1, coords.y + 1, coords.z) 
        end
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["AllPlayerSection_UHaveBringedAllServer"], FuS_Config.TimeNotify, 'success')
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
    end
end)

-- Kick All Player -- 
RegisterCommand('kickatutti', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
        for _, playerId in ipairs(GetPlayers()) do 
            DropPlayer(playerId, ' '..FuS_Lang["AllPlayerSection_MexToKick"]..'')
        end
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
    end
end)

-- No Clip V2 -- 
RegisterCommand('noclipv2', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        TriggerClientEvent("FuS_AdminMenu:NoClipV2", source) 
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
    end
end)

-- Spect Player -- 
RegisterCommand('spect', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
        if GetPlayerName(args[1]) then
            local playerId = args[1]
            local playerName = GetPlayerName(args[1]) 
            local coords = GetEntityCoords(GetPlayerPed(playerId))
            if coords.x ~= 0 and coords.y ~= 0 and coords.z ~= 0 then
                local playerId = args[1]
                TriggerClientEvent("FuS_AdminMenu:SpectatorMode", source, coords, playerId)
            end
        end
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
	end
end)

-- Screenshot Player -- 
RegisterCommand('screen', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
        local ID = tonumber(args[1])
        TriggerEvent("FuS_AdminMenu:GetIdentifiers", source, ID)
        TriggerClientEvent("FuS_AdminMenu:TakeScreen",ID)
    
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["CheckDiscordForScreenshot"], FuS_Config.TimeNotify, 'success')
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["CheckDiscordForScreenshot"], FuS_Config.TimeNotify, 'success')
	end
end)

-- Freeze Player -- 
local frozen = {}
RegisterCommand('freeze', function(source, args)
    if args[1] then
        if(tonumber(args[1]) and GetPlayerName(tonumber(args[1]))) then
            local player = tonumber(args[1])

            local xPlayer = ESX.GetPlayerFromId(source)
            local GruppoPlayer = xPlayer.getGroup()

            if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
                if (frozen[player]) then
                    frozen[player] = false 
                else
                    frozen[player] = true 
                end

                TriggerClientEvent("FuS_AdminMenu:FreezePlayer", player, frozen[player])

                local state = "unfreeze" 

                if (frozen[player]) then
                    state = "freeze"
                end
            
                TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["FusionFreeze_UHaveFreezed"].." "..state.." "..FuS_Lang["FusionFreeze_UHaveFreezedPlayer"].." "..GetPlayerName(player), FuS_Config.TimeNotify, 'info')
                TriggerClientEvent('zg-notify:TriggerNotification', player, FuS_Lang["FusionFreeze_UHasFreezed"].." "..state.." "..FuS_Lang["FusionFreeze_UHasFreezedFrom"].." "..GetPlayerName(source), FuS_Config.TimeNotify, 'info')
            else
                TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
            end
        end
    end
end)

-- Kill PLayer -- 
RegisterCommand('kill', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        TriggerClientEvent("FuS_AdminMenu:KillPlayer", args[1])
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'error')
    end
end)

-- Tag Staff -- 
local IdAttivi = {}
RegisterCommand(FuS_Config.Commands.Tag, function(source, args)
    if not IdAttivi[source] then
        IdAttivi[source] = false 
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        IdAttivi[source] = not IdAttivi[source]
        TriggerClientEvent("FuS_AdminMenu:UpdateId", -1, IdAttivi)
    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, FuS_Lang["NoPermission"], FuS_Config.TimeNotify, 'success')
    end
end)

ESX.RegisterServerCallback('FuS_AdminMenu:TabellaID', function(source, cb)
    cb(IdAttivi)
end)

-- Wipe Player -- 
RegisterServerEvent("FuS_AdminMenu:WipePlayer")
AddEventHandler("FuS_AdminMenu:WipePlayer", function(ID)
    local xPlayer = ESX.GetPlayerFromId(source)
    local GruppoPlayer = xPlayer.getGroup()
    local staffer = ESX.GetPlayerFromId(source)

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
        local xPlayer = ESX.GetPlayerFromId(ID)
        print(xPlayer.identifier.." "..FuS_Lang["PrintSection_PlayerWiped"].."")
        DropPlayer(ID, " "..FuS_Lang["UAreWiped"].."")
    
        TriggerClientEvent('zg-notify:TriggerNotification', source, ""..FuS_Lang["WipedAPlayer"].." "..ID.."", FuS_Config.TimeNotify, 'success')
    
        MySQL.Async.execute('DELETE FROM addon_account_data WHERE owner = @identifier', {
            ['@owner'] = xPlayer.identifier
        })
    
        MySQL.Async.execute('DELETE FROM characters WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
    
        MySQL.Async.execute('DELETE FROM datastore_data WHERE owner = @identifier', {
            ['@owner'] = xPlayer.identifier
        })
    
        MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner = @identifier', {
            ['@owner'] = xPlayer.identifier
        })
    
        MySQL.Async.execute('DELETE FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
    
        MySQL.Async.execute('DELETE FROM user_accounts WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
    
        MySQL.Async.execute('DELETE FROM user_inventory WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
    
        MySQL.Async.execute('DELETE FROM user_licenses WHERE owner = @identifier', {
            ['@owner'] = xPlayer.identifier
        })

        if FuS_W.WipePlayer == nil or FuS_W.WipePlayer == '' then
        else
            local LogOnDS = {
                {
                    ["color"] = 16711680,
                    ["title"] = "FuS_AdminMenu - New Wipe Registered",
                    ["description"] = "``Player Steam Hex:`` "..xPlayer.identifier.." \n ``ServerID:`` "..ID.."\n ``Details:`` "..FuS_Lang["PrintSection_PlayerWiped"].." \n ``SteamID:`` "..xPlayer.identifier.."\n ``Staffer Hex:`` "..staffer.identifier.."\n ``Staffer Name: `` "..staffer.name.."\n\n",
                    ["footer"] = {
                        ["icon_url"] = "https://imgur.com/75RMHFz.png",
                        ["text"] = "FuS_AdminMenu - Developed By Fusion Development",
                    },
                    ["image"] = {
                        ['url'] = "https://imgur.com/75RMHFz.png",
                    },
                }
            }
            PerformHttpRequest(FuS_W.WipePlayer, function(err, text, headers) end, 'POST', json.encode({username = "Fusion Development - FuS_AdminMenu", embeds = LogOnDS}), { ['Content-Type'] = 'application/json'})
        end

    else
        TriggerClientEvent('zg-notify:TriggerNotification', source, ""..FuS_Lang["WipedAPlayer"].." "..ID.."", FuS_Config.TimeNotify, 'success')
	end
end)