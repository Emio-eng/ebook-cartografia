local composer = require("composer")

local capaScene = composer.newScene()

-- Função para lidar com o toque no botão
function capaScene:create(event)
    local sceneGroup = self.view

    local capa = display.newImageRect(sceneGroup, "src/assets/capa.png", 768, 1024)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY

    -- Adiciona um botão para ir para a próxima página usando a imagem "button-right.png"
    local buttonRight = display.newImageRect(sceneGroup, "src/assets//icons/button-right.png", 78, 34)
    buttonRight.x = 695  -- Defina a posição X desejada
    buttonRight.y = 964  -- Defina a posição Y desejada
    buttonRight:addEventListener('tap', function(event)
      composer.removeScene("src.pages.capa")
      composer.gotoScene("src.pages.page1", {effect = "fade", time = 500})
  end)

    -- Configura o evento de toque no botão
end

capaScene:addEventListener("create", capaScene)

return capaScene
