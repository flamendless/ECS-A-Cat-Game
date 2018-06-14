local PATH = (...):gsub('%.init$', '')

--INSTANCES

return {
	test = require(PATH..".iTest"),
}
