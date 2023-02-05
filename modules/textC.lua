---@diagnostic disable: lowercase-global, undefined-global
local expect = require "cc.expect"
local expect, field = expect.expect, expect.field

textC = {}

local origBgColor = term.getBackgroundColour()
local origTxtColor = term.getTextColor()
local origMonitor = term.current()

local pickColor = {
    ["white"] = "0",
    ["orange"] = "1",
    ["magenta"] = "2",
    ["lightBlue"] = "3",
    ["yellow"] = "4",
    ["lime"] = "5",
    ["pink"] = "6",
    ["gray"] = "7",
    ["lightGray"] = "8",
    ["cyan"] = "9",
    ["purple"] = "a",
    ["blue"] = "b",
    ["brown"] = "c",
    ["green"] = "d",
    ["red"] = "e",
    ["black"] = "f"
}

function textC.write(msg, txtColor, bgColor, x, y, side)
    expect(1, msg, "string")
    expect(2, txtColor, "string")
    expect(3, bgColor, "string")
    expect(4, x, "number")
    expect(5, y, "number")
    expect(6, side, "string", "nil")

    if side ~= nil then
        monitor = peripheral.wrap(side)
        term.redirect(monitor)
    end

    term.setCursorPos(x,y)
    finalTxtColor = dupeTxt(pickColor[txtColor], #msg)
    finalBgColor = dupeTxt(pickColor[bgColor], #msg)
    term.blit( msg, finalTxtColor, finalBgColor)

    term.setBackgroundColor(origBgColor)
    term.setTextColor(origTxtColor)
    term.redirect(origMonitor)
end

function textC.clear(side)
    expect(1, side, "string", "nil")
	
	if side ~= nil then
        monitor = peripheral.wrap(side)
        term.redirect(monitor)
	end
	
	term.clear()
    term.redirect(origMonitor)
end

function dupeTxt(txt, amount)
    expect(1, txt, "string")
    expect(2, amount, "number")
    
    tmp = ""
    
    for x = 1, amount, 1 do
        tmp = tmp .. txt
    end
    
    return tmp
end