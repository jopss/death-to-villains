vilao = {}
vilao.__index=vilao

function vilao.new(obj)
	return setmetatable( obj, self );
end

function vilao:inicializa(fisica)
	
end

function vilao:show(x, y)
	
end

return vilao