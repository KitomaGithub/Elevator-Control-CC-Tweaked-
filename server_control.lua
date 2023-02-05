local expect = require "cc.expect"
local expect, field = expect.expect, expect.field

require("/modules/network")
require("/modules/fileSys")
require("/modules/textC")
require("/modules/elevMove")
require("/modules/draw")

-- CLear screen
textC.clear()

-- Text and Background Color
barBg = "red"
tab1Bg = "yellow"
tab2Bg = "orange"
tabTxt = "black"

--get The screen size
screen = {term.getSize()}
width = screen[1]
height = screen[2]

-- Set the variables for console and manual
manual = "manual"
console = "console"

-- Initialize server_hosts
server_hosts = {
    "floor_0",
    "floor_1"
}

-- Initialize the variable for "floor"
if fs.exists("data/floor/current") ~= true then
    fs.makeDir("data/floor")
    file.save("data/floor/current", "0")
end

if fs.exists("data/floor/max") == false then
    file.save("data/floor/max", "1")
end

if fs.exists("data/floor/min") == false then
    file.save("data/floor/min", "-1")
end

floorData = fs.open("data/floor/current", "r")
floor = floorData.readLine()
floorData.close()

maxData = fs.open("data/floor/max", "r")
max = maxData.readLine()
maxData.close()

minData = fs.open("data/floor/min", "r")
min = minData.readLine()
minData.close()

-- Switch console variables
manual_console_y = 6
manual_console_x = 14

-- Initialize the functions
function consoleTab()
    tempFloor = nil
    manual_console_y = 6

    textC.clear()
    currentTab = console
    draw.box(width,1,1,1,barBg)
    textC.write("Neko Elevator","white",barBg,width - 16,1)
    draw.box(width,1,1,2,tab1Bg)
    draw.box(9,1,1,1,tab1Bg)
    textC.write("Console",tabTxt,tab1Bg,2,1)
    draw.box(8,1,10,1,tab2Bg)
    textC.write("Manual",tabTxt,tab2Bg,11,1)
    draw.box(3,1,width - 2,1,"white")
    textC.write("x",tabTxt,"white",width - 1,1)

    term.setCursorPos(1,4)
    print("[*] Current Floor: "..floor)
end

function manualTab()
    textC.clear()
    currentTab = manual
    draw.box(width,1,1,1,barBg)
    textC.write("Neko Elevator","white",barBg,width - 16,1)
    draw.box(width,1,1,2,tab2Bg)
    draw.box(9,1,1,1,tab1Bg)
    textC.write("Console",tabTxt,tab1Bg,2,1)
    draw.box(8,1,10,1,tab2Bg)
    textC.write("Manual",tabTxt,tab2Bg,11,1)
    draw.box(3,1,width - 2,1,"white")
    textC.write("x",tabTxt,"white",width - 1,1)

    draw.image("images/up_arrow.nfp", 2,4)
    draw.image("images/down_arrow.nfp", 2,12)

    draw.box(width - 12, 7, 12, 4, "yellow")

    draw.image("images/left_arrow.nfp", 12,12)
    draw.image("images/right_arrow.nfp", width - 6,12)

    draw.box(18, 7, 19, 12, "yellow")

    draw.square(8, 7, 36, 12, "yellow")
    draw.box(6, 5, 37, 13, "gray")
    draw.square(4, 3, 38, 14, "green")

    term.setCursorPos(14,6)
    manual_console_y = manual_console_y + 1
    term.write("[*] Set to Manual Control")
    -- print("[*] max: "..max)
    -- print("[*] current: "..floor)
    -- print("[*] min: "..min)

    term.setCursorPos(21,14)
    term.write("Current")
    term.setCursorPos(21,15)
    term.write("Floor: "..floor)

    term.setCursorPos(manual_console_x,manual_console_y)
end

function verifyUsers(id)
    expect(1, id, "number")

    verified = false

    for _, server_host in pairs(server_hosts) do
        host_id = rednet.lookup("elev_cmd", server_host)

        if host_id == id then
            verified = true
            break
        end
    end

    return verified
