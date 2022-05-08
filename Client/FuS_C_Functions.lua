if FuS_Config.Legacy then
    ESX = exports['es_extended']:getSharedObject()
else
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

-- {Video And Audio Ban} -- 
local Fusion_Start = false
function FuS_AdminMenuBANTROLL()
    if Fusion_Start == false then
		Fusion_Start = true
    local dui = GetDuiHandle(CreateDui("https://cdn.discordapp.com/attachments/810275995621916703/821732415235948584/ban_gif_id.gif", 2000, 1157))

    CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd('Ban'), 'Troll', dui)

    local timer = GetGameTimer() + 10000
    while timer >= GetGameTimer() do
        DrawSprite('Ban', 'Troll', 0.5, 0.5, 2.50, 2.50, 0, 255, 255, 255, 255)
        Wait(0)
    end
end
end

RegisterNetEvent('FuS_AdminMenu:Troll')
AddEventHandler('FuS_AdminMenu:Troll', function(soundFile, soundVolume)
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = soundFile,
        transactionVolume   = soundVolume
    })
end)

RegisterNetEvent("FuS_AdminMenu:BanTroll")
AddEventHandler("FuS_AdminMenu:BanTroll",function (motivoban ,ID)
	local ped = GetPlayerServerId(PlayerId())
	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 50, "soundban", 0.8)
    FuS_AdminMenuBANTROLL()
    Wait(1)
end)

-- {Function Mute & Unmute} -- 
-- Mute / Unmute Player -- 
local mute = false 
Citizen.CreateThread(function()
    while true do 
        if mute then
            DisableControlAction(0, 245, true)
            DisableControlAction(0, 249, true)
            Citizen.Wait(0)
        else
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent("FuS_AdminMenu:MutePlayer")
AddEventHandler("FuS_AdminMenu:MutePlayer", function()
    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
            mute = true
        end
    end)
end)

RegisterNetEvent("FuS_AdminMenu:UnmutePlayer")
AddEventHandler("FuS_AdminMenu:UnmutePlayer", function()
    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
            mute = false
        end
    end)
end)

-- {Revive Self} -- 
RegisterNetEvent("FuS_AdminMenu:ReviveMe")
AddEventHandler("FuS_AdminMenu:ReviveMe", function()
    ExecuteCommand('rianima')
end)

-- {No Clip V2} -- 
local noclip = false
RegisterNetEvent('FuS_AdminMenu:NoClipV2')
AddEventHandler('FuS_AdminMenu:NoClipV2', function()
	noclip = not noclip
	FreezeEntityPosition(PlayerPedId(), noclip)
	SetEntityVisible(PlayerPedId(), not noclip)
	SetPlayerCanUseCover(PlayerId(), not noclip)
end)

Citizen.CreateThread(function()
	while true do
		if noclip then
			local yoff = 0.0
			local zoff = 0.0
			if IsDisabledControlPressed(0, 32) then
				yoff = 0.5
			end
			if IsDisabledControlPressed(0, 33) then
				yoff = -0.5
			end
			if IsDisabledControlPressed(0, 34) then
				SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+3)
			end
			if IsDisabledControlPressed(0, 35) then
				SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-3)
			end
			if IsDisabledControlPressed(0, 85) then
				zoff = 0.2
			end
			if IsDisabledControlPressed(0, 48) then
				zoff = -0.2
			end
			local newPos = nil
			if IsDisabledControlPressed(0, 21) then
				newPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, yoff * (10 + 0.3), zoff * (10 + 0.3))
			else
				newPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, yoff * (5 + 0.3), zoff * (5 + 0.3))
			end
			SetEntityVelocity(PlayerPedId(), 0.0, 0.0, 0.0)
			SetEntityRotation(PlayerPedId(), 0.0, 0.0, 0.0, 0, false)
			SetEntityHeading(PlayerPedId(), GetGameplayCamRelativeHeading())
			SetEntityCoordsNoOffset(PlayerPedId(), newPos.x, newPos.y, newPos.z, noclip, noclip, noclip)
			Citizen.Wait(0)
		else
			Citizen.Wait(1000)
		end
	end
end)

-- Spectate Function -- 
-- Spectate Functions -- 
local Fusion_CioCheNonVedi = false
local SpectateMode = false
local Fusion_UltimeCordinate = nil
local Fusion_PosizionePed = nil
local Fusion_SpectEffective = nil

