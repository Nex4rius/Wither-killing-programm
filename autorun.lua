component = require("component")
if component.isAvailable("internet") then
  print("- Internet Card        ok (optional)")
  print("")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/autorun.lua' autorun.lua")
  print("")
  os.execute("wget -f 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/wither.lua' wither.lua")
  print("")
  os.execute("wget 'https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/master/saveAfterReboot.lua' saveAfterReboot.lua")
  os.execute("clear")
else
  print("- Internet Card        Missing (optional)")
end
dofile("wither.lua")
