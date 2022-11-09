fx_version 'cerulean'
games { 'gta5' }

description "vRP Blackmarket"        		-- Optional
version '1.0.0'                         -- Optional


shared_script {
  "@vrp/lib/utils.lua"
}

server_script {				-- server.lua is not needed here as the vrp.lua will load the server.lua with an async function
	"vrp.lua"
}

client_scripts {
	'client.lua'
}

files{
	"cfg/cfg.lua"                        -- Optional
}