local ausgabe, typ, ausschalten
local datum = io.popen([==[date /t]==]):lines()()
local rendern = [==[F:\Untitled.mov]==]
local konvertieren = [==[F:\konvertieren.mp4]==]
local f = {}

local ahk = [[
SetTitleMatchMode, 2
WinActivate Opera
CoordMode, Mouse, Window
Sleep 1000
Click, 720, 300
Sleep 1000
Click, 400, 460
Sleep 1000
SendRaw %s
Sleep 1000
Send {ENTER}
Sleep 1000
Click, 800, 290
Sleep 1000
Send {Ctrl down}a{Ctrl up}
Sleep 1000
SendRaw %s
Sleep 1000
Click, 1275, 170
Sleep 1000
WinMinimize Opera
]]

local video = {
    [0] = "neuer Name",
    [1] = "Kaitag am Freitag #<NR> <DATUM>.mp4",
    [2] = "Kaitag Aktuell.mp4",
    [3] = "nachgedacht nachgefragt.mp4",
    [4] = "Bitte Nachdenken, Danke! BND #<NR>.mp4",
}

for k, v in pairs(video) do
    print(k, v)
end

while not video[typ] do
    print("\nVideoart?")
    typ = tonumber(io.read())
end

if typ == 0 then
    print("\nName eingeben:")
    ausgabe = string.format([==[%s.mp4"]==], io.read())
elseif typ == 1 then
    print("\nNummer eingeben:")
    ausgabe = string.format([==[Kaitag am Freitag #%s %s.mp4"]==], io.read(), string.sub(datum, 1, string.len(datum) - 1))
elseif typ == 2 then
    ausgabe = [==[Kaitag Aktuell.mp4"]==]
elseif typ == 3 then
    ausgabe = [==[nachgedacht nachgefragt.mp4"]==]
elseif typ == 4 then
    print("\nNummer eingeben:")
    ausgabe = string.format([==[Bitte Nachdenken, Danke! BND #%s.mp4"]==], io.read())
end

print('\n"' .. ausgabe .. '\n')

print("Danach ausschalten? [ja/nein]")

if io.read() == "ja" then
    ausschalten = true
end

local function sleep(zeit)
    os.execute("timeout " .. tostring(zeit))
end

local function move(von, nach)
    io.popen(string.format([==[move %s %s]==], von, nach))
end

local function copy(von, nach)
    io.popen(string.format([==[copy %s %s /Z]==], von, nach))
end

function f.Datei_In_Byte(name)
    for byte in io.popen([==[for %I in (]==] .. tostring(name) .. [==[) do @echo %~zI]==]):lines() do
        return tonumber(byte)
    end
end

function f.inMB(zahl)
    return string.format("%.1f", zahl / 1048576) .. "MB"
end

function f.anders(name)
    print(name)
    local neu, datei = 1, 0
    while datei ~= neu do
        neu = datei
        datei = f.Datei_In_Byte(name)
        print(string.format("+%s", f.inMB(datei - neu)))
        sleep(15)
    end
end

function f.konvertieren(eingabe, ausgabe)
    f.command(string.format([==["E:\Sonstiges\HandBrakeCLI.exe" -i %s -o %s -v -e x265 -q 26 -f av_mp4 --encoder-preset ultrafast --no-two-pass]==], eingabe, ausgabe))
end

function f.hochladen(datei)
    f.command([==["E:\Sonstiges\Opera\launcher.exe" https://www.youtube.com/upload]==])
    local d = io.open([==[F:\hochladen.ahk]==], "w")
    local pfad = string.sub(datei, 2, string.len(datei) - 1)
    local name = string.sub(datei, 5, string.len(datei) - 5)
    d:write(string.format(ahk, pfad, name))
    d:close()
    sleep(15)
    f.command([==["F:\hochladen.ahk"]==])
    f.command([==[DEL "F:\hochladen.ahk"]==])
end

function f.ausschalten()
    print("Warte bis Upload beende ist")
    local gesendet, alt = 100001, 0
    while gesendet - alt > 100000 do
        alt = gesendet
        local a = f.command([==[netstat -e]==])
        local i = 0
        for w in a[4]:gmatch("%S+") do
            i = i + 1
            if i == 3 then
                gesendet = w
            end
        end
        print(f.inMB(gesendet - alt))
        sleep(15)
    end
    print("Herunterfahren in ...")
    sleep(60)
    f.command([==[shutdown /s /f /t 5]==])
end

function f.command(text)
    local inhalt = {}
    local j = 0
    for i in io.popen(text):lines() do
        inhalt[j] = i
        print(i)
        j = j + 1
    end
    return inhalt
end

function f.main()
    f.command([==[TASKKILL /IM cpuburner.exe /F /T]==])
    f.anders('"' .. rendern .. '"')
    f.command([==[TASKKILL /IM Resolve.exe /F /T]==])
    f.konvertieren(rendern, konvertieren)
    move('"' .. konvertieren .. '"', [==["F:\]==] .. ausgabe)
    if typ == 1 then
        copy([==["F:\]==] .. ausgabe, [==["E:\Videos\Kai aus Hannover\Kaitag\Kaitag am Freitag Endversion\]==] .. ausgabe)
    end
    f.hochladen([==["F:\]==] .. ausgabe)
    if ausschalten then
        f.ausschalten()
    end
end

print(pcall(f.main))

sleep(60)
