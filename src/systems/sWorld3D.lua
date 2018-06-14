local world3D = ECS.System({COMPONENTS.position, COMPONENTS.size})

local getZSortedItems = require("modules.zsorted")

function world3D:init()
	self.world = Bump3D.newWorld()
	GAME.world = self.world
end

function world3D:entityAdded(e)
	local pos = e:get(COMPONENTS.position).pos
	local size = e:get(COMPONENTS.size).size
	self.world:add(e, pos.x, pos.y, pos.z, size.x, size.y, size.z)
end

function world3D:entityRemoved(e)
	self.world:remove(e)
end

return world3D
