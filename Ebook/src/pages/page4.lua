local composer = require("composer")

local page4Scene = composer.newScene()


function page4Scene:create(event)
    local sceneGroup = self.view

    -- Adicione o restante do código relacionado à cena aqui

    local capa = display.newImageRect(sceneGroup, "src/assets/frames/Frame5.png", 768, 1024)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY

    local buttonRight = display.newImageRect(sceneGroup, "src/assets/icons/arrow-right.png", 78, 34)
    buttonRight.x = 695
    buttonRight.y = 960
    buttonRight:addEventListener('tap', function()
        composer.removeScene("src.pages.page4")
        composer.gotoScene("src.pages.page5", {effect = "fade", time = 500})
    end)

    local buttonLeft = display.newImageRect(sceneGroup, "src/assets/icons/arrow-left.png", 78, 34)
    buttonLeft.x = 70
    buttonLeft.y = 960
    buttonLeft:addEventListener('tap', function()
        composer.removeScene("src.pages.page4")
        composer.gotoScene("src.pages.page3", {effect = "fade", time = 500})
    end)

end
page4Scene:addEventListener("create", page4Scene)

return page4Scene
