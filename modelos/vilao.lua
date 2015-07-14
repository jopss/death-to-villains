vilao = {}
vilao.__index=vilao

function vilao.new(obj)
	return setmetatable( obj, self );
end

function vilao:inicializa(fisica)
	physics.addBody(self.corpo, "hybrid", {density=0.5})
end

function vilao:show(x, y, image)
	self.corpo = display.newImage( "imagens/"..image..".png", x, y, true )
	self.corpo.nome = "vilao"
	self.corpo:toFront()
end

return vilao