version = "2.0.0"
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
  fs.makeDirectory("/stargate")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Stargate-Programm/master/autorun.lua' autorun.lua")
  print("")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Stargate-Programm/master/stargate/control.lua' stargate/control.lua")
  print("")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Stargate-Programm/master/stargate/compat.lua' stargate/compat.lua")
  print("")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Stargate-Programm/master/stargate/config.lua' stargate/config.lua")
  print("")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Stargate-Programm/master/stargate/check.lua' stargate/check.lua")
  print("")
  os.execute("wget 'https://raw.githubusercontent.com/DarknessShadow/Stargate-Programm/master/stargate/addresses.lua' stargate/addresses.lua")
  print("")
  os.execute("wget 'https://raw.githubusercontent.com/DarknessShadow/Stargate-Programm/master/stargate/saveAfterReboot.lua' stargate/saveAfterReboot.lua")
  print("")
  f = io.open ("stargate/addresses.lua", "r")
  addressRead = true
  leseLaenge = 1000
  while addressRead == true do
    readAddresses = f:read(leseLaenge)
    AdressesLength = string.len(readAddresses)
    if AdressesLength == leseLaenge then
      leseLaenge = leseLaenge * 2
    else
      addressRead = false
    end
  end
  f:close ()
  if string.sub(readAddresses, AdressesLength, AdressesLength) == " " then
    f = io.open ("stargate/addresses.lua", "a")
    f:seek ("end", -1)
    f:write("")
    f:close ()
  end
  os.execute("reboot")
end

function checkServerVersion()
  os.execute("wget -fQ 'https://raw.githubusercontent.com/DarknessShadow/Stargate-Programm/master/stargate/version.txt' version.txt")
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
  print("\nLoading...")
  dofile("wither/wither.lua")
end
