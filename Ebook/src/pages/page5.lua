local composer = require("composer")

local page5Scene = composer.newScene()

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

function page5Scene:create(event)
    local sceneGroup = self.view

    -- Adicione o restante do código relacionado à cena aqui

    local capa = display.newImageRect(sceneGroup, "src/assets/frames/Frame6.png", 768, 1024)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY

    local buttonRight = display.newImageRect(sceneGroup, "src/assets/icons/arrow-right.png", 78, 34)
    buttonRight.x = 695
    buttonRight.y = 960
    buttonRight:addEventListener('tap', function()
        stopAudioIfPlaying()  
        composer.removeScene("src.pages.page5")
        composer.gotoScene("src.pages.page6", {effect = "fade", time = 500})
    end)

    local buttonLeft = display.newImageRect(sceneGroup, "src/assets/icons/arrow-left.png", 78, 34)
    buttonLeft.x = 70
    buttonLeft.y = 960
    buttonLeft:addEventListener('tap', function()
        stopAudioIfPlaying()  
        composer.removeScene("src.pages.page5")
        composer.gotoScene("src.pages.page4", {effect = "fade", time = 500})
    end)

    local audioButton = display.newImageRect(sceneGroup, "src/assets/icons/alto-falante.png", 45, 45)
    audioButton.x = 380
    audioButton.y = 495
    audioButton:addEventListener('tap', toggleAudio)

end
page5Scene:addEventListener("create", page5Scene)

return page5Scene
