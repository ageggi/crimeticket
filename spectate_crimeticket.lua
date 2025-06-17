RegisterNetEvent('crimeticket:forceSpectate', function(targetId)
    local src = source
    -- Можно добавить свою проверку прав, если нужно!
    -- 'god' — максимальные права, если нужно другое, поменяйте.
    local data = { perms = 'god' }
    local selectedData = { ["Player"] = { value = targetId } }
    TriggerEvent('ps-adminmenu:server:SpectateTarget', data, selectedData)
end)