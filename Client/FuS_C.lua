if FuS_Config.Legacy then
    ESX = exports['es_extended']:getSharedObject()
else
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

--{Menu Staff SuperAdmin}--
function Fusion_MenuStaffSuperAdmin()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Home_Menu', {
        title = FuS_Lang["HomepageTitle"],
        align = FuS_Config.PositionMenu,
        elements = { 
            {label = FuS_Lang["ManagePlayer"], value = "fusion_manage_player"},
            {label = FuS_Lang["PersonalMenu"], value = 'fusion_personal_menu'},
            {label = FuS_Lang["AnnounceMenu"], value = 'fusion_announce_menu'},
            {label = FuS_Lang["VehicleMenu"], value = 'fusion_vehicle_menu'},
            {label = FuS_Lang["VarsTitle"], value = 'fusion_vars_menu'}
        }
    }, function(data, menu)

        local Fusion_Development = data.current.value 

        -- Manage Player -- 
        if Fusion_Development == 'fusion_manage_player' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_SubMenu_ManagePlayer', {
                title = FuS_Lang["ManagePlayer_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["ManagePlayer_List"], value = "fusion_lista_player"},
                    {label = FuS_Lang["ManagePlayer_All"], value = 'fusion_all_player'}
                }

            }, function(data1, menu1)

                local Fusion_Development2 = data1.current.value 

                if Fusion_Development2 == 'fusion_lista_player' then
                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckListPlayer", function(elements)
                        if elements ~= nil then
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Lista_Player', {
                                title = FuS_Lang["ManagePlayer_Title"],
                                align = FuS_Config.PositionMenu,
                                elements = elements

                            }, function(datalista, menulista)
                                if datalista.current.value ~= nil then
                                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Lista_Player_SubMenu', {
                                        title = FuS_Lang["ManagePlayer_Title"],
                                        align = FuS_Config.PositionMenu,
                                        elements = {
                                            {label = FuS_Lang["ListPlayer_ManageSection"], value = "fusion_manage_section"},
                                            {label = FuS_Lang["ListPlayer_ReviverSection"], value = 'fusion_reviver_section'}, 
                                            {label = FuS_Lang["ListPlayer_BanSection"], value = 'fusion_ban_player'},
                                            {label = FuS_Lang["ListPlayer_TeleportSection"], value = 'fusion_teleport_menu'},
                                            {label = FuS_Lang["ListPlayer_MutesSection"], value = 'fusion_mute_player'},
                                            {label = FuS_Lang["ListPlayer_GiveSection"], value = 'fusion_give_player'},
                                            {label = FuS_Lang["ListPlayer_SettingSection"], value = 'fusion_setting_player'},
                                            {label = FuS_Lang["WipePlayer"], value = 'fusion_wipe_player'}
                                        }

                                    }, function(datalista2, menulista2)

                                        local Fusion_Development3 = datalista2.current.value 

                                        -- Menu Gestione -- 
                                        if Fusion_Development3 == 'fusion_manage_section' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Menu_Manage_Player_Option', {
                                                title = FuS_Lang["ManagePlayer_Title"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["FusionCheck"], value = "fusion_check_player"},
                                                    {label = FuS_Lang["FusionScreenshot"], value = "fusion_screenshot_player"},
                                                    {label = FuS_Lang["FusionOpenInventory"], value = 'fusion_open_inventory'},
                                                    {label = FuS_Lang["FusionSpect"], value = "fusion_spect_player"},
                                                    {label = FuS_Lang["FusionFreeze"], value = "fusion_freeze_player"},
                                                    {label = FuS_Lang["FusionKill"], value = "fusion_kill_player"}
                                                }

                                            }, function(dad, mam)

                                                local Fusion_Development10 = dad.current.value 

                                                -- Check Player --
                                                if Fusion_Development10 == 'fusion_check_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('Fusion_Check'..' '..ID)

                                                -- Screenshot Player --
                                                elseif Fusion_Development10 == 'fusion_screenshot_player' then
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('screen'..' '..ID)

                                                -- Open Inventory Player -- 
                                                elseif Fusion_Development10 == 'fusion_open_inventory' then 
                                                    local ID = datalista.current.value 
                                                    if FuS_Config.UseOxInventory then 
                                                        ExecuteCommand('viewinv'..' '..ID)
                                                    else
                                                        ExecuteCommand(FuS_Config.Commands.OpenInventory..' '..ID)
                                                    end

                                                -- Spect Player -- 
                                                elseif Fusion_Development10 == 'fusion_spect_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('spect'..' '..ID)

                                                -- Freeze Player -- 
                                                elseif Fusion_Development10 == 'fusion_freeze_player' then 
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('freeze'..' '..ID)

                                                -- Kill Player --- 
                                                elseif Fusion_Development10 == 'fusion_kill_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('kill'..' '..ID)

                                                end
                                            
                                            end, function(dad, mam)
                                                mam.close()
                                            end)

                                        -- Menu Ban -- 
                                        elseif Fusion_Development3 == 'fusion_ban_player' then    
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fusion_ban_player', {
                                                title = FuS_Lang["ListPlayer_BanSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["BanSection_OneHourBan"], value = '1h'},
                                                    {label = FuS_Lang["BanSection_ThreeHourBan"], value = '3h'},
                                                    {label = FuS_Lang["BanSection_SixHourBan"], value = '6h'},
                                                    {label = FuS_Lang["BanSection_TwelveHourBan"], value = '12h'},
                                                    {label = FuS_Lang["BanSection_OneDayBan"], value = '1g'},
                                                    {label = FuS_Lang["BanSection_TwoDayBan"], value = '2g'},
                                                    {label = FuS_Lang["BanSection_ThreeDayBan"], value = '3g'},
                                                    {label = FuS_Lang["BanSection_FourDayBan"], value = '4g'},
                                                    {label = FuS_Lang["BanSection_FiveDayBan"], value = '5g'},
                                                    {label = FuS_Lang["BanSection_SixDayBan"], value = '6g'},
                                                    {label = FuS_Lang["BanSection_WeekBan"], value = '1s'},
                                                    {label = FuS_Lang["BanSection_OneMonthBan"], value = '1m'},
                                                    {label = FuS_Lang["BanSection_PermaBan"], value = 'perma'}
                                                }

                                            }, function(datalista3, menulista3)

                                                local Fusion_Development4 = datalista3.current.value 
                                           
                                                -- Ban 1 Ora --
                                                if Fusion_Development4 == '1h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''
            
                                                    }, function(data_input, menu_input)
            
                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end

                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 3 Ore --
                                                elseif Fusion_Development4 == '3h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_3H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 6 Ore --
                                                elseif Fusion_Development2 == '6h' then 
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_6H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 12 Ore --
                                                elseif Fusion_Development2 == '12h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_12H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Giorno --
                                                elseif Fusion_Development2 == '1g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 2 Giorni --
                                                elseif Fusion_Development2 == '2g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_2G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 3 Giorni --
                                                elseif Fusion_Development2 == '3g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_3G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 4 Giorni --
                                                elseif Fusion_Development2 == '4g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_4G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 5 Giorni --
                                                elseif Fusion_Development2 == '5g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_5G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 6 Giorni --
                                                elseif Fusion_Development2 == '6g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_6G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Settimana --
                                                elseif Fusion_Development2 == '1s' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1S', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Mese --
                                                elseif Fusion_Development2 == '1m' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1M', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Perma Ban --
                                                elseif Fusion_Development2 == 'perma' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_perma', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)
                                                end
                                            
                                            end, function(datalista3, menulista3)
                                                menulista3.close()
                                            end)

                                        -- Menu Teleports -- 
                                        elseif Fusion_Development3 == 'fusion_teleport_menu' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Teleports', {
                                                title = FuS_Lang["ListPlayer_TeleportSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["TeleportSection_TpToPlayer"], value = 'fusion_tp_to_player'},
                                                    {label = FuS_Lang["TeleportSection_TpToYouPlayer"], value = 'fusion_bring_to_you_player'}
                                                }
            
                                            }, function(databello, menubello)
            
                                                local Fusion_Development3 = databello.current.value 
            
                                                if Fusion_Development3 == 'fusion_tp_to_player' then
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('goto'.." "..ID)
                                                elseif Fusion_Development3 == 'fusion_bring_to_you_player' then 
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('bring'.." "..ID)
                                                end
                                            end, function(databello, menubello)
                                                menubello.close()
                                            end)

                                        -- Menu Mutes -- 
                                        elseif Fusion_Development3 == 'fusion_mute_player' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Mute', {
                                                title = FuS_Lang["ListPlayer_MutesSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["MutesSection_MutePlayer"], value = 'fusion_mute_player'},
                                                    {label = FuS_Lang["MutesSection_UnmutePlayer"], value = 'fusion_unmute_player'}
                                                }
            
                                            }, function(databello2, menubello2)
            
                                                local Fusion_Development4 = databello2.current.value 
            
                                                if Fusion_Development4 == 'fusion_mute_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('muta'.." "..ID)
                                                elseif Fusion_Development4 == 'fusion_unmute_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('smuta'.." "..ID)
                                                end
                                            end, function(databello2, menubello2) 
                                                menubello2.close()
                                            end)

                                        -- Menu Gives --
                                        elseif Fusion_Development3 == 'fusion_give_player' then
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_GiveSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["GiveSection_GiveBankMoney"], value = "fusion_give_bank_money"},
                                                    {label = FuS_Lang["GiveSection_GiveDirtyMoney"], value = "fusion_give_dirty_money"},
                                                    {label = FuS_Lang["GiveSection_GiveItem"], value = "fusion_give_item"},
                                                    {label = FuS_Lang["GiveSection_GiveVehicle"], value = 'fusion_give_vehicle_to_player'}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development6 = datata.current.value
            
                                                -- Give Bank -- 
                                                if Fusion_Development6 == 'fusion_give_bank_money' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteQuantity"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local ID = datalista.current.value 
                                                            local Quantity = d1_input.value
                                                            ExecuteCommand(FuS_Config.Commands.GiveAccountMoney..' '..ID..' bank '..Quantity)
                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedBankMoney"])})
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end)
                                            
                                                -- Give Dirty --
                                                elseif Fusion_Development6 == 'fusion_give_dirty_money' then  
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteQuantity"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local ID = datalista.current.value 
                                                            local Quantity = d1_input.value
                                                            ExecuteCommand(FuS_Config.Commands.GiveAccountMoney..' '..ID..' black_money '..Quantity)            
                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedDirtyMoney"])})                               
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end) 
                                                    
                                                -- Give Item -- 
                                                elseif Fusion_Development6 == 'fusion_give_item' then   
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteItem"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local Item = d1_input.value  
                                                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_2', {
                                                                title = FuS_Lang["WriteQuantity"],
                                                                default = ""
                                                            }, function(d1_input, m1_input)
        
                                                                if d1_input.value == nil then
                                                                    m1_input.close()
                                                                else
                                                                    m1_input.close()
                                                                    local ID = datalista.current.value 
                                                                    local Quantity = d1_input.value
                                                                    ExecuteCommand(FuS_Config.Commands.GiveItem..' '..ID..' '..Item..' '..Quantity)
                                                                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedItem"])})
                                                                end
                                                            
                                                            end, function(d1_input, m1_input)
                                                                m1_input.close()
                                                            end) 
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end) 

                                                -- Give Vehicle -- 
                                                elseif Fusion_Development6 == 'fusion_give_vehicle_to_player' then 
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_Veicolo', {
                                                        title = FuS_Lang["WriteModel"],
                                                        default = ""

                                                    }, function(d1, m1)

                                                        if d1.value == nil then
                                                            m1.close()
                                                        else
                                                            m1.close()
                                                            local ID = datalista.current.value 
                                                            local Modello = d1.value 
                                                            local coords = GetEntityCoords(GetPlayerPed(-1))
                                                            ESX.Game.SpawnVehicle(d1.value, coords, 200, function(vehicle)
                                                                SetEntityAsMissionEntity(vehicle, true, true)
                                                                SetVehicleOnGroundProperly(vehicle)
                                                                NetworkFadeInEntity(vehicle, true, true)
                                                                SetModelAsNoLongerNeeded(d1.value)
                                                                TriggerServerEvent("FuS_AdminMenu:GiveVehicle", ID, ESX.Game.GetVehicleProperties(vehicle))
                                                                Citizen.Wait(1000)
                                                                DeleteVehicle(vehicle)
                                                            end)
                                                            
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end)

                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)

                                        -- Menu Give -- 
                                        elseif Fusion_Development3 == 'fusion_setting_player' then
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_SettingSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["SettingSection_SetJob"], value = "fusion_setjob1_player"}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development13 = datata.current.value
            
                                                if Fusion_Development13 == 'fusion_setjob1_player' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option', {
                                                        title = FuS_Lang["WriteID"],
                                                        default = ""

                                                    }, function(datajob_input, menujob_input)

                                                        if datajob_input.value == nil then
                                                            menujob_input.close()
                                                        else
                                                            menujob_input.close()
                                                            local ID = datajob_input.value 
                                                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option_JobName', {
                                                                title = FuS_Lang["WriteNameJob1"],
                                                                default = ""

                                                            }, function(datajob2_input, menujob2_input)

                                                                if datajob2_input.value == nil then
                                                                    menujob2_input.close()
                                                                else
                                                                    menujob2_input.close()
                                                                    local NomeJob = datajob2_input.value 
                                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option_JobGrade', {
                                                                        title = FuS_Lang["WriteGradeJob1"],
                                                                        default = ""

                                                                    }, function(datajob3_input, menujob3_input)

                                                                        if datajob3_input.value == nil then
                                                                            menujob3_input.close()
                                                                        else
                                                                            local GradeJob = datajob3_input.value 
                                                                            ESX.UI.Menu.CloseAll()
                                                                            ExecuteCommand('setjob'..' '..ID..' '..NomeJob..' '..GradeJob)
                                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["SettingSection_JobSetted"])})
                                                                        end
                                                                    
                                                                    end, function(datajob3_input, menujob3_input)
                                                                        menujob3_input.close()
                                                                    end)
                                                                end
                                                            
                                                            end, function(datajob2_input, menujob2_input)
                                                                menujob2_input.close()
                                                            end)
                                                        end
                                                    
                                                    end, function(datajob_input, menujob_input)
                                                        menujob_input.close()
                                                    end)
                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)

                                        -- Wipe Player -- 
                                        elseif Fusion_Development3 == 'fusion_wipe_player' then 
                                            local ID = datalista.current.value 
                                            TriggerServerEvent("FuS_AdminMenu:WipePlayer", ID)

                                        -- Menu Reviver -- 
                                        elseif Fusion_Development3 == 'fusion_reviver_section' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_ReviverSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["ReviverSection_HealPlayer"], value = "fusion_give_heal"},
                                                    {label = FuS_Lang["ReviverSection_RevivePlayer"], value = "fusion_give_revive"},
                                                    {label = FuS_Lang["ReviverSection_GiveArmour"], value = "fusion_give_armour"}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development6 = datata.current.value
            
                                                if Fusion_Development6 == 'fusion_give_heal' then  
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('heal'..' '..ID) 
                                                elseif Fusion_Development6 == 'fusion_give_revive' then   
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('rianima'..' '..ID)
                                                elseif Fusion_Development6 == 'fusion_give_player' then   
                                                    local ID = datalista.current.value 
                                                    SetPedArmour(PlayerPedId(ID), 100)
                                                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["ReviverSection_ArmourGived"])})
                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)
                                        end
                                    
                                    end, function(datalista2, menulista2)
                                        menulista2.close()
                                    end)
                                end
                            end, function(datalista, menulista)
                                menulista.close()
                            end)
                        end
                    end)
                -- All Player Options -- 
                elseif Fusion_Development2 == 'fusion_all_player' then 
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_All_Options', {
                        title = FuS_Lang["ManagePlayer_All"],
                        align = FuS_Config.PositionMenu,
                        elements = {
                            {label = FuS_Lang["AllPlayerSection_BringAll"], value = "fusion_all_player_bring"},
                            {label = FuS_Lang["AllPlayerSection_KickAll"], value = "fusion_all_player_kick"},
                            {label = FuS_Lang["AllPlayerSection_ReviveAllPlayer"], value = "fusion_reviveall_player"},
                        }

                    }, function(datal9, menul9)

                        local Fusion_Development7 = datal9.current.value 

                        if Fusion_Development7 == 'fusion_all_player_bring' then
                            ExecuteCommand('bringatutti')
                        elseif Fusion_Development7 == 'fusion_all_player_kick' then 
                            ExecuteCommand('kickatutti')
                        elseif Fusion_Development7 == 'fusion_reviveall_player' then   
                            ExecuteCommand('rianimatutti')
                        end
                    
                    end, function(datal9, menul9)
                        menul9.close()
                    end)

                    
                end
            
            end, function(data1, menu1)
                menu1.close()
            end)

        -- Personale -- 
        elseif Fusion_Development == 'fusion_personal_menu' then  
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_AdminMenu_Personal', {
                title = FuS_Lang["PersonalMenu"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["PersonalSection_NoClip"], value = "fusion_admin_no_clip"},
                    {label = FuS_Lang["PersonalSection_NoClipV2"], value = "fusion_admin_no_clipv2"},
                    {label = FuS_Lang["PersonalSection_Godmode"], value = "fusion_admin_godmode"},
                    {label = FuS_Lang["PersonalSection_Invisible"], value = "fusion_admin_invisible"},
                    {label = FuS_Lang["PersonalSection_ChangeAspect"], value = "fusion_admin_change_aspect"}
                }

            }, function(dd, mm)

                local Fusion_Development8 = dd.current.value 

                -- No CLip -- 
                if Fusion_Development8 == 'fusion_admin_no_clip' then 
                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
                            playernoclip() 
                        end
                    end)

                -- NoClip V2 --
                elseif Fusion_Development8 == 'fusion_admin_no_clipv2' then
                    ExecuteCommand('noclipv2')

                -- GodMode -- 
                elseif Fusion_Development8 == 'fusion_admin_godmode' then
                    Fusion_Godmode_Func()

                -- Invisible -- 
                elseif Fusion_Development8 == 'fusion_admin_invisible' then
                    Fusion_Invisible_Func()
                    
                -- Change Aspect -- 
                elseif Fusion_Development8 == 'fusion_admin_change_aspect' then
                    Fusion_ChangeAspect_Func()
                    
                end
            
            end, function(dd, mm)
                mm.close()
            end)

        -- Annunci -- 
        elseif Fusion_Development == 'fusion_announce_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Menu_Annunci_Option', {
                title = FuS_Lang["AnnounceSection_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["AnnounceSection_AnnounceOnScreen"], value = 'fusion_annuncio_on_screen'},
                    {label = FuS_Lang["AnnounceSection_AnnounceOnMinimap"], value = 'fusion_annuncio_on_minimap'},
                    {label = FuS_Lang["AnnounceSection_AnnouceRestart"], value = 'fusion_annuncio_restart'},
                    {label = FuS_Lang["AnnounceSection_AnnounceEvent"], value = 'fusion_annuncio_event'}
                }

            }, function(dataye, menuye)

                local Fusion_Development9 = dataye.current.value 

                if Fusion_Development9 == 'fusion_annuncio_on_screen' then
                    ESX.UI.Menu.CloseAll()

                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSchermo', {
                        title = FuS_Lang["WriteMessage"],
                        default = ""

                    }, function(d_input, m_input)
                        if d_input == nil then 
                            m_input.close()
                        else
                            m_input.close()
                            local announcestring = d_input.value 
                            ExecuteCommand('FuS_Announce'..' '..announcestring)
                        end
                    end, function(d_input, m_input)
                        m_input.close()
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_on_minimap' then
                    ESX.UI.Menu.CloseAll()

                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSopra_Minimappa', {
                                title = FuS_Lang["WriteMessage"],
                                default = ""

                            }, function(data_input, menu_input)
                                if data_input == nil then 
                                    menu_input.close()
                                else
                                    menu_input.close()
                                    local mex = data_input.value 
                                    TriggerServerEvent("FuS_AdminMenu:AnnuncioSopraMinimappa", mex)
                                end

                            end, function(data_input, menu_input)
                                menu_input.close() 
                            end)
                        else
                            exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["NoPermission"])})
                        end
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_restart' then
                    ESX.UI.Menu.CloseAll()

                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSchermo', {
                        title = FuS_Lang["WriteMinutes"],
                        default = ""

                    }, function(d2_input, m2_input)
                        if d2_input == nil then 
                            m2_input.close()
                        else
                            m2_input.close()
                            local minuti = d2_input.value
                            local announcestring = FuS_Lang["AnnounceSection_RestartOn"]..' '..minuti..' '..FuS_Lang["AnnounceSection_Minutes"]
                            ExecuteCommand('FuS_Announce'..' '..announcestring)
                        end
                    end, function(d2_input, m2_input)
                        m2_input.close()
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_event' then
                    ESX.UI.Menu.CloseAll()

                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSopra_Minimappa_Evento', {
                                title = FuS_Lang["WriteMessage"],
                                default = ""

                            }, function(data2_input, menu2_input)
                                if data2_input == nil then 
                                    menu2_input.close()
                                else
                                    menu2_input.close()
                                    local messaggioevento = data2_input.value 
                                    TriggerServerEvent("FuS_AdminMenu:AnnuncioSopraMinimappaEvento", messaggioevento)
                                end

                            end, function(data2_input, menu2_input)
                                menu2_input.close() 
                            end)
                        else
                            exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["NoPermission"])})
                        end
                    end)
                end
            
            end, function(dataye, menuye)
                menuye.close()
            end)

        -- Vehicles --
        elseif Fusion_Development == 'fusion_vehicle_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Vehicle_Menu_Option', {
                title = FuS_Lang["VehicleSection_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["VehicleSection_SpawnVehicle"], value = "fusion_spawn_vehicle"},
                    {label = FuS_Lang["VehicleSection_DeleteVehicle"], value = "fusion_delete_vehicle"},
                    {label = FuS_Lang["VehicleSection_RepairVehicle"], value = "fusion_repair_vehicle"},
                    {label = FuS_Lang["VehicleSection_CleanVehicle"], value = 'fusion_clean_vehicle'},
                    {label = FuS_Lang["VehicleSection_FlipVehicle"], value = "fusion_flip_vehicle"},
                    {label = FuS_Lang["VehicleSection_FullkitVehicle"], value = "fusion_fullkit_vehicle"}
                }

            }, function(datav, menuv)

                local Fusion_Development11 = datav.current.value 

                -- Spawn -- 
                if Fusion_Development11 == 'fusion_spawn_vehicle' then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Spawn_Vehicle_Option', {
                        title = FuS_Lang["VehicleSection_TypeModel"],
                        default = ""

                    }, function(dio_input, mdio_input)

                        if dio_input.value == nil or dio_input.value == "" then
                            mdio_input.close()
                        else
                            mdio_input.close()
                            TriggerEvent("esx:spawnVehicle", dio_input.value)
                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleSpawned"])})
                        end
                    
                    end, function(dio_input, mdio_input)
                        mdio_input.close()
                    end)

                -- Delete -- 
                elseif Fusion_Development11 == 'fusion_delete_vehicle' then 
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        TriggerEvent("esx:deleteVehicle")
                    else
                        exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["VehicleSection_YourNotInVehicle"])})
                    end

                -- Repair --
                elseif Fusion_Development11 == 'fusion_repair_vehicle' then 
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        SetVehicleFixed(GetVehiclePedIsUsing(PlayerPedId()))	
                        SetVehicleDirtLevel(GetVehiclePedIsUsing(PlayerPedId()),0)
                    else
                        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleRepaired"])})
                    end

                -- Clean -- 
                elseif Fusion_Development11 == 'fusion_clean_vehicle' then
                    local playerPed = PlayerPedId() 
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    SetVehicleDirtLevel(vehicle, 0)
                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleCleaned"])})

                -- Flip -- 
                elseif Fusion_Development11 == 'fusion_flip_vehicle' then 
                    local player = PlayerPedId()
                    local posmenu = GetEntityCoords(player)
                    local carTarget = GetClosestVehicle(posmenu['x'], posmenu['y'], posmenu['z'], 10.0, 0, 70)
                    SetPedIntoVehicle(player, carTarget, -1)
                    Citizen.Wait(100)
                    ClearPedTask(player)
                    Citizen.Wait(100)
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    playerCoords = playerCoords + vector3(0, 2, 0)
                    SetEntityCoords(carTarget, playerCoords)
                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleFlipped"])})
                
                -- Fullkit -- 
                elseif Fusion_Development11 == 'fusion_fullkit_vehicle' then 
                    Fusion_FullkitVehicle()
                end
            
            end, function(datav, menuv)
                menuv.close()
            end)

        -- Vars Menu -- 
        elseif Fusion_Development == 'fusion_vars_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Home_Vars_Menu', {
                title = FuS_Lang["VarsTitle"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["VarsSection_ClearChat"], value = "fusion_clearchat_option"},
                    {label = FuS_Lang["VarsSection_NamePlayer"], value = "fusion_nameplayer_option"},
                    {label = FuS_Lang["VarsSection_BlipPlayer"], value = "fusion_blipplayer_option"},
                    {label = FuS_Lang["VarsSection_ClearAllVehicles"], value = "fusion_clearallvehicles_option"},
                    {label = FuS_Lang["VarsSection_ClearAllObj"], value = "fusion_clearallobj_option"},
                    {label = FuS_Lang["VarsSection_ClearAllPed"], value = "fusion_clearallped_option"}
                }
            }, function(days, mays)

                local Fusion_Development12 = days.current.value 

                if Fusion_Development12 == 'fusion_clearchat_option' then
                    ExecuteCommand(FuS_Config.Commands.ClearChat)
                elseif Fusion_Development12 == 'fusion_nameplayer_option' then
                    Fusion_NamesPlayer()
                elseif Fusion_Development12 == 'fusion_blipplayer_option' then
                    Fusion_BlipsPlayer()
                elseif Fusion_Development12 == 'fusion_clearallvehicles_option' then
                    Fusion_ClearallVeh()
                elseif Fusion_Development12 == 'fusion_clearallobj_option' then
                    Fusion_ClearallObj()
                elseif Fusion_Development12 == 'fusion_clearallped_option' then
                    Fusion_ClearallPed()
                --elseif Fusion_Development12 == '' then
                end
            
            end, function(days, mays)
                mays.close()
            end)
        end
    
    end, function(data, menu)
        menu.close()
    end)
