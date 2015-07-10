nave = {}
nave.__index=nave

function nave.new(obj)
	return setmetatable( obj, self );
end

function nave:inicializa(fisica)
	
end

function nave:show(x, y)
	
end

return nave