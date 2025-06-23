local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('crimeticket', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local idcard = Player.PlayerData.citizenid or "Нет данных"
    local userId = src
    local userName = Player.PlayerData.charinfo and Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname or GetPlayerName(src)

    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local admin = QBCore.Functions.GetPlayer(v)
        if admin and admin.PlayerData and admin.PlayerData.group == "god" then
            TriggerClientEvent('crimeticket:show', admin.PlayerData.source, {
                idcard = idcard,
                id = userId,
                name = userName
            })
        end
    end
end)