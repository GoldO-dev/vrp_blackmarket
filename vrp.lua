local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local vRP = Proxy.getInterface("vRP")

async(function()
	vRP.loadScript("vrp_blackmarket", "server")                -- Change vrp_Test to match folder name
end)