-- main.lua

local composer = require("composer")

-- Cria uma instância da cena da capa
local capa = require("capa")

-- Cria a cena da capa
composer.gotoScene("capa")

-- Chama a função create da cena da capa
capa:create()
