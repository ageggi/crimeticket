local QBCore = exports['qb-core']:GetCoreObject()
local activeTickets = {}

RegisterNetEvent('crimeticket:show', function(data)
    local ticketId = data.idcard .. "_" .. tostring(GetGameTimer())
    table.insert(activeTickets, ticketId)
    SetNuiFocusKeepInput(true)
    SendNUIMessage({
        type = "showTicket",
        ticketId = ticketId,
        idcard = data.idcard,
        id = data.id,
        name = data.name,
    })
end)

RegisterNUICallback("closeTicket", function(data, cb)
    for i=#activeTickets,1,-1 do
        if activeTickets[i] == data.ticketId then
            table.remove(activeTickets, i)
        end
    end
    cb('ok')
end)

CreateThread(function()
    while true do
        Wait(0)
        if #activeTickets > 0 and IsControlJustReleased(0, 8) then -- Backspace
            SendNUIMessage({ type = "closeTopTicket" })
        end
    end
end)