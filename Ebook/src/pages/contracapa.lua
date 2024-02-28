local composer = require("composer")

local contracapaScene = composer.newScene()

function contracapaScene:create(event)
    local sceneGroup = self.view

    print("Contracapa Scene: create")

    -- Adicione o código para a contracapa aqui
    local largura = 768   -- Largura desejada
    local altura = 1024   -- Altura desejada

    local contracapa = display.newImageRect(sceneGroup, "src/assets/contra.png", largura, altura)
    contracapa.x = display.contentCenterX
    contracapa.y = display.contentCenterY
end

function contracapaScene:show(event)
    local phase = event.phase
    print("Contracapa Scene: show", phase)
end

function contracapaScene:hide(event)
    local phase = event.phase
    print("Contracapa Scene: hide", phase)
end

return contracapaScene
