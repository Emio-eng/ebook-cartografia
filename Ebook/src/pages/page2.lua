local composer = require("composer")
system.activate("multitouch")

local page2Scene = composer.newScene()

local mapaOriginal
local mapaSubstituto
local zoomLevel = 1.0
local audioFile = "src/sounds/page5.mp3"

local function stopAudioIfPlaying()
    if audio.isChannelActive(1) then
        audio.stop(1)
    end
end

function toggleAudio()
    if audio.isChannelActive(1) then
        audio.stop(1)
    else
        local options = {
            channel = 1,
            loops = 0,
            fadein = 1000,
        }
        audio.play(audio.loadStream(audioFile), options)
    end
end


local function zoomIn()
    zoomLevel = zoomLevel + 0.1
    transition.to(mapaOriginal, { xScale = zoomLevel, yScale = zoomLevel, x = display.contentCenterX, y = 750, time = 1000, onComplete = function()
        mapaOriginal.isVisible = false
        mapaSubstituto.isVisible = true
    end })
end

local function zoomOut()
    zoomLevel = zoomLevel - 0.1
    transition.to(mapaOriginal, { xScale = zoomLevel, yScale = zoomLevel, x = display.contentCenterX, y = 750, time = 1000, onComplete = function()
        mapaSubstituto.isVisible = false
        mapaOriginal.isVisible = true
    end })
end

function page2Scene:create(event)
    local sceneGroup = self.view

    -- Adicione o restante do código relacionado à cena aqui

    local capa = display.newImageRect(sceneGroup, "src/assets/frames/frame3.png", 768, 1024)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY

    local buttonZoomOut = display.newText(sceneGroup, "-", 200, 900, native.systemFontBold, 40)
    buttonZoomOut:setFillColor(0, 0, 0)
    buttonZoomOut:addEventListener("tap", zoomOut)

    local buttonRight = display.newImageRect(sceneGroup, "src/assets/icons/arrow-right.png", 78, 34)
    buttonRight.x = 695
    buttonRight.y = 960
    buttonRight:addEventListener('tap', function()
        stopAudioIfPlaying()  
        composer.removeScene("src.pages.page2")
        composer.gotoScene("src.pages.page3", {effect = "fade", time = 500})
    end)

    local buttonLeft = display.newImageRect(sceneGroup, "src/assets/icons/arrow-left.png", 78, 34)
    buttonLeft.x = 70
    buttonLeft.y = 960
    buttonLeft:addEventListener('tap', function()
        stopAudioIfPlaying()  
        composer.removeScene("src.pages.page2")
        composer.gotoScene("src.pages.page1", {effect = "fade", time = 500})
    end)

    local audioButton = display.newImageRect(sceneGroup, "src/assets/icons/alto-falante.png", 45, 45)
    audioButton.x = 380
    audioButton.y = 330
    audioButton:addEventListener('tap', toggleAudio)

    -- Carregue o mapa original
    mapaOriginal = display.newImageRect(sceneGroup, "src/assets/page2/mapa.png", 514, 516)
    mapaOriginal.x = display.contentCenterX
    mapaOriginal.y = 750

    -- Carregue o mapa substituto
    mapaSubstituto = display.newImageRect(sceneGroup, "src/assets/page2/garanhuns_zoom.png", 958, 576)
    mapaSubstituto.x = display.contentCenterX
    mapaSubstituto.y = 750
    mapaSubstituto.isVisible = false
end

function page2Scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Adiciona a função de toque ao toque na cena
        sceneGroup:addEventListener("tap", zoomIn)
    elseif (phase == "did") then
        -- Lógica adicional após a cena ser mostrada
    end
end

function page2Scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Remove a função de toque ao toque na cena
        sceneGroup:removeEventListener("tap", zoomIn)
    elseif (phase == "did") then
        -- Lógica adicional após a cena ser ocultada
    end
end

page2Scene:addEventListener("create", page2Scene)
page2Scene:addEventListener("show", page2Scene)
page2Scene:addEventListener("hide", page2Scene)

return page2Scene
