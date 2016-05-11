version = "2.1.3"
component = require("component")
sides = require("sides")
term = require("term")
event = require("event")
fs = require("filesystem")
r = require("robot")
chunkloaderstatus = false
generatorstatus = false
serverAddresse = "https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/"
versionTyp = "master/"

dofile("wither/sicherNachNeustart.lua")

function writeSaveFile()
  f = io.open ("wither/sicherNachNeustart.lua", "w")
  f:write('NetherStar = ' .. NetherStar .. '\n')
  f:write('Sprache = "' .. Sprache .. '" -- Deutsch / English\n')
  f:close ()
end

if Sprache == "" or Sprache == nil then
  print("Sprache? / Language? Deutsch / English\n")
  antwortFrageSprache = io.read()
  if antwortFrageSprache == "deutsch" or antwortFrageSprache == "Deutsch" or antwortFrageSprache == "english" or antwortFrageSprache == "English" then
    Sprache = antwortFrageSprache
  else
    print("\nUnbekannte Eingabe\nStandardeinstellung = deutsch")
    Sprache = "Deutsch"
  end
  writeSaveFile()
  print("")
end

dofile("wither/sprache.lua")


function checkKomponenten()
  print(pruefeKomponenten)
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
  Pfad = serverAddresse .. versionTyp
  os.execute("wget -f " .. Pfad .. "autorun.lua autorun.lua")
  print("")
  os.execute("wget -f " .. Pfad .. "wither/wither.lua wither/wither.lua")
  print("")
  os.execute("wget -f " .. Pfad .. "wither/check.lua wither/check.lua")
  print("")
  os.execute("wget -f " .. Pfad .. "wither/sprache.lua wither/sprache.lua")
  print("")
  os.execute("wget " .. Pfad .. "wither/sicherNachNeustart.lua wither/sicherNachNeustart.lua")
  print("")
  os.execute("reboot")
end

function checkServerVersion()
  os.execute("wget -fQ " .. serverAddresse .. versionTyp .. "wither/version.txt' version.txt")
  f = io.open ("version.txt", "r")
  serverVersion = f:read(5)
  f:close ()
  os.execute("del version.txt")
  return serverVersion
end

if checkKomponenten() == true then
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
