local charcoords = {
    vector3(-3.5 , 1013.9, 206.8388),
	vector3(-3.8 , 1013.9, 206.8388),
	vector3(-4.0 , 1013.9, 206.8388),
	vector3(-4.5 , 1013.9, 206.8388),
}
local camcoords = {
    vector3(0.421, 1014.9, 205.4088),
	vector3(1.505, 1015.63, 205.4088),
	vector3(2.700, 1016.20, 205.4088),
	vector3(3.90, 1017.05, 205.4088),
}
local char1
local char2
local char3
local char4
local globalcam
function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

local new = 0
RegisterNetEvent('redemrp_identity:SpawnCharacter')
AddEventHandler('redemrp_identity:SpawnCharacter', function()
    if Config.UsingRespawn then
		if new > 0 then
		TriggerEvent("redemrp_respawn:respawn", new)
	  end
    else
        SetTimecycleModifier('Base_modifier')
        --SetEntityCoords(ped, Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z)
        Citizen.Wait(3700)
        FreezeEntityPosition(PlayerPedId(), false)
        Citizen.Wait(500)
        DisplayHud(true)
        DisplayRadar(true)
        Citizen.Wait(3000)
        if Config.UsingClothes then
            Citizen.Wait(5000)
            TriggerServerEvent("redemrp_clothing:loadClothes", 1, function(cb)
                end)
        else end

    end
end)

RegisterNetEvent('redemrp_identity:removeLoadingScreen')
AddEventHandler('redemrp_identity:removeLoadingScreen', function()
DoScreenFadeIn(500)
    print("test test")
    SendNUIMessage({
        loading = false
    })
	if char1 ~= nil then
TaskGoToCoordAnyMeans(char1 ,0.421, 1014.9, 205.4088 ,1.0, 0, 0, 0, 0.5)
 Citizen.CreateThread(function()
  while GetScriptTaskStatus(char1, 0x93399E79 , 1)  ~= 8 do
            Wait(250)
    end
        TaskAchieveHeading(char1, 200.0, 0)
		end)
end
 Wait(750)
if char2 ~= nil then
TaskGoToCoordAnyMeans(char2 ,1.505, 1015.63, 205.4088 ,1.0, 0, 0, 0, 0.5)
 Citizen.CreateThread(function()
  while GetScriptTaskStatus(char2, 0x93399E79 , 1)  ~= 8 do
            Wait(250)
        end
        TaskAchieveHeading(char2, 200.0, 0)
		end)
end

 Wait(750)
if char3 ~= nil then
TaskGoToCoordAnyMeans(char3 ,2.700, 1016.20, 205.4088 ,1.0, 0, 0, 0, 0.5)
 Citizen.CreateThread(function()
  while GetScriptTaskStatus(char3, 0x93399E79 , 1)  ~= 8 do
            Wait(250)
        end
        TaskAchieveHeading(char3, 200.0, 0)
		end)
end

 Wait(750)
if char4 ~= nil then
TaskGoToCoordAnyMeans(char4 ,3.90, 1017.05, 205.4088 ,1.0, 0, 0, 0, 0.5)
 Citizen.CreateThread(function()
  while GetScriptTaskStatus(char4, 0x93399E79 , 1)  ~= 8 do
            Wait(250)
        end
        TaskAchieveHeading(char4, 200.0, 0)
		end)
end
end)

                    local elementy = {
                        ["hat"] = 1,
                        ["shirt"] = 1,
                        ["vest"] = 1,
                        ["pants"] = 1,
                        ["mask"] = 1,
                        ["boots"] =1,
                        ["skirt"] = 1,
                        ["coat"] = 1,
                        ["gloves"] = 1,
                        ["bandana"] = 1,
                        ["gunbelts"] =1,
                        ["belts"] = 1,
                        ["beltbuckle"] = 1,
                        ["offhand"] = 1,
                        ["neckties"] = 1,
                        ["suspenders"] = 1,
                        ["spurs"] = 1,
                        ["poncho"] = 1,
                        ["eyewear"] = 1,



                    }

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
        local skin1
        local skin2
        local skin3
        local skin4
        local clothes1
        local clothes2
        local clothes3
        local clothes4
        local type1
        local type2
        local type3
        local type4
        if skins and skins[1] ~= nil then
            type1 = json.decode(skins[1].skin).sex
            skin1 = json.decode(skins[1].skin)
            if clothes[1] then
                for k,v in ipairs(clothes)do
                    if skins[1].charid == v.charid then
                        print(clothes[k].clothes)
                        clothes1 = json.decode(clothes[k].clothes)
                        break
                    end
                end
            else
                clothes1 = elementy
            end
        else
            SendNUIMessage({
                loading = false,
            })
        end
        if skins and skins[2] ~= nil then
            type2 = json.decode(skins[2].skin).sex
            skin2 = json.decode(skins[2].skin)
            if clothes[2] then
                for k,v in ipairs(clothes)do
                    if skins[2].charid == v.charid then
                        print(clothes[k].clothes)
                        clothes2 = json.decode(clothes[k].clothes)
                        break
                    end
                end
            else
                clothes2 = elementy
            end
        end
        if skins and skins[3] ~= nil then
            type3 = json.decode(skins[3].skin).sex
            skin3 = json.decode(skins[3].skin)
            if clothes[3] then
                for k,v in ipairs(clothes)do
                    if skins[3].charid == v.charid then
                        print(clothes[k].clothes)
                        clothes3 = json.decode(clothes[k].clothes)
                        break
                    end
                end
            else
                clothes3 = elementy
            end
        end
        if skins and skins[4] ~= nil then
            type4 = json.decode(skins[4].skin).sex
            skin4 = json.decode(skins[4].skin)
            if clothes[4] then
                for k,v in ipairs(clothes)do
                    if skins[4].charid == v.charid then
                        print(clothes[k].clothes)
                        clothes4 = json.decode(clothes[k].clothes)
                        break
                    end
                end
            else
                clothes4 = elementy
            end
        end
                if skins == nil or clothes == nil then
			TriggerEvent('redemrp_identity2:removeLoadingScreen')
		end
        createCharacters(type1,type2,type3,type4,skin1,skin2,skin3,skin4 , clothes1 ,clothes2 ,clothes3 ,clothes4)

    end)
