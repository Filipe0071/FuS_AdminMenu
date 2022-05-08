if FuS_Config.Legacy then
    ESX = exports['es_extended']:getSharedObject()
else
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

-- Callback Check Group Player --
ESX.RegisterServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then 
        local GruppoPlayer = xPlayer.getGroup()
        if GruppoPlayer ~= nil then 
            cb(GruppoPlayer)
        else
            cb(nil)
        end 
    else
        cb(nil)
    end
end)

-- Check Player If Banned From Json File --
local BanTokens = true 
AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local _src = source 
    local File = LoadResourceFile(GetCurrentResourceName(), "Fusion_Bans.json")
    local Bannato = false 
    local identifier = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local license = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local liveid = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local xblid = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local discord = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local playerip = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local playerName = GetPlayerName(source)
    if File ~= nil then 
        local Table = json.decode(File)
        if type(Table) == "table" then 
            local Playertokens = {}
            if BanTokens then
                for i = 1, GetNumPlayerTokens(_src) do 
                    table.insert(Playertokens, GetPlayerToken(_src, i)) 
                    if Bannato then 
                        break 
                    end
                end
            end

            for a, Ide in pairs(GetPlayerIdentifiers(_src)) do 
                for b, BanTable in ipairs(Table) do 
                    if type(BanTable.identifier) == "table" then 
                        for c, IdeBanlist in pairs(BanTable.identifier) do 
                            if IdeBanlist == Ide then 
                                if BanTable.scadenzaban ~= nil and os.time() > BanTable.scadenzaban then   
                                    if not BanTable.perma then   
                                        table.remove(Table, BanTable.banId)
                                        SaveResourceFile(GetCurrentResourceName(), "Fusion_Bans.json", json.encode(Table, { indent = true }), -1)
                                        print("^7[^8FuS^7-^8AdminMenu^7] - Player: "..GetPlayerName(_src).. "Try To Join With Ban...")
                                        Bannato = true 
                                        break 
                                    else 
                                        if BanTable.offlineban ~= nil and BanTable.offlineban then
                                            if GetPlayerName(_src) ~= nil then
                                                BanTable.name = GetPlayerName(_src).. " [Offline Ban]"
                                            end

                                            BanTable.offlineban = false 
                                            BanTable.identifier = GetPlayerIdentifiers(_src)
                                            BanTable.token = Playertokens 
                                            SaveResourceFile(GetCurrentResourceName(), "Fusion_Bans.json", json.encode(Table, { indent = true }), -1)
                                        end

                                        CancelEvent()
                                        setKickReason(""..FuS_Lang["BanSection_YouAreBannedFromThisServer"].."\n"..FuS_Lang["BanSection_BanExpire"].." "..os.date("%x", BanTable.scadenzaban).." "..os.date("%X", BanTable.scadenzaban).."\n Ban ID: "..BanTable.banId)
                                        print("^7[^8FuS^7-^8AdminMenu^7] - Player: "..GetPlayerName(_src).." Try To Join With Identifiers Ban...")
                                    end
                                else 
                                    if BanTable.offlineban ~= nil and BanTable.offlineban then
                                        if GetPlayerName(_src) ~= nil then
                                            BanTable.name = GetPlayerName(_src).." [Offline Ban]"
                                        end

                                        BanTable.offlineban = false 
                                        BanTable.identifier = GetPlayerIdentifiers(_src)
                                        BanTable.token = Playertokens 
                                        SaveResourceFile(GetCurrentResourceName(), "Fusion_Bans.json", json.encode(Table, { indent = true }), -1)
                                    end

                                    CancelEvent()
                                    if BanTable.perma then
                                        setKickReason(""..FuS_Lang["BanSection_YouAreBannedFromThisServer"].."\n"..FuS_Lang["BanSection_BanExpire"].." "..FuS_Lang["BanSection_PermanentBan"].." \n Ban ID: "..BanTable.banId)
                                        Bannato = true 
                                        break 
                                    else
                                        setKickReason(""..FuS_Lang["BanSection_YouAreBannedFromThisServer"].."\n"..FuS_Lang["BanSection_BanExpire"].." "..os.date("%x", BanTable.scadenzaban).." "..os.date("%X", BanTable.scadenzaban).."\n Ban ID: "..BanTable.banId)
                                        print("^7[^8FuS^7-^8AdminMenu^7] - Player: "..GetPlayerName(_src).." Try To Join With Identifiers Ban...")
                                        Bannato = true 
                                        break 
                                    end
                                end
                            end
                        end
                        local BannaToken = true
                        if not Bannato and BannaToken then 
                            if BanTable.perma then
                                if type(BanTable.token) == "table" then
                                    for d, TokenBanlist in pairs(BanTable.token) do 
                                        for g, Player in pairs(Playertokens) do 
                                            if Player == TokenBanlist then
                                                CancelEvent()
                                                setKickReason(""..FuS_Lang["BanSection_YouAreBannedFromThisServer"].."\n"..FuS_Lang["BanSection_BanExpire"].." "..os.date("%x", BanTable.scadenzaban).." "..os.date("%X", BanTable.scadenzaban).."\n Ban ID: "..BanTable.banId)
                                                print("^7[^8FuS^7-^8AdminMenu^7] - Player: "..GetPlayerName(_src).." Try To Join With Tokens Banned...")
                                                Bannato = true 
                                                break 
                                            end
                                        end
                                        if Bannato then
                                            break 
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if Bannato then
                        break
                    end
                end
                if Bannato then
                    break 
                end
            end
        else 
            Fusion_BanJsonCreator()
        end
    else
        Fusion_BanJsonCreator()
    end
