local vrp_blackmarket = class("vrp_blackmarket", vRP.Extension)                    				-- Class Name, Can be changed to anything
local lang = vRP.lang

function vrp_blackmarket:__construct()                                    					-- Change Template to match Class Name
	vRP.Extension.__construct(self)
	
	self.cfg = module("vrp_blackmarket", "cfg/cfg")									-- links cfg file
end

vrp_blackmarket.event = {}
vrp_blackmarket.tunnel = {}

vRP:registerExtension(vrp_blackmarket)                                    					-- Change Template to match Class Name