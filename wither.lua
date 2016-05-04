local component = require("component")
r = require("robot")

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
  r.forward()
  r.forward()
end

function exit()
  r.turnAround()
  r.forward()
  r.forward()
  r.turnRight()
  r.forward()
  r.turnLeft()
  r.forward()
  r.forward()
  r.turnLeft()
  r.forward()
  r.turnLeft()
end

function placeWither()
  checkInventory()
  print(WitherSkeletonSkull .. "   " .. SoulSand .. "   " .. WardedGlass)
end

function checkInventory()
  for i = 1, 16 do
    checkSlot(i)
    if item then
      name = item.name .. item.damage
      if "minecraft:skull1" == name and 3 <= item.size then
        WitherSkeletonSkull = i
      end
      if "minecraft:soul_sand0" == name and 4 <= item.size then
        SoulSand = i
      end
      if "Thaumcraft:blockCosmeticOpaque2" == name then
        WardedGlass = i
      end
    end
  end
end

function main()
--  while running do
    enter()
    placeWither()
    exit()
--  end
end
 
function checkSlot(slot)
  item = component.inventory_controller.getStackInInternalSlot(slot)
end

running = true

main()