end

--{Menu Staff Admin}--
function Fusion_MenuStaffAdmin()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Home_Menu', {
        title = FuS_Lang["HomepageTitle"],
        align = FuS_Config.PositionMenu,
        elements = { 
            {label = FuS_Lang["ManagePlayer"], value = "fusion_manage_player"},
            {label = FuS_Lang["PersonalMenu"], value = 'fusion_personal_menu'},
            {label = FuS_Lang["AnnounceMenu"], value = 'fusion_announce_menu'},
            {label = FuS_Lang["VehicleMenu"], value = 'fusion_vehicle_menu'},
            {label = FuS_Lang["VarsTitle"], value = 'fusion_vars_menu'}
        }
    }, function(data, menu)

        local Fusion_Development = data.current.value 

        -- Manage Player -- 
        if Fusion_Development == 'fusion_manage_player' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_SubMenu_ManagePlayer', {
                title = FuS_Lang["ManagePlayer_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["ManagePlayer_List"], value = "fusion_lista_player"},
                    {label = FuS_Lang["ManagePlayer_All"], value = 'fusion_all_player'}
                }

            }, function(data1, menu1)

                local Fusion_Development2 = data1.current.value 

                if Fusion_Development2 == 'fusion_lista_player' then
                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckListPlayer", function(elements)
                        if elements ~= nil then
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Lista_Player', {
                                title = FuS_Lang["ManagePlayer_Title"],
                                align = FuS_Config.PositionMenu,
                                elements = elements

                            }, function(datalista, menulista)
                                if datalista.current.value ~= nil then
                                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Lista_Player_SubMenu', {
                                        title = FuS_Lang["ManagePlayer_Title"],
                                        align = FuS_Config.PositionMenu,
                                        elements = {
                                            {label = FuS_Lang["ListPlayer_ManageSection"], value = "fusion_manage_section"},
                                            {label = FuS_Lang["ListPlayer_ReviverSection"], value = 'fusion_reviver_section'}, 
                                            {label = FuS_Lang["ListPlayer_BanSection"], value = 'fusion_ban_player'},
                                            {label = FuS_Lang["ListPlayer_TeleportSection"], value = 'fusion_teleport_menu'},
                                            {label = FuS_Lang["ListPlayer_MutesSection"], value = 'fusion_mute_player'},
                                            {label = FuS_Lang["ListPlayer_GiveSection"], value = 'fusion_give_player'},
                                            {label = FuS_Lang["ListPlayer_SettingSection"], value = 'fusion_setting_player'},
                                            {label = FuS_Lang["WipePlayer"], value = 'fusion_wipe_player'}
                                        }

                                    }, function(datalista2, menulista2)

                                        local Fusion_Development3 = datalista2.current.value 

                                        -- Menu Gestione -- 
                                        if Fusion_Development3 == 'fusion_manage_section' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Menu_Manage_Player_Option', {
                                                title = FuS_Lang["ManagePlayer_Title"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["FusionCheck"], value = "fusion_check_player"},
                                                    {label = FuS_Lang["FusionScreenshot"], value = "fusion_screenshot_player"},
                                                    {label = FuS_Lang["FusionOpenInventory"], value = 'fusion_open_inventory'},
                                                    {label = FuS_Lang["FusionSpect"], value = "fusion_spect_player"},
                                                    {label = FuS_Lang["FusionFreeze"], value = "fusion_freeze_player"},
                                                    {label = FuS_Lang["FusionKill"], value = "fusion_kill_player"}
                                                }

                                            }, function(dad, mam)

                                                local Fusion_Development10 = dad.current.value 

                                                -- Check Player --
                                                if Fusion_Development10 == 'fusion_check_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('Fusion_Check'..' '..ID)

                                                -- Screenshot Player --
                                                elseif Fusion_Development10 == 'fusion_screenshot_player' then
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('screen'..' '..ID)

                                                -- Open Inventory Player -- 
                                                elseif Fusion_Development10 == 'fusion_open_inventory' then 
                                                    local ID = datalista.current.value 
                                                    if FuS_Config.UseOxInventory then 
                                                        ExecuteCommand('viewinv'..' '..ID)
                                                    else
                                                        ExecuteCommand(FuS_Config.Commands.OpenInventory..' '..ID)
                                                    end

                                                -- Spect Player -- 
                                                elseif Fusion_Development10 == 'fusion_spect_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('spect'..' '..ID)

                                                -- Freeze Player -- 
                                                elseif Fusion_Development10 == 'fusion_freeze_player' then 
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('freeze'..' '..ID)

                                                -- Kill Player --- 
                                                elseif Fusion_Development10 == 'fusion_kill_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('kill'..' '..ID)

                                                end
                                            
                                            end, function(dad, mam)
                                                mam.close()
                                            end)

                                        -- Menu Ban -- 
                                        elseif Fusion_Development3 == 'fusion_ban_player' then    
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fusion_ban_player', {
                                                title = FuS_Lang["ListPlayer_BanSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["BanSection_OneHourBan"], value = '1h'},
                                                    {label = FuS_Lang["BanSection_ThreeHourBan"], value = '3h'},
                                                    {label = FuS_Lang["BanSection_SixHourBan"], value = '6h'},
                                                    {label = FuS_Lang["BanSection_TwelveHourBan"], value = '12h'},
                                                    {label = FuS_Lang["BanSection_OneDayBan"], value = '1g'},
                                                    {label = FuS_Lang["BanSection_TwoDayBan"], value = '2g'},
                                                    {label = FuS_Lang["BanSection_ThreeDayBan"], value = '3g'},
                                                    {label = FuS_Lang["BanSection_FourDayBan"], value = '4g'},
                                                    {label = FuS_Lang["BanSection_FiveDayBan"], value = '5g'},
                                                    {label = FuS_Lang["BanSection_SixDayBan"], value = '6g'},
                                                    {label = FuS_Lang["BanSection_WeekBan"], value = '1s'},
                                                    {label = FuS_Lang["BanSection_OneMonthBan"], value = '1m'},
                                                    {label = FuS_Lang["BanSection_PermaBan"], value = 'perma'}
                                                }

                                            }, function(datalista3, menulista3)

                                                local Fusion_Development4 = datalista3.current.value 


                                                -- Ban 1 Ora --
                                                if Fusion_Development4 == '1h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''
            
                                                    }, function(data_input, menu_input)
            
                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end

                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 3 Ore --
                                                elseif Fusion_Development4 == '3h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_3H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 6 Ore --
                                                elseif Fusion_Development2 == '6h' then 
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_6H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 12 Ore --
                                                elseif Fusion_Development2 == '12h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_12H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Giorno --
                                                elseif Fusion_Development2 == '1g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 2 Giorni --
                                                elseif Fusion_Development2 == '2g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_2G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 3 Giorni --
                                                elseif Fusion_Development2 == '3g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_3G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 4 Giorni --
                                                elseif Fusion_Development2 == '4g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_4G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 5 Giorni --
                                                elseif Fusion_Development2 == '5g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_5G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 6 Giorni --
                                                elseif Fusion_Development2 == '6g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_6G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Settimana --
                                                elseif Fusion_Development2 == '1s' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1S', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Mese --
                                                elseif Fusion_Development2 == '1m' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1M', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Perma Ban --
                                                elseif Fusion_Development2 == 'perma' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_perma', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)
                                                end
                                            
                                            end, function(datalista3, menulista3)
                                                menulista3.close()
                                            end)

                                        -- Menu Teleports -- 
                                        elseif Fusion_Development3 == 'fusion_teleport_menu' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Teleports', {
                                                title = FuS_Lang["ListPlayer_TeleportSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["TeleportSection_TpToPlayer"], value = 'fusion_tp_to_player'},
                                                    {label = FuS_Lang["TeleportSection_TpToYouPlayer"], value = 'fusion_bring_to_you_player'}
                                                }
            
                                            }, function(databello, menubello)
            
                                                local Fusion_Development3 = databello.current.value 
            
                                                if Fusion_Development3 == 'fusion_tp_to_player' then
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('goto'.." "..ID)
                                                elseif Fusion_Development3 == 'fusion_bring_to_you_player' then 
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('bring'.." "..ID)
                                                end
                                            end, function(databello, menubello)
                                                menubello.close()
                                            end)

                                        -- Menu Mutes -- 
                                        elseif Fusion_Development3 == 'fusion_mute_player' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Mute', {
                                                title = FuS_Lang["ListPlayer_MutesSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["MutesSection_MutePlayer"], value = 'fusion_mute_player'},
                                                    {label = FuS_Lang["MutesSection_UnmutePlayer"], value = 'fusion_unmute_player'}
                                                }
            
                                            }, function(databello2, menubello2)
            
                                                local Fusion_Development4 = databello2.current.value 
            
                                                if Fusion_Development4 == 'fusion_mute_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('muta'.." "..ID)
                                                elseif Fusion_Development4 == 'fusion_unmute_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('smuta'.." "..ID)
                                                end
                                            end, function(databello2, menubello2) 
                                                menubello2.close()
                                            end)

                                        -- Menu Gives --
                                        elseif Fusion_Development3 == 'fusion_give_player' then
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_GiveSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["GiveSection_GiveBankMoney"], value = "fusion_give_bank_money"},
                                                    {label = FuS_Lang["GiveSection_GiveDirtyMoney"], value = "fusion_give_dirty_money"},
                                                    {label = FuS_Lang["GiveSection_GiveItem"], value = "fusion_give_item"},
                                                    {label = FuS_Lang["GiveSection_GiveVehicle"], value = 'fusion_give_vehicle_to_player'}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development6 = datata.current.value
            
                                                -- Give Bank -- 
                                                if Fusion_Development6 == 'fusion_give_bank_money' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteQuantity"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local ID = datalista.current.value 
                                                            local Quantity = d1_input.value
                                                            ExecuteCommand(FuS_Config.Commands.GiveAccountMoney..' '..ID..' bank '..Quantity)
                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedBankMoney"])})
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end)
                                            
                                                -- Give Dirty --
                                                elseif Fusion_Development6 == 'fusion_give_dirty_money' then  
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteQuantity"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local ID = datalista.current.value 
                                                            local Quantity = d1_input.value
                                                            ExecuteCommand(FuS_Config.Commands.GiveAccountMoney..' '..ID..' black_money '..Quantity)            
                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedDirtyMoney"])})                               
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end) 
                                                    
                                                -- Give Item -- 
                                                elseif Fusion_Development6 == 'fusion_give_item' then   
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteItem"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local Item = d1_input.value  
                                                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_2', {
                                                                title = FuS_Lang["WriteQuantity"],
                                                                default = ""
                                                            }, function(d1_input, m1_input)
        
                                                                if d1_input.value == nil then
                                                                    m1_input.close()
                                                                else
                                                                    m1_input.close()
                                                                    local ID = datalista.current.value 
                                                                    local Quantity = d1_input.value
                                                                    ExecuteCommand(FuS_Config.Commands.GiveItem..' '..ID..' '..Item..' '..Quantity)
                                                                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedItem"])})
                                                                end
                                                            
                                                            end, function(d1_input, m1_input)
                                                                m1_input.close()
                                                            end) 
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end) 

                                                -- Give Vehicle -- 
                                                elseif Fusion_Development6 == 'fusion_give_vehicle_to_player' then 
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_Veicolo', {
                                                        title = FuS_Lang["WriteModel"],
                                                        default = ""

                                                    }, function(d1, m1)

                                                        if d1.value == nil then
                                                            m1.close()
                                                        else
                                                            m1.close()
                                                            local ID = datalista.current.value 
                                                            local Modello = d1.value 
                                                            local coords = GetEntityCoords(GetPlayerPed(-1))
                                                            ESX.Game.SpawnVehicle(d1.value, coords, 200, function(vehicle)
                                                                SetEntityAsMissionEntity(vehicle, true, true)
                                                                SetVehicleOnGroundProperly(vehicle)
                                                                NetworkFadeInEntity(vehicle, true, true)
                                                                SetModelAsNoLongerNeeded(d1.value)
                                                                TriggerServerEvent("FuS_AdminMenu:GiveVehicle", ID, ESX.Game.GetVehicleProperties(vehicle))
                                                                Citizen.Wait(1000)
                                                                DeleteVehicle(vehicle)
                                                            end)
                                                            
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end)

                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)

                                        -- Menu Give -- 
                                        elseif Fusion_Development3 == 'fusion_setting_player' then
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_SettingSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["SettingSection_SetJob"], value = "fusion_setjob1_player"}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development13 = datata.current.value
            
                                                if Fusion_Development13 == 'fusion_setjob1_player' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option', {
                                                        title = FuS_Lang["WriteID"],
                                                        default = ""

                                                    }, function(datajob_input, menujob_input)

                                                        if datajob_input.value == nil then
                                                            menujob_input.close()
                                                        else
                                                            menujob_input.close()
                                                            local ID = datajob_input.value 
                                                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option_JobName', {
                                                                title = FuS_Lang["WriteNameJob1"],
                                                                default = ""

                                                            }, function(datajob2_input, menujob2_input)

                                                                if datajob2_input.value == nil then
                                                                    menujob2_input.close()
                                                                else
                                                                    menujob2_input.close()
                                                                    local NomeJob = datajob2_input.value 
                                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option_JobGrade', {
                                                                        title = FuS_Lang["WriteGradeJob1"],
                                                                        default = ""

                                                                    }, function(datajob3_input, menujob3_input)

                                                                        if datajob3_input.value == nil then
                                                                            menujob3_input.close()
                                                                        else
                                                                            local GradeJob = datajob3_input.value 
                                                                            ESX.UI.Menu.CloseAll()
                                                                            ExecuteCommand('setjob'..' '..ID..' '..NomeJob..' '..GradeJob)
                                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["SettingSection_JobSetted"])})
                                                                        end
                                                                    
                                                                    end, function(datajob3_input, menujob3_input)
                                                                        menujob3_input.close()
                                                                    end)
                                                                end
                                                            
                                                            end, function(datajob2_input, menujob2_input)
                                                                menujob2_input.close()
                                                            end)
                                                        end
                                                    
                                                    end, function(datajob_input, menujob_input)
                                                        menujob_input.close()
                                                    end)
                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)

                                        -- Wipe Player -- 
                                        elseif Fusion_Development3 == 'fusion_wipe_player' then 
                                            local ID = datalista.current.value 
                                            TriggerServerEvent("FuS_AdminMenu:WipePlayer", ID)

                                        -- Menu Reviver -- 
                                        elseif Fusion_Development3 == 'fusion_reviver_section' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_ReviverSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["ReviverSection_HealPlayer"], value = "fusion_give_heal"},
                                                    {label = FuS_Lang["ReviverSection_RevivePlayer"], value = "fusion_give_revive"},
                                                    {label = FuS_Lang["ReviverSection_GiveArmour"], value = "fusion_give_armour"}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development6 = datata.current.value
            
                                                if Fusion_Development6 == 'fusion_give_heal' then  
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('heal'..' '..ID) 
                                                elseif Fusion_Development6 == 'fusion_give_revive' then   
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('rianima'..' '..ID)
                                                elseif Fusion_Development6 == 'fusion_give_player' then   
                                                    local ID = datalista.current.value 
                                                    SetPedArmour(PlayerPedId(ID), 100)
                                                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["ReviverSection_ArmourGived"])})
                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)
                                        end
                                    
                                    end, function(datalista2, menulista2)
                                        menulista2.close()
                                    end)
                                end
                            end, function(datalista, menulista)
                                menulista.close()
                            end)
                        end
                    end)
                -- All Player Options -- 
                elseif Fusion_Development2 == 'fusion_all_player' then 
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_All_Options', {
                        title = FuS_Lang["ManagePlayer_All"],
                        align = FuS_Config.PositionMenu,
                        elements = {
                            {label = FuS_Lang["AllPlayerSection_BringAll"], value = "fusion_all_player_bring"},
                            {label = FuS_Lang["AllPlayerSection_KickAll"], value = "fusion_all_player_kick"},
                            {label = FuS_Lang["AllPlayerSection_ReviveAllPlayer"], value = "fusion_reviveall_player"},
                        }

                    }, function(datal9, menul9)

                        local Fusion_Development7 = datal9.current.value 

                        if Fusion_Development7 == 'fusion_all_player_bring' then
                            ExecuteCommand('bringatutti')
                        elseif Fusion_Development7 == 'fusion_all_player_kick' then 
                            ExecuteCommand('kickatutti')
                        elseif Fusion_Development7 == 'fusion_reviveall_player' then   
                            ExecuteCommand('rianimatutti')
                        end
                    
                    end, function(datal9, menul9)
                        menul9.close()
                    end)

                    
                end
            
            end, function(data1, menu1)
                menu1.close()
            end)

        -- Personale -- 
        elseif Fusion_Development == 'fusion_personal_menu' then  
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_AdminMenu_Personal', {
                title = FuS_Lang["PersonalMenu"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["PersonalSection_NoClip"], value = "fusion_admin_no_clip"},
                    {label = FuS_Lang["PersonalSection_NoClipV2"], value = "fusion_admin_no_clipv2"},
                    {label = FuS_Lang["PersonalSection_Godmode"], value = "fusion_admin_godmode"},
                    {label = FuS_Lang["PersonalSection_Invisible"], value = "fusion_admin_invisible"},
                    {label = FuS_Lang["PersonalSection_ChangeAspect"], value = "fusion_admin_change_aspect"}
                }

            }, function(dd, mm)

                local Fusion_Development8 = dd.current.value 

                -- No CLip -- 
                if Fusion_Development8 == 'fusion_admin_no_clip' then 
                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
                            playernoclip() 
                        end
                    end)

                -- NoClip V2 --
                elseif Fusion_Development8 == 'fusion_admin_no_clipv2' then
                    ExecuteCommand('noclipv2')

                -- GodMode -- 
                elseif Fusion_Development8 == 'fusion_admin_godmode' then
                    Fusion_Godmode_Func()

                -- Invisible -- 
                elseif Fusion_Development8 == 'fusion_admin_invisible' then
                    Fusion_Invisible_Func()
                    
                -- Change Aspect -- 
                elseif Fusion_Development8 == 'fusion_admin_change_aspect' then
                    Fusion_ChangeAspect_Func()
                    
                end
            
            end, function(dd, mm)
                mm.close()
            end)

        -- Annunci -- 
        elseif Fusion_Development == 'fusion_announce_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Menu_Annunci_Option', {
                title = FuS_Lang["AnnounceSection_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["AnnounceSection_AnnounceOnScreen"], value = 'fusion_annuncio_on_screen'},
                    {label = FuS_Lang["AnnounceSection_AnnounceOnMinimap"], value = 'fusion_annuncio_on_minimap'},
                    {label = FuS_Lang["AnnounceSection_AnnouceRestart"], value = 'fusion_annuncio_restart'},
                    {label = FuS_Lang["AnnounceSection_AnnounceEvent"], value = 'fusion_annuncio_event'}
                }

            }, function(dataye, menuye)

                local Fusion_Development9 = dataye.current.value 

                if Fusion_Development9 == 'fusion_annuncio_on_screen' then
                    ESX.UI.Menu.CloseAll()

                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSchermo', {
                        title = FuS_Lang["WriteMessage"],
                        default = ""

                    }, function(d_input, m_input)
                        if d_input == nil then 
                            m_input.close()
                        else
                            m_input.close()
                            local announcestring = d_input.value 
                            ExecuteCommand('FuS_Announce'..' '..announcestring)
                        end
                    end, function(d_input, m_input)
                        m_input.close()
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_on_minimap' then
                    ESX.UI.Menu.CloseAll()

                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSopra_Minimappa', {
                                title = FuS_Lang["WriteMessage"],
                                default = ""

                            }, function(data_input, menu_input)
                                if data_input == nil then 
                                    menu_input.close()
                                else
                                    menu_input.close()
                                    local mex = data_input.value 
                                    TriggerServerEvent("FuS_AdminMenu:AnnuncioSopraMinimappa", mex)
                                end

                            end, function(data_input, menu_input)
                                menu_input.close() 
                            end)
                        else
                            exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["NoPermission"])})
                        end
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_restart' then
                    ESX.UI.Menu.CloseAll()

                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSchermo', {
                        title = FuS_Lang["WriteMinutes"],
                        default = ""

                    }, function(d2_input, m2_input)
                        if d2_input == nil then 
                            m2_input.close()
                        else
                            m2_input.close()
                            local minuti = d2_input.value
                            local announcestring = FuS_Lang["AnnounceSection_RestartOn"]..' '..minuti..' '..FuS_Lang["AnnounceSection_Minutes"]
                            ExecuteCommand('FuS_Announce'..' '..announcestring)
                        end
                    end, function(d2_input, m2_input)
                        m2_input.close()
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_event' then
                    ESX.UI.Menu.CloseAll()

                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSopra_Minimappa_Evento', {
                                title = FuS_Lang["WriteMessage"],
                                default = ""

                            }, function(data2_input, menu2_input)
                                if data2_input == nil then 
                                    menu2_input.close()
                                else
                                    menu2_input.close()
                                    local messaggioevento = data2_input.value 
                                    TriggerServerEvent("FuS_AdminMenu:AnnuncioSopraMinimappaEvento", messaggioevento)
                                end

                            end, function(data2_input, menu2_input)
                                menu2_input.close() 
                            end)
                        else
                            exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["NoPermission"])})
                        end
                    end)
                end
            
            end, function(dataye, menuye)
                menuye.close()
            end)

        -- Vehicles --
        elseif Fusion_Development == 'fusion_vehicle_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Vehicle_Menu_Option', {
                title = FuS_Lang["VehicleSection_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["VehicleSection_SpawnVehicle"], value = "fusion_spawn_vehicle"},
                    {label = FuS_Lang["VehicleSection_DeleteVehicle"], value = "fusion_delete_vehicle"},
                    {label = FuS_Lang["VehicleSection_RepairVehicle"], value = "fusion_repair_vehicle"},
                    {label = FuS_Lang["VehicleSection_CleanVehicle"], value = 'fusion_clean_vehicle'},
                    {label = FuS_Lang["VehicleSection_FlipVehicle"], value = "fusion_flip_vehicle"},
                    {label = FuS_Lang["VehicleSection_FullkitVehicle"], value = "fusion_fullkit_vehicle"}
                }

            }, function(datav, menuv)

                local Fusion_Development11 = datav.current.value 

                -- Spawn -- 
                if Fusion_Development11 == 'fusion_spawn_vehicle' then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Spawn_Vehicle_Option', {
                        title = FuS_Lang["VehicleSection_TypeModel"],
                        default = ""

                    }, function(dio_input, mdio_input)

                        if dio_input.value == nil or dio_input.value == "" then
                            mdio_input.close()
                        else
                            mdio_input.close()
                            TriggerEvent("esx:spawnVehicle", dio_input.value)
                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleSpawned"])})
                        end
                    
                    end, function(dio_input, mdio_input)
                        mdio_input.close()
                    end)

                -- Delete -- 
                elseif Fusion_Development11 == 'fusion_delete_vehicle' then 
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        TriggerEvent("esx:deleteVehicle")
                    else
                        exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["VehicleSection_YourNotInVehicle"])})
                    end

                -- Repair --
                elseif Fusion_Development11 == 'fusion_repair_vehicle' then 
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        SetVehicleFixed(GetVehiclePedIsUsing(PlayerPedId()))	
                        SetVehicleDirtLevel(GetVehiclePedIsUsing(PlayerPedId()),0)
                    else
                        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleRepaired"])})
                    end

                -- Clean -- 
                elseif Fusion_Development11 == 'fusion_clean_vehicle' then
                    local playerPed = PlayerPedId() 
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    SetVehicleDirtLevel(vehicle, 0)
                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleCleaned"])})

                -- Flip -- 
                elseif Fusion_Development11 == 'fusion_flip_vehicle' then 
                    local player = PlayerPedId()
                    local posmenu = GetEntityCoords(player)
                    local carTarget = GetClosestVehicle(posmenu['x'], posmenu['y'], posmenu['z'], 10.0, 0, 70)
                    SetPedIntoVehicle(player, carTarget, -1)
                    Citizen.Wait(100)
                    ClearPedTask(player)
                    Citizen.Wait(100)
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    playerCoords = playerCoords + vector3(0, 2, 0)
                    SetEntityCoords(carTarget, playerCoords)
                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleFlipped"])})
                
                -- Fullkit -- 
                elseif Fusion_Development11 == 'fusion_fullkit_vehicle' then 
                    Fusion_FullkitVehicle()
                end
            
            end, function(datav, menuv)
                menuv.close()
            end)

        -- Vars Menu -- 
        elseif Fusion_Development == 'fusion_vars_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Home_Vars_Menu', {
                title = FuS_Lang["VarsTitle"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["VarsSection_ClearChat"], value = "fusion_clearchat_option"},
                    {label = FuS_Lang["VarsSection_NamePlayer"], value = "fusion_nameplayer_option"},
                    {label = FuS_Lang["VarsSection_BlipPlayer"], value = "fusion_blipplayer_option"},
                    {label = FuS_Lang["VarsSection_ClearAllVehicles"], value = "fusion_clearallvehicles_option"},
                    {label = FuS_Lang["VarsSection_ClearAllObj"], value = "fusion_clearallobj_option"},
                    {label = FuS_Lang["VarsSection_ClearAllPed"], value = "fusion_clearallped_option"}
                }
            }, function(days, mays)

                local Fusion_Development12 = days.current.value 

                if Fusion_Development12 == 'fusion_clearchat_option' then
                    ExecuteCommand(FuS_Config.Commands.ClearChat)
                elseif Fusion_Development12 == 'fusion_nameplayer_option' then
                    Fusion_NamesPlayer()
                elseif Fusion_Development12 == 'fusion_blipplayer_option' then
                    Fusion_BlipsPlayer()
                elseif Fusion_Development12 == 'fusion_clearallvehicles_option' then
                    Fusion_ClearallVeh()
                elseif Fusion_Development12 == 'fusion_clearallobj_option' then
                    Fusion_ClearallObj()
                elseif Fusion_Development12 == 'fusion_clearallped_option' then
                    Fusion_ClearallPed()
                --elseif Fusion_Development12 == '' then
                end
            
            end, function(days, mays)
                mays.close()
            end)
        end
    
    end, function(data, menu)
        menu.close()
    end)
