system.activate( "multitouch" )

local composer = require "composer"

local capa = require("src.pages.page2")

-- load title screen
composer.gotoScene( "src.pages.page2", "fade" )

capa:create()