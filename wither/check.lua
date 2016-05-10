version = "2.0.3"
component = require("component")
sides = require("sides")
term = require("term")
event = require("event")
fs = require("filesystem")
r = require("robot")

function checkComponents()
  print("Checking Components\n")
  if component.isAvailable("chunkloader") then
    c = component.chunkloader
    chunkloaderstatus = true
    print("- ChunkLoader          ok (optional)")
  else
    chunkloaderstatus = false
    print("- ChunkLoader          Missing (optional)")
  end
  if component.isAvailable("generator") then
    g = component.generator
    generatorstatus = true
    print("- Generator            ok (optional)")
  else
    generatorstatus = false
    print("- Generator            Missing (optional)")
  end
  if component.isAvailable("internet") then
    print("- Internet             ok (optional)")
    internet = true
  else
    print("- Internet             Missing (optional)")
    internet = false
  end
  if component.isAvailable("inventory_controller") then
    print("- Inventory Controller ok\n")
    inv = component.inventory_controller
    return true
  else
    print("- Inventory Controller Missing\n")
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
  serverVersion = f:read(5)
  f:close ()
  os.execute("del version.txt")
  return serverVersion
end

if checkComponents() == true then
  if internet == true then
    print("\nCurrect Version:       " .. version .. "\nAvailable Version:     " .. checkServerVersion())
    if version == checkServerVersion() then
    elseif install == nil then
      print("\nUpdate? yes/no\n")
      askUpdate = io.read()
      if askUpdate == "yes" or askUpdate == "y" then
        print("\nUpdate: yes\n")
        update()
      else
        print("\nAnswer: " .. askUpdate)
      end
    end
  end
  dofile("wither/wither.lua")
end
