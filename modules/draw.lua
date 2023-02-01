local expect = require "cc.expect"
local expect, field = expect.expect, expect.field

draw = {}

local origColor = term.getBackgroundColour()
local origMonitor = term.current()

local pickColor = {
    ["white"] = colors.white,
    ["orange"] = colors.orange,
    ["magenta"] = colors.magenta,
    ["lightBlue"] = colors.lightBlue,
    ["yellow"] = colors.yellow,
    ["lime"] = colors.lime,
    ["pink"] = colors.pink,
    ["gray"] = colors.gray,
    ["lightGray"] = colors.lightGray,
    ["cyan"] = colors.cyan,
    ["purple"] = colors.purple,
    ["blue"] = colors.blue,
    ["brown"] = colors.brown,
    ["green"] = colors.green,
    ["red"] = colors.red,
    ["black"] = colors.black
}

function draw.box(w,h,x,y,color,side)
    expect(1, w, "number")
    expect(2, h, "number")
    expect(3, x, "number")
    expect(4, y, "number")
    expect(5, color, "string")
    expect(6, side, "string", "nil")
   	
    if side ~= nil then
        monitor = peripheral.wrap(side)
        term.redirect(monitor)
    end
    theColor = pickColor[color]
    paintutils.drawBox(
        x, y,
        w + x - 1, h + y - 1,
        theColor 
    )

	term.setBackgroundColor(origColor)
    term.redirect(origMonitor)
end

function draw.pixel(x,y,color,side)
    expect(1, x, "number")
    expect(2, y, "number")
    expect(3, color, "string")
    expect(4, side, "string", "nil")
    
    if side ~= nil then
        monitor = peripheral.wrap(side)
        term.redirect(monitor)
    end
    
    theColor = pickColor[color]
    paintutils.drawPixel(x,y,theColor)

	term.setBackgroundColor(origColor)
    term.redirect(origMonitor)
end