end)



function createCharacters(t1, t2, t3, t4, skin1,skin2,skin3,skin4, clothes1 ,clothes2 ,clothes3 ,clothes4)
local type1 = tonumber(t1)
local type2 = tonumber(t2)
local type3 = tonumber(t3)
local type4 = tonumber(t4)
local _skin1 = skin1
local _skin2 = skin2
local _skin3 = skin3
local _skin4 = skin4
local _clothes1 = clothes1
local _clothes2 = clothes2
local _clothes3 = clothes3
local _clothes4 = clothes4
	while not HasModelLoaded( GetHashKey("mp_male") ) do
		Wait(500)
		modelrequest(  GetHashKey("mp_male") )
	end
	while not HasModelLoaded(  GetHashKey("mp_female") ) do
		Wait(500)
		modelrequest(  GetHashKey("mp_female") )
	end


	if type1 == 1 then
		char1 = CreatePed( GetHashKey("mp_male"), charcoords[1].x, charcoords[1].y, charcoords[1].z, 200.0, true, true, 0, 0)
		while not DoesEntityExist(char1) do
			Wait(100)
		end
	end
	if type1 == 2 then
		char1 = CreatePed(GetHashKey("mp_female"), charcoords[1].x, charcoords[1].y, charcoords[1].z, 200.0, true, true, 0, 0)
		while not DoesEntityExist(char1) do
			Wait(100)
		end
	end

	if char1 ~= nil then
	NetworkSetEntityInvisibleToNetwork(char1,true)
	SetEntityAsMissionEntity(char1, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, char1, true)
    SetEntityInvincible(char1, true)
    SetEntityCanBeDamagedByRelationshipGroup(char1, false, `PLAYER`)
	print(type1)
	TriggerEvent("redemrp_skin:applySkin", _skin1 , char1, _clothes1)
	end
	
	
	
	
	-- CHAR2
	if type2 == 1 then
		char2 = CreatePed( GetHashKey("mp_male"), charcoords[2].x, charcoords[2].y, charcoords[2].z, 200.0, true, true, 0, 0)
		while not DoesEntityExist(char2) do
			Wait(100)
		end
	end
	if type2 == 2 then
		char2 = CreatePed(GetHashKey("mp_female"), charcoords[2].x, charcoords[2].y, charcoords[2].z, 200.0, true, true, 0, 0)
		while not DoesEntityExist(char2) do
			Wait(100)
		end
	end


	if char2 ~= nil then
	NetworkSetEntityInvisibleToNetwork(char2,true)
	SetEntityAsMissionEntity(char2, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, char2, true)
	SetEntityInvincible(char2, true)
    SetEntityCanBeDamagedByRelationshipGroup(char2, false, `PLAYER`)
		print(type1)
		Wait(250)
		  TriggerEvent("redemrp_skin:applySkin", _skin2 , char2 , _clothes2)
	end
	
	
	
	
	-- CHAR3
	if type3 == 1 then
		char3 = CreatePed( GetHashKey("mp_male"), charcoords[3].x, charcoords[3].y, charcoords[3].z, 200.0, true, true, 0, 0)
		while not DoesEntityExist(char3) do
			Wait(100)
		end
	end
	if type3 == 2 then
		char3 = CreatePed(GetHashKey("mp_female"), charcoords[3].x, charcoords[3].y, charcoords[3].z, 200.0, true, true, 0, 0)
		while not DoesEntityExist(char3) do
			Wait(100)
		end
	end
	if char3 ~= nil then
	NetworkSetEntityInvisibleToNetwork(char3,true)
	SetEntityAsMissionEntity(char3, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, char3, true)
    SetEntityInvincible(char3, true)
    SetEntityCanBeDamagedByRelationshipGroup(char3, false, `PLAYER`)
	Wait(350)
	TriggerEvent("redemrp_skin:applySkin", _skin3 , char3,_clothes3)
   end
   
   
   
	-- CHAR4
	if type4 == 1 then
		char4 = CreatePed( GetHashKey("mp_male"), charcoords[4].x, charcoords[4].y, charcoords[4].z, 200.0, true, true, 0, 0)
		while not DoesEntityExist(char4) do
			Wait(100)
		end
	end
	if type4 == 2 then
		char4 = CreatePed(GetHashKey("mp_female"), charcoords[4].x, charcoords[4].y, charcoords[4].z, 200.0, true, true, 0, 0)
		while not DoesEntityExist(char4) do
			Wait(100)
		end
	end

	if char4 ~= nil then
	NetworkSetEntityInvisibleToNetwork(char4,true)
	SetEntityAsMissionEntity(char4, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, char4, true)
    SetEntityInvincible(char4, true)
    SetEntityCanBeDamagedByRelationshipGroup(char4, false, `PLAYER`)
	Wait(500)
		  TriggerEvent("redemrp_skin:applySkin", _skin4 , char4, _clothes4)
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
	if _ped == 1 then
	  cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetOffsetFromEntityInWorldCoords(char1 , 0.0, 8.0, 1.3) , 0.00, 0.00, 0.00, 8.00, false, 0)
       PointCamAtEntity(cam,char1)
       SetCamActiveWithInterp(cam, globalcam, 1000, true, true)
       Citizen.Wait(1000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF, char1, 0, 0, tonumber(-402959), 1, 1, 0, 0)
	end
	if _ped == 2 then
	  cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetOffsetFromEntityInWorldCoords(char2 , 0.0, 8.0, 1.3) , 0.00, 0.00, 0.00, 8.00, false, 0)
       PointCamAtEntity(cam,char2)
       SetCamActiveWithInterp(cam, globalcam, 1000, true, true)
       Citizen.Wait(1000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF, char2, 0, 0, tonumber(-402959), 1, 1, 0, 0)
	end
	if _ped == 3 then
	  cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetOffsetFromEntityInWorldCoords(char3 , 0.0, 8.0, 1.3) , 0.00, 0.00, 0.00, 8.00, false, 0)
       PointCamAtEntity(cam,char3)
       SetCamActiveWithInterp(cam, globalcam, 1000, true, true)
       Citizen.Wait(1000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF, char3, 0, 0, tonumber(-402959), 1, 1, 0, 0)
	end
	if _ped == 4 then
	  cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetOffsetFromEntityInWorldCoords(char4 , 0.0, 8.0, 1.3) , 0.00, 0.00, 0.00, 8.00, false, 0)
       PointCamAtEntity(cam,char4)
       SetCamActiveWithInterp(cam, globalcam, 1000, true, true)
       Citizen.Wait(1000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF, char4, 0, 0, tonumber(-402959), 1, 1, 0, 0)
	end
	Citizen.Wait(2000)
    SetNuiFocus(false, false)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    local charId = tonumber(data.id)
    print("Player spawned!")
    TriggerServerEvent("redemrp:selectCharacter", charId)
	Citizen.Wait(1000)
	TriggerServerEvent("redemrp_respawn:CheckPos")
	TriggerEvent("redemrp_identity:SpawnCharacter")
	TriggerEvent('playerSpawned')
	TriggerServerEvent("redemrp_skin:loadSkin", function(cb)
		end)
	Citizen.Wait(2000)
	TriggerServerEvent("redemrp_inventory:LoadItems")	
    spawned = true
	Citizen.Wait(7000)
        
		DeletePed(char1)
		DeletePed(char2)
		DeletePed(char3)
		DeletePed(char4)
        SetCamActive(cam, false)
        DestroyAllCams()
end)

RegisterNUICallback('createCharacter2', function(id, cb)

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
	Wait(1000)
    TriggerServerEvent("redemrp_inventory:LoadItems")
    --TriggerEvent("redemrp_skin:openCreator")
		DeletePed(char1)
		DeletePed(char2)
		DeletePed(char3)
		DeletePed(char4)
end)

RegisterNUICallback('deleteCharacter', function(id, cb)
    local charId = tonumber(id)
    print (charId)
     local charId = tonumber(id)
    -- print (charId)
    TriggerServerEvent('redemrp_identity:deleteCharacter', charId)
    TriggerServerEvent('redemrp_skin:deleteSkin', charId)
    TriggerServerEvent('redemrp_clothing:deleteClothes', charId)
    TriggerServerEvent('redemrp_inventory:deleteInv', charId)
    Citizen.Wait(5)
    TriggerServerEvent('redemrp_identity:getCharacters')
	DeletePed(char1)
	DeletePed(char2)
	DeletePed(char3)
	DeletePed(char4)
end)


