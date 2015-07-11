nave = {}
nave.__index=nave
nave.altura=_H-60

function nave.new(obj)
	return setmetatable( obj, self );
end

function nave:inicializa()
	physics.addBody(self.corpo, "hybrid")
end

function nave:show(x)
	self.corpo = display.newImage( "imagens/nave.png", x, self.altura, true )
	self.corpo.nome = "nave"
	self.corpo:toFront()
	--self:atirar()
end

function nave:atirar()
	tiro = require("modelos.tiro")
	tiro = tiro:new{}
	tiro:show(self.corpo.x,self.altura)
	tiro:inicializa()
end

function nave:andar(xx)
	transition.moveTo(self.corpo, { x=xx, y=self.altura, time=736})
end

return nave