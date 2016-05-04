local component = require("component")
r = require("robot")
inv = component.inventory_controller

WitherSkeletonSkull = 0
WitherSkeletonSkullSizeFree = 0
SoulSand = 0
SoulSandSizeFree = 0
WardedGlass = 0
WardedGlassSizeFree = 0

function enter()
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
end

function exit()
  r.back()
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

function placeWither()
  
end

function checkInventory()
  for i = 1, 16 do
    checkSlot(i)
    if item then
      name = item.name .. ":" .. item.damage
      if "minecraft:skull:0" == name and 3 <= item.size then
        WitherSkeletonSkull = i
        WitherSkeletonSkullSizeFree = r.space(i)
      end
      if "minecraft:soul_sand:0" == name and 4 <= item.size then
        SoulSand = i
        SoulSandSizeFree =r.space(i)
      end
      if "Thaumcraft:blockCosmeticOpaque:2" == name and 1 <= item.size then
        WardedGlass = i
        WardedGlassSizeFree = r.space(i)
      end
    end
  end
end

function invRefill()
  for i = 1, inv.getInventorySize(0) do
    checkInterfaceSlot(i)
    if item then
      name = item.name .. ":" .. item.damage
      if "minecraft:skull:0" == name then
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
        end
        inv.suckFromSlot(0, i, WardedGlassSizeFree)
      end
    end
  end
end

function reset()
  WitherSkeletonSkull = 0
  WitherSkeletonSkullSizeFree = 0
  SoulSand = 0
  SoulSandSizeFree = 0
  WardedGlass = 0
  WardedGlassSizeFree = 0
end

function main()
--  while running do
  checkInventory()
  invRefill()
  if WitherSkeletonSkull == 0 or SoulSand == 0 or WardedGlass == 0 then
--    os.sleep(300)
  else
    enter()
    placeWither()
    exit()
--    os.sleep(60)
  end
  reset()
--  end
end
 
function checkSlot(slot)
  item = inv.getStackInInternalSlot(slot)
end
 
function checkInterfaceSlot(slot)
  item = inv.getStackInSlot(0, slot)
end

running = true

main()
