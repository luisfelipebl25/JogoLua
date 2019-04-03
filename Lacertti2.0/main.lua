-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

-- Gerador de numeros random para inimigos--
math.randomseed( os.time() )

-- Configure imagem de folha--
local sheetOptions =
{
    frames =
    {
        {   -- inimigo Esquerda--
            x = 0,
            y = 0,
            width = 100,
            height = 113
        },
        {   -- inimigo Direita--
            x = 0,
            y = 113,
            width = 100,

            height = 107
        },
        {   -- Fruta amarela--
            x = 0,
            y = 220,
            width = 12,
            height = 12
        },
        {   -- Fruta roxa--
            x = 0,
            y = 232,
            width = 12,
            height = 12
        },
        {   -- Fruta Vermelha--
            x = 0,
            y = 244,
            width = 12,
            height = 12
        },
        {   -- Mosca Amarela
            x = 0,
            y = 256,
            width = 17,
            height = 22
        },
        {   -- Mosca Azul--
            x = 0,
            y = 278,
            width = 17,
            height = 22
        },
    },
}
--Carregando folha de imagem e fazendo ref. a tabela sheetOptions --
local objectSheet = graphics.newImageSheet( "ElementosLacertti.png", sheetOptions )

-- Inicializando as variaveis--
local lives = 3
local score = 0
local died = false

local inimigosTabela = {}

local lacertti
local gameLoopTimer
local livesText
local scoreText


-- Configurando grupos de exibicao--
local backGroup = display.newGroup()  -- Grupo de imagens background
local mainGroup = display.newGroup()  -- Grupo de imagens (inimigos, frutas, moscas)
local uiGroup = display.newGroup()    -- Grupo de Textos de pontuacao 

-- Carregando plano BackCeu --
local background1 = display.newImageRect( backGroup, "ceuDegra.png", 360, 570 )
background1.x = display.contentCenterX
background1.y = display.contentCenterY

-- transition.moveBy(background1, {y=900, time=50000})

-- Carregando plano BackRochedo --
local background2 = display.newImageRect( backGroup, "fundoRochedo.png", 360, 570 )
background2.x = display.contentCenterX
background2.y = display.contentCenterY


--Carregar loop arvore -- 
local background3 = display.newImageRect( backGroup, "cauleArv1.png", 360, 570 )
background3.x = display.contentCenterX
background3.y = display.contentCenterY

transition.moveBy(background3, {y=3000, time=25000})

--carregando Personagem--
lacertti = display.newImageRect(mainGroup, "LacerttiDir.png",50,100)
lacertti.x = display.contentCenterX
lacertti.y = display.contentHeight - 10

physics.addBody( lacertti, { radius=20, isSensor=true } )
lacertti.myName = lacertti_name


scoreText = display.newText( "Score: " .. score, 240, 25, native.systemFont, 16 )

scoreText:setFillColor(0.180, 0.65, 0.35  )


--Criando Inimigos--
local inimigosTabela = {}

local function inimigosTabela()
    
    local novoInimigo = display.newImageRect( mainGroup, objectSheet, 1, 100, 113 )
    physics.addBody( novoInimigo, "dynamic", { radius=40, bounce=0.8 } )
    novoInimigo.myName = "inimigo"

    
    novoInimigo:toBack()
    table.insert(inimigosTabela, novoInimigo)
    physics.addBody(novoInimigo, 'dynamic', {isSensor = true})

    novoInimigo.x = math.random( display.contentWidth )
    novoInimigo.y = 5
    novoInimigo:setLinearVelocity( math.random( -30,20 ), math.random( 120,190 ) )
end

-- movendo lagarto

motionx = 0 -- variavel usada para mover o lagarto ao longo do eixo x
speed = 4 -- velocidade do lagarto

local function movePlayer(event)
    local posicao = lacertti.x + motionx
    if (posicao > 85 and posicao < display.contentWidth) then
        lacertti.x = posicao
    end
end
Runtime:addEventListener("enterFrame", movePlayer)
 
 
function playerVelocity(event)
    if (event.phase == "began") then
    if event.x  >= display.contentCenterX then
    motionx = speed
    lacertti.xScale = 1
    elseif event.x <= display.contentCenterX then
    motionx = -speed
    lacertti.xScale = -1
end
elseif (event.phase == "ended") then
motionx = 0
end
end
background1:addEventListener("touch", playerVelocity)