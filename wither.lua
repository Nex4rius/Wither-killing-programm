-- Version 1.8
-- by DarknessShadow

local component = require("component")
r = require("robot")
--chunkloader = require("chunkloader")
--generator = require("generator")
inv = component.inventory_controller

WitherSkeletonSkull = 0
WitherSkeletonSkullSizeFree = 6
SoulSand = 0
SoulSandSizeFree = 8
WardedGlass = 0
WardedGlassSizeFree = 2
fuel = 0
fuelSizeFree = 4
chunkloaderstatus = false
generatorstatus = false
dofile("saveAfterReboot.lua")

if component.isAvailable("chunkloader") then
  c = component.chunkloader
  chunkloaderstatus = true
else
  chunkloaderstatus = false
end
if component.isAvailable("generator") then
  g = component.generator
  generatorstatus = true
else
  generatorstatus = false
end
end

function writeSaveFile()
  f = io.open ("saveAfterReboot.lua", "w")
  f:write('NetherStar = ' .. NetherStar .. '\n')
  f:close ()
end

function chunkloader(change)
  if chunkloaderstatus == true then
    c.setActive(change)
  end
end

function generator()
  if generatorstatus == true then
    r.select(fuel)
    g.insert()
  end
end

function placeWither()
  print("Spawning Wither")
  r.turnRight()
  r.forward()
  r.turnLeft()
  r.forward()
  r.forward()
  r.turnLeft()
  r.forward()
  r.turnRight()
  r.use()
  r.forward()
  r.forward()
  r.select(WitherSkeletonSkull)
  r.turnLeft()
  r.place()
  r.turnAround()
  r.place()
  r.down()
  r.select(SoulSand)
  r.place()
  r.turnAround()
  r.place()
  r.placeDown()
  r.up()
  r.placeDown()
  r.turnRight()
  r.back()
  r.select(WitherSkeletonSkull)
  r.place()
  r.back()
  r.select(WardedGlass)
  r.place()
  r.turnLeft()
  r.forward()
  r.turnLeft()
  r.forward()
  r.forward()
  r.turnLeft()
  r.forward()
  r.turnLeft()
end

function checkWand()
  item = inv.getStackInInternalSlot(13)
  r.select(13)
  if item then
    if item.name == "Thaumcraft:WandCasting" then
      inv.equip()
      return true
    end
  else
    inv.equip()
    item = inv.getStackInInternalSlot(13)
    if item then
      if item.name == "Thaumcraft:WandCasting" then
        inv.equip()
        return true
      else
        return false
      end
    end
  end
end

function checkInventory()
  for i = 1, 16 do
    item = inv.getStackInInternalSlot(i)
    if item then
      name = item.name .. ":" .. item.damage
      if "minecraft:skull:1" == name then
        if 3 <= item.size then
          WitherSkeletonSkull = i
        end
        WitherSkeletonSkullSizeFree = 6 - item.size
      end
      if "minecraft:soul_sand:0" == name then
        if 4 <= item.size then
          SoulSand = i
        end
        SoulSandSizeFree = 8 - item.size
      end
      if "Thaumcraft:blockCosmeticOpaque:2" == name then
        if 1 <= item.size then
         WardedGlass = i
        end
        WardedGlassSizeFree = 2 - item.size
      end
      if "Railcraft:fuel.coke:0" == name or "minecraft:coal" == item.name or "Thaumcraft:ItemResource:0" == name then
        if 1 <= item.size then
         fuel = i
        end
        fuelSizeFree = 4 - item.size
      end
    end
  end
end

function invRefill()
  for i = 1, inv.getInventorySize(0) do
    item = inv.getStackInSlot(0, i)
    if item then
      name = item.name .. ":" .. item.damage
      if "minecraft:skull:1" == name then
        if WitherSkeletonSkull == 0 then
          r.select(1)
        else
          r.select(WitherSkeletonSkull)
        end
        inv.suckFromSlot(0, i, WitherSkeletonSkullSizeFree)
      end
      if "minecraft:soul_sand:0" == name then
        if SoulSand == 0 then
          r.select(1)
        else
          r.select(SoulSand)
        end
        inv.suckFromSlot(0, i, SoulSandSizeFree)
      end
      if "Thaumcraft:blockCosmeticOpaque:2" == name then
        if WardedGlass == 0 then
          r.select(1)
        else
          r.select(WardedGlass)
        end
        inv.suckFromSlot(0, i, WardedGlassSizeFree)
      end
      if "Railcraft:fuel.coke:0" == name or "minecraft:coal" == item.name or "Thaumcraft:ItemResource:0" == name then
        if fuel == 0 then
          r.select(1)
        else
          r.select(fuel)
        end
        inv.suckFromSlot(0, i, fuelSizeFree)
      end
    end
  end
end

function reset()
  WitherSkeletonSkull = 0
  WitherSkeletonSkullSizeFree = 64
  SoulSand = 0
  SoulSandSizeFree = 64
  WardedGlass = 0
  WardedGlassSizeFree = 64
  fuel = 0
  fuelSizeFree = 4
end

function main()
  while running do
    if checkWand() == true then
      checkInventory()
      invRefill()
      checkInventory()
      generator()
      if WitherSkeletonSkull == 0 or SoulSand == 0 or WardedGlass == 0 then
        print("Materials missing waiting 5min (6000 Ticks)")
        os.sleep(300)
      else
        chunkloader(true)
        placeWither()
        WaitForNetherStar()
        chunkloader(false)
      end
      reset()
    else
      print("Insert wand into tool slot")
      print("Waiting 1min (1200 Ticks)")
      os.sleep(60)
    end
    print("")
  end
end

function WaitForNetherStar()
  wait = true
  print("Waiting for Nether Star")
  while wait do
    os.sleep(5)
    for i = 1, inv.getInventorySize(3) do
      item = inv.getStackInSlot(3, i)
      if item then
        name = item.name .. ":" .. item.damage
        if "minecraft:nether_star:0" == name then
          r.select(16)
          inv.suckFromSlot(3, i)
          NetherStar = NetherStar + 1
          writeSaveFile()
          print("Nether Stars Collected: " .. NetherStar)
          for j = 1, inv.getInventorySize(0) do
            inv.dropIntoSlot(0, j)
          end
          wait = false
          break
        end
      end
    end
  end
end

running = true

main()
