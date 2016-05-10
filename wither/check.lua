version = "2.0.4"
component = require("component")
sides = require("sides")
term = require("term")
event = require("event")
fs = require("filesystem")
r = require("robot")

dofile("wither/sicherNachNeustart.lua")
dofile("wither/sprache.lua")

function checkComponents()
  print("Checking Components\n")
  if component.isAvailable("chunkloader") then
    c = component.chunkloader
    chunkloaderstatus = true
    print(chunkloaderOK)
  else
    chunkloaderstatus = false
    print(chunkloaderFehlt)
  end
  if component.isAvailable("generator") then
    g = component.generator
    generatorstatus = true
    print(generatorOK)
  else
    generatorstatus = false
    print(generatorFehlt)
  end
  if component.isAvailable("internet") then
    print(InternetOK)
    internet = true
  else
    print(InternetFehlt)
    internet = false
  end
  if component.isAvailable("inventory_controller") then
    print(inventory_controllerOK)
    inv = component.inventory_controller
    return true
  else
    print(inventory_controllerFehlt)
    return false
  end
end

function update()
  fs.makeDirectory("/wither")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/autorun.lua' autorun.lua")
  print("")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/wither/wither.lua' wither/wither.lua")
  print("")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/wither/check.lua' wither/check.lua")
  print("")
  os.execute("wget 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/wither/sicherNachNeustart.lua' wither/sicherNachNeustart.lua")
  print("")
  os.execute("reboot")
end

function checkServerVersion()
  os.execute("wget -fQ 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/wither/version.txt' version.txt")
  f = io.open ("version.txt", "r")
  serverVersion = f:read(10)
  f:close ()
  os.execute("del version.txt")
  return serverVersion
end

if checkComponents() == true then
  if internet == true then
    print(derzeitigeVersion .. version .. verfuegbareVersion .. checkServerVersion())
    if version == checkServerVersion() then
    elseif installieren == nil then
      print(aktualisierenFrage)
      antwortFrage = io.read()
      if antwortFrage == "ja" or antwortFrage == "j" or antwortFrage == "yes" or antwortFrage == "y" then
        print(aktualisierenJa)
        update()
      else
        print(aktualisierenNein .. antwortFrage)
      end
    end
  end
  dofile("wither/wither.lua")
end
