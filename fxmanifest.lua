fx_version 'adamant'
game 'gta5'

Author 'Fusion Development'
Description 'Fusion Development - Admin Menu [AIO]'
Developer '!BestyFir3TM#0886'
Version '1.0'

ui_page 'html/ui.html'

files {
    -- HTML -- 
    'html/ui.html',
    -- JS -- 
    'html/Js/scripts.js',
    -- CSS -- 
    'html/Css/styles.css', 
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Config/FuS_Config.lua',
    'Config/FuS_Language.lua',
    'Config/FuS_Webhook.lua',
    'Server/*.lua'
}

client_scripts {
    'Config/FuS_Config.lua',
    'Config/FuS_Language.lua',
    'Client/*.lua'
}

dependencies {
    'InteractSound',
    'screenshot-basic'
}

export 'Fusion_Alert'
