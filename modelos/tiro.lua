tiro = {}
tiro.__index=tiro

function tiro.new(obj)
	return setmetatable( obj, self );
end

function tiro:inicializa()
	physics.addBody(self.corpo, "hybrid")
end

function tiro:show(xx, yy)
	self.corpo = display.newImage( "imagens/laser.png", xx, yy-60, true )	
	self.corpo.nome = "tiro"
	transition.moveTo(self.corpo, { x=xx, y=0-(self.corpo.contentHeight), time=736})
end

return tiro