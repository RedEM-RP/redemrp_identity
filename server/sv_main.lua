local identifierUsed = GetConvar('es_identifierUsed', 'steam')

local foundResources = {}
local neededResources = {"redemrp_skin", "redemrp_clothing"}

local detectNeededResources = function()
    for k,v in ipairs(neededResources)do
        if GetResourceState(v) == "started" then
            foundResources[v] = true
			print("^4[redemrp_identity] ^2["..v.."] ^0 Found ^0")
        else
			print("^4[redemrp_identity] ^1["..v.."] ^0Not Found, missing features ^0")
		end
    end
	print("^4[redemrp_identity] ^0 Loaded ^0")
end

detectNeededResources()

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
        if(foundResources.redemrp_skin)then
            MySQL.Async.fetchAll('SELECT * FROM skins WHERE `identifier`=@identifier;', {identifier = id}, function(result2)
                if(foundResources.redemrp_clothing)then
                    MySQL.Async.fetchAll('SELECT * FROM clothes WHERE `identifier`=@identifier;', {identifier = id}, function(result3)
                        TriggerClientEvent('redemrp_identity:openSelectionMenu', _source, result, result2, result3)
                    end)
                else
                    TriggerClientEvent('redemrp_identity:openSelectionMenu', _source, result, result2, {})
                end
            end)
        else
            TriggerClientEvent('redemrp_identity:openSelectionMenu', _source, result, {}, {})
        end
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

    MySQL.Async.fetchAll('DELETE FROM characters WHERE `identifier` = @identifier AND `characterid`=@characterid;', {identifier = id, characterid=_charid}, function(result)end)
    
    TriggerEvent("redemrp_identity:characterRemoved", _source, id, _charid)



end)
