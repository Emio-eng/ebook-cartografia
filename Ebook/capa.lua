-- capa.lua

local composer = require("composer")

local capaScene = composer.newScene()

function capaScene:create(event)
    local sceneGroup = self.view

    -- Carrega a imagem da capa
    local largura = 768   -- Largura desejada
    local altura = 1024   -- Altura desejada

    local capa = display.newImageRect(sceneGroup, "assets/capa.png", largura, altura)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY
end

return capaScene
