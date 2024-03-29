local composer = require("composer")
local audio = require("audio")

local page1Scene = composer.newScene()
local mapaFeio
local mapa2
local pirataTriste
local pirataFeliz
local maxCirculos = 400  -- Defina o número máximo de círculos escuros para revelar o mapa_feio
local contadorCirculos = 0  -- Variável para armazenar a quantidade de círculos
local circulosCriados = {}  -- Tabela para armazenar referências aos círculos criados
local isMapVisible = false  -- Variável para controlar a visibilidade do mapa_feio
local audioButton

local audioFile = "src/sounds/page1.mp3"



local function stopAudioIfPlaying()
    if audio.isChannelActive(1) then
        audio.stop(1)
    end
end

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

    -- Crie o pirata triste inicialmente
    pirataTriste = display.newImageRect(sceneGroup, "src/assets/page1/pirata_triste.png", 180, 180)
    pirataTriste.x = 80 -- Posição na esquerda
    pirataTriste.y = 860 -- Posição na parte inferior

    -- Crie o pirata feliz inicialmente (invisível)
    pirataFeliz = display.newImageRect(sceneGroup, "src/assets/page1/pirata_rico.png", 180, 180)
    pirataFeliz.x = 80
    pirataFeliz.y = 860
    pirataFeliz.isVisible = false

    local buttonRight = display.newImageRect(sceneGroup, "src/assets/icons/arrow-right.png", 78, 34)
buttonRight.x = 695
buttonRight.y = 960
buttonRight:addEventListener('tap', function()
    stopAudioIfPlaying()  -- Adicione esta linha para parar o áudio, se estiver reproduzindo
    esconderCirculos()
    mostrarPirataFeliz()
    composer.removeScene("src.pages.page1")
    composer.gotoScene("src.pages.page2", { effect = "fade", time = 500 })
end)

local buttonLeft = display.newImageRect(sceneGroup, "src/assets/icons/arrow-left.png", 78, 34)
buttonLeft.x = 70
buttonLeft.y = 960
buttonLeft:addEventListener('tap', function()
    stopAudioIfPlaying()  -- Adicione esta linha para parar o áudio, se estiver reproduzindo
    esconderCirculos()
    composer.removeScene("src.pages.page1")
    composer.gotoScene("src.pages.capa", { effect = "fade", time = 500 })
end)

    local audioButton = display.newImageRect(sceneGroup, "src/assets/icons/alto-falante.png", 45, 45)
    audioButton.x = display.contentCenterX
    audioButton.y = 355
    audioButton:addEventListener('tap', toggleAudio)

    -- Adicione um evento de toque para a cena
    sceneGroup:addEventListener("touch", deslizarDedo)
end

function deslizarDedo(event)
    local phase = event.phase

    if (phase == "moved" or phase == "began") then
        local x, y = event.x, event.y

        -- Verifique se as coordenadas estão dentro da área do pirata
        if estaDentroDoPirata(x, y) then
            return true  -- Evite a criação de círculos se o toque estiver no pirata
        end

        -- Verifique se as coordenadas estão dentro da área da imagem e se o mapa_feio não está visível
        if estaDentroDaImagem(x, y) and not isMapVisible then
            -- Crie um círculo escuro
            local circuloEscuro = display.newCircle(mapaFeio.parent, x, y, 30)

            -- Adicione um controle de transparência dependendo da visibilidade do mapa_feio
            local transparencia = isMapVisible and 0.2 or 0.8
            circuloEscuro:setFillColor(0, 0, 0, transparencia)  -- Cor do círculo escuro

            -- Aumente o contador de círculos
            contadorCirculos = contadorCirculos + 1

            -- Adicione o círculo à tabela de circulosCriados
            table.insert(circulosCriados, circuloEscuro)

            -- Se atingir o número máximo de círculos, revele o mapa_feio
            if contadorCirculos >= maxCirculos then
                mostrarMapaFeio()
            end
        end
    end

    return true
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

function estaDentroDoPirata(x, y)
    local margem = 20  -- Ajuste essa margem conforme necessário

    local leftBound = pirataTriste.x - pirataTriste.width / 2 - margem
    local rightBound = pirataTriste.x + pirataTriste.width / 2 + margem
    local upperBound = pirataTriste.y - pirataTriste.height / 2 - margem
    local lowerBound = pirataTriste.y + pirataTriste.height / 2 + margem

    return (x >= leftBound and x <= rightBound and y >= upperBound and y <= lowerBound)
end


function mostrarMapaFeio()
    -- Torne o mapa_feio visível
    mapa2.isVisible = true

    -- Defina a variável para indicar que o mapa_feio está visível
    isMapVisible = true

    -- Remova o evento de toque para que não seja possível adicionar mais círculos
    page1Scene:removeEventListener("touch", deslizarDedo)

    -- Altere a visibilidade dos círculos criados para torná-los invisíveis
    for _, circulo in ipairs(circulosCriados) do
        circulo.isVisible = false
    end

    -- Substitua o pirata triste pelo pirata feliz
    mostrarPirataFeliz()
end

function mostrarPirataFeliz()
    -- Verifique se o mapa2 está visível
    if mapa2.isVisible then
        -- Altere a visibilidade do pirata triste e feliz ao mudar de mapa
        pirataTriste.isVisible = false
        pirataFeliz.isVisible = true
    end
end


function esconderCirculos()
    -- Remova os círculos criados
    for i, circulo in ipairs(circulosCriados) do
        display.remove(circulo)
    end
    circulosCriados = {}
end

function estaDentroDaImagem(x, y)
    local leftBound = mapaFeio.x - mapaFeio.width / 2
    local rightBound = mapaFeio.x + mapaFeio.width / 2
    local upperBound = mapaFeio.y - mapaFeio.height / 2
    local lowerBound = mapaFeio.y + mapaFeio.height / 2

    return (x >= leftBound and x <= rightBound and y >= upperBound and y <= lowerBound)
end


page1Scene:addEventListener("create", page1Scene)
page1Scene:addEventListener("hide", page1Scene)

return page1Scene
