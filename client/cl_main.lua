Citizen.CreateThread(function()
Citizen.Wait(1000)
SetNuiFocus(true, true)
end)
local new = 0
RegisterNetEvent('redemrp_identity:SpawnCharacter')
AddEventHandler('redemrp_identity:SpawnCharacter', function()
	if Config.UsingRespawn then
		TriggerEvent("redemrp_respawn:respawn", new)
	else
		SetEntityCoords(PlayerPedId(), Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z)

		SetTimecycleModifier('Base_modifier')
		SetEntityCoords(ped, Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z)
		cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Config.CameraLocation.x, Config.CameraLocation.y, Config.CameraLocation.z, 300.00, 0.00, 0.00, 100.00, false, 0)
		PointCamAtCoord(cam2, Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z+200)
		SetCamActiveWithInterp(cam2, cam, 900, true, true)
		Citizen.Wait(900)
		
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z+200, 300.00, 0.00, 0.00, 100.00, false, 0)
		PointCamAtCoord(cam, Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z)
		SetEntityCoords(ped, Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z)
		SetCamActiveWithInterp(cam, cam2, 3700, true, true)
		Citizen.Wait(3700)
		RenderScriptCams(false, true, 500, true, true)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		Citizen.Wait(500)
		SetCamActive(cam, false)
		DestroyCam(cam, true)
		DestroyCam(cam2, true)
		DestroyCam(cam3, true)
		DisplayHud(true)
		DisplayRadar(true)
		Citizen.Wait(3000)
		TriggerServerEvent("redemrp_skin:loadSkin", function(cb)
		end)
	if Config.UsingClothes then
		Citizen.Wait(5000)
		 TriggerServerEvent("redemrp_clothing:loadClothes", 1, function(cb)
        end)
	else end

	end
end)

RegisterNUICallback('selectCharacter', function(id, cb)
	SetNuiFocus(false, false)
	local ped = PlayerPedId()
	FreezeEntityPosition(ped, false)
	local charId = tonumber(id)
	print("Player spawned!")
	TriggerServerEvent("redemrp:selectCharacter", charId)
	TriggerEvent("redemrp_identity:SpawnCharacter")
end)

RegisterNUICallback('createCharacter2', function(id, cb)
local ped = PlayerPedId()
FreezeEntityPosition(ped, false)
local charId = tonumber(id)
        --Citizen.Wait(0)
        --local spawned = Citizen.InvokeNative(0xB8DFD30D6973E135 --[[NetworkIsPlayerActive]], PlayerPedId(), Citizen.ResultAsInteger())
        --if spawned then
            --printClient("Player spawned!")
            TriggerServerEvent("xrp:firstSpawn", charId)
            firstSpawn = true
        --end
end)

RegisterNUICallback('newCharacter', function(data, cb)
	SetNuiFocus(false, false)
	local function tchelper(first, rest)
		return first:upper()..rest:lower()
	end
	local fname = data.name:gsub("(%a)([%w_']*)", tchelper)
	local lname = data.lname:gsub("(%a)([%w_']*)", tchelper)
	TriggerServerEvent('redemrp:createCharacter', fname, lname)
	new = 1
	TriggerEvent("redemrp_identity:SpawnCharacter")
	new = 0
	--TriggerEvent("redemrp_skin:openCreator")
end)

RegisterNUICallback('deleteCharacter', function(id, cb)
	local charId = tonumber(id)
	--print (charId)
	TriggerServerEvent('redemrp_identity:deleteCharacter', charId)
       TriggerServerEvent('redemrp_skin:deleteSkin', charId)
       TriggerServerEvent('redemrp_clothing:deleteClothes', charId)
       TriggerServerEvent('redemrp_inventory:deleteInv', charId)
	--Citizen.Wait(5)
	TriggerServerEvent('redemrp_identity:getCharacters')
end)

Citizen.CreateThread(function()
ShutdownLoadingScreen()
Wait(3000)
TriggerServerEvent('redemrp_identity:getCharacters')
	local ped = PlayerPedId()
	SetEntityCoords(ped, 3791.45, 3091.3, 103.71) -- POSITION WHEN PLAYER IS CREATING/SELECTING
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Config.CameraLocation.x, Config.CameraLocation.y, Config.CameraLocation.z, 360.00,0.00,0.00, 100.00, false, 0)
	PointCamAtCoord(cam, Config.CameraLocation.x, Config.CameraLocation.y+100, Config.CameraLocation.z+2)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
	DisplayHud(false)
	DisplayRadar(false)
end)

RegisterNetEvent('redemrp_identity:getCharacters')
AddEventHandler('redemrp_identity:getCharacters', function(characters)

	for k,v in pairs(characters) do
		for name,_ in pairs(v) do print(name) end
		v.name = v.firstname .. " " .. v.lastname
	end
	
    SendNUIMessage({
        type = 1,
        list = characters
    })
end)
