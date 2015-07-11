local centerX = display.contentCenterX
local centerY = display.contentCenterY
_W = display.contentWidth
_H = display.contentHeight
display.setStatusBar( display.HiddenStatusBar )

physics = require("physics")
physics.start()
physics.setDrawMode( "hybrid" )

local screen_adjustment = 1.4
local background = display.newImage("imagens/back_estrelas.png", true)
background.xScale = (screen_adjustment  * background.contentWidth)/background.contentWidth
background.yScale = background.xScale
background.x = _W / 2
background.y = _H / 2

chao = display.newRect( _W/2, _H, _W, 10 )
physics.addBody(chao,"static")

teto = display.newRect( _W/2, 0, _W, 10 )
physics.addBody(teto,"static")

nave = require("modelos.nave")
nave = nave:new{}
nave:show(centerX)
nave:inicializa()

function andarNave( event )
	nave:andar(event.x)
end

function onLocalCollision( self, event )
    	if ( event.other.nome == "tiro") then
				event.other:removeSelf()
   		end
end

chao:addEventListener( "touch", andarNave )

teto.collision = onLocalCollision
teto:addEventListener( "collision", teto )

timer.performWithDelay( 752, function() nave:atirar() end, -1 )