end

--{Menu Staff Mod}--
function Fusion_MenuStaffMod()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Home_Menu', {
        title = FuS_Lang["HomepageTitle"],
        align = FuS_Config.PositionMenu,
        elements = { 
            {label = FuS_Lang["ManagePlayer"], value = "fusion_manage_player"},
            {label = FuS_Lang["PersonalMenu"], value = 'fusion_personal_menu'},
            --{label = FuS_Lang["AnnounceMenu"], value = 'fusion_announce_menu'},
            {label = FuS_Lang["VehicleMenu"], value = 'fusion_vehicle_menu'},
            {label = FuS_Lang["VarsTitle"], value = 'fusion_vars_menu'}
        }
    }, function(data, menu)

        local Fusion_Development = data.current.value 

        -- Manage Player -- 
        if Fusion_Development == 'fusion_manage_player' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_SubMenu_ManagePlayer', {
                title = FuS_Lang["ManagePlayer_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["ManagePlayer_List"], value = "fusion_lista_player"},
                    {label = FuS_Lang["ManagePlayer_All"], value = 'fusion_all_player'}
                }

            }, function(data1, menu1)

                local Fusion_Development2 = data1.current.value 

                if Fusion_Development2 == 'fusion_lista_player' then
                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckListPlayer", function(elements)
                        if elements ~= nil then
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Lista_Player', {
                                title = FuS_Lang["ManagePlayer_Title"],
                                align = FuS_Config.PositionMenu,
                                elements = elements

                            }, function(datalista, menulista)
                                if datalista.current.value ~= nil then
                                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Lista_Player_SubMenu', {
                                        title = FuS_Lang["ManagePlayer_Title"],
                                        align = FuS_Config.PositionMenu,
                                        elements = {
                                            {label = FuS_Lang["ListPlayer_ManageSection"], value = "fusion_manage_section"},
                                            {label = FuS_Lang["ListPlayer_ReviverSection"], value = 'fusion_reviver_section'}, 
                                            {label = FuS_Lang["ListPlayer_BanSection"], value = 'fusion_ban_player'},
                                            {label = FuS_Lang["ListPlayer_TeleportSection"], value = 'fusion_teleport_menu'},
                                            {label = FuS_Lang["ListPlayer_MutesSection"], value = 'fusion_mute_player'},
                                            --{label = FuS_Lang["ListPlayer_GiveSection"], value = 'fusion_give_player'},
                                            {label = FuS_Lang["ListPlayer_SettingSection"], value = 'fusion_setting_player'}
                                            --{label = FuS_Lang["WipePlayer"], value = 'fusion_wipe_player'}
                                        }

                                    }, function(datalista2, menulista2)

                                        local Fusion_Development3 = datalista2.current.value 

                                        -- Menu Gestione -- 
                                        if Fusion_Development3 == 'fusion_manage_section' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Menu_Manage_Player_Option', {
                                                title = FuS_Lang["ManagePlayer_Title"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["FusionCheck"], value = "fusion_check_player"},
                                                    {label = FuS_Lang["FusionScreenshot"], value = "fusion_screenshot_player"},
                                                    {label = FuS_Lang["FusionOpenInventory"], value = 'fusion_open_inventory'},
                                                    {label = FuS_Lang["FusionSpect"], value = "fusion_spect_player"},
                                                    {label = FuS_Lang["FusionFreeze"], value = "fusion_freeze_player"},
                                                    {label = FuS_Lang["FusionKill"], value = "fusion_kill_player"}
                                                }

                                            }, function(dad, mam)

                                                local Fusion_Development10 = dad.current.value 

                                                -- Check Player --
                                                if Fusion_Development10 == 'fusion_check_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('Fusion_Check'..' '..ID)

                                                -- Screenshot Player --
                                                elseif Fusion_Development10 == 'fusion_screenshot_player' then
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('screen'..' '..ID)

                                                -- Open Inventory Player -- 
                                                elseif Fusion_Development10 == 'fusion_open_inventory' then 
                                                    local ID = datalista.current.value 
                                                    if FuS_Config.UseOxInventory then 
                                                        ExecuteCommand('viewinv'..' '..ID)
                                                    else
                                                        ExecuteCommand(FuS_Config.Commands.OpenInventory..' '..ID)
                                                    end

                                                -- Spect Player -- 
                                                elseif Fusion_Development10 == 'fusion_spect_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('spect'..' '..ID)

                                                -- Freeze Player -- 
                                                elseif Fusion_Development10 == 'fusion_freeze_player' then 
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('freeze'..' '..ID)

                                                -- Kill Player --- 
                                                elseif Fusion_Development10 == 'fusion_kill_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('kill'..' '..ID)

                                                end
                                            
                                            end, function(dad, mam)
                                                mam.close()
                                            end)

                                        -- Menu Ban -- 
                                        elseif Fusion_Development3 == 'fusion_ban_player' then    
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fusion_ban_player', {
                                                title = FuS_Lang["ListPlayer_BanSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["BanSection_OneHourBan"], value = '1h'},
                                                    {label = FuS_Lang["BanSection_ThreeHourBan"], value = '3h'},
                                                    {label = FuS_Lang["BanSection_SixHourBan"], value = '6h'},
                                                    {label = FuS_Lang["BanSection_TwelveHourBan"], value = '12h'},
                                                    {label = FuS_Lang["BanSection_OneDayBan"], value = '1g'},
                                                    {label = FuS_Lang["BanSection_TwoDayBan"], value = '2g'},
                                                    {label = FuS_Lang["BanSection_ThreeDayBan"], value = '3g'},
                                                    {label = FuS_Lang["BanSection_FourDayBan"], value = '4g'},
                                                    {label = FuS_Lang["BanSection_FiveDayBan"], value = '5g'},
                                                    {label = FuS_Lang["BanSection_SixDayBan"], value = '6g'},
                                                    {label = FuS_Lang["BanSection_WeekBan"], value = '1s'},
                                                    {label = FuS_Lang["BanSection_OneMonthBan"], value = '1m'},
                                                    {label = FuS_Lang["BanSection_PermaBan"], value = 'perma'}
                                                }

                                            }, function(datalista3, menulista3)

                                                local Fusion_Development4 = datalista3.current.value 

                                                -- Ban 1 Ora --
                                                if Fusion_Development4 == '1h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''
            
                                                    }, function(data_input, menu_input)
            
                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end

                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 3 Ore --
                                                elseif Fusion_Development4 == '3h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_3H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 6 Ore --
                                                elseif Fusion_Development2 == '6h' then 
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_6H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 12 Ore --
                                                elseif Fusion_Development2 == '12h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_12H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Giorno --
                                                elseif Fusion_Development2 == '1g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 2 Giorni --
                                                elseif Fusion_Development2 == '2g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_2G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 3 Giorni --
                                                elseif Fusion_Development2 == '3g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_3G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 4 Giorni --
                                                elseif Fusion_Development2 == '4g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_4G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 5 Giorni --
                                                elseif Fusion_Development2 == '5g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_5G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 6 Giorni --
                                                elseif Fusion_Development2 == '6g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_6G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Settimana --
                                                elseif Fusion_Development2 == '1s' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1S', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Mese --
                                                elseif Fusion_Development2 == '1m' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1M', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Perma Ban --
                                                elseif Fusion_Development2 == 'perma' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_perma', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)
                                                end
                                            
                                            end, function(datalista3, menulista3)
                                                menulista3.close()
                                            end)

                                        -- Menu Teleports -- 
                                        elseif Fusion_Development3 == 'fusion_teleport_menu' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Teleports', {
                                                title = FuS_Lang["ListPlayer_TeleportSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["TeleportSection_TpToPlayer"], value = 'fusion_tp_to_player'},
                                                    {label = FuS_Lang["TeleportSection_TpToYouPlayer"], value = 'fusion_bring_to_you_player'}
                                                }
            
                                            }, function(databello, menubello)
            
                                                local Fusion_Development3 = databello.current.value 
            
                                                if Fusion_Development3 == 'fusion_tp_to_player' then
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('goto'.." "..ID)
                                                elseif Fusion_Development3 == 'fusion_bring_to_you_player' then 
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('bring'.." "..ID)
                                                end
                                            end, function(databello, menubello)
                                                menubello.close()
                                            end)

                                        -- Menu Mutes -- 
                                        elseif Fusion_Development3 == 'fusion_mute_player' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Mute', {
                                                title = FuS_Lang["ListPlayer_MutesSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["MutesSection_MutePlayer"], value = 'fusion_mute_player'},
                                                    {label = FuS_Lang["MutesSection_UnmutePlayer"], value = 'fusion_unmute_player'}
                                                }
            
                                            }, function(databello2, menubello2)
            
                                                local Fusion_Development4 = databello2.current.value 
            
                                                if Fusion_Development4 == 'fusion_mute_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('muta'.." "..ID)
                                                elseif Fusion_Development4 == 'fusion_unmute_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('smuta'.." "..ID)
                                                end
                                            end, function(databello2, menubello2) 
                                                menubello2.close()
                                            end)

                                        -- Menu Gives --
                                        elseif Fusion_Development3 == 'fusion_give_player' then
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_GiveSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["GiveSection_GiveBankMoney"], value = "fusion_give_bank_money"},
                                                    {label = FuS_Lang["GiveSection_GiveDirtyMoney"], value = "fusion_give_dirty_money"},
                                                    {label = FuS_Lang["GiveSection_GiveItem"], value = "fusion_give_item"},
                                                    {label = FuS_Lang["GiveSection_GiveVehicle"], value = 'fusion_give_vehicle_to_player'}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development6 = datata.current.value
            
                                                -- Give Bank -- 
                                                if Fusion_Development6 == 'fusion_give_bank_money' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteQuantity"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local ID = datalista.current.value 
                                                            local Quantity = d1_input.value
                                                            ExecuteCommand(FuS_Config.Commands.GiveAccountMoney..' '..ID..' bank '..Quantity)
                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedBankMoney"])})
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end)
                                            
                                                -- Give Dirty --
                                                elseif Fusion_Development6 == 'fusion_give_dirty_money' then  
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteQuantity"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local ID = datalista.current.value 
                                                            local Quantity = d1_input.value
                                                            ExecuteCommand(FuS_Config.Commands.GiveAccountMoney..' '..ID..' black_money '..Quantity)            
                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedDirtyMoney"])})                               
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end) 
                                                    
                                                -- Give Item -- 
                                                elseif Fusion_Development6 == 'fusion_give_item' then   
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteItem"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local Item = d1_input.value  
                                                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_2', {
                                                                title = FuS_Lang["WriteQuantity"],
                                                                default = ""
                                                            }, function(d1_input, m1_input)
        
                                                                if d1_input.value == nil then
                                                                    m1_input.close()
                                                                else
                                                                    m1_input.close()
                                                                    local ID = datalista.current.value 
                                                                    local Quantity = d1_input.value
                                                                    ExecuteCommand(FuS_Config.Commands.GiveItem..' '..ID..' '..Item..' '..Quantity)
                                                                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedItem"])})
                                                                end
                                                            
                                                            end, function(d1_input, m1_input)
                                                                m1_input.close()
                                                            end) 
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end) 

                                                -- Give Vehicle -- 
                                                elseif Fusion_Development6 == 'fusion_give_vehicle_to_player' then 
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_Veicolo', {
                                                        title = FuS_Lang["WriteModel"],
                                                        default = ""

                                                    }, function(d1, m1)

                                                        if d1.value == nil then
                                                            m1.close()
                                                        else
                                                            m1.close()
                                                            local ID = datalista.current.value 
                                                            local Modello = d1.value 
                                                            local coords = GetEntityCoords(GetPlayerPed(-1))
                                                            ESX.Game.SpawnVehicle(d1.value, coords, 200, function(vehicle)
                                                                SetEntityAsMissionEntity(vehicle, true, true)
                                                                SetVehicleOnGroundProperly(vehicle)
                                                                NetworkFadeInEntity(vehicle, true, true)
                                                                SetModelAsNoLongerNeeded(d1.value)
                                                                TriggerServerEvent("FuS_AdminMenu:GiveVehicle", ID, ESX.Game.GetVehicleProperties(vehicle))
                                                                Citizen.Wait(1000)
                                                                DeleteVehicle(vehicle)
                                                            end)
                                                            
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end)

                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)

                                        -- Menu Give -- 
                                        elseif Fusion_Development3 == 'fusion_setting_player' then
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_SettingSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["SettingSection_SetJob"], value = "fusion_setjob1_player"}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development13 = datata.current.value
            
                                                if Fusion_Development13 == 'fusion_setjob1_player' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option', {
                                                        title = FuS_Lang["WriteID"],
                                                        default = ""

                                                    }, function(datajob_input, menujob_input)

                                                        if datajob_input.value == nil then
                                                            menujob_input.close()
                                                        else
                                                            menujob_input.close()
                                                            local ID = datajob_input.value 
                                                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option_JobName', {
                                                                title = FuS_Lang["WriteNameJob1"],
                                                                default = ""

                                                            }, function(datajob2_input, menujob2_input)

                                                                if datajob2_input.value == nil then
                                                                    menujob2_input.close()
                                                                else
                                                                    menujob2_input.close()
                                                                    local NomeJob = datajob2_input.value 
                                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option_JobGrade', {
                                                                        title = FuS_Lang["WriteGradeJob1"],
                                                                        default = ""

                                                                    }, function(datajob3_input, menujob3_input)

                                                                        if datajob3_input.value == nil then
                                                                            menujob3_input.close()
                                                                        else
                                                                            local GradeJob = datajob3_input.value 
                                                                            ESX.UI.Menu.CloseAll()
                                                                            ExecuteCommand('setjob'..' '..ID..' '..NomeJob..' '..GradeJob)
                                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["SettingSection_JobSetted"])})
                                                                        end
                                                                    
                                                                    end, function(datajob3_input, menujob3_input)
                                                                        menujob3_input.close()
                                                                    end)
                                                                end
                                                            
                                                            end, function(datajob2_input, menujob2_input)
                                                                menujob2_input.close()
                                                            end)
                                                        end
                                                    
                                                    end, function(datajob_input, menujob_input)
                                                        menujob_input.close()
                                                    end)
                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)

                                        -- Wipe Player -- 
                                        elseif Fusion_Development3 == 'fusion_wipe_player' then 
                                            local ID = datalista.current.value 
                                            TriggerServerEvent("FuS_AdminMenu:WipePlayer", ID)

                                        -- Menu Reviver -- 
                                        elseif Fusion_Development3 == 'fusion_reviver_section' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_ReviverSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["ReviverSection_HealPlayer"], value = "fusion_give_heal"},
                                                    {label = FuS_Lang["ReviverSection_RevivePlayer"], value = "fusion_give_revive"},
                                                    {label = FuS_Lang["ReviverSection_GiveArmour"], value = "fusion_give_armour"}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development6 = datata.current.value
            
                                                if Fusion_Development6 == 'fusion_give_heal' then  
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('heal'..' '..ID) 
                                                elseif Fusion_Development6 == 'fusion_give_revive' then   
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('rianima'..' '..ID)
                                                elseif Fusion_Development6 == 'fusion_give_player' then   
                                                    local ID = datalista.current.value 
                                                    SetPedArmour(PlayerPedId(ID), 100)
                                                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["ReviverSection_ArmourGived"])})
                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)
                                        end
                                    
                                    end, function(datalista2, menulista2)
                                        menulista2.close()
                                    end)
                                end
                            end, function(datalista, menulista)
                                menulista.close()
                            end)
                        end
                    end)
                -- All Player Options -- 
                elseif Fusion_Development2 == 'fusion_all_player' then 
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_All_Options', {
                        title = FuS_Lang["ManagePlayer_All"],
                        align = FuS_Config.PositionMenu,
                        elements = {
                            {label = FuS_Lang["AllPlayerSection_BringAll"], value = "fusion_all_player_bring"},
                            {label = FuS_Lang["AllPlayerSection_KickAll"], value = "fusion_all_player_kick"},
                            {label = FuS_Lang["AllPlayerSection_ReviveAllPlayer"], value = "fusion_reviveall_player"},
                        }

                    }, function(datal9, menul9)

                        local Fusion_Development7 = datal9.current.value 

                        if Fusion_Development7 == 'fusion_all_player_bring' then
                            ExecuteCommand('bringatutti')
                        elseif Fusion_Development7 == 'fusion_all_player_kick' then 
                            ExecuteCommand('kickatutti')
                        elseif Fusion_Development7 == 'fusion_reviveall_player' then   
                            ExecuteCommand('rianimatutti')
                        end
                    
                    end, function(datal9, menul9)
                        menul9.close()
                    end)

                    
                end
            
            end, function(data1, menu1)
                menu1.close()
            end)

        -- Personale -- 
        elseif Fusion_Development == 'fusion_personal_menu' then  
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_AdminMenu_Personal', {
                title = FuS_Lang["PersonalMenu"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["PersonalSection_NoClip"], value = "fusion_admin_no_clip"},
                    {label = FuS_Lang["PersonalSection_NoClipV2"], value = "fusion_admin_no_clipv2"},
                    {label = FuS_Lang["PersonalSection_Godmode"], value = "fusion_admin_godmode"},
                    {label = FuS_Lang["PersonalSection_Invisible"], value = "fusion_admin_invisible"},
                    {label = FuS_Lang["PersonalSection_ChangeAspect"], value = "fusion_admin_change_aspect"}
                }

            }, function(dd, mm)

                local Fusion_Development8 = dd.current.value 

                -- No CLip -- 
                if Fusion_Development8 == 'fusion_admin_no_clip' then 
                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
                            playernoclip() 
                        end
                    end)

                -- NoClip V2 --
                elseif Fusion_Development8 == 'fusion_admin_no_clipv2' then
                    ExecuteCommand('noclipv2')

                -- GodMode -- 
                elseif Fusion_Development8 == 'fusion_admin_godmode' then
                    Fusion_Godmode_Func()

                -- Invisible -- 
                elseif Fusion_Development8 == 'fusion_admin_invisible' then
                    Fusion_Invisible_Func()
                    
                -- Change Aspect -- 
                elseif Fusion_Development8 == 'fusion_admin_change_aspect' then
                    Fusion_ChangeAspect_Func()
                    
                end
            
            end, function(dd, mm)
                mm.close()
            end)

        -- Annunci -- 
        elseif Fusion_Development == 'fusion_announce_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Menu_Annunci_Option', {
                title = FuS_Lang["AnnounceSection_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["AnnounceSection_AnnounceOnScreen"], value = 'fusion_annuncio_on_screen'},
                    {label = FuS_Lang["AnnounceSection_AnnounceOnMinimap"], value = 'fusion_annuncio_on_minimap'},
                    {label = FuS_Lang["AnnounceSection_AnnouceRestart"], value = 'fusion_annuncio_restart'},
                    {label = FuS_Lang["AnnounceSection_AnnounceEvent"], value = 'fusion_annuncio_event'}
                }

            }, function(dataye, menuye)

                local Fusion_Development9 = dataye.current.value 

                if Fusion_Development9 == 'fusion_annuncio_on_screen' then
                    ESX.UI.Menu.CloseAll()

                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSchermo', {
                        title = FuS_Lang["WriteMessage"],
                        default = ""

                    }, function(d_input, m_input)
                        if d_input == nil then 
                            m_input.close()
                        else
                            m_input.close()
                            local announcestring = d_input.value 
                            ExecuteCommand('FuS_Announce'..' '..announcestring)
                        end
                    end, function(d_input, m_input)
                        m_input.close()
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_on_minimap' then
                    ESX.UI.Menu.CloseAll()

                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSopra_Minimappa', {
                                title = FuS_Lang["WriteMessage"],
                                default = ""

                            }, function(data_input, menu_input)
                                if data_input == nil then 
                                    menu_input.close()
                                else
                                    menu_input.close()
                                    local mex = data_input.value 
                                    TriggerServerEvent("FuS_AdminMenu:AnnuncioSopraMinimappa", mex)
                                end

                            end, function(data_input, menu_input)
                                menu_input.close() 
                            end)
                        else
                            exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["NoPermission"])})
                        end
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_restart' then
                    ESX.UI.Menu.CloseAll()

                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSchermo', {
                        title = FuS_Lang["WriteMinutes"],
                        default = ""

                    }, function(d2_input, m2_input)
                        if d2_input == nil then 
                            m2_input.close()
                        else
                            m2_input.close()
                            local minuti = d2_input.value
                            local announcestring = FuS_Lang["AnnounceSection_RestartOn"]..' '..minuti..' '..FuS_Lang["AnnounceSection_Minutes"]
                            ExecuteCommand('FuS_Announce'..' '..announcestring)
                        end
                    end, function(d2_input, m2_input)
                        m2_input.close()
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_event' then
                    ESX.UI.Menu.CloseAll()

                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSopra_Minimappa_Evento', {
                                title = FuS_Lang["WriteMessage"],
                                default = ""

                            }, function(data2_input, menu2_input)
                                if data2_input == nil then 
                                    menu2_input.close()
                                else
                                    menu2_input.close()
                                    local messaggioevento = data2_input.value 
                                    TriggerServerEvent("FuS_AdminMenu:AnnuncioSopraMinimappaEvento", messaggioevento)
                                end

                            end, function(data2_input, menu2_input)
                                menu2_input.close() 
                            end)
                        else
                            exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["NoPermission"])})
                        end
                    end)
                end
            
            end, function(dataye, menuye)
                menuye.close()
            end)

        -- Vehicles --
        elseif Fusion_Development == 'fusion_vehicle_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Vehicle_Menu_Option', {
                title = FuS_Lang["VehicleSection_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["VehicleSection_SpawnVehicle"], value = "fusion_spawn_vehicle"},
                    {label = FuS_Lang["VehicleSection_DeleteVehicle"], value = "fusion_delete_vehicle"},
                    {label = FuS_Lang["VehicleSection_RepairVehicle"], value = "fusion_repair_vehicle"},
                    {label = FuS_Lang["VehicleSection_CleanVehicle"], value = 'fusion_clean_vehicle'},
                    {label = FuS_Lang["VehicleSection_FlipVehicle"], value = "fusion_flip_vehicle"},
                    {label = FuS_Lang["VehicleSection_FullkitVehicle"], value = "fusion_fullkit_vehicle"}
                }

            }, function(datav, menuv)

                local Fusion_Development11 = datav.current.value 

                -- Spawn -- 
                if Fusion_Development11 == 'fusion_spawn_vehicle' then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Spawn_Vehicle_Option', {
                        title = FuS_Lang["VehicleSection_TypeModel"],
                        default = ""

                    }, function(dio_input, mdio_input)

                        if dio_input.value == nil or dio_input.value == "" then
                            mdio_input.close()
                        else
                            mdio_input.close()
                            TriggerEvent("esx:spawnVehicle", dio_input.value)
                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleSpawned"])})
                        end
                    
                    end, function(dio_input, mdio_input)
                        mdio_input.close()
                    end)

                -- Delete -- 
                elseif Fusion_Development11 == 'fusion_delete_vehicle' then 
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        TriggerEvent("esx:deleteVehicle")
                    else
                        exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["VehicleSection_YourNotInVehicle"])})
                    end

                -- Repair --
                elseif Fusion_Development11 == 'fusion_repair_vehicle' then 
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        SetVehicleFixed(GetVehiclePedIsUsing(PlayerPedId()))	
                        SetVehicleDirtLevel(GetVehiclePedIsUsing(PlayerPedId()),0)
                    else
                        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleRepaired"])})
                    end

                -- Clean -- 
                elseif Fusion_Development11 == 'fusion_clean_vehicle' then
                    local playerPed = PlayerPedId() 
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    SetVehicleDirtLevel(vehicle, 0)
                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleCleaned"])})

                -- Flip -- 
                elseif Fusion_Development11 == 'fusion_flip_vehicle' then 
                    local player = PlayerPedId()
                    local posmenu = GetEntityCoords(player)
                    local carTarget = GetClosestVehicle(posmenu['x'], posmenu['y'], posmenu['z'], 10.0, 0, 70)
                    SetPedIntoVehicle(player, carTarget, -1)
                    Citizen.Wait(100)
                    ClearPedTask(player)
                    Citizen.Wait(100)
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    playerCoords = playerCoords + vector3(0, 2, 0)
                    SetEntityCoords(carTarget, playerCoords)
                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleFlipped"])})
                
                -- Fullkit -- 
                elseif Fusion_Development11 == 'fusion_fullkit_vehicle' then 
                    Fusion_FullkitVehicle()
                end
            
            end, function(datav, menuv)
                menuv.close()
            end)

        -- Vars Menu -- 
        elseif Fusion_Development == 'fusion_vars_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Home_Vars_Menu', {
                title = FuS_Lang["VarsTitle"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["VarsSection_ClearChat"], value = "fusion_clearchat_option"},
                    {label = FuS_Lang["VarsSection_NamePlayer"], value = "fusion_nameplayer_option"},
                    {label = FuS_Lang["VarsSection_BlipPlayer"], value = "fusion_blipplayer_option"}
                    --{label = FuS_Lang["VarsSection_ClearAllVehicles"], value = "fusion_clearallvehicles_option"},
                    --{label = FuS_Lang["VarsSection_ClearAllObj"], value = "fusion_clearallobj_option"},
                    --{label = FuS_Lang["VarsSection_ClearAllPed"], value = "fusion_clearallped_option"}
                }
            }, function(days, mays)

                local Fusion_Development12 = days.current.value 

                if Fusion_Development12 == 'fusion_clearchat_option' then
                    ExecuteCommand(FuS_Config.Commands.ClearChat)
                elseif Fusion_Development12 == 'fusion_nameplayer_option' then
                    Fusion_NamesPlayer()
                elseif Fusion_Development12 == 'fusion_blipplayer_option' then
                    Fusion_BlipsPlayer()
                elseif Fusion_Development12 == 'fusion_clearallvehicles_option' then
                    Fusion_ClearallVeh()
                elseif Fusion_Development12 == 'fusion_clearallobj_option' then
                    Fusion_ClearallObj()
                elseif Fusion_Development12 == 'fusion_clearallped_option' then
                    Fusion_ClearallPed()
                --elseif Fusion_Development12 == '' then
                end
            
            end, function(days, mays)
                mays.close()
            end)
        end
    
    end, function(data, menu)
        menu.close()
    end)
