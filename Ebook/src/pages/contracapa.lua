local composer = require("composer")

local contracapaScene = composer.newScene()

function contracapaScene:create(event)
    local sceneGroup = self.view

    print("Contracapa Scene: create")

    local contracapa = display.newImageRect(sceneGroup, "src/assets/frames/Frame8.png", 768, 1024)
    contracapa.x = display.contentCenterX
    contracapa.y = display.contentCenterY

    local buttonCapa = display.newImageRect(sceneGroup, "src/assets/icons/bussola.png", 78, 78)
    buttonCapa.x = 685
    buttonCapa.y = 950
    buttonCapa:addEventListener('tap', function(event)
      composer.removeScene("src.pages.contracapa")
      composer.gotoScene("src.pages.capa", {effect = "fade", time = 500})
  end)

    local buttonLeft = display.newImageRect(sceneGroup, "src/assets/icons/button-left.png", 78, 34)
    buttonLeft.x = 70
    buttonLeft.y = 960
    buttonLeft:addEventListener('tap', function()
      composer.removeScene("src.pages.contracapa")
      composer.gotoScene("src.pages.page6", {effect = "fade", time = 500})
  end)
end

contracapaScene:addEventListener("create", contracapaScene)
return contracapaScene
