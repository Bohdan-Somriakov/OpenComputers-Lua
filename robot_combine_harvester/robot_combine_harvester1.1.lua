component = require("component")
robot = require("robot")

function sizeInvent()
    local quantity = 0
    for i = 1, robot.inventorySize() do
        quantity = quantity + robot.space(i)
    end

    return quantity
end

local turnRight = true

while sizeInvent() > 0 do
    robot.useDown()
    robot.forward()

    if robot.detect() then
        if turnRight then
            robot.turnRight()
            if robot.forward() == nil then
                robot.turnAround()
            end
            robot.turnRight()
            turnRight = false
        else
            robot.turnLeft()
            if robot.forward() == nil then
                robot.turnAround()
            end
            robot.turnLeft()
            turnRight = true
        end
    end
end
--[[
Initialization:

The script begins by importing the necessary modules, component and robot, to interact with the ComputerCraft components and control the robot.
Inventory Size Function:

The sizeInvent() function calculates the total available space in the robot's inventory. It iterates through each inventory slot and sums up the available space.
Turning Direction Initialization:

The variable turnRight is initialized to true. It will be used to alternate the turning direction when an obstacle is encountered.
Main Loop:

The main loop runs as long as there is available space in the robot's inventory (sizeInvent() > 0).
Within each iteration of the loop:
The robot uses its tool downwards (robot.useDown()) to interact with the block below it.
The robot moves forward (robot.forward()).
The script checks if there is a block in front of the robot (robot.detect()).
If a block is detected:
The robot alternates turning directions:
If turnRight is true, the robot turns right, moves forward, turns right again, and sets turnRight to false.
If turnRight is false, the robot turns left, moves forward, turns left again, and sets turnRight to true.
Loop Continuation:

The loop continues until there is no available space left in the robot's inventory.
]]