end

--{Menu Staff Helper}--
function Fusion_MenuStaffHelper()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Home_Menu', {
        title = FuS_Lang["HomepageTitle"],
        align = FuS_Config.PositionMenu,
        elements = { 
            {label = FuS_Lang["ManagePlayer"], value = "fusion_manage_player"},
            {label = FuS_Lang["PersonalMenu"], value = 'fusion_personal_menu'},
            --{label = FuS_Lang["AnnounceMenu"], value = 'fusion_announce_menu'},
            {label = FuS_Lang["VehicleMenu"], value = 'fusion_vehicle_menu'},
            {label = FuS_Lang["VarsTitle"], value = 'fusion_vars_menu'}
        }
    }, function(data, menu)

        local Fusion_Development = data.current.value 

        -- Manage Player -- 
        if Fusion_Development == 'fusion_manage_player' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_SubMenu_ManagePlayer', {
                title = FuS_Lang["ManagePlayer_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["ManagePlayer_List"], value = "fusion_lista_player"},
                    {label = FuS_Lang["ManagePlayer_All"], value = 'fusion_all_player'}
                }

            }, function(data1, menu1)

                local Fusion_Development2 = data1.current.value 

                if Fusion_Development2 == 'fusion_lista_player' then
                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckListPlayer", function(elements)
                        if elements ~= nil then
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Lista_Player', {
                                title = FuS_Lang["ManagePlayer_Title"],
                                align = FuS_Config.PositionMenu,
                                elements = elements

                            }, function(datalista, menulista)
                                if datalista.current.value ~= nil then
                                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Lista_Player_SubMenu', {
                                        title = FuS_Lang["ManagePlayer_Title"],
                                        align = FuS_Config.PositionMenu,
                                        elements = {
                                            {label = FuS_Lang["ListPlayer_ManageSection"], value = "fusion_manage_section"},
                                            {label = FuS_Lang["ListPlayer_ReviverSection"], value = 'fusion_reviver_section'}, 
                                            {label = FuS_Lang["ListPlayer_BanSection"], value = 'fusion_ban_player'},
                                            {label = FuS_Lang["ListPlayer_TeleportSection"], value = 'fusion_teleport_menu'},
                                            {label = FuS_Lang["ListPlayer_MutesSection"], value = 'fusion_mute_player'}
                                            --{label = FuS_Lang["ListPlayer_GiveSection"], value = 'fusion_give_player'},
                                            --{label = FuS_Lang["ListPlayer_SettingSection"], value = 'fusion_setting_player'},
                                            --{label = FuS_Lang["WipePlayer"], value = 'fusion_wipe_player'}
                                        }

                                    }, function(datalista2, menulista2)

                                        local Fusion_Development3 = datalista2.current.value 

                                        -- Menu Gestione -- 
                                        if Fusion_Development3 == 'fusion_manage_section' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Menu_Manage_Player_Option', {
                                                title = FuS_Lang["ManagePlayer_Title"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["FusionCheck"], value = "fusion_check_player"},
                                                    --{label = FuS_Lang["FusionScreenshot"], value = "fusion_screenshot_player"},
                                                    {label = FuS_Lang["FusionOpenInventory"], value = 'fusion_open_inventory'},
                                                    {label = FuS_Lang["FusionSpect"], value = "fusion_spect_player"},
                                                    {label = FuS_Lang["FusionFreeze"], value = "fusion_freeze_player"},
                                                    {label = FuS_Lang["FusionKill"], value = "fusion_kill_player"}
                                                }

                                            }, function(dad, mam)

                                                local Fusion_Development10 = dad.current.value 

                                                -- Check Player --
                                                if Fusion_Development10 == 'fusion_check_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('Fusion_Check'..' '..ID)

                                                -- Screenshot Player --
                                                elseif Fusion_Development10 == 'fusion_screenshot_player' then
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('screen'..' '..ID)

                                                -- Open Inventory Player -- 
                                                elseif Fusion_Development10 == 'fusion_open_inventory' then 
                                                    local ID = datalista.current.value 
                                                    if FuS_Config.UseOxInventory then 
                                                        ExecuteCommand('viewinv'..' '..ID)
                                                    else
                                                        ExecuteCommand(FuS_Config.Commands.OpenInventory..' '..ID)
                                                    end

                                                -- Spect Player -- 
                                                elseif Fusion_Development10 == 'fusion_spect_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('spect'..' '..ID)

                                                -- Freeze Player -- 
                                                elseif Fusion_Development10 == 'fusion_freeze_player' then 
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('freeze'..' '..ID)

                                                -- Kill Player --- 
                                                elseif Fusion_Development10 == 'fusion_kill_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('kill'..' '..ID)

                                                end
                                            
                                            end, function(dad, mam)
                                                mam.close()
                                            end)

                                        -- Menu Ban -- 
                                        elseif Fusion_Development3 == 'fusion_ban_player' then    
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fusion_ban_player', {
                                                title = FuS_Lang["ListPlayer_BanSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["BanSection_OneHourBan"], value = '1h'},
                                                    {label = FuS_Lang["BanSection_ThreeHourBan"], value = '3h'},
                                                    {label = FuS_Lang["BanSection_SixHourBan"], value = '6h'},
                                                    {label = FuS_Lang["BanSection_TwelveHourBan"], value = '12h'},
                                                    {label = FuS_Lang["BanSection_OneDayBan"], value = '1g'},
                                                    {label = FuS_Lang["BanSection_TwoDayBan"], value = '2g'},
                                                    {label = FuS_Lang["BanSection_ThreeDayBan"], value = '3g'},
                                                    {label = FuS_Lang["BanSection_FourDayBan"], value = '4g'},
                                                    {label = FuS_Lang["BanSection_FiveDayBan"], value = '5g'},
                                                    {label = FuS_Lang["BanSection_SixDayBan"], value = '6g'},
                                                    {label = FuS_Lang["BanSection_WeekBan"], value = '1s'},
                                                    {label = FuS_Lang["BanSection_OneMonthBan"], value = '1m'}
                                                    --{label = FuS_Lang["BanSection_PermaBan"], value = 'perma'}
                                                }

                                            }, function(datalista3, menulista3)

                                                local Fusion_Development4 = datalista3.current.value 

                                                -- Ban 1 Ora --
                                                if Fusion_Development4 == '1h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''
            
                                                    }, function(data_input, menu_input)
            
                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end

                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 3 Ore --
                                                elseif Fusion_Development4 == '3h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_3H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 6 Ore --
                                                elseif Fusion_Development2 == '6h' then 
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_6H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 12 Ore --
                                                elseif Fusion_Development2 == '12h' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_12H', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Giorno --
                                                elseif Fusion_Development2 == '1g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 2 Giorni --
                                                elseif Fusion_Development2 == '2g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_2G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 3 Giorni --
                                                elseif Fusion_Development2 == '3g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_3G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 4 Giorni --
                                                elseif Fusion_Development2 == '4g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_4G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 5 Giorni --
                                                elseif Fusion_Development2 == '5g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_5G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 6 Giorni --
                                                elseif Fusion_Development2 == '6g' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_6G', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Settimana --
                                                elseif Fusion_Development2 == '1s' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1S', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Ban 1 Mese --
                                                elseif Fusion_Development2 == '1m' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_1M', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)

                                                -- Perma Ban --
                                                elseif Fusion_Development2 == 'perma' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Ban_perma', {
                                                        title = FuS_Lang["BanSection_MotivationBan"],
                                                        default = ''

                                                    }, function(data_input, menu_input)

                                                        if data_input.value == nil or data_input.value == '' then
                                                            menu_input.close()
                                                        else
                                                            local ID = datalista.current.value 
                                                            local Value = datalista3.current.value
                                                            local motivoban = data_input.value
                                                            TriggerServerEvent("FuS_AdminMenu:AnimationVideo", "", ID, motivoban)
                                                            ESX.UI.Menu.CloseAll()
                                                            Citizen.Wait(11000)
                                                            TriggerServerEvent("FuS_AdminMenu:BanEvent",ID,motivoban,Value)
                                                        end
                                                    
                                                    end, function(data_input, menu_input)
                                                        menu_input.close()
                                                    end)
                                                end
                                            
                                            end, function(datalista3, menulista3)
                                                menulista3.close()
                                            end)

                                        -- Menu Teleports -- 
                                        elseif Fusion_Development3 == 'fusion_teleport_menu' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Teleports', {
                                                title = FuS_Lang["ListPlayer_TeleportSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["TeleportSection_TpToPlayer"], value = 'fusion_tp_to_player'},
                                                    {label = FuS_Lang["TeleportSection_TpToYouPlayer"], value = 'fusion_bring_to_you_player'}
                                                }
            
                                            }, function(databello, menubello)
            
                                                local Fusion_Development3 = databello.current.value 
            
                                                if Fusion_Development3 == 'fusion_tp_to_player' then
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('goto'.." "..ID)
                                                elseif Fusion_Development3 == 'fusion_bring_to_you_player' then 
                                                    local ID = datalista.current.value
                                                    ExecuteCommand('bring'.." "..ID)
                                                end
                                            end, function(databello, menubello)
                                                menubello.close()
                                            end)

                                        -- Menu Mutes -- 
                                        elseif Fusion_Development3 == 'fusion_mute_player' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Mute', {
                                                title = FuS_Lang["ListPlayer_MutesSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["MutesSection_MutePlayer"], value = 'fusion_mute_player'},
                                                    {label = FuS_Lang["MutesSection_UnmutePlayer"], value = 'fusion_unmute_player'}
                                                }
            
                                            }, function(databello2, menubello2)
            
                                                local Fusion_Development4 = databello2.current.value 
            
                                                if Fusion_Development4 == 'fusion_mute_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('muta'.." "..ID)
                                                elseif Fusion_Development4 == 'fusion_unmute_player' then
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('smuta'.." "..ID)
                                                end
                                            end, function(databello2, menubello2) 
                                                menubello2.close()
                                            end)

                                        -- Menu Gives --
                                        elseif Fusion_Development3 == 'fusion_give_player' then
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_GiveSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["GiveSection_GiveBankMoney"], value = "fusion_give_bank_money"},
                                                    {label = FuS_Lang["GiveSection_GiveDirtyMoney"], value = "fusion_give_dirty_money"},
                                                    {label = FuS_Lang["GiveSection_GiveItem"], value = "fusion_give_item"},
                                                    {label = FuS_Lang["GiveSection_GiveVehicle"], value = 'fusion_give_vehicle_to_player'}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development6 = datata.current.value
            
                                                -- Give Bank -- 
                                                if Fusion_Development6 == 'fusion_give_bank_money' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteQuantity"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local ID = datalista.current.value 
                                                            local Quantity = d1_input.value
                                                            ExecuteCommand(FuS_Config.Commands.GiveAccountMoney..' '..ID..' bank '..Quantity)
                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedBankMoney"])})
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end)
                                            
                                                -- Give Dirty --
                                                elseif Fusion_Development6 == 'fusion_give_dirty_money' then  
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteQuantity"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local ID = datalista.current.value 
                                                            local Quantity = d1_input.value
                                                            ExecuteCommand(FuS_Config.Commands.GiveAccountMoney..' '..ID..' black_money '..Quantity)            
                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedDirtyMoney"])})                               
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end) 
                                                    
                                                -- Give Item -- 
                                                elseif Fusion_Development6 == 'fusion_give_item' then   
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_1', {
                                                        title = FuS_Lang["WriteItem"],
                                                        default = ""
                                                    }, function(d1_input, m1_input)

                                                        if d1_input.value == nil then
                                                            m1_input.close()
                                                        else
                                                            m1_input.close()
                                                            local Item = d1_input.value  
                                                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_2', {
                                                                title = FuS_Lang["WriteQuantity"],
                                                                default = ""
                                                            }, function(d1_input, m1_input)
        
                                                                if d1_input.value == nil then
                                                                    m1_input.close()
                                                                else
                                                                    m1_input.close()
                                                                    local ID = datalista.current.value 
                                                                    local Quantity = d1_input.value
                                                                    ExecuteCommand(FuS_Config.Commands.GiveItem..' '..ID..' '..Item..' '..Quantity)
                                                                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["GiveSection_GivvedItem"])})
                                                                end
                                                            
                                                            end, function(d1_input, m1_input)
                                                                m1_input.close()
                                                            end) 
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end) 

                                                -- Give Vehicle -- 
                                                elseif Fusion_Development6 == 'fusion_give_vehicle_to_player' then 
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Menu_Give_Veicolo', {
                                                        title = FuS_Lang["WriteModel"],
                                                        default = ""

                                                    }, function(d1, m1)

                                                        if d1.value == nil then
                                                            m1.close()
                                                        else
                                                            m1.close()
                                                            local ID = datalista.current.value 
                                                            local Modello = d1.value 
                                                            local coords = GetEntityCoords(GetPlayerPed(-1))
                                                            ESX.Game.SpawnVehicle(d1.value, coords, 200, function(vehicle)
                                                                SetEntityAsMissionEntity(vehicle, true, true)
                                                                SetVehicleOnGroundProperly(vehicle)
                                                                NetworkFadeInEntity(vehicle, true, true)
                                                                SetModelAsNoLongerNeeded(d1.value)
                                                                TriggerServerEvent("FuS_AdminMenu:GiveVehicle", ID, ESX.Game.GetVehicleProperties(vehicle))
                                                                Citizen.Wait(1000)
                                                                DeleteVehicle(vehicle)
                                                            end)
                                                            
                                                        end
                                                    
                                                    end, function(d1_input, m1_input)
                                                        m1_input.close()
                                                    end)

                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)

                                        -- Menu Give -- 
                                        elseif Fusion_Development3 == 'fusion_setting_player' then
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_SettingSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["SettingSection_SetJob"], value = "fusion_setjob1_player"}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development13 = datata.current.value
            
                                                if Fusion_Development13 == 'fusion_setjob1_player' then
                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option', {
                                                        title = FuS_Lang["WriteID"],
                                                        default = ""

                                                    }, function(datajob_input, menujob_input)

                                                        if datajob_input.value == nil then
                                                            menujob_input.close()
                                                        else
                                                            menujob_input.close()
                                                            local ID = datajob_input.value 
                                                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option_JobName', {
                                                                title = FuS_Lang["WriteNameJob1"],
                                                                default = ""

                                                            }, function(datajob2_input, menujob2_input)

                                                                if datajob2_input.value == nil then
                                                                    menujob2_input.close()
                                                                else
                                                                    menujob2_input.close()
                                                                    local NomeJob = datajob2_input.value 
                                                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_SetJob1_Option_JobGrade', {
                                                                        title = FuS_Lang["WriteGradeJob1"],
                                                                        default = ""

                                                                    }, function(datajob3_input, menujob3_input)

                                                                        if datajob3_input.value == nil then
                                                                            menujob3_input.close()
                                                                        else
                                                                            local GradeJob = datajob3_input.value 
                                                                            ESX.UI.Menu.CloseAll()
                                                                            ExecuteCommand('setjob'..' '..ID..' '..NomeJob..' '..GradeJob)
                                                                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["SettingSection_JobSetted"])})
                                                                        end
                                                                    
                                                                    end, function(datajob3_input, menujob3_input)
                                                                        menujob3_input.close()
                                                                    end)
                                                                end
                                                            
                                                            end, function(datajob2_input, menujob2_input)
                                                                menujob2_input.close()
                                                            end)
                                                        end
                                                    
                                                    end, function(datajob_input, menujob_input)
                                                        menujob_input.close()
                                                    end)
                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)

                                        -- Wipe Player -- 
                                        elseif Fusion_Development3 == 'fusion_wipe_player' then 
                                            local ID = datalista.current.value 
                                            TriggerServerEvent("FuS_AdminMenu:WipePlayer", ID)

                                        -- Menu Reviver -- 
                                        elseif Fusion_Development3 == 'fusion_reviver_section' then 
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_SubMenu_Option_Give', {
                                                title = FuS_Lang["ListPlayer_ReviverSection"],
                                                align = FuS_Config.PositionMenu,
                                                elements = {
                                                    {label = FuS_Lang["ReviverSection_HealPlayer"], value = "fusion_give_heal"},
                                                    {label = FuS_Lang["ReviverSection_RevivePlayer"], value = "fusion_give_revive"},
                                                    {label = FuS_Lang["ReviverSection_GiveArmour"], value = "fusion_give_armour"}
                                                }
            
                                            }, function(datata, menunu)
            
                                                local Fusion_Development6 = datata.current.value
            
                                                if Fusion_Development6 == 'fusion_give_heal' then  
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('heal'..' '..ID) 
                                                elseif Fusion_Development6 == 'fusion_give_revive' then   
                                                    local ID = datalista.current.value 
                                                    ExecuteCommand('rianima'..' '..ID)
                                                elseif Fusion_Development6 == 'fusion_give_player' then   
                                                    local ID = datalista.current.value 
                                                    SetPedArmour(PlayerPedId(ID), 100)
                                                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["ReviverSection_ArmourGived"])})
                                                end
                                            
                                            end, function(datata, menunu)
                                                menunu.close()
                                            end)
                                        end
                                    
                                    end, function(datalista2, menulista2)
                                        menulista2.close()
                                    end)
                                end
                            end, function(datalista, menulista)
                                menulista.close()
                            end)
                        end
                    end)
                -- All Player Options -- 
                elseif Fusion_Development2 == 'fusion_all_player' then 
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_List_Player_All_Options', {
                        title = FuS_Lang["ManagePlayer_All"],
                        align = FuS_Config.PositionMenu,
                        elements = {
                            {label = FuS_Lang["AllPlayerSection_BringAll"], value = "fusion_all_player_bring"},
                            {label = FuS_Lang["AllPlayerSection_KickAll"], value = "fusion_all_player_kick"},
                            {label = FuS_Lang["AllPlayerSection_ReviveAllPlayer"], value = "fusion_reviveall_player"},
                        }

                    }, function(datal9, menul9)

                        local Fusion_Development7 = datal9.current.value 

                        if Fusion_Development7 == 'fusion_all_player_bring' then
                            ExecuteCommand('bringatutti')
                        elseif Fusion_Development7 == 'fusion_all_player_kick' then 
                            ExecuteCommand('kickatutti')
                        elseif Fusion_Development7 == 'fusion_reviveall_player' then   
                            ExecuteCommand('rianimatutti')
                        end
                    
                    end, function(datal9, menul9)
                        menul9.close()
                    end)

                    
                end
            
            end, function(data1, menu1)
                menu1.close()
            end)

        -- Personale -- 
        elseif Fusion_Development == 'fusion_personal_menu' then  
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_AdminMenu_Personal', {
                title = FuS_Lang["PersonalMenu"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["PersonalSection_NoClip"], value = "fusion_admin_no_clip"},
                    {label = FuS_Lang["PersonalSection_NoClipV2"], value = "fusion_admin_no_clipv2"},
                    {label = FuS_Lang["PersonalSection_Godmode"], value = "fusion_admin_godmode"},
                    {label = FuS_Lang["PersonalSection_Invisible"], value = "fusion_admin_invisible"},
                    {label = FuS_Lang["PersonalSection_ChangeAspect"], value = "fusion_admin_change_aspect"}
                }

            }, function(dd, mm)

                local Fusion_Development8 = dd.current.value 

                -- No CLip -- 
                if Fusion_Development8 == 'fusion_admin_no_clip' then 
                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then
                            playernoclip() 
                        end
                    end)

                -- NoClip V2 --
                elseif Fusion_Development8 == 'fusion_admin_no_clipv2' then
                    ExecuteCommand('noclipv2')

                -- GodMode -- 
                elseif Fusion_Development8 == 'fusion_admin_godmode' then
                    Fusion_Godmode_Func()

                -- Invisible -- 
                elseif Fusion_Development8 == 'fusion_admin_invisible' then
                    Fusion_Invisible_Func()
                    
                -- Change Aspect -- 
                elseif Fusion_Development8 == 'fusion_admin_change_aspect' then
                    Fusion_ChangeAspect_Func()
                    
                end
            
            end, function(dd, mm)
                mm.close()
            end)

        -- Annunci -- 
        elseif Fusion_Development == 'fusion_announce_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Menu_Annunci_Option', {
                title = FuS_Lang["AnnounceSection_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["AnnounceSection_AnnounceOnScreen"], value = 'fusion_annuncio_on_screen'},
                    {label = FuS_Lang["AnnounceSection_AnnounceOnMinimap"], value = 'fusion_annuncio_on_minimap'},
                    {label = FuS_Lang["AnnounceSection_AnnouceRestart"], value = 'fusion_annuncio_restart'},
                    {label = FuS_Lang["AnnounceSection_AnnounceEvent"], value = 'fusion_annuncio_event'}
                }

            }, function(dataye, menuye)

                local Fusion_Development9 = dataye.current.value 

                if Fusion_Development9 == 'fusion_annuncio_on_screen' then
                    ESX.UI.Menu.CloseAll()

                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSchermo', {
                        title = FuS_Lang["WriteMessage"],
                        default = ""

                    }, function(d_input, m_input)
                        if d_input == nil then 
                            m_input.close()
                        else
                            m_input.close()
                            local announcestring = d_input.value 
                            ExecuteCommand('FuS_Announce'..' '..announcestring)
                        end
                    end, function(d_input, m_input)
                        m_input.close()
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_on_minimap' then
                    ESX.UI.Menu.CloseAll()

                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSopra_Minimappa', {
                                title = FuS_Lang["WriteMessage"],
                                default = ""

                            }, function(data_input, menu_input)
                                if data_input == nil then 
                                    menu_input.close()
                                else
                                    menu_input.close()
                                    local mex = data_input.value 
                                    TriggerServerEvent("FuS_AdminMenu:AnnuncioSopraMinimappa", mex)
                                end

                            end, function(data_input, menu_input)
                                menu_input.close() 
                            end)
                        else
                            exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["NoPermission"])})
                        end
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_restart' then
                    ESX.UI.Menu.CloseAll()

                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSchermo', {
                        title = FuS_Lang["WriteMinutes"],
                        default = ""

                    }, function(d2_input, m2_input)
                        if d2_input == nil then 
                            m2_input.close()
                        else
                            m2_input.close()
                            local minuti = d2_input.value
                            local announcestring = FuS_Lang["AnnounceSection_RestartOn"]..' '..minuti..' '..FuS_Lang["AnnounceSection_Minutes"]
                            ExecuteCommand('FuS_Announce'..' '..announcestring)
                        end
                    end, function(d2_input, m2_input)
                        m2_input.close()
                    end)
                elseif Fusion_Development9 == 'fusion_annuncio_event' then
                    ESX.UI.Menu.CloseAll()

                    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
                        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin" or GruppoPlayer == "admin" or GruppoPlayer == "mod" or GruppoPlayer == "helper") then 
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_AdminMenu_AnnuncioSopra_Minimappa_Evento', {
                                title = FuS_Lang["WriteMessage"],
                                default = ""

                            }, function(data2_input, menu2_input)
                                if data2_input == nil then 
                                    menu2_input.close()
                                else
                                    menu2_input.close()
                                    local messaggioevento = data2_input.value 
                                    TriggerServerEvent("FuS_AdminMenu:AnnuncioSopraMinimappaEvento", messaggioevento)
                                end

                            end, function(data2_input, menu2_input)
                                menu2_input.close() 
                            end)
                        else
                            exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["NoPermission"])})
                        end
                    end)
                end
            
            end, function(dataye, menuye)
                menuye.close()
            end)

        -- Vehicles --
        elseif Fusion_Development == 'fusion_vehicle_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Vehicle_Menu_Option', {
                title = FuS_Lang["VehicleSection_Title"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["VehicleSection_SpawnVehicle"], value = "fusion_spawn_vehicle"},
                    {label = FuS_Lang["VehicleSection_DeleteVehicle"], value = "fusion_delete_vehicle"},
                    {label = FuS_Lang["VehicleSection_RepairVehicle"], value = "fusion_repair_vehicle"},
                    {label = FuS_Lang["VehicleSection_CleanVehicle"], value = 'fusion_clean_vehicle'},
                    {label = FuS_Lang["VehicleSection_FlipVehicle"], value = "fusion_flip_vehicle"},
                    {label = FuS_Lang["VehicleSection_FullkitVehicle"], value = "fusion_fullkit_vehicle"}
                }

            }, function(datav, menuv)

                local Fusion_Development11 = datav.current.value 

                -- Spawn -- 
                if Fusion_Development11 == 'fusion_spawn_vehicle' then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Fusion_Spawn_Vehicle_Option', {
                        title = FuS_Lang["VehicleSection_TypeModel"],
                        default = ""

                    }, function(dio_input, mdio_input)

                        if dio_input.value == nil or dio_input.value == "" then
                            mdio_input.close()
                        else
                            mdio_input.close()
                            TriggerEvent("esx:spawnVehicle", dio_input.value)
                            exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleSpawned"])})
                        end
                    
                    end, function(dio_input, mdio_input)
                        mdio_input.close()
                    end)

                -- Delete -- 
                elseif Fusion_Development11 == 'fusion_delete_vehicle' then 
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        TriggerEvent("esx:deleteVehicle")
                    else
                        exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["VehicleSection_YourNotInVehicle"])})
                    end

                -- Repair --
                elseif Fusion_Development11 == 'fusion_repair_vehicle' then 
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        SetVehicleFixed(GetVehiclePedIsUsing(PlayerPedId()))	
                        SetVehicleDirtLevel(GetVehiclePedIsUsing(PlayerPedId()),0)
                    else
                        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleRepaired"])})
                    end

                -- Clean -- 
                elseif Fusion_Development11 == 'fusion_clean_vehicle' then
                    local playerPed = PlayerPedId() 
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    SetVehicleDirtLevel(vehicle, 0)
                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleCleaned"])})

                -- Flip -- 
                elseif Fusion_Development11 == 'fusion_flip_vehicle' then 
                    local player = PlayerPedId()
                    local posmenu = GetEntityCoords(player)
                    local carTarget = GetClosestVehicle(posmenu['x'], posmenu['y'], posmenu['z'], 10.0, 0, 70)
                    SetPedIntoVehicle(player, carTarget, -1)
                    Citizen.Wait(100)
                    ClearPedTask(player)
                    Citizen.Wait(100)
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    playerCoords = playerCoords + vector3(0, 2, 0)
                    SetEntityCoords(carTarget, playerCoords)
                    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleFlipped"])})
                
                -- Fullkit -- 
                elseif Fusion_Development11 == 'fusion_fullkit_vehicle' then 
                    Fusion_FullkitVehicle()
                end
            
            end, function(datav, menuv)
                menuv.close()
            end)

        -- Vars Menu -- 
        elseif Fusion_Development == 'fusion_vars_menu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fusion_Home_Vars_Menu', {
                title = FuS_Lang["VarsTitle"],
                align = FuS_Config.PositionMenu,
                elements = {
                    {label = FuS_Lang["VarsSection_ClearChat"], value = "fusion_clearchat_option"},
                    {label = FuS_Lang["VarsSection_NamePlayer"], value = "fusion_nameplayer_option"},
                    {label = FuS_Lang["VarsSection_BlipPlayer"], value = "fusion_blipplayer_option"},
                    {label = FuS_Lang["VarsSection_ClearAllVehicles"], value = "fusion_clearallvehicles_option"},
                    {label = FuS_Lang["VarsSection_ClearAllObj"], value = "fusion_clearallobj_option"},
                    {label = FuS_Lang["VarsSection_ClearAllPed"], value = "fusion_clearallped_option"}
                }
            }, function(days, mays)

                local Fusion_Development12 = days.current.value 

                if Fusion_Development12 == 'fusion_clearchat_option' then
                    ExecuteCommand(FuS_Config.Commands.ClearChat)
                elseif Fusion_Development12 == 'fusion_nameplayer_option' then
                    Fusion_NamesPlayer()
                elseif Fusion_Development12 == 'fusion_blipplayer_option' then
                    Fusion_BlipsPlayer()
                elseif Fusion_Development12 == 'fusion_clearallvehicles_option' then
                    Fusion_ClearallVeh()
                elseif Fusion_Development12 == 'fusion_clearallobj_option' then
                    Fusion_ClearallObj()
                elseif Fusion_Development12 == 'fusion_clearallped_option' then
                    Fusion_ClearallPed()
                --elseif Fusion_Development12 == '' then
                end
            
            end, function(days, mays)
                mays.close()
            end)
        end
    
    end, function(data, menu)
        menu.close()
    end)
