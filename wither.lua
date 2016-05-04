local component = require("component")
r = require("robot")
inv = component.inventory_controller

WitherSkeletonSkull = 0
SoulSand = 0
WardedGlass = 0

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
      if "minecraft:skull:1" == name and 4 <= item.size then
        WitherSkeletonSkull = i
      end
      if "minecraft:soul_sand:0" == name and 5 <= item.size then
        SoulSand = i
      end
      if "Thaumcraft:blockCosmeticOpaque:2" == name and 2 <= item.size then
        WardedGlass = i
      end
    end
  end
end

function invRefill()
  for i = 1, inv.getInventorySide(0)  do
    checkInterfaceSlot(i)
    if item then
      name = item.name .. ":" .. item.damage
      if "minecraft:skull:1" == name then
        if WitherSkeletonSkull == 0 then
        else
          r.select(WitherSkeletonSkull)
          suckFromSlot(0, i)
        end
      end
      if "minecraft:soul_sand:0" == name then
        if SoulSand == 0 then
        else
          r.select(SoulSand)
          suckFromSlot(0, i)
        end
      end
      if "Thaumcraft:blockCosmeticOpaque:2" == name then
        if WardedGlass == 0 then
        else
          r.select(WardedGlass)
          suckFromSlot(0, i)
        end
      end
    end
  end
end

function reset()
  WitherSkeletonSkull = 0
  SoulSand = 0
  WardedGlass = 0
end

function main()
--  while running do
  checkInventory()
  invRefill()
  if WitherSkeletonSkull == 0 or SoulSand == 0 or WardedGlass == 0 then
    os.sleep(300)
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
  item = inv.getStackInSlot(slot)
end

running = true

main()
