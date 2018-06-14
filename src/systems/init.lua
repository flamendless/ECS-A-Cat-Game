local PATH = (...):gsub('%.init$', '')

--SYSTEMS

return {
	render_box = require(PATH..".sRenderBox"),
	render_text = require(PATH..".sRenderText"),
	render_sprite = require(PATH..".sRenderSprite"),
	debugging = require(PATH..".sDebugging"),
	timer = require(PATH..".sTimer"),
	movement = require(PATH..".sMovement"),
	key_input = require(PATH..".sKeyInput"),
	gravity = require(PATH..".sGravity"),
	world3D = require(PATH..".sWorld3D"),
	record = require(PATH..".sRecord"),
	direction = require(PATH..".sDirection"),
	jump = require(PATH..".sJump"),
	grids = require(PATH..".sGrids"),
	gui = require(PATH..".sGUI"),
}
