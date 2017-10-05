local f = {}

local function sleep(zeit)
    os.execute("timeout " .. tostring(zeit))
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
        sleep(1)
    end
end

function f.links(datei, a)
    f.anders('"' .. datei .. '"')
    local output = io.open(string.sub(datei, 1, a - 5) .. "-LINKS.txt", "r")
    if output then
        if string.len(io.open(string.sub(datei, 1, a - 5) .. "-LINKS.txt", "r"):read("*a")) > 0 then
            return
        end
    end
    local input = io.open(datei, "r")
    output = io.open(string.sub(datei, 1, a - 5) .. "-LINKS.txt", "w")
    for zeile in input:lines() do
        local nix, anfang, ende, link, beschreibung
        nix, anfang = string.find(zeile, '<A HREF="')
        if anfang then
            ende = string.find(zeile, '"', anfang + 1)
            if ende then
                link = string.sub(zeile, anfang + 1, ende - 1)
            end
        end
        nix, anfang = string.find(zeile, '>', ende)
        if anfang then
            ende = string.find(zeile, '<', anfang)
            if ende then
                beschreibung = string.sub(zeile, anfang + 1, ende - 1)
            end
        end
        if link and beschreibung then
            output:write(string.format([==[<a href="%s">%s</a>]==] .. "\n" , link, beschreibung))
        end
    end
    input:close()
    output:close()
end

for datei in io.popen([[dir "E:\Transfer" /s /b /a]]):lines() do
    local a = string.len(datei)
    if string.sub(datei, a - 4, a) == ".html" then
        print(pcall(f.links, datei, a))
    end
end