end

function checkCursor()
    
    cursorPos = { term.getCursorPos() }
    if cursorPos[2] >= height - 2 and currentTab == console then
        if currentTab == console then
            consoleTab()
        elseif currentTab == manual then
            manualTab()
        end
        
        term.setCursorPos(1,4)
    end
    
end

tempFloor = nil
function elevMove(cmd, destination)
    expect(1, cmd, "string")
    expect(2, destination, "number", "nil")

    tempFloor = nil

    if currentTab == console then
        if cmd == "up" and tonumber(floor) < tonumber(max) then
            print("[*] Elevator Moving Up...")
            floor = floor + 1
            file.save("data/floor/current", floor)
            sleep(2)
            print("[*] Elevator arrived at Floor: "..floor)
        elseif cmd == "down" and tonumber(floor) > tonumber(min) then
            print("[*] Elevator Moving down...")
            floor = floor - 1
            file.save("data/floor/current", floor)
            sleep(2)
            print("[*] Elevator arrived at Floor: "..floor)
        elseif cmd == "moveTo" then
            if floor > tempFloor then
                floor = floor + tempFloor

            elseif floor < tempFloor then
                floor = floor - tempFloor

            end
        end
    
    elseif currentTab == manual then
        if cmd == "up" and tonumber(floor) < tonumber(max) then
            floor = floor + 1
            file.save("data/floor/current", floor)
            draw.square(width - 14, 5, 13, 5, "black")
            draw.square(16, 5, 20, 13, "black")
            term.setCursorPos(14,6)
            print("[*] Elevator Moving Up...")
            term.setCursorPos(21,14)
            term.write("Currently")
            term.setCursorPos(21,15)
            term.write("Moving Up...")
            sleep(2)
            draw.square(16, 5, 20, 13, "black")
            term.setCursorPos(14,7)
            print("[*] Elevator arrived at destination")
            term.setCursorPos(21,14)
            term.write("Current")
            term.setCursorPos(21,15)
            term.write("Floor: "..floor)
        elseif cmd == "down" and tonumber(floor) > tonumber(min) then
            floor = floor - 1
            file.save("data/floor/current", floor)
            draw.square(width - 14, 5, 13, 5, "black")
            draw.square(16, 5, 20, 13, "black")
            term.setCursorPos(14,6)
            print("[*] Elevator Moving Down...")
            term.setCursorPos(21,14)
            term.write("Currently")
            term.setCursorPos(21,15)
            term.write("Moving Down...")
            sleep(2)
            draw.square(16, 5, 20, 13, "black")
            term.setCursorPos(14,7)
            print("[*] Elevator arrived at destination")
            term.setCursorPos(21,14)
            term.write("Current")
            term.setCursorPos(21,15)
            term.write("Floor: "..floor)
        elseif cmd == "moveTo" and destination ~= nil then
            if tonumber(floor) > tonumber(destination) then
                currentFloor = floor
                floor = destination
                file.save("data/floor/current", floor)

                file.save("data/floor/current", floor)
                draw.square(width - 14, 5, 13, 5, "black")
                draw.square(16, 5, 20, 13, "black")
                term.setCursorPos(14,6)
                print("[*] Elevator Moving Down...")
                term.setCursorPos(21,14)
                term.write("Currently")
                term.setCursorPos(21,15)
                term.write("Moving Down...")
                sleep(2 * math.abs(destination - currentFloor))
                draw.square(16, 5, 20, 13, "black")
                term.setCursorPos(14,7)
                print("[*] Elevator arrived at destination")
                term.setCursorPos(21,14)
                term.write("Current")
                term.setCursorPos(21,15)
                term.write("Floor: "..floor)
            elseif tonumber(floor) < tonumber(destination) then
                currentFloor = floor
                floor = destination
                file.save("data/floor/current", floor)
                
                file.save("data/floor/current", floor)
                draw.square(width - 14, 5, 13, 5, "black")
                draw.square(16, 5, 20, 13, "black")
                term.setCursorPos(14,6)
                print("[*] Elevator Moving Up...")
                term.setCursorPos(21,14)
                term.write("Currently")
                term.setCursorPos(21,15)
                term.write("Moving Up...")
                sleep(2 * math.abs(destination - currentFloor))
                draw.square(16, 5, 20, 13, "black")
                term.setCursorPos(14,7)
                print("[*] Elevator arrived at destination")
                term.setCursorPos(21,14)
                term.write("Current")
                term.setCursorPos(21,15)
                term.write("Floor: "..floor)
            end
        end
    end
