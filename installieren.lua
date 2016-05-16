fs = require("filesystem")
fs.makeDirectory("/wither/sprache")
serverAddresse = "https://raw.githubusercontent.com/DarknessShadow/Wither-killing-programm/"
versionTyp = "master/"
Pfad = serverAddresse .. versionTyp
os.execute("wget -f " .. Pfad .. "autorun.lua autorun.lua") print("")
os.execute("wget -f " .. Pfad .. "wither/check.lua wither/check.lua") print("")
os.execute("wget -f " .. Pfad .. "wither/wither.lua wither/wither.lua") print("")
os.execute("wget -f " .. Pfad .. "wither/sprache/deutsch.lua wither/sprache/deutsch.lua") print("")
os.execute("wget -f " .. Pfad .. "wither/sprache/english.lua wither/sprache/english.lua") print("")
os.execute("wget " .. Pfad .. "wither/sicherNachNeustart.lua wither/sicherNachNeustart.lua") print("")
os.execute("del -v installieren.lua\n\n")
installieren = true
os.execute("autorun.lua")
