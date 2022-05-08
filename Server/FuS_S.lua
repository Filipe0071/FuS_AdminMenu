if FuS_Config.Legacy then
    ESX = exports['es_extended']:getSharedObject()
else
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

-- Announce On Screen --
msg = ""
RegisterCommand('FuS_Announce', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gruppo = xPlayer.getGroup()

    if Gruppo ~= nil and (Gruppo == "superadmin" or Gruppo == "admin" or Gruppo == "mod" or Gruppo == "helper") then 
        for i,v in pairs(args) do 
            msg = msg .. " " .. v 
        end
        TriggerClientEvent('FuS_AdminMenu:AnnounceOnScreen', -1, msg)

        local PlayerName = GetPlayerName(source)
        local steam = FuS_Lang["BanSection_IdentifierNotAvaible"]
        local discord = FuS_Lang["BanSection_IdentifierNotAvaible"]
        local license = FuS_Lang["BanSection_IdentifierNotAvaible"] 
        local live = FuS_Lang["BanSection_IdentifierNotAvaible"] 
        local xbl = FuS_Lang["BanSection_IdentifierNotAvaible"]
        local ip = FuS_Lang["BanSection_IdentifierNotAvaible"]

        for m,n in ipairs(GetPlayerIdentifiers(source)) do 

            if n:match("steam") then 
                steam = n 

            elseif n:match("discord") then
                discord = n:gsub("discord:","")

            elseif n:match("license") then 
                license = n

            elseif n:match("live") then
                live = n

            elseif n:match("xbl") then 
                xbl = n 

            elseif n:match("ip") then
                ip = n:gsub("ip:","")
            end
        end

        if FuS_W.AnnounceWebhook == nil or FuS_W.AnnounceWebhook == '' then
        else
            local LogOnDS = {
                {
                    ["color"] = 16711680,
                    ["title"] = "FuS_AdminMenu - New Announce Registered",
                    ["description"] = "``Player:`` "..PlayerName.." \n ``ServerID:`` "..source.."\n ``Details:`` \n ``SteamID:`` "..steam.." \n ``Discord:`` <@"..discord..">".." \n ``Rockstar License:`` "..license.." \n ``Live Id:`` "..live.." \n ``Xbox Id:`` "..xbl.." \n ``Ip:`` "..ip.."\n\n **As Write Announce:** "..msg,
                    ["footer"] = {
                        ["icon_url"] = "https://imgur.com/75RMHFz.png",
                        ["text"] = "FuS_AdminMenu - Developed By Fusion Development",
                    },
                    ["image"] = {
                        ['url'] = "https://imgur.com/75RMHFz.png",
                    },
                }
            }
            PerformHttpRequest(FuS_W.AnnounceWebhook, function(err, text, headers) end, 'POST', json.encode({username = "Fusion Development - FuS_AdminMenu", embeds = LogOnDS}), { ['Content-Type'] = 'application/json'})
        end

    end
end)

-- Announce Up Minimap --
RegisterServerEvent("FuS_AdminMenu:AnnuncioSopraMinimappa")
AddEventHandler("FuS_AdminMenu:AnnuncioSopraMinimappa", function(mex)
    local _source = source 
    local xPlayers = ESX.GetPlayers()
    local xPlayer = ESX.GetPlayerFromId(_source)
    local GruppoPlayer = xPlayer.getGroup()
    local name = GetPlayerName(_source)
    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        for i = 1, #xPlayers, 1 do 
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], FuS_Lang["NameServer"], '~s~~w~(~y~'..FuS_Lang["AnnounceSection_SubtitleAnnounce"]..'~w~)', mex, 'CHAR_DAVE', 0)

            local steam = FuS_Lang["BanSection_IdentifierNotAvaible"]
            local discord = FuS_Lang["BanSection_IdentifierNotAvaible"]
            local license = FuS_Lang["BanSection_IdentifierNotAvaible"] 
            local live = FuS_Lang["BanSection_IdentifierNotAvaible"] 
            local xbl = FuS_Lang["BanSection_IdentifierNotAvaible"]
            local ip = FuS_Lang["BanSection_IdentifierNotAvaible"]
    
            for m,n in ipairs(GetPlayerIdentifiers(_source)) do 
    
                if n:match("steam") then 
                    steam = n 
    
                elseif n:match("discord") then
                    discord = n:gsub("discord:","")
    
                elseif n:match("license") then 
                    license = n
    
                elseif n:match("live") then
                    live = n
    
                elseif n:match("xbl") then 
                    xbl = n 
    
                elseif n:match("ip") then
                    ip = n:gsub("ip:","")
                end
            end

            if FuS_W.AnnounceWebhook == nil or FuS_W.AnnounceWebhook == '' then
            else

                local LogOnDS = {
                    {
                        ["color"] = 16711680,
                        ["title"] = "FuS_AdminMenu - New Announce Registered",
                        ["description"] = "``Player:`` "..name.." \n ``ServerID:`` ".._source.."\n ``Details:`` \n ``SteamID:`` "..steam.." \n ``Discord:`` <@"..discord..">".." \n ``Rockstar License:`` "..license.." \n ``Live Id:`` "..live.." \n ``Xbox Id:`` "..xbl.." \n ``Ip:`` "..ip.."\n\n **As Write Announce Up Minimap:** "..mex,
                        ["footer"] = {
                            ["icon_url"] = "https://imgur.com/75RMHFz.png",
                            ["text"] = "FuS_AdminMenu - Developed By Fusion Development",
                        },
                        ["image"] = {
                            ['url'] = "https://imgur.com/75RMHFz.png",
                        },
                    }
                }
                PerformHttpRequest(FuS_W.AnnounceWebhook, function(err, text, headers) end, 'POST', json.encode({username = "Fusion Development - FuS_AdminMenu", embeds = LogOnDS}), { ['Content-Type'] = 'application/json'})
            end
        end
    end