end

function selectFloor(cmd)
    if tempFloor == nil then
        tempFloor = floor
    end

    if cmd == "left" and tonumber(tempFloor) > tonumber(min) then

        draw.square(16, 5, 20, 13, "black")
        term.setCursorPos(21,14)
        term.setCursorPos(21,14)
        tempFloor = tempFloor - 1
        if tostring(tempFloor) == tostring(floor) then
            term.write("Current")
        else
            term.write("Move to ")
        end
        term.setCursorPos(21,15)
        term.write("Floor: "..tempFloor)

    elseif cmd == "right" and tonumber(tempFloor) < tonumber(max) then

        draw.square(16, 5, 20, 13, "black")
        term.setCursorPos(21,14)
        term.setCursorPos(21,14)
        tempFloor = tempFloor + 1
        if tostring(tempFloor) == tostring(floor) then
            term.write("Current")
        else
            term.write("Move to ")
        end
        term.setCursorPos(21,15)
        term.write("Floor: "..tempFloor)
    end
end

-- Start code
term.setCursorPos(1,1)
print("[ Neko Elev OS ]")

print("[*] Starting Server. . .")
sleep(2)

print("[*] Opening Network. . .")
net.open("right", "server_control", "server")

consoleTab()

-- Loop Code for Console
while true do
    eventData = {os.pullEvent()}
    sleep(0.5)
    event = eventData[1]
    verify = false

    if event == "mouse_click" then
        btn = eventData[2]
        x = eventData[3]
        y = eventData[4]

        if x >= width - 2 and x <= width and y == 1 then
            checkCursor()

            if currentTab == console then
                print("[*] Closing program. . .")
                sleep(2)
            else
                draw.square(width - 14, 5, 13, 5, "black")
                term.setCursorPos(14,6)
                print("[*] Closing program. . .")
                sleep(2)
            end

            term.setCursorPos(1,1)
            term.clear()
            break
        elseif currentTab == manual and btn == 1 then

            if x >= 2 and x <=10 and y >= 4 and y <= 10 then
                checkCursor()

                elevMove("up")
            elseif x >= 2 and x <=10 and y >= 12 and y <= 18 then
                checkCursor()

                elevMove("down")
            elseif x >= 12 and x <= 17 and y >= 12 and y <= 18 then
                selectFloor("left")
            elseif x >= 45 and x <= 50 and y >= 12 and y <= 18 then
                selectFloor("right")
            elseif x >= 37 and x <= 542 and y >= 13 and y <= 17 then
                elevMove("moveTo", tonumber(tempFloor))
            elseif x >= 1 and x <= 9 and y == 1 then
                consoleTab()
                net.open("right", "server_control", "server")
            end

        elseif currentTab == console and btn == 1 and
            x >= 10 and x <= 17 and y == 1 then
            manualTab()
            net.close("right", "server_control", "server")
            
        end
    end

    if event == "rednet_message" then
        protocol = eventData[4]

        if protocol == "elev_cmd" then

            user_id = eventData[2]
            verify = verifyUsers(user_id)
    
            if verify and currentTab == console then
                cmd = eventData[3]
                
                checkCursor()

                print("[*] Computer# "..user_id..": "..cmd)

                if cmd == "move_up" then
                    elevMove("up")
                elseif cmd == "move_down" then
                    elevMove("down")
                end

            elseif verify == false then
                print("[*] Computer#"..user_id.." Illegal Access")
            end
            
        end

    end
end