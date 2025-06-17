local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand("crimeticket", function(source, _args, _raw)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    for _, id in ipairs(GetPlayers()) do
        local admin = QBCore.Functions.GetPlayer(tonumber(id))
        if admin and QBCore.Functions.HasPermission(admin.PlayerData.source, "god") then
            TriggerClientEvent('crimeticket:notifyAdmin', admin.PlayerData.source, src, GetPlayerName(src))
        end
    end
end, false)