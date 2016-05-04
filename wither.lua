-- Version 1.1

local component = require("component")
r = require("robot")
inv = component.inventory_controller

WitherSkeletonSkull = 0
WitherSkeletonSkullSizeFree = 64
SoulSand = 0
SoulSandSizeFree = 64
WardedGlass = 0
WardedGlassSizeFree = 64

function placeWither()
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

function checkInventory()
  for i = 1, 16 do
    item = inv.getStackInInternalSlot(i)
    if item then
      name = item.name .. ":" .. item.damage
      if "minecraft:skull:1" == name then
        if 3 <= item.size then
          WitherSkeletonSkull = i
        end
        WitherSkeletonSkullSizeFree = 64 - item.size
      end
      if "minecraft:soul_sand:0" == name then
        if 4 <= item.size then
          SoulSand = i
        end
        SoulSandSizeFree = 64 - item.size
      end
      if "Thaumcraft:blockCosmeticOpaque:2" == name then
        if 1 <= item.size then
         WardedGlass = i
        end
        WardedGlassSizeFree = 64 - item.size
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
end

function main()
--  while running do
  checkInventory()
  invRefill()
  if WitherSkeletonSkull == 0 or SoulSand == 0 or WardedGlass == 0 then
--    os.sleep(300)
  else
    placeWither()
    WaitForNetherStar()
  end
  reset()
--  end
end

function WaitForNetherStar()
  wait = true
  while wait do
    for i = 1, inv.getInventorySize(3) do
      item = inv.getStackInSlot(3, i)
      if item then
        name = item.name .. ":" .. item.damage
        if "minecraft:nether_star:0" == name then
          r.select(16)
          inv.suckFromSlot(3, i)
          for j = 1, inv.getInventorySize(0) do
            inv.dropIntoSlot(0, j)
          end
          wait = false
          break
        end
      end
    end
  end
  os.sleep(30)
end

running = true

main()
