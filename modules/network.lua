local expect = require "cc.expect"
local expect, field = expect.expect, expect.field

net = {}

function net.open(side, protocol, computerName)
	expect(1, side, "string")
    expect(2, protocol, "string")
    expect(3, computerName, "string")
    
    rednet.open(side)
    rednet.host(protocol, computerName)
end

function net.close(protocol)
    expect(1, protocol, "string")
    
    rednet.unhost(protocol)
    rednet.close()
end