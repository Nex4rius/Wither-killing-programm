component = require("component")
if component.isAvailable("internet") then
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/autorun.lua' autorun.lua")
  print("")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/wither.lua' wither.lua")
  print("")
  os.execute("wget 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/saveAfterReboot.lua' saveAfterReboot.lua")
  os.execute("clear")
  print("Checking Components\n")
  print("- Internet Card        ok (optional)")
else
  print("Checking Components\n")
  print("- Internet Card        Missing (optional)")
end
dofile("wither.lua")