end

-- No Clip Functions -- 
local noclip = false
local noclip_speed = 1

function playernoclip()
	noclip = not noclip
	local ped = PlayerPedId()
	if noclip then 
		SetEntityVisible(ped, false, false)
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["NotifySection_NoClipActive"])})
	else 
		SetEntityVisible(ped, true, false)
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["NotifySection_NoClipDeactive"])})
	end
end

function getPosition()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
	return x,y,z
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)
	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end
	return x,y,z
end

function isNoclip()
	return noclip
end

Citizen.CreateThread(function()
	while true do
        local pincopallino = 60
		--Citizen.Wait(pincopallino)
		if noclip then
			local ped = PlayerPedId()
			local x,y,z = getPosition()
			local dx,dy,dz = getCamDirection()
			local speed = noclip_speed
			SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
		if IsControlPressed(0,32) then -- MOVE UP
            pincopallino = 5
			x = x+speed*dx
			y = y+speed*dy
			z = z+speed*dz
		end
		if IsControlPressed(0,269) then -- MOVE DOWN
            pincopallino = 5
			x = x-speed*dx
			y = y-speed*dy
			z = z-speed*dz
		end
		SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
		end
        Citizen.Wait(pincopallino)
	end
end)

-- Godmode Functions --
local godmodec = true
function Fusion_Godmode_Func()
    godmodec = not godmodec 
    local pPed = PlayerPedId()
    if not godmodec then 
        SetEntityInvincible(pPed, true)
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["NotifySection_GodmodeActive"])})
    else
        SetEntityInvincible(pPed, false)
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["NotifySection_GodmodeDeactive"])})
    end
