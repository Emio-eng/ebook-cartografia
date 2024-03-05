system.activate( "multitouch" )

local composer = require "composer"

local capa = require("src.pages.page1")

-- load title screen
composer.gotoScene( "src.pages.page1", "fade" )

capa:create()