end)

-- Event Ban --
RegisterServerEvent("FuS_AdminMenu:BanEvent")
AddEventHandler("FuS_AdminMenu:BanEvent", function(ID, motivoban, Value)
    local src = source 
    local steam = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local discord = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local license = FuS_Lang["BanSection_IdentifierNotAvaible"] 
    local live = FuS_Lang["BanSection_IdentifierNotAvaible"] 
    local xbl = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local ip = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local expire = 0 
    local motivoban = motivoban
    local perma = false 
    local PlayerName = GetPlayerName(ID)

    local xPlayer = ESX.GetPlayerFromId(src)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then

        if PlayerName ~= nil then
            PlayerName = GetPlayerName(ID)
        else
            PlayerName = FuS_Lang["BanSection_PlayerNameNotAvaible"]
        end

        for m,n in ipairs(GetPlayerIdentifiers(ID)) do 

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

        if ID ~= src then
            if Value == '1h' then
                expire = 3600 + os.time()
            elseif Value == '3h' then  
                expire = 10800 + os.time() 
            elseif Value == '6h' then
                expire = 21600 + os.time()
            elseif Value == '12h' then
                expire = 43200 + os.time()
            elseif Value == "1g" then
                expire = 86400 + os.time()
            elseif Value == "2g" then  
                expire = 172800 + os.time()
            elseif Value == "3g" then 
                expire = 259200 + os.time()
            elseif Value == "4g" then 
                expire = 345600 + os.time()
            elseif Value == "5g" then 
                expire = 432000 + os.time()
            elseif Value == "6g" then 
                expire = 518400 + os.time()
            elseif Value == "1s" then
                expire = 604800 + os.time()
            elseif Value == "1m" then
                expire = 2419200 + os.time()
            elseif Value == "perma" then  
                expire = 9999999999999999 + os.time() 
                perma = true 
            end
        end

        if motivoban == nil or motivoban == "" then
            motivoban = FuS_Lang["BanSection_ReasonNotSpecified"]
        end

        Fusion_Ban(ID,tonumber(ID),motivoban,expire,perma)
    end

end)