end

-- Invisible Functions --
local invisible = true 
function Fusion_Invisible_Func() 
    invisible = not invisible 
    local pPed = PlayerPedId()
    if not invisible then 
        SetEntityVisible(pPed, false, false)
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["NotifySection_InvisibleActive"])})
    elseif invisible then 
        SetEntityVisible(pPed, true, false)
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["NotifySection_InvisibleDeactive"])})
    end
end

-- Change Aspect Functions --
function Fusion_ChangeAspect_Func()
    Citizen.Wait(100)
    TriggerEvent(FuS_Config.Triggers.ChangeAspectSkin, source)
end

-- Screenshot SyS -- 
RegisterNetEvent("FuS_AdminMenu:TakeScreen")
AddEventHandler("FuS_AdminMenu:TakeScreen", function()
    exports['screenshot-basic']:requestScreenshotUpload("IP-INSERT", "files[]", function(data)
        local image = json.decode(data)
        local upload = image.files[1].url
        TriggerServerEvent('FuS_AdminMenu:Screenshot',upload)
    end) 
end)

-- Announce SyS -- 
announcestring = false 
lastfor = 10

-- Announce On Screen - Event --
RegisterNetEvent('FuS_AdminMenu:AnnounceOnScreen')
announcestring = false
AddEventHandler('FuS_AdminMenu:AnnounceOnScreen', function(msg)
    announcestring = msg 
    Citizen.Wait(lastfor * 1000)
    announcestring = false 
end)

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do 
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString("~m~| ~g~"..FuS_Lang["NameServer"].." ~m~|")
    PushScaleformMovieFunctionParameterString(announcestring)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

