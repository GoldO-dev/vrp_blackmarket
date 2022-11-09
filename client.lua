
--##########    VRP Main    ##########--
-- init vRP client context
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

local cvRP = module("vrp", "client/vRP")
vRP = cvRP()

local pvRP = {}
-- load script in vRP context
pvRP.loadScript = module
Proxy.addInterface("vRP", pvRP)

local cfg = module("vrp_blackmarket", "cfg/cfg")            	-- Optiona, Change vrp_template to match folder name

local luang = module("vrp", "lib/luang")

local vrp_blackmarket = class("vrp_blackmarket", vRP.Extension)           -- Class Name, Can be changed to anything (match with server class name to make things easier

function vrp_blackmarket:__construct()                            	-- Change Template to match Class Name
	vRP.Extension.__construct(self)
end

--##########    VRP Main done    ##########--

local marketLoc = 0
local informerLoc = 0


--Initial thread 
Citizen.CreateThread(function()
	marketLoc = math.random(1, #cfg.marketPedSpawnLocations)
	informerLoc = math.random(1, #cfg.informerPedSpawnLocations)
	SetupBlackMarket()
	SetupInformer()
end)


--#####    Setups    #####

--Blackmarket ped and blip setup
function SetupBlackMarket()
	marketLoc = math.random(1, #cfg.marketPedSpawnLocations)
    if cfg.useMarketBlip then
        CreateMarketBlip()
    end
	SpawnNewMarketPed()
end


--Informer ped and blip setup
function SetupInformer()
	informerLoc = math.random(1, #cfg.informerPedSpawnLocations)
    if cfg.useInformerBlip then
        CreateInformerBlip()
    end
	SpawnNewInformerPed()
end

--#####    Setups done    #####


--#####    Blip functionality    #####

--Create blip for the black market
function CreateMarketBlip()
    DeleteMarketBlip()
    marketBlip = AddBlipForCoord(cfg.marketPedSpawnLocations[marketLoc]["x"],cfg.marketPedSpawnLocations[marketLoc]["y"],cfg.marketPedSpawnLocations[marketLoc]["z"])
    SetBlipSprite(marketBlip, 500)
    SetBlipScale(marketBlip, 0.8)
    SetBlipColour(marketBlip, 4)
    SetBlipAsShortRange(marketBlip, false)
    BeginTextCommandSetBlipName("STRING")
    --AddTextComponentString(self.lang.marketBlipName)
    AddTextComponentString("Mysterious market")
    EndTextCommandSetBlipName(marketBlip)
end

--Delete blip for the black market
function DeleteMarketBlip()
    if DoesBlipExist(marketBlip) then
        RemoveBlip(marketBlip)
    end
end


--Create blip for the informer
function CreateInformerBlip()
    DeleteInformerBlip()
    informerBlip = AddBlipForCoord(cfg.informerPedSpawnLocations[informerLoc]["x"],cfg.informerPedSpawnLocations[informerLoc]["y"],cfg.informerPedSpawnLocations[informerLoc]["z"])
    SetBlipSprite(informerBlip, 500)
    SetBlipScale(informerBlip, 0.8)
    SetBlipColour(informerBlip, 4)
    SetBlipAsShortRange(informerBlip, false)
    BeginTextCommandSetBlipName("STRING")
    --AddTextComponentString(self.lang.informerBlipName)
    AddTextComponentString("Mysterious informer")
    EndTextCommandSetBlipName(informerBlip)
end

--Delete blip for the informer
function DeleteInformerBlip()
	if DoesBlipExist(informerBlip) then
		RemoveBlip(informerBlip)
	end
end

--#####    Blip functionality done    #####



--#####    Ped functionality    #####

--Spawn ped for the black market
function SpawnNewMarketPed()
    for k, v in pairs(cfg.blackMarketPed) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(1) 
        end
        marketPed = CreatePed(4, v.model, cfg.marketPedSpawnLocations[marketLoc]["x"],cfg.marketPedSpawnLocations[marketLoc]["y"],cfg.marketPedSpawnLocations[marketLoc]["z"]-1, 3374176, true, true)
        SetEntityHeading(marketPed, cfg.marketPedSpawnLocations[marketLoc]["h"])
        FreezeEntityPosition(marketPed, true)
        SetEntityInvincible(marketPed, true)
        SetBlockingOfNonTemporaryEvents(marketPed, true)
        TaskStartScenarioInPlace(marketPed, v.anim, 0, true)
    end
end

--Delete ped for the black market
function DeleteMarketPed()
    local player = PlayerPedId()
    if DoesEntityExist(marketPed) then
        ClearPedTasks(marketPed) 
        ClearPedTasksImmediately(marketPed)
        ClearPedSecondaryTask(marketPed)
        FreezeEntityPosition(marketPed, false)
        SetEntityInvincible(marketPed, false)
        SetBlockingOfNonTemporaryEvents(marketPed, false)
        TaskReactAndFleePed(marketPed, player)
        SetPedAsNoLongerNeeded(marketPed)
        Wait(8000)
        DeletePed(marketPed)
        SetupBlackMarket()
    end
end

--Spawn ped for the informer
function SpawnNewInformerPed()
	for k, v in pairs(cfg.informerPed) do
		RequestModel(GetHashKey(v.model))
		while not HasModelLoaded(GetHashKey(v.model)) do
			Wait(1) 
		end
		informerPed = CreatePed(4, v.model, cfg.informerPedSpawnLocations[informerLoc]["x"],cfg.informerPedSpawnLocations[informerLoc]["y"],cfg.informerPedSpawnLocations[informerLoc]["z"]-1, 3374176, true, true)
		SetEntityHeading(informerPed, cfg.informerPedSpawnLocations[informerLoc]["h"])
		FreezeEntityPosition(informerPed, true)
		SetEntityInvincible(informerPed, true)
		SetBlockingOfNonTemporaryEvents(informerPed, true)
		TaskStartScenarioInPlace(informerPed, v.anim, 0, true)
	end
end

--Delte ped for the informer
function DeleteInformerPed()
    local player = PlayerPedId()
	if DoesEntityExist(informerPed) then
        ClearPedTasks(informerPed) 
		ClearPedTasksImmediately(informerPed)
        ClearPedSecondaryTask(informerPed)
        FreezeEntityPosition(informerPed, false)
        SetEntityInvincible(informerPed, false)
        SetBlockingOfNonTemporaryEvents(informerPed, false)
        TaskReactAndFleePed(informerPed, player)
		SetPedAsNoLongerNeeded(informerPed)
		Wait(8000)
		DeletePed(informerPed)
        SetupInformer()
	end
end


--Thread to check if the player is near the informer npc or near the blackmarket npc
Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        local informerDistance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, cfg.informerPedSpawnLocations[informerLoc]["x"],cfg.informerPedSpawnLocations[informerLoc]["y"],cfg.informerPedSpawnLocations[informerLoc]["z"]-1, true)
        local marketDistance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, cfg.marketPedSpawnLocations[marketLoc]["x"],cfg.marketPedSpawnLocations[marketLoc]["y"],cfg.marketPedSpawnLocations[marketLoc]["z"]-1, true)
        
        --Black market distance check
        if marketDistance < cfg.npcRange then
            print("Player is near the blackmarket npc!")
        end
        

        --Informer distance check
        if informerDistance < cfg.npcRange then
            print("Player is near the informer npc!")
        end
        Citizen.Wait(0)
    end
end)

--#####    Ped functionality    #####



vRP:registerExtension(vrp_blackmarket)   