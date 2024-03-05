local composer = require("composer")
local physics = require("physics")

local page1Scene = composer.newScene()
local mapaOriginal
local personagem
local pontos = {
    {271, 646},
    {163, 780},
    {239, 842},
    {287, 818},
    {343, 726},
    {439, 718},
}

local retangulos = {} 

function page1Scene:create(event)
    local sceneGroup = self.view

    physics.start()
    physics.setGravity(0, 0)  

    local capa = display.newImageRect(sceneGroup, "src/assets/frames/frame2.png", 768, 1024)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY

    mapaOriginal = display.newImageRect(sceneGroup, "src/assets/page1/mapa2.jpeg", 590, 430)
    mapaOriginal.x = display.contentCenterX
    mapaOriginal.y = 735

    -- Cria retas entre os pontos
    for i = 1, #pontos - 1 do
        local x1, y1 = pontos[i][1], pontos[i][2]
        local x2, y2 = pontos[i + 1][1], pontos[i + 1][2]

        local linha = display.newLine(sceneGroup, x1, y1, x2, y2)
        linha:setStrokeColor(1, 1, 1)  -- Branco
        linha.strokeWidth = 25  -- Ajuste conforme necessário
    end

    -- Reposiciona o personagem para o primeiro ponto
    personagem = display.newImageRect(sceneGroup, "src/assets/page1/pirate.png", 50, 50)
    personagem.x, personagem.y = pontos[1][1], pontos[1][2]
    


    local buttonRight = display.newImageRect(sceneGroup, "src/assets/icons/arrow-right.png", 78, 34)
    buttonRight.x = 695
    buttonRight.y = 960
    buttonRight:addEventListener('tap', function()
        composer.removeScene("src.pages.page1") -- Remover a cena atual
        composer.gotoScene("src.pages.page2", {effect = "fade", time = 500})
    end)
    
    local buttonLeft = display.newImageRect(sceneGroup, "src/assets/icons/arrow-left.png", 78, 34)
    buttonLeft.x = 70
    buttonLeft.y = 960
    buttonLeft:addEventListener('tap', function()
        composer.removeScene("src.pages.page1") -- Remover a cena atual
        composer.gotoScene("src.pages.capa", {effect = "fade", time = 500})
    end)

   

    -- Cria retângulos como colisões
    for i = 1, #pontos - 1 do
        local x1, y1 = pontos[i][1], pontos[i][2]
        local x2, y2 = pontos[i + 1][1], pontos[i + 1][2]

        local width = math.abs(x2 - x1)
        local height = math.abs(y2 - y1)

        local rect = display.newRect(sceneGroup, x1 + width / 2, y1 + height / 2, width, height)
        rect:setFillColor(0, 0, 0, 0)  -- Define a opacidade para 0 para tornar o retângulo invisível

        retangulos[#retangulos + 1] = rect
    end

    -- Adiciona a função de arrastar ao personagem
    personagem:addEventListener("touch", arrastarPersonagem)
end

function arrastarPersonagem(event)
    local phase = event.phase

    if (phase == "began") then
        display.currentStage:setFocus(personagem)
        personagem.isFocus = true
        personagem.x0 = event.x - personagem.x
        personagem.y0 = event.y - personagem.y

    elseif (personagem.isFocus) then
        if (phase == "moved") then
            local novoX = event.x - personagem.x0
            local novoY = event.y - personagem.y0

            personagem.x = novoX
            personagem.y = novoY
        elseif (phase == "ended" or phase == "cancelled") then
            display.currentStage:setFocus(nil)
            personagem.isFocus = false
        end
    end

    return true
end

page1Scene:addEventListener("create", page1Scene)

return page1Scene
