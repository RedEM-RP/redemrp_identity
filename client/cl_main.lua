local characters = {}
local PlayerSkins = {}
local PlayerClothes = {}
local PlayerSex = {}
local globalcam

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

RegisterNetEvent('redemrp_identity:SpawnCharacter')
AddEventHandler('redemrp_identity:SpawnCharacter', function(new)
    if Config.UsingRespawn then
            TriggerEvent("redemrp_respawn:respawn" , new)
			TriggerServerEvent("redemrp_respawn:CheckPos")
    else
	
		DoScreenFadeIn(500)
		local coords = cord
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 621.67,374.08,873.24, 300.00,0.00,0.00, 100.00, false, 0)
		PointCamAtCoord(cam, Config.SpawnPoint.x,Config.SpawnPoint.y,Config.SpawnPoint.z+200)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 1, true, true)
		DoScreenFadeIn(500)
		Citizen.Wait(500)
		SetEntityCoords(PlayerPedId(), Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z)
		cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Config.SpawnPoint.x,Config.SpawnPoint.y,Config.SpawnPoint.z+200, 300.00,0.00,0.00, 100.00, false, 0)
		PointCamAtCoord(cam3, Config.SpawnPoint.x,Config.SpawnPoint.y,Config.SpawnPoint.z+200)
		SetCamActiveWithInterp(cam3, cam, 3700, true, true)
		Citizen.Wait(3700)
		
		cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Config.SpawnPoint.x,Config.SpawnPoint.y,Config.SpawnPoint.z+200, 300.00,0.00,0.00, 100.00, false, 0)
		PointCamAtCoord(cam2, Config.SpawnPoint.x,Config.SpawnPoint.y,Config.SpawnPoint.z+2)
		SetCamActiveWithInterp(cam2, cam3, 3700, true, true)
		RenderScriptCams(false, true, 500, true, true)
		Citizen.Wait(500)
		SetCamActive(cam, false)
		DestroyCam(cam, true)
		DestroyCam(cam2, true)
		DestroyCam(cam3, true)
		DisplayHud(true)
		DisplayRadar(true)
		Citizen.Wait(3000)

    end
end)

RegisterNetEvent('redemrp_identity:removeLoadingScreen')
AddEventHandler('redemrp_identity:removeLoadingScreen', function()
    DoScreenFadeIn(500)
    SendNUIMessage({
        loading = false
    })
    for i=1,4 do	
        if characters[i] ~= nil then
            TaskGoToCoordAnyMeans(characters[i] ,Config.gotocoords[i] ,1.0, 0, 0, 0, 0.5)
            Citizen.CreateThread(function()
                while GetScriptTaskStatus(characters[i], 0x93399E79 , 1)  ~= 8 do
                    Wait(250)
                end
                TaskAchieveHeading(characters[i], 200.0, 0)
            end)
        end

    end

end)

RegisterNetEvent('redemrp_identity:openSelectionMenu')
AddEventHandler('redemrp_identity:openSelectionMenu', function(characters,skins,clothes)
    Citizen.CreateThread(function()
        SetEntityAlpha(PlayerPedId(), 0)
        SendNUIMessage({
            loading = true,
            list = characters
        })
        SetNuiFocus(true, true)
        local ped = PlayerPedId()
        SetEntityCoords(PlayerPedId(), 1.505, 1015.63, 202.4088)
        FreezeEntityPosition(PlayerPedId(), true)
        DestroyAllCams()
        globalcam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 7.0, 1002.0, 209.24, 0.00, 0.00, 0.00, 11.00, false, 0)
        PointCamAtCoord(globalcam, -1.838056, 1026.48, 204.8)
        SetCamActive(globalcam, true)
        RenderScriptCams(true, false, 1, true, true)
        DisplayHud(false)
        DisplayRadar(false)
        for k, v in ipairs(characters) do
            PlayerSkins[k] = FindCharacterSkin(skins, v.characterid)
            PlayerSex[k] = PlayerSkins[k].sex
            PlayerClothes[k] = FindCharacterClothes(clothes, v.characterid)
        end
		if next(PlayerSkins) then
			if not next(PlayerSkins[1]) then
				TriggerEvent("redemrp_identity:removeLoadingScreen")
			end
		else
			TriggerEvent("redemrp_identity:removeLoadingScreen")
        end
        createCharacters()
    end)
end)

function FindCharacterClothes(clothes, charid)
    for k, v in ipairs(clothes) do
        if v.charid == charid then
            print("Identity Clothes Found")
            return json.decode(v.clothes)
        end
    end
    return {}
end

