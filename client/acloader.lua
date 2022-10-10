local ProhibitedVariables = {
"fESX", "Plane", "TiagoMenu", "Outcasts666", "dexMenu", "Cience", "LynxEvo", "zzzt", "AKTeam",
"gaybuild", "ariesMenu", "WarMenu", "SwagMenu", "Dopamine", "Gatekeeper", "MIOddhwuie"
}

local Enabled = false
function CheckVariables()
    for i, v in pairs(ProhibitedVariables) do
        if _G[v] ~= nil then
            local reason = Config.Messages.ProhibitedVariables:gsub("{VARIABLE}", v);
            TriggerServerEvent('Anticheat:Modder', "[AC]: " .. reason);
        end
    end
end

if Enabled then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(30000)
            CheckVariables()
        end
    end)
else
    return "Nil"
end
