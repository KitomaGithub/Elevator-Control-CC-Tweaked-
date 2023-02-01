local expect = require "cc.expect"
local expect, field = expect.expect, expect.field

elevator = {}

function elevator.up(side, blocks)
	expect(1, side, "string")
    expect(2, blocks, "number")
    
	motor = peripheral.warap(side)
	motor.setSpeed(-32)
	sleep(motor.translate(blocks))
	motor.stop()
end

function elevator.down(side, blocks)
	expect(1, side, "string")
    expect(2, blocks, "number")
    
	motor = peripheral.warap(side)
	motor.setSpeed(32)
	sleep(motor.translate(blocks))
	motor.stop()
end