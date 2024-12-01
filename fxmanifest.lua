
fx_version 'cerulean'
game 'gta5'

description 'QB Screenshot'
author 'hao_ya'
version '1.0'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server.lua'
}

client_scripts {
    'config.lua',
    'client.lua'
}

shared_script '@qb-core/shared/locale.lua'
dependency 'oxmysql'
