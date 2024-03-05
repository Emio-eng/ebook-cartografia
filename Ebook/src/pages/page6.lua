local composer = require("composer")

local page6Scene = composer.newScene()

local mapaOriginal
local botaoNorte, textoNorte
local botaoCentro, textoCentro
local botaoNordeste, textoNordeste
local botaoSul, textoSul
local botaoSudeste, textoSudeste
local buttonRight
local buttonLeft

local function removerOuAdicionarImagem(botao, imagemPath, largura, altura, posX, posY)
    if botao.estadoImagem then
        botao.estadoImagem:removeSelf()
        botao.estadoImagem = nil
    else
        botao.estadoImagem = display.newImageRect(imagemPath, largura, altura)
        botao.estadoImagem.x = posX
        botao.estadoImagem.y = posY
    end
end

local function onBotaoNorteClicado(event)
    removerOuAdicionarImagem(event.target, "src/assets/page6/norte.png", 396, 269, 308, 610)
end

local function onBotaoNordesteClicado(event)
    removerOuAdicionarImagem(event.target, "src/assets/page6/nordeste.png", 231, 252, 560, 690)
end

local function onBotaoSudesteClicado(event)
    removerOuAdicionarImagem(event.target, "src/assets/page6/sudeste.png", 210, 160, 500, 832)
end

local function onBotaoSulClicado(event)
    removerOuAdicionarImagem(event.target, "src/assets/page6/sul.png", 126, 163, 405, 945)
end

local function onBotaoCentroOesteClicado(event)
    removerOuAdicionarImagem(event.target, "src/assets/page6/centro_oeste.png", 232, 258, 395, 755)
end

local function criarBotaoTexto(sceneGroup, x, y, texto, distanciaTexto, callback)
    local botao = display.newRect(sceneGroup, x, y, 38, 35)
    botao:setFillColor(0, 0, 0, 0)  
    botao:setStrokeColor(0, 0, 0)   
    botao.strokeWidth = 2  

    local areaToque = display.newRect(sceneGroup, botao.x, botao.y, botao.width + 10, botao.height + 10)
    areaToque:setFillColor(0, 0, 0, 0)  
    areaToque.strokeWidth = 0  
    areaToque.isHitTestable = true 

    local textoBotao = display.newText(sceneGroup, texto, botao.x + botao.width / 2 + distanciaTexto, botao.y, native.systemFont, 20)
    textoBotao:setFillColor(0, 0, 0) 

    areaToque:addEventListener("tap", function(event)
        callback(event)
    end)

    return areaToque, textoBotao
end

local function resetBotoes()
    if botaoNorte and botaoNorte.estadoImagem then
        botaoNorte.estadoImagem:removeSelf()
        botaoNorte.estadoImagem = nil
    end

    if botaoNordeste and botaoNordeste.estadoImagem then
        botaoNordeste.estadoImagem:removeSelf()
        botaoNordeste.estadoImagem = nil
    end

    if botaoSudeste and botaoSudeste.estadoImagem then
        botaoSudeste.estadoImagem:removeSelf()
        botaoSudeste.estadoImagem = nil
    end

    if botaoSul and botaoSul.estadoImagem then
        botaoSul.estadoImagem:removeSelf()
        botaoSul.estadoImagem = nil
    end

    if botaoCentro and botaoCentro.estadoImagem then
        botaoCentro.estadoImagem:removeSelf()
        botaoCentro.estadoImagem = nil
    end
end



function page6Scene:create(event)
    local sceneGroup = self.view

    -- Carregue a capa
    local capa = display.newImageRect(sceneGroup, "src/assets/frames/frame7.png", 768, 1024)
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY

    -- Carregue o mapa original
    mapaOriginal = display.newImageRect(sceneGroup, "src/assets/page6/mapa_inteiro.png", 550, 550)
    mapaOriginal.x = display.contentCenterX
    mapaOriginal.y = 750
 
    -- Crie os botões para navegação
   
    buttonRight = display.newImageRect(sceneGroup, "src/assets/icons/arrow-right.png", 78, 34)
    buttonRight.x = 695
    buttonRight.y = 960
    buttonRight:addEventListener('tap', function()
        composer.removeScene("src.pages.page6") -- Remover a cena atual
        resetBotoes()
        composer.gotoScene("src.pages.contracapa", {effect = "fade", time = 500})
    end)
    
    buttonLeft = display.newImageRect(sceneGroup, "src/assets/icons/arrow-left.png", 78, 34)
    buttonLeft.x = 70
    buttonLeft.y = 960
    buttonLeft:addEventListener('tap', function()
        composer.removeScene("src.pages.page6") -- Remover a cena atual
        resetBotoes()
        composer.gotoScene("src.pages.page5", {effect = "fade", time = 500})
    end)

    botaoNorte, textoNorte = criarBotaoTexto(sceneGroup, display.contentCenterX - 320, 800, "Norte", 30, onBotaoNorteClicado)
    botaoCentro, textoCentro = criarBotaoTexto(sceneGroup, display.contentCenterX - 320, 840, "Centro-oeste", 60, onBotaoCentroOesteClicado)
    botaoNordeste, textoNordeste = criarBotaoTexto(sceneGroup, display.contentCenterX - 320, 880, "Nordeste", 45, onBotaoNordesteClicado)
    botaoSul, textoSul = criarBotaoTexto(sceneGroup, display.contentCenterX - 320, 920, "Sul", 20, onBotaoSulClicado)
    botaoSudeste, textoSudeste = criarBotaoTexto(sceneGroup, display.contentCenterX - 320, 760, "Sudeste", 40, onBotaoSudesteClicado)

end

function page6Scene:hide(event)
    if event.phase == "will" then
        -- Remover os elementos ao sair da cena
        display.remove(mapaOriginal)
        resetBotoes()
    end
end

page6Scene:addEventListener("create", page6Scene)
page6Scene:addEventListener("hide", page6Scene)

return page6Scene