-- Function Ban With File Json --
function Fusion_Ban(source, target, motivoban, timeban, perma)
    local src = source 
    local steam = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local discord = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local license = FuS_Lang["BanSection_IdentifierNotAvaible"] 
    local live = FuS_Lang["BanSection_IdentifierNotAvaible"] 
    local xbl = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local ip = FuS_Lang["BanSection_IdentifierNotAvaible"]
    local File = LoadResourceFile(GetCurrentResourceName(), "Fusion_Bans.json")
    if File ~= nil then 
        local Table = json.decode(File)
        if type(Table) == "table" then 
            local IDBan = GeneraIdBan()
            local BanID = tonumber(IDBan)
            local PlayerName = GetPlayerName(target)

            if PlayerName ~= nil then 
                PlayerName = GetPlayerName(target)
            else
                PlayerName = FuS_Lang["BanSection_PlayerNameNotAvaible"]
            end 

            for m,n in ipairs(GetPlayerIdentifiers(target)) do 

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

            if reason ~= nil then 
                reason = motivoban 
            else 
                reason = FuS_Lang["BanSection_ReasonNotSpecified"]
            end 

            local Tokens 
            BanToken = true 
            if BanToken then 
                Tokens = {}
                for i = 1, GetNumPlayerTokens(source) do 
                    table.insert(Tokens, GetPlayerToken(source, i))
                end
            else
                Tokens = "N/A"
            end 

            table.insert(Table, {
                name = PlayerName, 
                banId = BanID,
                perma = perma,
                reason = motivoban,
                data = os.date("%x %X %p"),
                identifier = GetPlayerIdentifiers(source),
                scadenzaban = timeban,
                token = Tokens 
            })
            SaveResourceFile(GetCurrentResourceName(), "Fusion_Bans.json", json.encode(Table, { indent = true }), -1)

            if FuS_W.BanJsonLog == nil or FuS_W.BanJsonLog == '' then
            else
                local LogOnDS = {
                    {
                        ["color"] = 16711680,
                        ["title"] = "FuS_AdminMenu - New BAN Json Registered",
                        ["description"] = "``Player:`` "..PlayerName.." \n ``ServerID:`` "..target.."\n ``Details:`` "..motivoban.." \n ``SteamID:`` "..steam.." \n ``Discord:`` <@"..discord..">".." \n ``Rockstar License:`` "..license.." \n ``Live Id:`` "..live.." \n ``Xbox Id:`` "..xbl.." \n ``Ip:`` "..ip.."\n\n",
                        ["footer"] = {
                            ["icon_url"] = "https://imgur.com/75RMHFz.png",
                            ["text"] = "FuS_AdminMenu - Developed By Fusion Development",
                        },
                        ["image"] = {
                            ['url'] = "https://imgur.com/75RMHFz.png",
                        },
                    }
                }
                PerformHttpRequest(FuS_W.BanJsonLog, function(err, text, headers) end, 'POST', json.encode({username = "Fusion Development - FuS_AdminMenu", embeds = LogOnDS}), { ['Content-Type'] = 'application/json'})
            end


            DropPlayer(target, ""..FuS_Lang["BanSection_BannedFrom"].." "..FuS_Lang["BanSection_NameServer"].." \n"..FuS_Lang["BanSection_Reason"].." "..motivoban.." \n"..FuS_Lang["BanSection_BanID"].." #"..BanID)
        else
            Fusion_BanJsonCreator()
        end
    else 
        Fusion_BanJsonCreator()
    end
end

-- Generate ID Ban -- 
function GeneraIdBan()
    local function IsNumberTaken(number)
        local Table = json.decode(File)
        if type(Table) == "table" then
            for a, b in pairs(Table) do
                if b.banId == number then
                    return true
                end
            end
        end
	end

	local function GenerateNumber()
		local numBase1 = math.random(100,999)
		local numBase2 = math.random(1000,9999)
		local num = string.format(numBase1.. "" ..numBase2)
		return num
	end

	local banid = GenerateNumber()

	if IsNumberTaken(banid) then
		SetTimeout(5, GeneraIdBan())
	end

	return banid
end

-- Ban Creator json File --
function Fusion_BanJsonCreator()
    local File = LoadResourceFile(GetCurrentResourceName(), "Fusion_Bans.json")
    if not File or File == "" then 
        SaveResourceFile(GetCurrentResourceName(), "Fusion_Bans.json", "[]", -1)
        print()
        print("^7[^8FuS^7-^8AdminMenu^7] - "..FuS_Lang["PrintSection_RegeneratingJsonFile"].." ^7")
        Citizen.Wait(5000)
        print()
        print("^7[^8FuS^7-^8AdminMenu^7] - "..FuS_Lang["PrintSection_JsonFileRegenerated"].."^7")
    else
        local Table = json.decode(File)
        if not Table then 
            SaveResourceFile(GetCurrentResourceName(), "Fusion_Bans.json", "[]", -1)
            Table = {}
            print()
            print("^7[^8FuS^7-^8AdminMenu^7] - "..FuS_Lang["PrintSection_JsonFileCorrupted"].."^7")
            print()
            print("^7[^8FuS^7-^8AdminMenu^7] - "..FuS_Lang["PrintSection_ServerShuttingDown"].."^7")
            Citizen.Wait(3000)
            os.exit()
        end
    end
