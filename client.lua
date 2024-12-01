
CreateThread(function()
    while true do
        Wait(Config.Interval * 1000)
        exports['screenshot-basic']:requestScreenshotUpload(Config.Storage, 'file', {encoding = 'jpg', quality = 1.0}, function(data)
            Wait(1000)
            local resp = json.decode(data)
            TriggerServerEvent('qb-screenshot:Webhook', resp.attachments[1].proxy_url)
        end)
    end
end)
