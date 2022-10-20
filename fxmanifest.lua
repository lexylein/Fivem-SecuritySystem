fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'Noro_Lex'
discord 'https://discord.gg/3AG6v6rRm7'
description 'made by Noro_Lex'
version '1.4'

shared_script 'config.lua'

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/*.lua',
	'client/*.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/*.lua',
	'server/*.lua',
}