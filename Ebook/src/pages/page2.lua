local composer = require("composer")

local page2Scene = composer.newScene()

local mapaOriginal
local mapaSubstituto
local zoomLevel = 1.0
local buttonZoomIn
local buttonZoomOut

local function zoomIn(event)
    zoomLevel = zoomLevel + 0.1
    transition.to(mapaOriginal, { xScale = zoomLevel, yScale = zoomLevel, x = display.contentCenterX, y = 750, time = 1000, onComplete = function()
        mapaOriginal.isVisible = false
        mapaSubstituto.isVisible = true
    end })
end

local function zoomOut(event)
    zoomLevel = zoomLevel - 0.1
    transition.to(mapaOriginal, { xScale = zoomLevel, yScale = zoomLevel, x = display.contentCenterX, y = 750, time = 1000, onComplete = function()
        mapaSubstituto.isVisible = false
        mapaOriginal.isVisible = true
    end })
end

function page2Scene:create(event)
    local sceneGroup = self.view

    local capa = display.newImageRect(sceneGroup, "src/assets/frames/frame3.png", 768, 1024)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY

    buttonZoomIn = display.newText(sceneGroup, "+", 100, 900, native.systemFontBold, 40)
    buttonZoomIn:setFillColor(0, 0, 0)
    buttonZoomIn:addEventListener("tap", zoomIn)

    buttonZoomOut = display.newText(sceneGroup, "-", 200, 900, native.systemFontBold, 40)
    buttonZoomOut:setFillColor(0, 0, 0)
    buttonZoomOut:addEventListener("tap", zoomOut)

    -- Carregue o mapa original
    mapaOriginal = display.newImageRect(sceneGroup, "src/assets/page2/mapa.png", 514, 516)
    mapaOriginal.x = display.contentCenterX
    mapaOriginal.y = 750

    -- Carregue o mapa substituto
    mapaSubstituto = display.newImageRect(sceneGroup, "src/assets/page2/garanhuns_zoom.png", 958, 576)
    mapaSubstituto.x = display.contentCenterX
    mapaSubstituto.y = 750
    mapaSubstituto.isVisible = false  -- Inicialmente invisível
end

return page2Scene