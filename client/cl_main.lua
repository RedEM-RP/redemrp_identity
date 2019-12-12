Citizen.CreateThread(function()
Citizen.Wait(1000)
SetNuiFocus(true, true)
end)

RegisterNetEvent('redemrp_identity:SpawnCharacter')
AddEventHandler('redemrp_identity:SpawnCharacter', function()
local ped = PlayerPedId()
			SetTimecycleModifier('Base_modifier')
			SetEntityCoords(ped, Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z) -- SPAWN COORDS
			cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1921.78,105.54,338.37, 300.00,0.00,0.00, 100.00, false, 0)
			PointCamAtCoord(cam2, Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z+200) -- SPAWN COORDS
			SetCamActiveWithInterp(cam2, cam, 900, true, true)
			Citizen.Wait(900)
			
			cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z+200, 300.00,0.00,0.00, 100.00, false, 0)
			PointCamAtCoord(cam, Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z) -- SPAWN COORDS
			SetEntityCoords(ped, Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z) -- SPAWN COORDS
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
			Citizen.Wait(2000)
            TriggerServerEvent("xrp_skin:loadSkin", function(cb)
            end)
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
	local fname = data.name
	local lname = data.lname
	TriggerServerEvent('redemrp:createCharacter', fname, lname)
	TriggerEvent("redemrp_identity:SpawnCharacter")
	TriggerEvent("redemrp_skin:openCreator")
end)

RegisterNUICallback('deleteCharacter', function(id, cb)
	local charId = tonumber(id)
	--print (charId)
	TriggerServerEvent('redemrp_identity:deleteCharacter', charId)
	--Citizen.Wait(5)
	TriggerServerEvent('redemrp_identity:getCharacters')
end)

Citizen.CreateThread(function()
TriggerServerEvent('redemrp_identity:getCharacters')
	--SetTimecycleModifier('Colter_Cave')
	local ped = PlayerPedId()
	SetEntityCoords(ped, 3791.45, 3091.3, 103.71) -- POSITION WHEN PLAYER IS CREATING/SELECTING
	cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1921.78,105.54,338.37, 360.00,0.00,0.00, 100.00, false, 0)
	PointCamAtCoord(cam3, -238.11, 744.48, 116.68+2)
    SetCamActive(cam3, true)
    RenderScriptCams(true, false, 1, true, true)
	DisplayHud(false)
	DisplayRadar(false)
end)

RegisterNetEvent('redemrp_identity:getCharacters')
AddEventHandler('redemrp_identity:getCharacters', function(characters)

	for k,v in pairs(characters) do
		for name,_ in pairs(v)do print(name) end
		v.name = v.firstname .. " " .. v.lastname
	end
	
    SendNUIMessage({
        type = 1,
        list = characters
    })
end)