local composer = require("composer")

local contracapaScene = composer.newScene()

function contracapaScene:create(event)
    local sceneGroup = self.view

    print("Contracapa Scene: create")

    local contracapa = display.newImageRect(sceneGroup, "src/assets/contra.png", 768, 1024)
    contracapa.x = display.contentCenterX
    contracapa.y = display.contentCenterY

    local buttonLeft = display.newImageRect(sceneGroup, "src/assets//icons/button-left.png", 78, 34)
    buttonLeft.x = 695  -- Defina a posição X desejada
    buttonLeft.y = 964  -- Defina a posição Y desejada
    buttonRight:addEventListener('tap', function()
      composer.gotoScene("src.pages.page6", {effect = "fade", time = 500})
  end)
end

contracapaScene:addEventListener("create", contracapaScene)
return contracapaScene