Citizen.CreateThread(function()
    while true do 
        local pincopallino2 = 1500
        if announcestring then 
            pincopallino2 = 5
            scaleform = Initialize("mp_big_message_freemode")
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        end
        Citizen.Wait(pincopallino2)
    end
end)

-- Fullkit Vehicle Functions -- 
function Fusion_FullkitVehicle()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		SetVehicleModKit(vehicle, 0)
		SetVehicleMod(vehicle, 14, 0, true)
		SetVehicleNumberPlateTextIndex(vehicle, 5)
		ToggleVehicleMod(vehicle, 18, true)
		ToggleVehicleMod(vehicle, 22, true)
		SetVehicleMod(vehicle, 23, 11, false)
		SetVehicleMod(vehicle, 24, 11, false)
		SetVehicleWheelType(vehicle, 12) 
		SetVehicleWindowTint(vehicle, 3)
		ToggleVehicleMod(vehicle, 20, true)
		SetVehicleTyreSmokeColor(vehicle, 0, 0, 0)
		LowerConvertibleRoof(vehicle, true)
		SetVehicleIsStolen(vehicle, false)
		SetVehicleIsWanted(vehicle, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetCanResprayVehicle(vehicle, true)
		SetPlayersLastVehicle(vehicle)
		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleTyresCanBurst(vehicle, false)
		SetVehicleWheelsCanBreak(vehicle, false)
		SetVehicleCanBeTargetted(vehicle, false)
		SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
		SetVehicleHasStrongAxles(vehicle, true)
		SetVehicleDirtLevel(vehicle, 0)
		SetVehicleCanBeVisiblyDamaged(vehicle, false)
		IsVehicleDriveable(vehicle, true)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleStrong(vehicle, true)
		RollDownWindow(vehicle, 0)
		RollDownWindow(vehicle, 1)
		SetVehicleNeonLightEnabled(vehicle, 0, true)
		SetVehicleNeonLightEnabled(vehicle, 1, true)
		SetVehicleNeonLightEnabled(vehicle, 2, true)
		SetVehicleNeonLightEnabled(vehicle, 3, true)
		SetVehicleNeonLightsColour(vehicle, 0, 0, 255)
		SetPedCanBeDraggedOut(PlayerPedId(), false)
		SetPedStayInVehicleWhenJacked(PlayerPedId(), true)
		SetPedRagdollOnCollision(PlayerPedId(), false)
		ResetPedVisibleDamage(PlayerPedId())
		ClearPedDecorations(PlayerPedId())
		SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
		for i = 0,14 do
			SetVehicleExtra(veh, i, 0)
		end
		SetVehicleModKit(veh, 0)
		for i = 0,49 do
			local custom = GetNumVehicleMods(veh, i)
			for j = 1,custom do
				SetVehicleMod(veh, i, math.random(1,j), 1)
			end
		end
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VehicleSection_VehicleFullkitted"])})
    else
        exports["zg-notify"]:TriggerNotification({['type'] = "error",['text'] = tostring(FuS_Lang["VehicleSection_YourNotInVehicle"])})
    end
end

-- Nomi Functions -- 
local vedinomi = false 
function Fusion_NamesPlayer()
    vedinomi = not vedinomi 
    if vedinomi then
        vedinomi = true 
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VarsSection_NameActive"])})
    else
        vedinomi = false 
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VarsSection_NameDeactive"])})
    end

    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(1)
            for _, ServerPlayer in ipairs(GetActivePlayers()) do 
                local player = tonumber(ServerPlayer) 
                if GetPlayerPed(player) ~= PlayerPedId() then
                    ped = GetPlayerPed(player)
                    idTesta = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped,"Nome: "..GetPlayerName(player) .. "\nID: ["..GetPlayerServerId(player).."]\n Vita: "..GetEntityHealth(ped), false, false, "", false)
                    if vedinomi then
                        N_0x63bb75abedc1f6a0(idTesta, 9, true)
                    else
                        N_0x63bb75abedc1f6a0(idTesta, 0, false)
                    end

                    if not vedinomi then
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, false)
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 0, false)
                        
                        RemoveMpGamerTag(idTesta)
                        return
                    end
                end
            end
            if not vedinomi then
                return 
            end
        end
    end)
    if not vedinomi then
        return 
    end
