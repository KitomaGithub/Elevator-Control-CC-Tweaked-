local expect = require "cc.expect"
local expect, field = expect.expect, expect.field

file = {}

function file.save(pathFile, data)
    expect(1, pathFile, "string")

	fs.delete(pathFile)
	local lFile = fs.open(pathFile, "a")
	lFile.write(data)
	lFile.close()
end