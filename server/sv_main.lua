local identifierUsed = GetConvar('es_identifierUsed', 'steam')

RegisterServerEvent("redemrp_identity:updateName")
AddEventHandler("redemrp_identity:updateName", function(fname, lname)
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        user.setFirstname(tostring(fname))
        user.setLastname(tostring(lname))
    end)
end)

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
	    TriggerClientEvent('redemrp_identity:getCharacters', _source, result)
	end)
end)

RegisterServerEvent("redemrp_identity:deleteCharacter")
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
end)