local PATH = (...):gsub('%.init$', '')

--COMPONENTS

return {
	position = require(PATH..".cPosition"),
	size = require(PATH..".cSize"),
	color = require(PATH..".cColor"),
	timer = require(PATH..".cTimer"),
	depth = require(PATH..".cDepth"),
	text = require(PATH..".cText"),
	id = require(PATH..".cID"),
	move_speed = require(PATH..".cMoveSpeed"),
	direction = require(PATH..".cDirection"),
	key_input = require(PATH..".cKeyInput"),
	sprite = require(PATH..".cSprite"),
	gravity = require(PATH..".cGravity"),
	visible = require(PATH..".cVisible"),
	movable = require(PATH..".cMovable"),
	shadow = require(PATH..".cShadow"),
	jump = require(PATH..".cJump"),
	dive = require(PATH..".cDive"),
	record = require(PATH..".cRecord"),
	grids = require(PATH..".cGrids"),
}
