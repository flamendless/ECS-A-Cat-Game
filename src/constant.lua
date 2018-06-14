local constant = {}

function constant:new(t)
	local mt = {
		__index = function(self, key)
			if t[key] == nil then error(("%s does not exist."):format(key))
			else return t[key] end
		end,
		__newindex = function(self, key, value)
			error(("%s cannot be modified to %s"):format(key, value))
		end,
		__metatable = false
	}
	return setmetatable({}, mt)
end

function constant:set(t)
	local _t = {}
	for k, v in pairs(t) do
		_t[k] = v
	end
	return self:new(_t)
end

return constant
