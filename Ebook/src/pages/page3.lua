local composer = require("composer")

local page3Scene = composer.newScene()

local satelite
local terra
local orbitRadius = 175
local initialAngle = 45 -- Ângulo inicial em graus
local rotationSpeed = 2 -- Velocidade de rotação em graus por frame
local isAnimating = false
local numRevolutions = 0 -- Número de voltas completas


local audioFile = "src/sounds/page3.mp3"

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

local function projecaoCilindrica()
    if satelite then
        -- Remover satelite, terra e espaco
        display.remove(satelite)
        display.remove(terra)
        display.remove(espaco)

        -- Renderizar a imagem da projeção cilíndrica
        local projecaoCilindrica = display.newImageRect(page3Scene.view, "src/assets/page3/projecao.png", 550, 400)
        projecaoCilindrica.x = display.contentCenterX
        projecaoCilindrica.y = 750
    end
end

local function onEnterFrame(event)
    if isAnimating then
        -- Incrementar a rotação do satélite
        satelite.rotation = satelite.rotation + rotationSpeed

        -- Calcular a posição do satélite com base na rotação e raio da órbita
        local angle = math.rad(satelite.rotation)
        local x = terra.x + orbitRadius * math.cos(angle)
        local y = terra.y + orbitRadius * math.sin(angle)

        -- Atualizar a posição do satélite
        satelite.x, satelite.y = x, y

        -- Verificar se uma volta completa foi feita (360 graus)
        if satelite.rotation >= 360 then
            numRevolutions = numRevolutions + 1
            satelite.rotation = satelite.rotation - 360  -- Reduzir a rotação para evitar números muito grandes
            -- Chamar a função de projeção cilíndrica
            projecaoCilindrica()
            print("Uma volta completa foi feita. Número total de voltas: " .. numRevolutions)
            isAnimating = false  -- Parar a animação após uma volta completa
        end
    end
end

local function onShake(event)
    if numRevolutions >= 1 then
        return
    end

    -- Iniciar ou parar a animação apenas se a quantidade de voltas for menor que 1
    isAnimating = not isAnimating
end

function page3Scene:create(event)
    local sceneGroup = self.view

    local capa = display.newImageRect(sceneGroup, "src/assets/frames/frame4.png", 768, 1024)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY

    espaco = display.newImageRect(sceneGroup, "src/assets/page3/espaco.png", 550, 400)
    espaco.x = display.contentCenterX
    espaco.y = 750

    terra = display.newImageRect(sceneGroup, "src/assets/page3/terra.png", 200, 200)
    terra.x = 386
    terra.y = 750

    -- Calcular a posição inicial do satélite com base no ângulo inicial
    local initialX = terra.x + orbitRadius * math.cos(math.rad(initialAngle))
    local initialY = terra.y + orbitRadius * math.sin(math.rad(initialAngle))

    satelite = display.newImageRect(sceneGroup, "src/assets/page3/satelite.png", 75, 75)
    satelite.x = initialX
    satelite.y = initialY

    local buttonRight = display.newImageRect(sceneGroup, "src/assets/icons/arrow-right.png", 78, 34)
    buttonRight.x = 695
    buttonRight.y = 960
    buttonRight:addEventListener('tap', function()
        stopAudioIfPlaying()  
        composer.removeScene("src.pages.page3")
        composer.gotoScene("src.pages.page4", {effect = "fade", time = 500})
    end)

    local buttonLeft = display.newImageRect(sceneGroup, "src/assets/icons/arrow-left.png", 78, 34)
    buttonLeft.x = 70
    buttonLeft.y = 960
    buttonLeft:addEventListener('tap', function()
        stopAudioIfPlaying()  
        composer.removeScene("src.pages.page3")
        composer.gotoScene("src.pages.page2", {effect = "fade", time = 500})
    end)

    local audioButton = display.newImageRect(sceneGroup, "src/assets/icons/alto-falante.png", 45, 45)
    audioButton.x = 380
    audioButton.y = 440
    audioButton:addEventListener('tap', toggleAudio)
end

 
function page3Scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "did") then
        Runtime:addEventListener("enterFrame", onEnterFrame)
        Runtime:addEventListener("accelerometer", onShake)
    end
end

function page3Scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        Runtime:removeEventListener("enterFrame", onEnterFrame)
        Runtime:removeEventListener("accelerometer", onShake)
    end
end

page3Scene:addEventListener("create", page3Scene)
page3Scene:addEventListener("show", page3Scene)
page3Scene:addEventListener("hide", page3Scene)

return page3Scene
