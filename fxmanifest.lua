fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'Noro_Lex'
description 'made by Noro_Lex'
version '1.1'

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
