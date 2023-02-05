if fs.exists("modules/") then
    fs.delete("modules/")
end

if fs.exists("images/") then
    fs.delete("images/")
end

if fs.exists("data/") then
    fs.delete("data/")
end

moduleDestination = "modules/"
imageDestination = "images/"

program = "wget"
webModules = "https://raw.githubusercontent.com/KitomaGithub/Elevator-Control-CC-Tweaked-/master/modules/"
webImages = "https://raw.githubusercontent.com/KitomaGithub/Elevator-Control-CC-Tweaked-/master/images/"

draw = webModules.."draw.lua"
elevMove = webModules.."elevMove.lua"
fileSys = webModules.."fileSys.lua"
network = webModules.."network.lua"
textC = webModules.."textC.lua"

imgUp = webImages.."up_arrow.nfp"
imgDown = webImages.."down_arrow.nfp"
imgLeft = webImages.."left_arrow.nfp"
imgRight = webImages.."right_arrow.nfp"


serverFile = "https://raw.githubusercontent.com/KitomaGithub/Elevator-Control-CC-Tweaked-/master/server_control.lua"

shell.run( program, elevMove, moduleDestination .. "elevMove.lua" )
shell.run( program, draw, moduleDestination .. "draw.lua" )
shell.run( program, fileSys, moduleDestination .. "fileSys.lua" )
shell.run( program, network, moduleDestination .. "network.lua" )
shell.run( program, textC, moduleDestination .. "textC.lua" )

shell.run( program, imgUp, imageDestination .. "up_arrow.nfp" )
shell.run( program, imgDown, imageDestination .. "down_arrow.nfp" )
shell.run( program, imgLeft, imageDestination .. "left_arrow.nfp" )
shell.run( program, imgRight, imageDestination .. "right_arrow.nfp" )

shell.run( program, serverFile, "server_control.lua" )

term.clear()
term.setCursorPos(1,1)

print("Program successfully Installed")