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

function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

RegisterNetEvent('securitysys:leavemarker')
AddEventHandler('securitysys:leavemarker', function(playerCoords, reason, name)

    if Config.LeaveMarker == true then

        if reason == nil then

            reason = "Disconnect"

        end

        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, playerCoords.x, playerCoords.y, playerCoords.z, true)

        while distance < 20 do

            player = PlayerPedId()
            coords = GetEntityCoords(player)

            distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, playerCoords.x, playerCoords.y, playerCoords.z, true)

            DrawMarker(Config.LeaveMarkerID, playerCoords.x, playerCoords.y, playerCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, Config.LeaveMarkerColor.r, Config.LeaveMarkerColor.g, Config.LeaveMarkerColor.b, 100, false, true, 2, true, false, false, false)

            Draw3DText(playerCoords.x, playerCoords.y, playerCoords.z -0.2, 0.5, name)
            Draw3DText(playerCoords.x, playerCoords.y, playerCoords.z -0.4, 0.5, "Reason: " .. reason)

            Citizen.Wait(0)

        end
    
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

--[[AddEventHandler("onClientResourceStop", function(resource)
    if GetCurrentResourceName() == resource then
        ForceSocialClubUpdate() -----will close fivem process on resource stop
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if GetCurrentResourceName() == resource then
        ForceSocialClubUpdate()-----will close fivem process on resource stop
    end
end)]]