function love.conf(t)
	t.releases = {
	  title = "A Cat Game",
	  loveVersion = "11.0",
	  version = "0.0.1",
	  author = "Brandon Blanker Lim-it",
	  homepage = "http://twitter.com/@flamendless",
	  email = "flamendless8@gmail.com",
	  description = "A Cute and Cuddly Game about cats",
	  excludeFileList = {
	    "*.git",
	    "*.md",
	    "*.zip",
	    "*.love",
	  },
	  releaseDirectory = "build",
	}
	t.window.title = t.releases.title
	t.window.width = 1028
	t.window.height = 720
end
