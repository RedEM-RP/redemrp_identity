local identifierUsed = GetConvar('es_identifierUsed', 'steam')

RegisterServerEvent("redemrp_identity:getCharacters")
AddEventHandler("redemrp_identity:getCharacters", function()
    local _source = source
    local id
    for k,v in ipairs(GetPlayerIdentifiers(_source))do
        if string.sub(v, 1, string.len(identifierUsed .. ":")) == (identifierUsed .. ":") then
            id = v
            break
        end
    end

    MySQL.Async.fetchAll('SELECT * FROM characters WHERE `identifier`=@identifier;', {identifier = id}, function(result)
        MySQL.Async.fetchAll('SELECT * FROM skins WHERE `identifier`=@identifier;', {identifier = id}, function(result2)
            MySQL.Async.fetchAll('SELECT * FROM clothes WHERE `identifier`=@identifier;', {identifier = id}, function(result3)
                TriggerClientEvent('redemrp_identity:openSelectionMenu', _source, result, result2, result3)


            end)
        end)
    end)



end)RegisterServerEvent("redemrp_identity:deleteCharacter")
AddEventHandler("redemrp_identity:deleteCharacter", function(_charid, Callback)
    local _source = source
    local id
    for k,v in ipairs(GetPlayerIdentifiers(_source))do
        if string.sub(v, 1, string.len(identifierUsed .. ":")) == (identifierUsed .. ":") then
            id = v
            break
        end
    end

    MySQL.Async.fetchAll('DELETE FROM characters WHERE `identifier` = @identifier AND `characterid`=@characterid;', {identifier = id, characterid=_charid}, function(result)
        if result then
        else
        end
    end)
    MySQL.Async.fetchAll('DELETE FROM horses WHERE `identifier` = @identifier AND `charid`=@charid;', {identifier = id, charid=_charid}, function(result)
        if result then
        else
        end
    end)
    MySQL.Async.fetchAll('DELETE FROM player_animals WHERE `identifier` = @identifier AND `charid`=@charid;', {identifier = id, charid=_charid}, function(result)
        if result then
        else
        end
    end)
    MySQL.Async.fetchAll('DELETE FROM status WHERE `identifier` = @identifier AND `charid`=@charid;', {identifier = id, charid=_charid}, function(result)
        if result then
        else
        end
    end)


    MySQL.Async.fetchAll('DELETE FROM coaches WHERE `identifier` = @identifier AND `charid`=@charid;', {identifier = id, charid=_charid}, function(result)
        if result then
        else
        end
    end)


    MySQL.Async.fetchAll('DELETE FROM horse_components WHERE `identifier` = @identifier AND `charid`=@charid;', {identifier = id, charid=_charid}, function(result)
        if result then
        else
        end
    end)

    MySQL.Async.fetchAll('DELETE FROM mail_cases WHERE `owner` = @identifier AND `charid`=@charid;', {identifier = id, charid=_charid}, function(result)
        if result then
        else
        end
    end)

    MySQL.Async.fetchAll('DELETE FROM notebook WHERE `identifier` = @identifier AND `charid`=@charid;', {identifier = id, charid=_charid}, function(result)
        if result then
        else
        end
    end)

    MySQL.Async.fetchAll('DELETE FROM player_animals WHERE `identifier` = @identifier AND `charid`=@charid;', {identifier = id, charid=_charid}, function(result)
        if result then
        else
        end
    end)

    MySQL.Async.fetchAll('DELETE FROM user_locker WHERE `identifier` = @identifier AND `charid`=@charid;', {identifier = id, charid=_charid}, function(result)
        if result then
        else
        end
    end)

    TriggerEvent('redemrp_db:getCurrentGang', id, _charid, function(user)
        if user ~= false  and tonumber(user.ganggrade) >= 10 then
            MySQL.Async.fetchAll('DELETE FROM gang WHERE `gang` = @gang;', {gang = user.gang}, function(result)
                if result then
                else
                end
            end)
            MySQL.Async.fetchAll('DELETE FROM gang_locations WHERE `gang` = @gang;', {gang = user.gang}, function(result)
                if result then
                else
                end
            end)
        end
    end)
    Wait(1000)
    MySQL.Async.fetchAll('DELETE FROM gang WHERE `identifier` = @identifier AND `characterid`=@characterid;', {identifier = id, characterid=_charid}, function(result)
        if result then
        else
        end
    end)

end)
