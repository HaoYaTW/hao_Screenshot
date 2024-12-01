
local QBCore = exports['qb-core']:GetCoreObject()

function discordLog(message, color, p_u)
    PerformHttpRequest(Config.Screenshot, function(err, text, headers) end, 'POST', json.encode({username = Config.Username, embeds = {{["color"] = color, ["image"] = {["url"] = p_u}, ["author"] = {["name"] = Config.TopName,["icon_url"] = Config.TopIcon}, ["description"] = "".. message .."",["footer"] = {["text"] = os.date("%x %X %p"),["icon_url"] = "https://imgur.com/CHOLjZw.png",},}}, avatar_url = Config.BottomIcon}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('qb-screenshot:Webhook', function(pic_u)
    local _source = source
    local pic_url = pic_u
    local Player = QBCore.Functions.GetPlayer(_source)

    if Player then
        local licenseid = Player.PlayerData.license 
        local money = Player.PlayerData.money['cash']
        local bank = Player.PlayerData.money['bank']
        local black = Player.PlayerData.money['black_money'] or 0
        local job = Player.PlayerData.job.name
        local grade = Player.PlayerData.job.grade.level
        local inventory = Player.PlayerData.items

        local ids = ExtractIdentifiers(_source)

        _player = "\n" .. Config.Player .. ": " .. sanitize(GetPlayerName(_source))
        _steamID = "\nSteam ID:  [" .. ids.steam .. "](https://steamcommunity.com/profiles/" .. tonumber(ids.steam:gsub("steam:", ""), 16) .. ")"
        _discordID = "\nDiscord:  <@" .. ids.discord:gsub("discord:", "") .. ">"
        _id = "\nID: " .. _source .. "  人數: " .. GetNumPlayerIndices()
        _money = "\n```現金: " .. money
        _bank = "\n銀行: " .. bank .. "\n黑錢: " .. black
        _job = "\n職業: " .. job .. "  階級" .. grade .. "\n```"
        _license = ids.license ~= "" and "```\nLicense: " .. licenseid or ""
        _inventoryItems = inventory and "\n身上物品: ``` " .. json.encode(inventory) .. "```" or ""

        discordLog(_player .. _steamID .. _discordID .. _id .. _license .. _money .. _bank .. _job .. _inventoryItems, Config.Color, pic_url)
    end
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = "",
        fivem = "",
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "steam") then identifiers.steam = id
        elseif string.find(id, "ip") then identifiers.ip = id
        elseif string.find(id, "discord") then identifiers.discord = id
        elseif string.find(id, "license") then identifiers.license = id
        elseif string.find(id, "xbl") then identifiers.xbl = id
        elseif string.find(id, "live") then identifiers.live = id
        elseif string.find(id, "fivem") then identifiers.fivem = id end
    end

    return identifiers
end

function sanitize(string)
    return string:gsub('@', '')
end

exports('sanitize', function(string)
    sanitize(string)
end)