RegisterNetEvent('FuS_AdminMenu:SpectatorMode')
AddEventHandler('FuS_AdminMenu:SpectatorMode', function(coords, playerId)
	if not Fusion_CioCheNonVedi then
		Fusion_CioCheNonVedi = true
		if SpectateMode then
			SpectateMode = false
			Wait(300)
			RequestCollisionAtCoord(Fusion_PosizionePed)
			NetworkSetInSpectatorMode(false, Fusion_SpectEffective)
			FreezeEntityPosition(PlayerPedId(), false)
			SetEntityCoords(PlayerPedId(), Fusion_UltimeCordinate)
			SetEntityVisible(PlayerPedId(), true)
			Fusion_UltimeCordinate = nil
			Fusion_PosizionePed = nil
			Fusion_SpectEffective = nil
			Fusion_CioCheNonVedi = false
		else
			SpectateMode = true
			foundplayer = false
			Fusion_UltimeCordinate = GetEntityCoords(PlayerPedId())
			SetEntityVisible(PlayerPedId(), false)
			SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z + 10.0)
			FreezeEntityPosition(PlayerPedId(), true)
			Wait(1500)
			SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z - 10.0)
			for _, i in ipairs(GetActivePlayers()) do
				if NetworkIsPlayerActive(i) and tonumber(GetPlayerServerId(i)) == tonumber(playerId) then
					foundplayer = true
					ped = GetPlayerPed(i)
					Fusion_PosizionePed = GetEntityCoords(ped)
					Fusion_SpectEffective = ped
					RequestCollisionAtCoord(Fusion_PosizionePed)
					NetworkSetInSpectatorMode(true, Fusion_SpectEffective)
					Fusion_CioCheNonVedi = false
					while SpectateMode do
						Wait(100)
						local cped = GetEntityCoords(Fusion_SpectEffective)
						if cped.x == 0 and cped.y == 0 and cped.z == 0 then
							SpectateMode = false
							Wait(300)
							RequestCollisionAtCoord(Fusion_PosizionePed)
							NetworkSetInSpectatorMode(false, Fusion_SpectEffective)
							FreezeEntityPosition(PlayerPedId(), false)
							SetEntityCoords(PlayerPedId(), Fusion_UltimeCordinate)
							SetEntityVisible(PlayerPedId(), true)
							Fusion_UltimeCordinate = nil
							Fusion_PosizionePed = nil
							Fusion_SpectEffective = nil
							Fusion_CioCheNonVedi = false
						else
							SetEntityCoords(PlayerPedId(), cped.x, cped.y, cped.z - 10.0)
						end
					end
					break
				end
			end
			if not foundplayer then
				FreezeEntityPosition(PlayerPedId(), false)
				SetEntityCoords(PlayerPedId(), Fusion_UltimeCordinate)
				SetEntityVisible(PlayerPedId(), true)
				Fusion_UltimeCordinate = nil
				spectate = false
				Fusion_CioCheNonVedi = false
			end
		end
	end
end)

-- Freeze Player -- 
local states = {}
states.frozen = false
states.frozenPos = nil

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(12)

		if(states.frozen)then
			ClearPedTasks(PlayerPedId())
			SetEntityCoords(PlayerPedId(), states.frozenPos)
		else
			Citizen.Wait(200)
		end
	end
end)

RegisterNetEvent("FuS_AdminMenu:FreezePlayer")
AddEventHandler("FuS_AdminMenu:FreezePlayer", function(state)
	local player = PlayerId()
	local ped = PlayerPedId()

	states.frozen = state 
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasks(ped)
		end
	end
end)

-- Kill Player Functions -- 
RegisterNetEvent("FuS_AdminMenu:KillPlayer")
AddEventHandler("FuS_AdminMenu:KillPlayer", function()
	SetEntityHealth(PlayerPedId(), 0)
end)

-- Heal Player Functions -- 
RegisterNetEvent("FuS_AdminMenu:HealPlayer")
AddEventHandler("FuS_AdminMenu:HealPlayer", function()
	if GetResourceState(FuS_Config.NameResourceStatus) == 'started' then
		SetEntityHealth(PlayerPedId(), 200)
		TriggerEvent('esx_status:set', 'hunger', 1000000)
		TriggerEvent('esx_status:set', 'thirst', 1000000)
	else
		SetEntityHealth(PlayerPedId(), 200)
	end
end)

-- Tag Staff --
local playerDistances = {}
local Staffers = {}

Citizen.CreateThread(function()
	ESX.TriggerServerCallback("FuS_AdminMenu:TabellaID", function(NewTable)
		Staffers = NewTable
	end)
end)

RegisterNetEvent("FuS_AdminMenu:UpdateId")
AddEventHandler("FuS_AdminMenu:UpdateId", function(NewTable)
	Staffers = NewTable
end)

local function DrawText3D(position, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(position.x,position.y,position.z+1)
    local dist = #(GetGameplayCamCoords()-position)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0*scale, 0.55*scale)
        else 
            SetTextScale(0.0*scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    local pId = PlayerPedId()
    while true do
        local found = false
        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if playerDistances[id] then
                if playerDistances[id] < 10 then
                    local targetPedCords = GetEntityCoords(targetPed)
                    DrawText3D(targetPedCords, "~r~"..FuS_Config.TagStaff.."", 255,255,255)
                    found = true
                end
            end
        end
        if not found then
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for _, id in ipairs(GetActivePlayers()) do
            if Staffers[GetPlayerServerId(id)] then
                local targetPed = GetPlayerPed(id)
                local distance = #(playerCoords-GetEntityCoords(targetPed))
                playerDistances[id] = distance
            else
                playerDistances[id] = nil
            end
        end
        Citizen.Wait(2000)
    end
end)