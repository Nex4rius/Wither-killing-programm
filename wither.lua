r = require("robot")

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
end

function main()
--  while running do
    enter()
    placeWither()
    exit()
--  end
end

running = true

main()