end)

-- Announce Up Minimap - Event Announce --
RegisterServerEvent("FuS_AdminMenu:AnnuncioSopraMinimappaEvento")
AddEventHandler("FuS_AdminMenu:AnnuncioSopraMinimappaEvento", function(messaggioevento)
    local _source = source 
    local xPlayers = ESX.GetPlayers()
    local xPlayer = ESX.GetPlayerFromId(_source)
    local GruppoPlayer = xPlayer.getGroup()
    local name = GetPlayerName(_source)
    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        for i=1, #xPlayers, 1 do 
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i]) 
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], FuS_Lang["NameServer"], '~s~~w~(~r~'..FuS_Lang["AnnounceSection_SubtitleEvent"]..'~w~)', messaggioevento, 'CHAR_DAVE', 0)

            local steam = FuS_Lang["BanSection_IdentifierNotAvaible"]
            local discord = FuS_Lang["BanSection_IdentifierNotAvaible"]
            local license = FuS_Lang["BanSection_IdentifierNotAvaible"] 
            local live = FuS_Lang["BanSection_IdentifierNotAvaible"] 
            local xbl = FuS_Lang["BanSection_IdentifierNotAvaible"]
            local ip = FuS_Lang["BanSection_IdentifierNotAvaible"]
    
            for m,n in ipairs(GetPlayerIdentifiers(_source)) do 
    
                if n:match("steam") then 
                    steam = n 
    
                elseif n:match("discord") then
                    discord = n:gsub("discord:","")
    
                elseif n:match("license") then 
                    license = n
    
                elseif n:match("live") then
                    live = n
    
                elseif n:match("xbl") then 
                    xbl = n 
    
                elseif n:match("ip") then
                    ip = n:gsub("ip:","")
                end
            end

            if FuS_W.AnnounceWebhook == nil or FuS_W.AnnounceWebhook == '' then
            else

                local LogOnDS = {
                    {
                        ["color"] = 16711680,
                        ["title"] = "FuS_AdminMenu - New Announce Registered",
                        ["description"] = "``Player:`` "..name.." \n ``ServerID:`` ".._source.."\n ``Details:`` \n ``SteamID:`` "..steam.." \n ``Discord:`` <@"..discord..">".." \n ``Rockstar License:`` "..license.." \n ``Live Id:`` "..live.." \n ``Xbox Id:`` "..xbl.." \n ``Ip:`` "..ip.."\n\n **As Write Announce Event:** "..messaggioevento,
                        ["footer"] = {
                            ["icon_url"] = "https://imgur.com/75RMHFz.png",
                            ["text"] = "FuS_AdminMenu - Developed By Fusion Development",
                        },
                        ["image"] = {
                            ['url'] = "https://imgur.com/75RMHFz.png",
                        },
                    }
                }
                PerformHttpRequest(FuS_W.AnnounceWebhook, function(err, text, headers) end, 'POST', json.encode({username = "Fusion Development - FuS_AdminMenu", embeds = LogOnDS}), { ['Content-Type'] = 'application/json'})
            end
        end 
    end
end)