function FindCharacterSkin(skins, charid)
    for k, v in ipairs(skins) do
        if v.charid == charid then
            print("Identity SKIN Found")
            return json.decode(v.skin)
        end
    end
    return {}
end

function createCharacters()
    local maleHash = GetHashKey("mp_male")
    local femaleHash = GetHashKey("mp_female")
    modelrequest( maleHash)
    while not HasModelLoaded(maleHash) do
        Wait(100)
    end
    modelrequest(femaleHash)
    while not HasModelLoaded(femaleHash) do
        Wait(100)
    end
    for i=1,4 do
		if PlayerSex[i] ~= nil then
			if tonumber(PlayerSex[i]) == 1 then
				characters[i] = CreatePed(maleHash, Config.charcoords[i].x, Config.charcoords[i].y, Config.charcoords[i].z, 200.0, true, true, 0, 0)
				while not DoesEntityExist(characters[i]) do
					Wait(100)
				end
			elseif tonumber(PlayerSex[i]) == 2 then
				characters[i] = CreatePed(femaleHash, Config.charcoords[i].x, Config.charcoords[i].y, Config.charcoords[i].z, 200.0, true, true, 0, 0)
				while not DoesEntityExist(characters[i]) do
					Wait(100)
				end
			end

			if characters[i] ~= nil then
				NetworkSetEntityInvisibleToNetwork(characters[i],true)
				SetEntityAsMissionEntity(characters[i], true, true)
				Citizen.InvokeNative(0x283978A15512B2FE, characters[i], true)
				SetEntityInvincible(characters[i], true)
				SetEntityCanBeDamagedByRelationshipGroup(characters[i], false, GetHashKey("PLAYER"))
				TriggerEvent("redemrp_skin:applySkin", PlayerSkins[i] , characters[i], PlayerClothes[i])
			end
		end
	end

end


Citizen.CreateThread(function()
    ShutdownLoadingScreen()
    Wait(3000)
    TriggerServerEvent('redemrp_identity:getCharacters')
end)

RegisterNUICallback('selectCharacter', function(data, cb)
    local cam
    local _ped = tonumber(data.pedid) + 1
	if characters[_ped] then
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetOffsetFromEntityInWorldCoords(characters[_ped] , 0.0, 8.0, 1.3) , 0.00, 0.00, 0.00, 8.00, false, 0)
		PointCamAtEntity(cam,characters[_ped])
		SetCamActiveWithInterp(cam, globalcam, 1000, true, true)
		Citizen.Wait(1000)
		Citizen.InvokeNative(0xB31A277C1AC7B7FF, characters[_ped], 0, 0, tonumber(-402959), 1, 1, 0, 0)
	end
    Citizen.Wait(2000)
    SetNuiFocus(false, false)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    local charId = tonumber(data.id)
    TriggerServerEvent("redemrp:selectCharacter", charId)
    Citizen.Wait(1000)
    TriggerEvent("redemrp_identity:SpawnCharacter")
    TriggerEvent('playerSpawned')
	TriggerServerEvent("redemrp_skin:loadSkin")
    Citizen.Wait(7000)
    for v, k in pairs (characters) do
        DeletePed(k)
		characters[v] = nil
    end
    SetCamActive(cam, false)
    DestroyAllCams()
end)


RegisterNUICallback('newCharacter', function(data, cb)
    SetNuiFocus(false, false)
    local function tchelper(first, rest)
        return first:upper()..rest:lower()
    end
    local fname = data.name:gsub("(%a)([%w_']*)", tchelper)
    local lname = data.lname:gsub("(%a)([%w_']*)", tchelper)
    TriggerServerEvent('redemrp:createCharacter', fname, lname)
    TriggerEvent("redemrp_identity:SpawnCharacter" , true)
    Wait(1000)
    for v, k in pairs (characters) do
        DeletePed(k)
		characters[v] = nil
    end
end)

RegisterNUICallback('deleteCharacter', function(id, cb)
    local charId = tonumber(id)
    TriggerServerEvent('redemrp_identity:deleteCharacter', charId)
	TriggerServerEvent('redemrp_skin:deleteSkin', charId)
    TriggerServerEvent('redemrp_clothing:deleteClothes', charId)
    TriggerServerEvent('redemrp_inventory:deleteInv', charId)
    Citizen.Wait(1000)
    TriggerServerEvent('redemrp_identity:getCharacters')
    for v, k in pairs (characters) do
        DeletePed(k)
		characters[v] = nil
	    PlayerSkins[v] = nil
		PlayerClothes[v] = nil
		PlayerSex[v] = nil
    end
end)



