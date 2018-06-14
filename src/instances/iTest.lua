--THIS IS FOR TESTING ECS

return function()
	local test = ECS.Instance()

	local height = 32
	--Entities
	local sample = ECS.Entity()
		:give(COMPONENTS.record)
		:give(COMPONENTS.color, {1,0,0,1})
		:give(COMPONENTS.position, 32,64,-height)
		:give(COMPONENTS.size, 32,32,height)
		:give(COMPONENTS.move_speed, 100)
		:give(COMPONENTS.jump, 300)
		:give(COMPONENTS.direction)
		:give(COMPONENTS.shadow)
		:give(COMPONENTS.key_input, {
				keypressed = {
					space = LOGIC.jump(),
				},
				down = {
					a = LOGIC.moveHorizontal(-1),
					d = LOGIC.moveHorizontal(1),
					w = LOGIC.moveVertical(-1),
					s = LOGIC.moveVertical(1),
				}
			})
		:give(COMPONENTS.id, "red box")
		:apply()

	local record_manager = ECS.Entity()
		:give(COMPONENTS.record)
		:give(COMPONENTS.key_input, {
				keypressed = {
					r = function() GAME.current:emit("manager", "record") end,
					p = function() GAME.current:emit("manager", "replay") end,
				},
				down = {
					n = function() GAME.current:emit("manager", "nextFrame") end,
					b = function() GAME.current:emit("manager", "previousFrame") end,
				}
			})
		:apply()

	local left_wall = ECS.Entity()
		:give(COMPONENTS.position, 0,20,-height)
		:give(COMPONENTS.size, 32,CONST.game_size.y,height)
		:give(COMPONENTS.id, "left_wall")
		:apply()
	local top_wall = ECS.Entity()
		:give(COMPONENTS.position, 0,20,-height)
		:give(COMPONENTS.size, CONST.game_size.x,32,height)
		:give(COMPONENTS.id, "top_wall")
		:apply()
	local right_wall = ECS.Entity()
		:give(COMPONENTS.position, CONST.game_size.x - 32,20,-height)
		:give(COMPONENTS.size, 32,CONST.game_size.y,height)
		:give(COMPONENTS.id, "right_wall")
		:apply()
	local bottom_wall = ECS.Entity()
		:give(COMPONENTS.position, 0,CONST.game_size.y,-height)
		:give(COMPONENTS.size, CONST.game_size.x,32,height)
		:give(COMPONENTS.id, "bottom_wall")
		:apply()
	local tall_wall = ECS.Entity()
		:give(COMPONENTS.position, 128,128,-height*2)
		:give(COMPONENTS.size, 64,64,height*2)
		:apply()
	local floor = ECS.Entity()
		:give(COMPONENTS.position, 0,0,0)
		:give(COMPONENTS.size, CONST.game_size.x, CONST.game_size.y, 5)
		:give(COMPONENTS.visible, false)
		:give(COMPONENTS.id, "floor")
		:apply()
	local wall = ECS.Entity()
		:give(COMPONENTS.position, 32, CONST.game_size.y/2, -height)
		:give(COMPONENTS.size, CONST.game_size.x/4, 32, height)
		:apply()

	--Systems
	local debugging = SYSTEMS.debugging()
	local key_input = SYSTEMS.key_input()
	local world3D = SYSTEMS.world3D()
	local record = SYSTEMS.record()
	local dir = SYSTEMS.direction()
	local gui = SYSTEMS.gui()

	--System Adding
	test:addSystem(world3D, "init")

	test:addSystem(dir, "update")
	test:addSystem(dir, "change_dir")

	test:addSystem(record, "capture")
	test:addSystem(record, "update")
	test:addSystem(record, "draw")
	test:addSystem(record, "manager")

	test:addSystem(key_input, "update")
	test:addSystem(key_input, "replayUpdate")
	test:addSystem(key_input, "keypressed")
	test:addSystem(key_input, "keyreleased")
	test:addSystem(key_input, "replayKeys")

	test:addSystem(SYSTEMS.jump(), "jump")

	test:addSystem(SYSTEMS.movement(), "update")
	test:addSystem(SYSTEMS.timer(), "update")

	test:addSystem(SYSTEMS.render_box(), "draw")
	test:addSystem(SYSTEMS.render_text(), "draw")

	if CONST.test then
		test:addSystem(debugging, "addMSG")
		test:addSystem(debugging, "draw")
		test:addSystem(debugging, "mousepressed")
		test:addSystem(debugging, "mousereleased")
		test:addSystem(debugging, "keyreleased")
	end

	test:addSystem(gui, "register")
	test:addSystem(gui, "draw")
	
	--Entity Adding
	GAME:addEntities(test, sample, left_wall, top_wall, right_wall, bottom_wall, wall, floor, tall_wall, record_manager)

	return test
end