end


-- Blip Functions -- 
local mostrablip = false 
function Fusion_BlipsPlayer()
    mostrablip = not mostrablip
    if mostrablip then
        mostrablip = true
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VarsSection_BlipActive"])})
    else
        mostrablip = false
        exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VarsSection_BlipDeactive"])})
    end
    Citizen.CreateThread(function()
        local blips = {}
        while true do
            Citizen.Wait(1)
            for _, ServerPlayer in ipairs(GetActivePlayers()) do
                local player = tonumber(ServerPlayer)
                if GetPlayerPed(player) ~= GetPlayerPed(-1) then
                    ped = GetPlayerPed(player)
                    if mostrablip then
                        RemoveBlip(blips[player])
                        local playerName = GetPlayerName(player)
                        local new_blip = AddBlipForEntity(ped)
                        SetBlipNameToPlayerName(new_blip, player)
                        SetBlipColour(new_blip, 1)
                        SetBlipScale(new_blip, 0.9)

                        blips[player] = new_blip
                    else
                        for blip, v in pairs(blips) do
                            RemoveBlip(v)
                        end
                        isShowingBlips = false
                        return
                    end
                end
            end
            if not mostrablip then 
                return
            end
        end
    end)
    if not mostrablip then 
        return
    end
end

-- Clear Veh -- 
function Fusion_ClearallVeh()
    local Vehicle = 0
    for vehicle in EnumerateVehicles() do
        SetEntityAsMissionEntity(GetVehiclePedIsIn(vehicle, true), 1, 1)
        DeleteEntity(GetVehiclePedIsIn(vehicle, true))
        SetEntityAsMissionEntity(vehicle, 1, 1)
        DeleteEntity(vehicle)
        Vehicle =  Vehicle + 1
    end
    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VarsSection_VehicleCleared"])})
end

-- Clear Obj -- 
function Fusion_ClearallObj()
    local ObJet = 0
    for obj in EnumerateObjects() do
        DeleteEntity(obj)
        ObJet =  ObJet + 1
    end
    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VarsSection_ObjCleared"])})
end

-- Clear Ped -- 
function Fusion_ClearallPed()
    local Ped = 0 
    for ped in EnumeratePeds() do 
        if not (IsPedAPlayer(ped)) then
            RemoveAllPedWeapons(ped, true)
            DeleteEntity(ped)
            Ped = Ped + 1
        end
    end
    exports["zg-notify"]:TriggerNotification({['type'] = "success",['text'] = tostring(FuS_Lang["VarsSection_PedCleared"])})
end

-- Enumerators -- 
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true

		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end

	return nearbyEntities
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

-- Fix Default   
RegisterCommand('fix', function()
    ESX.UI.Menu.CloseAll()
end)

--{Apertura Menu Staff}--
RegisterKeyMapping('_FusionOpen_MenuStaff','Open Menu STAFF','KEYBOARD', FuS_Config.KeybindMenu)
RegisterCommand('_FusionOpen_MenuStaff',function()
    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
        if GruppoPlayer ~= nil and (GruppoPlayer == "superadmin") then
            Fusion_MenuStaffSuperAdmin()
        elseif GruppoPlayer ~= nil and (GruppoPlayer == "admin") then 
            Fusion_MenuStaffAdmin()
        elseif GruppoPlayer ~= nil and (GruppoPlayer == "mod") then 
            Fusion_MenuStaffMod()
        elseif GruppoPlayer ~= nil and (GruppoPlayer == "helper") then 
            Fusion_MenuStaffHelper()
        else
            exports["zg-notify"]:TriggerNotification({['type'] = "error", ['text'] = tostring(FuS_Lang["NoPermission"])})
        end
    end)
end)

--{No Clip Rapido}--        
RegisterKeyMapping('_FusionOpen_MenuStaff_NoClip','NoClip','KEYBOARD', 'PAGEUP')
RegisterCommand('_FusionOpen_MenuStaff_NoClip', function()
    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
        if GruppoPlayer ~= nil and (GruppoPlayer == 'superadmin' or GruppoPlayer == 'admin' or GruppoPlayer == 'mod') then
            playernoclip()
        end
    end)
end)

--{Nomi Rapidi}--        
RegisterKeyMapping('_FusionOpen_MenuStaff_NomiRapidi','Names Player','KEYBOARD', 'F9')
RegisterCommand('_FusionOpen_MenuStaff_NomiRapidi', function()
    ESX.TriggerServerCallback("FuS_AdminMenu:CheckGroupPlayer", function(GruppoPlayer)
        if GruppoPlayer ~= nil and (GruppoPlayer == 'superadmin' or GruppoPlayer == 'admin' or GruppoPlayer == 'mod') then
            Fusion_NamesPlayer()
        end
    end)
end)