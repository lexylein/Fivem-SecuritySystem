ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


--start/stop
AddEventHandler('onClientResourceStart', function(ressourceName)
 
    if(GetCurrentResourceName() ~= ressourceName)then
        return
    end
 
end)
 
AddEventHandler('onClientResourceStop', function(ressourceName)
 
    if(GetCurrentResourceName() ~= ressourceName)then
        return
    end
 
end)


--code
function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end

RegisterNetEvent('securitysys:events')
AddEventHandler('securitysys:events', function(type, target, reason)

    if type == 'kick' then

        TriggerServerEvent("securitysys:kick", tonumber(target), reason)
        KickAccount(tonumber(target))

    elseif type == 'ban' then

        BanPlayer(tonumber(source), "[AC]: " .. reason);

    elseif type == 'bantemp' then

        BanPlayer(tonumber(target), "[AC]: " .. reason);

    elseif type == 'unban' then

        reason(tonumber(target))

    elseif type == 'warn' then

        WarnAccount(tonumber(target), reason)

    elseif type == 'unwarn' then

        UnWarnAccount(tonumber(target))

    elseif type == 'blacklist' then

        BlacklisttPlayer(tonumber(target), reason)

    elseif type == 'whitelist' then

        WhitelistPlayer(tonumber(target))

    end

end)

RegisterCommand('sys-kick', function(source, args, rawCommand)

    ESX.TriggerServerCallback("securitysys:getGroup", function(playergroup)

        if Config.Perms[playergroup].CanKick then
    
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'kick_dia', {

                title = _U('dpkick'),
        
            }, function(data, menu)
        
                local target = data.value
        
                if tonumber(target) ~= nill then
            
                    local id = GetPlayerFromServerId(tonumber(target))
                    local ped = GetPlayerPed(id)
        
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'kickreson_dia', {
                        
                        title = _U('dpreson'),
        
                    }, function(data, menu)
        
                        local target2 = data.value
        
                        if target2 ~= nill then
                    
                            local player = PlayerPedId()
                            local reason = target2
        
                            TriggerEvent("securitysys:events", 'kick', id, reason)
                    
                            menu.close()
                    
                        else
                    
                            if Config.use_notify == true then
                    
                                    TriggerEvent('notify:sendMessage', _U('title'), _U('inputresonerror'), 5000, 'error')
                    
                            elseif Config.use_cutom_notify == true then
                    
                                    cutom_notify(_U('title'), _U('inputresonerror'), 'error')
                    
                            else
                    
                                    ShowNotification("~r~" .. _U('inputresonerror'))
                    
                            end
        
                            menu.close()
                    
                            end
        
                    end, function(data, menu)
        
                        menu.close()
        
                    end)
            
                    menu.close()
            
                else
            
                    if Config.use_notify == true then
            
                            TriggerEvent('notify:sendMessage', _U('title'), _U('inputiderror'), 5000, 'error')
            
                    elseif Config.use_cutom_notify == true then
            
                            cutom_notify(_U('title'), _U('inputiderror'), 'error')
            
                    else
            
                            ShowNotification("~r~" .. _U('inputiderror'))
            
                    end
        
                    menu.close()
            
                    end
        
            end, function(data, menu)
        
                menu.close()
        
            end)
    
        else
    
            if Config.use_notify == true then
    
                TriggerEvent('notify:sendMessage', _U('securitysys'), _U('NoPermission'), 5000, 'error')
    
            elseif Config.use_cutom_notify == true then
    
                cutom_notify(_U('securitysys'), _U('NoPermission'))
    
            else
    
                ShowNotification("~r~" .. _U('NoPermission'))
    
            end
    
        end
    
    end)

end)

AddEventHandler("onClientResourceStop", function(resource)
    if GetCurrentResourceName() == resource then
        ForceSocialClubUpdate() -----will close fivem process on resource stop
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if GetCurrentResourceName() == resource then
        ForceSocialClubUpdate()-----will close fivem process on resource stop
    end
end)