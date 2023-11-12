component = require("component")
robot = require("robot")

function sizeInvent()
    local quantity = 0
    for i = 1, robot.inventorySize() do
        quantity = quantity + robot.space(i)
    end

    return quantity
end

-- Move turnRight outside the while loop
local turnRight = true

while sizeInvent() > 0 do
    robot.useDown()
    robot.forward()

    if robot.detect() == true and robot.detectUp() == false then
        if turnRight then
            print("should turn right")
            robot.turnRight()
            robot.forward()
            robot.turnRight()
            turnRight = false
            print(turnRight)
        else
            print("should turn left")
            robot.turnLeft()
            robot.forward()
            robot.turnLeft()
            turnRight = true
            print(turnRight)
        end
    elseif robot.detectUp() == true then
         robot.turnRight()
         robot.forward()
         robot.turnRight()
         turnRight = false
    end
end
--[[
Inventory Size Calculation (sizeInvent function):

The sizeInvent function calculates the total quantity of items in the robot's inventory.
It iterates through each slot in the robot's inventory and adds the quantity of items in that slot to the total.
The assumption is made that each slot in the robot's inventory can hold a maximum of 16 items.
Main Loop:

The script enters a while loop that continues as long as there are items in the robot's inventory (determined by the result of sizeInvent() > 0).
Inside the loop, the robot uses an item below itself (robot.useDown()), moves forward (robot.forward()), and then checks if there is an obstacle in front of it (robot.detect()).
Turning Mechanism:

If an obstacle is detected, the script makes the robot turn either to the right or to the left, alternating between turns.
The turning direction is determined by the turnRight variable. If turnRight is true, the robot turns right; otherwise, it turns left.
After turning, the robot moves forward again to continue its exploration.
Print Statements:

Note:

It's important to note that this script assumes that the robot is placed in an environment where it can move freely and that there are items for it to collect. The specific behavior of the robot depends on the surrounding environment in the Minecraft world.
]]
