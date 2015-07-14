vilao = {}
vilao.__index=vilao
vilao.imagem=""

function vilao.new(obj)
	return setmetatable( obj, self );
end

function vilao:inicializa(fisica)
	physics.addBody(self.corpo, "hybrid", {density=0.5})
end

function vilao:show(x, y, image)
	self.corpo = display.newImage( "imagens/"..image..".png", x, y, true )
	self.corpo.nome = "vilao"
	self.corpo.pontuacao = 0
	self.corpo:toFront()
	self.imagem = image
end

function vilao:definirPontuacao()
	if self.imagem == "darthvader" then
		self.corpo.pontuacao = 100
	
	elseif self.imagem == "dracula" then
		self.corpo.pontuacao = 80
	
	elseif self.imagem == "joker" then
		self.corpo.pontuacao = 50
	
	elseif self.imagem == "terminator" then
		self.corpo.pontuacao = 30
	
	else
		self.corpo.pontuacao = 0
		
	end
end

return vilao