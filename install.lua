if fs.exists("disk/modules") then
    fs.delete("disk/modules")
end
 
destination = "modules/"
program = "wget"

draw = "https://raw.githubusercontent.com/KitomaGithub/Elevator-Control-CC-Tweaked-/master/modules/draw.lua"
elevMove = "https://raw.githubusercontent.com/KitomaGithub/Elevator-Control-CC-Tweaked-/master/modules/elevMove.lua"
fileSys = "https://raw.githubusercontent.com/KitomaGithub/Elevator-Control-CC-Tweaked-/master/modules/fileSys.lua"
network = "https://raw.githubusercontent.com/KitomaGithub/Elevator-Control-CC-Tweaked-/master/modules/network.lua"
textC = "https://raw.githubusercontent.com/KitomaGithub/Elevator-Control-CC-Tweaked-/master/modules/textC.lua"

serverFile = "https://raw.githubusercontent.com/KitomaGithub/Elevator-Control-CC-Tweaked-/master/server_control.lua"

shell.run( program, elevMove, destination .. "elevMove.lua" )
shell.run( program, draw, destination .. "draw.lua" )
shell.run( program, fileSys, destination .. "fileSys.lua" )
shell.run( program, network, destination .. "network.lua" )
shell.run( program, textC, destination .. "textC.lua" )

shell.run( program, serverFile, "server_control.lua" )

term.clear()
term.setCursorPos(1,1)

print("Program successfully Installed")