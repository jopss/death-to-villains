tiro = {}
tiro.__index=tiro

function tiro.new(obj)
	return setmetatable( obj, self );
end

function tiro:inicializa(fisica)
	
end

function tiro:show(x, y)
	
end

return tiro