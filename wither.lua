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
  r.turnAround()
  r.forward()
  r.forward()
  r.turnAround()
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
      if "minecraft:skull:1" == name and 3 <= item.size then
        WitherSkeletonSkull = i
      end
      if "minecraft:soul_sand:0" == name and 4 <= item.size then
        SoulSand = i
      end
      if "Thaumcraft:blockCosmeticOpaque:2" == name then
        WardedGlass = i
      end
    end
  end
end

function invRefill()
  
end

function reset()
  WitherSkeletonSkull = 0
  SoulSand = 0
  WardedGlass = 0
end

function main()
--  while running do
    invRefill()
    checkInventory()
    if WitherSkeletonSkull == 0 or SoulSand == 0 or WardedGlass == 0 then
      os.sleep(60)
    else
      enter()
      placeWither()
      exit()
    end
    reset()
--  end
end
 
function checkSlot(slot)
  item = inv.getStackInInternalSlot(slot)
end

running = true

main()