end

-- Check Name Resource --  
Citizen.CreateThread(function()
    if (GetCurrentResourceName() == "FuS_AdminMenu") then 
        Fusion_BanJsonCreator()
        print()
        print('^8~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^7')
        print("^7[^8FuS^7-^8AdminMenu^7] - ^3Check If esx_menu_default Is Started^7")
        print("^7[^8FuS^7-^8AdminMenu^7] - ^3Check Il esx_menu_dialog Is Started^7")
        print('^8~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^7')
    end
end)

-- Get Player List --
spairs = function(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- List Player --
ESX.RegisterServerCallback("FuS_AdminMenu:CheckListPlayer", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then 
        local elements = {}
        for k,v in spairs(GetPlayers()) do 
            local name = GetPlayerName(v)
            if name ~= nil then 
                table.insert(elements, {label = "Name: "..name.." ID: "..v, value = v})
            end
        end
        cb(elements)
    end
end)

-- Get Player Option In List Player --
function CheckIdentifier(source, id) 
    for k,v in ipairs(GetPlayerIdentifiers(source)) do 
        if id == v then 
            return true 
        end
    end
end

-- Event Video For Ban -- 
RegisterServerEvent('FuS_AdminMenu:AnimationVideo')
AddEventHandler('FuS_AdminMenu:AnimationVideo', function(motivoban,ID)
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        TriggerClientEvent("FuS_AdminMenu:BanTroll", ID,motivoban)
    end
end)

-- Screenshot System -- 
RegisterServerEvent("FuS_AdminMenu:GetIdentifiers")
AddEventHandler("FuS_AdminMenu:GetIdentifiers", function(source, ID)
    local src = source
    local steam = "N/A"
    local steam2 = "N/A"
    local discord = "N/A"
    local discord2 = "N/A"
    local license = "N/A"
    local live = "N/A"
    local xbl = "N/A"
    local ip = "N/A"
    local playername = GetPlayerName(ID)
    local namestaffer = GetPlayerName(src)

    for m,n in ipairs(GetPlayerIdentifiers(ID)) do 

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

    for m,n in ipairs(GetPlayerIdentifiers(src)) do 

        if n:match("steam") then
            steam2 = n
    
        elseif n:match("discord") then
            discord2 = n:gsub("discord:","")
        end
    end

    local Descrizione = "**[Staffer Details]** \n**``ID Staffer:``**`` "..src.." ``\n**``Name Staffer:``**`` "..namestaffer.." ``\n**``Steam Hex:``**`` "..steam2.." ``\n**``Discord ID:``**`` "..discord2.." ``\n\n**[Player Details]** \n**``ID Player:``**`` "..ID.." ``\n**``Name Player:``**`` "..playername.." ``\n**``Steam Hex:``**`` "..steam.." ``\n**``License:``**`` "..license.." ``\n**``Discord ID:``**`` "..discord.." ``\n**``Live ID:``**`` "..live.." ``\n**``Xbox ID:``**`` "..xbl.." ``\n**``IP:``**`` "..ip.."``"

    PerformHttpRequest(FuS_W.ScreenshotWebhook, function()
    end, "POST", json.encode({
        embeds = {{
            author = {
                name = "FuS_AdminMenu - Screenshot Logs",
                icon_url = "https://imgur.com/75RMHFz.png",
            },
            title = "FuS_AdminMenu - Screenshot Player",
            description = Descrizione,
            color = 179870,
            footer = {
                text = "FuS_AdminMenu - Developed By Fusion Development",
                icon_url = "https://imgur.com/75RMHFz.png",
            }
        }}
    }), {
        ["Content-Type"] = "application/json"
    })

end)

RegisterServerEvent('FuS_AdminMenu:Screenshot')
AddEventHandler('FuS_AdminMenu:Screenshot', function(upload)
    LogDiscord(upload)
end)

function LogDiscord(image)
    if FuS_W.ScreenshotWebhook == nil or FuS_W.ScreenshotWebhook == '' then
        print('^7[^8FuS^7-^8AdminMenu^7] - Screenshot Webhook Is Empty, Screenshot Don\'t Work Without Webhook Pls Setup')
    else
        PerformHttpRequest(FuS_W.ScreenshotWebhook, function()
        end, "POST", json.encode({
            embeds = {{
                author = {
                    name = "",
                    icon_url = "https://imgur.com/75RMHFz.png",
                },
                title = "**``Screenshot Requested``**",
                description = "",
                color = 179870,
                image = {
                    url = image
                },
                footer = {
                    text = "FuS_AdminMenu - Developed By Fusion Development",
                    icon_url = "https://imgur.com/75RMHFz.png",
                }
            }}
        }), {
            ["Content-Type"] = "application/json"
        })
    end
end

RegisterServerEvent("FuS_AdminMenu:ActiveMode")
AddEventHandler("FuS_AdminMenu:ActiveMode", function()
    local PlayerName = GetPlayerName(source)
    if FuS_W.LogModStaff == nil or FuS_W.LogModStaff == '' then
    else
        PerformHttpRequest(FuS_W.LogModStaff, function()
        end, "POST", json.encode({
            embeds = {{
                author = {
                    name = "FuS_AdminMenu - Mod Staff Log On",
                    icon_url = "https://imgur.com/75RMHFz.png",
                },
                title = "FuS_AdminMenu - Mod Staff Log On",
                description = " \n**Name STAFF**: "..PlayerName.."\n**Tag Staff**: Active\n**Time: ** "..os.date("!%H:%M",  os.time() + 1 * 60 * 60).."", 
                color = 179870,
                footer = {
                    text = "FuS_AdminMenu - Developed By Fusion Development",
                    icon_url = "https://imgur.com/75RMHFz.png",
                }
            }}
        }), {
            ["Content-Type"] = "application/json"
        })
    end
end)

RegisterServerEvent("FuS_AdminMenu:DeactiveMode")
AddEventHandler("FuS_AdminMenu:DeactiveMode", function()
    local PlayerName = GetPlayerName(source)
    if FuS_W.LogModStaff == nil or FuS_W.LogModStaff == '' then
    else
        PerformHttpRequest(FuS_W.LogModStaff, function()
        end, "POST", json.encode({
            embeds = {{
                author = {
                    name = "FuS_AdminMenu - Mod Staff Log Off",
                    icon_url = "https://imgur.com/75RMHFz.png",
                },
                title = "FuS_AdminMenu - Mod Staff Log Off",
                description = " \n**Name STAFF**: "..PlayerName.."\n**Tag Staff**: Active\n**Time: ** "..os.date("!%H:%M",  os.time() + 1 * 60 * 60).."", 
                color = 179870,
                footer = {
                    text = "FuS_AdminMenu - Developed By Fusion Development",
                    icon_url = "https://imgur.com/75RMHFz.png",
                }
            }}
        }), {
            ["Content-Type"] = "application/json"
        })
    end
end)

-- Give Car -- 
RegisterServerEvent("FuS_AdminMenu:GiveVehicle")
AddEventHandler("FuS_AdminMenu:GiveVehicle", function(ID, vehicleProps)
    local src = source 
    local xTarget = ESX.GetPlayerFromId(ID)
    local xPlayer = ESX.GetPlayerFromId(src)
    local GruppoPlayer = xPlayer.getGroup()

    if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
        if xTarget then
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, garage, type) VALUES (@owner, @plate, @vehicle, @garage, @type)', {
                ['@owner'] = xTarget.identifier,
                ['@plate'] = vehicleProps.plate, 
                ['@vehicle'] = json.encode(vehicleProps),
                ['@garage'] = FuS_Config.DefaultNameGarageSQL,
                ['@type'] = 'car',
            }, function(ok) 
                TriggerClientEvent('zg-notify:TriggerNotification', src, ""..FuS_Lang["GiveSection_VehicleGivedTo"].." "..GetPlayerName(ID).." ID: "..ID.."", FuS_Config.TimeNotify, 'success')
                TriggerClientEvent('zg-notify:TriggerNotification', ID, ""..FuS_Lang["GiveSection_UHaveVehicleGived"].." "..GetPlayerName(src).." ID: "..src.."", FuS_Config.TimeNotify, 'success')

                local s_PlayerName = GetPlayerName(ID)
                local s_steam = FuS_Lang["BanSection_IdentifierNotAvaible"]
                local s_discord = FuS_Lang["BanSection_IdentifierNotAvaible"]
                local s_license = FuS_Lang["BanSection_IdentifierNotAvaible"] 
                local s_live = FuS_Lang["BanSection_IdentifierNotAvaible"] 
                local s_xbl = FuS_Lang["BanSection_IdentifierNotAvaible"]
                local s_ip = FuS_Lang["BanSection_IdentifierNotAvaible"]

                local t_PlayerName = GetPlayerName(src)
                local t_steam = FuS_Lang["BanSection_IdentifierNotAvaible"]
                local t_discord = FuS_Lang["BanSection_IdentifierNotAvaible"]
                local t_license = FuS_Lang["BanSection_IdentifierNotAvaible"] 
                local t_live = FuS_Lang["BanSection_IdentifierNotAvaible"] 
                local t_xbl = FuS_Lang["BanSection_IdentifierNotAvaible"]
                local t_ip = FuS_Lang["BanSection_IdentifierNotAvaible"]
        
                for m,n in ipairs(GetPlayerIdentifiers(ID)) do 
        
                    if n:match("steam") then 
                        t_steam = n 
        
                    elseif n:match("discord") then
                        t_discord = n:gsub("discord:","")
        
                    elseif n:match("license") then 
                        t_license = n
        
                    elseif n:match("live") then
                        t_live = n
        
                    elseif n:match("xbl") then 
                        t_xbl = n 
        
                    elseif n:match("ip") then
                        t_ip = n:gsub("ip:","")
                    end
                end

                for m,n in ipairs(GetPlayerIdentifiers(src)) do 
        
                    if n:match("steam") then 
                        s_steam = n 
        
                    elseif n:match("discord") then
                        s_discord = n:gsub("discord:","")
        
                    elseif n:match("license") then 
                        s_license = n
        
                    elseif n:match("live") then
                        s_live = n
        
                    elseif n:match("xbl") then 
                        s_xbl = n 
        
                    elseif n:match("ip") then
                        s_ip = n:gsub("ip:","")
                    end
                end

                if FuS_W.GiveVehicleWebhook == nil or FuS_W.GiveVehicleWebhook == '' then
                else
                    local LogOnDS = {
                        {
                            ["color"] = 16711680,
                            ["title"] = "FuS_AdminMenu - New Announce Registered",
                            ["description"] = "``Staffer:`` "..s_PlayerName.." \n ``ServerID:`` "..src.."\n ``Details:`` \n ``SteamID:`` "..s_steam.." \n ``Discord:`` <@"..s_discord..">".." \n ``Rockstar License:`` "..s_license.." \n ``Live Id:`` "..s_live.." \n ``Xbox Id:`` "..s_xbl.." \n ``Ip:`` "..s_ip.."\n\n ``Player:`` "..t_PlayerName.." \n ``ServerID:`` "..ID.."\n ``Details:`` \n ``SteamID:`` "..t_steam.." \n ``Discord:`` <@"..t_discord..">".." \n ``Rockstar License:`` "..t_license.." \n ``Live Id:`` "..t_live.." \n ``Xbox Id:`` "..t_xbl.." \n ``Ip:`` "..t_ip.."\n\n **Staffer:** "..t_PlayerName.." **Has Gived Car With Plate:** "..vehicleProps.." **To Player:** "..t_PlayerName.." ",
                            ["footer"] = {
                                ["icon_url"] = "https://imgur.com/75RMHFz.png",
                                ["text"] = "FuS_AdminMenu - Developed By Fusion Development",
                            },
                            ["image"] = {
                                ['url'] = "https://imgur.com/75RMHFz.png",
                            },
                        }
                    }
                    PerformHttpRequest(FuS_W.GiveVehicleWebhook, function(err, text, headers) end, 'POST', json.encode({username = "Fusion Development - FuS_AdminMenu", embeds = LogOnDS}), { ['Content-Type'] = 'application/json'})
                end

            end)
        end
    end
end)