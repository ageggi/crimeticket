RegisterNetEvent('crimeticket:notifyAdmin', function(senderSrc, senderName)
    local display = true
    local keyE, keyY = 38, 246 -- E, Y
    local timer = GetGameTimer() + 10000
    local firstShow = true
    local drawY = 0.88

    CreateThread(function()
        while display and GetGameTimer() < timer do
            Wait(0)
            if firstShow then
                PlaySoundFrontend(-1, "SELECT", "HUD_LIQUOR_STORE_SOUNDSET", true)
                firstShow = false
            end

            DrawBottomCenterTextWithBlackStrip(
                ('Крайм-тикет от игрока "%s"\n~g~E~s~ - следить    ~r~Y~s~ - отменить'):format(senderName),
                0.5, drawY, 0.35, 255,255,255,255, 0.92
            )
            if IsControlJustReleased(0, keyE) then
                TriggerServerEvent('ps-adminmenu:forceSpectateSimple', senderSrc)
                display = false
            elseif IsControlJustReleased(0, keyY) then
                display = false
            end
        end
    end)
end)

function DrawBottomCenterTextWithBlackStrip(text, x, y, scale, r, g, b, a, boxAlpha)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextCentre(1)
    SetTextOutline()
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)

    local maxLineLength = 0
    for line in string.gmatch(text, "[^\n]+") do
        if #line > maxLineLength then
            maxLineLength = #line
        end
    end
    local calculatedWidth = 0.015 * maxLineLength + 0.04
    local rectWidth = math.min(calculatedWidth, 0.25)
    local lines = 1
    for _ in string.gmatch(text, "\n") do lines = lines + 1 end
    local rectHeight = 0.038 * lines + 0.011

    DrawRect(x, y + 0.017 * lines, rectWidth, rectHeight, 0, 0, 0, math.floor(255 * boxAlpha))
    DrawText(x, y)
end