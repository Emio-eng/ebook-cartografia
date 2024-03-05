local composer = require("composer")

local page1Scene = composer.newScene()
local mapaFeio
local mapa2
local personagem
local mascara

function page1Scene:create(event)
    local sceneGroup = self.view

    local capa = display.newImageRect(sceneGroup, "src/assets/frames/frame2.png", 768, 1024)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY

    mapaFeio = display.newImageRect(sceneGroup, "src/assets/page1/mapa_feio.jpg", 590, 430)
    mapaFeio.x = display.contentCenterX
    mapaFeio.y = 735

    mapa2 = display.newImageRect(sceneGroup, "src/assets/page1/mapa2.png", 590, 430)
    mapa2.x = display.contentCenterX
    mapa2.y = 735
    mapa2.isVisible = false

    mascara = graphics.newMask("src/assets/page1/mascara.png")
    mapaFeio:setMask(mascara)
    mapaFeio.maskX = display.contentCenterX
    mapaFeio.maskY = display.contentCenterY

    local buttonRight = display.newImageRect(sceneGroup, "src/assets/icons/arrow-right.png", 78, 34)
    buttonRight.x = 695
    buttonRight.y = 960
    buttonRight:addEventListener('tap', function()
        composer.removeScene("src.pages.page1")
        composer.gotoScene("src.pages.page2", { effect = "fade", time = 500 })
    end)

    local buttonLeft = display.newImageRect(sceneGroup, "src/assets/icons/arrow-left.png", 78, 34)
    buttonLeft.x = 70
    buttonLeft.y = 960
    buttonLeft:addEventListener('tap', function()
        composer.removeScene("src.pages.page1")
        composer.gotoScene("src.pages.capa", { effect = "fade", time = 500 })
    end)

    mapaFeio:addEventListener("touch", deslizarDedo)
end

function deslizarDedo(event)
    local phase = event.phase

    if (phase == "moved" or phase == "began") then
        local x, y = event.x - display.screenOriginX, event.y - display.screenOriginY
        local normalizedX, normalizedY = x / display.actualContentWidth, 1 - y / display.actualContentHeight

        -- Ajuste a posição da máscara para revelar gradualmente o mapa2
        mapaFeio.maskX = normalizedX * display.contentWidth
        mapaFeio.maskY = normalizedY * display.contentHeight
        mapa2.isVisible = true
    elseif (phase == "ended" or phase == "cancelled") then
        mapa2.isVisible = false
    end

    return true
end

page1Scene:addEventListener("create", page1Scene)

return page1Scene
