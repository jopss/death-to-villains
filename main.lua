local centerX = display.contentCenterX
local centerY = display.contentCenterY
_W = display.contentWidth
_H = display.contentHeight
display.setStatusBar( display.HiddenStatusBar )

physics = require("physics")
physics.start()
physics.setDrawMode( "hybrid" )
physics.setGravity( 0, 0.3 )

local backs = {"back_estrelas.png", "back_nuvem.jpg"}
local indexBacks = math.random(1,2)

local screen_adjustment = 1.4
local background = display.newImage("imagens/"..backs[indexBacks], true)
background.xScale = (screen_adjustment  * background.contentWidth)/background.contentWidth
background.yScale = background.xScale
background.x = _W / 2
background.y = _H / 2


chao = display.newRect( _W/2, _H, _W, 10 )
chao.nome = "chao"
physics.addBody(chao,"static")

teto = display.newRect( _W/2, 0, _W, 10 )
physics.addBody(teto,"static")

nave = require("modelos.nave")
nave = nave:new{}
nave:show(centerX)
nave:inicializa()

local viloes = {"darthvader", "dracula", "joker", "terminator"}
local qtd_viloes = 0;
local qtd_max_viloes = 20;
totalPontuacao = 0
txtScore = display.newText( "Pontos: 0", _W-60, 15, native.systemFontBold, 14 )

local function contaPontuacao(ponto)
	totalPontuacao = totalPontuacao + ponto
	txtScore:removeSelf()
	txtScore = display.newText( "Pontos: "..totalPontuacao, _W-60, 15, native.systemFontBold, 14 )
end

local function eventoTouchParaAndarNave( event )
	nave:andar(event.x)
end

local function colisaoComTeto( self, event )
    	if ( event.other.nome == "tiro") then
				event.other:removeSelf()
   		end
end

local function colisaoComVilao( self, event )

		--colisao dos viloes com o tiro
    	if ( event.other.nome == "tiro") then
				contaPontuacao(self.pontuacao)
				
				--remove o tiro e o vilao
				self:removeSelf()
				event.other:removeSelf()
				
				--cria uma nova imagem na mesma posicao do vilao removido
				--mas mudando a imagem para o sauron
				--essa imagem nao pode ter fisica associada
				local vilaoMorto = require("modelos.vilao")
				vilaoMorto = vilao:new{}
				vilaoMorto:show(self.x, self.y, "sauron")
				
				--decrescenta a quantidade de viloes na tela
				qtd_viloes=qtd_viloes-1

   		end
		
		--colisao dos viloes com o chao
		if ( event.other.nome == "chao") then
			self:removeSelf() --apaga o vilao que tocou o chao
			
			--decrescenta a quantidade de viloes na tela
			qtd_viloes=qtd_viloes-1
		end
		
		--colisao dos viloes com a nave
		if ( event.other.nome == "nave") then
			--termina o jogo
			physics.pause()
			timer.pause(idTimerAtirar)
			timer.pause(idTimerVilao)
			
			--remove a nave e altera a imagem para a nova morta
			event.other:removeSelf()
			nave = require("modelos.nave")
			nave = nave:new{}
			nave:show(event.other.x, event.other.y, "nave_morta")
			
			-- botao para reiniciar
			local retry = display.newImage( "imagens/retry.png", centerX, centerY, true )
			retry.tap = reiniciarJogo
			retry:addEventListener( "tap", retry )
		end
end

local function criarVilaoEmLoop()
    
	if qtd_viloes < qtd_max_viloes then
		local index = math.random(1,4)
		local posX = math.random(50,1150)
		
		--cria um novo vilao, variando a imagem e a posicao x.
		local vilaoNovo = require("modelos.vilao")
		vilaoNovo = vilao:new{}
		vilaoNovo:show(posX, 50, viloes[index])
		vilaoNovo:inicializa()
		vilaoNovo:definirPontuacao()
		
		--acrescenta a quantidade de viloes na tela
		qtd_viloes=qtd_viloes+1
		
		--registra evento de colisao para este vilao
		vilaoNovo.corpo.collision = colisaoComVilao
		vilaoNovo.corpo:addEventListener( "collision", vilaoNovo.corpo )
	end
	
end

function reiniciarJogo( self, event )
	self:removeSelf()
	
end

chao:addEventListener( "touch", eventoTouchParaAndarNave )

teto.collision = colisaoComTeto
teto:addEventListener( "collision", teto )

idTimerAtirar = timer.performWithDelay( 752, function() nave:atirar() end, -1 )
idTimerVilao = timer.performWithDelay( 800, function() criarVilaoEmLoop() end, -1 )
