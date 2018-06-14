local ecs = require("modules.Concord.concord").init({
		useEvents = false
	})

io.stdout:setvbuf("no")
math.randomseed(os.time())

--load modules
require("modules.lovedebug.lovedebug")
Flux = require("modules.flux.flux")
Vector = require("modules.brinevector.brinevector")
Vector3D = require("modules.brinevector3D.brinevector3D")
Lume = require("modules.lume.lume")
Timer = require("modules.hump.timer")
Inspect = require("modules.inspect.inspect")
Log = require("modules.log.log")
Log.usecolor = false
Bump3D = require("modules.bump-3dpd.bump-3dpd")

--Others
UTILS = require("src.utils")
GAME = require("src.game")
LOGIC = require("src.logic")
CONSTANT = require("src.constant")

--declare global variables
local _CONST = {}
_CONST.window_size = Vector(love.graphics.getDimensions())
_CONST.game_size = _CONST.window_size/2
_CONST.ratio = math.min((_CONST.window_size.x / _CONST.game_size.x),(_CONST.window_size.y / _CONST.game_size.y))
_CONST.gravity = 1280
_CONST.dt_multiplier = 1
_CONST.isPixel = true
_CONST.test = true

CONST = CONSTANT:set(_CONST)

--load main ECS libs
ECS = {}
ECS.Component = require("modules.Concord.concord.component")
ECS.System = require("modules.Concord.concord.system")
ECS.Instance = require("modules.Concord.concord.instance")
ECS.Entity = require("modules.Concord.concord.entity")

COMPONENTS = require("src.components")
SYSTEMS = require("src.systems")
INSTANCES = require("src.instances")
ENTITIES = require("src.entities")

function love.load()
	if CONST.isPixel then
		love.graphics.setDefaultFilter("nearest", "nearest", 1)
	end
	GAME.current = INSTANCES.test()
end

function love.update(dt)
	Flux.update(dt)
	Timer.update(dt)
	GAME.current:emit("update", dt)
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(CONST.ratio, CONST.ratio)
	love.graphics.setColor(1,1,1,1)
	GAME.current:emit("draw")
	--RENDERER:draw()
	love.graphics.pop()
end

function love.keypressed(key)
	GAME.current:emit("keypressed", key)
end

function love.keyreleased(key)
	GAME.current:emit("keyreleased", key)
end

function love.mousepressed(x,y,mb)
	local mx = x/CONST.ratio
	local my = y/CONST.ratio
	GAME.current:emit("mousepressed", mx,my,mb)
end

function love.mousereleased(x,y,mb)
	local mx = x/CONST.ratio
	local my = y/CONST.ratio
	GAME.current:emit("mousereleased", mx,my,mb)
end
