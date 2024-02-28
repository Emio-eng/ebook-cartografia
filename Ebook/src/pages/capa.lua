local composer = require("composer")

local capaScene = composer.newScene()

-- Função para lidar com o toque no botão
local function handleButtonTap(event)
  composer.gotoScene("src.pages.contracapa", {effect = "fade", time = 500})
end

function capaScene:create(event)
    local sceneGroup = self.view

    -- Carrega a imagem da capa
    local largura = 768   -- Largura desejada
    local altura = 1024   -- Altura desejada

    local capa = display.newImageRect(sceneGroup, "src/assets/capa.png", largura, altura)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY

    -- Adiciona um botão para ir para a próxima página usando a imagem "button-right.png"
    local buttonRight = display.newImageRect(sceneGroup, "src/assets/button-right.png", 78, 34)
    buttonRight.x = 695  -- Defina a posição X desejada
    buttonRight.y = 964  -- Defina a posição Y desejada

    -- Configura o evento de toque no botão
    buttonRight:addEventListener('tap', handleButtonTap)
end

return capaScene
