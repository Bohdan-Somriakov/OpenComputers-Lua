function sleep(n)
  os.execute("sleep " .. tonumber(n))
end
component = require("component")
robot = require("robot")
local energy_to_go_home = 10000
local energy_count = 30000 -->  (max energy - energy needed to make way to fuel)
function has_free_slots()
    local slots_with_items = 0
    for i = 1, robot.inventorySize() do
        if robot.count(i) > 0 then
            slots_with_items = slots_with_items + 1
        end
    end
    if slots_with_items == robot.inventorySize() then
        return false
    else
        return true
    end
end

function harvest_crops()
    local turnRight = true
    
    print("energy_count = ", energy_count)
    move_crops() --> checking is the robot needs to recharge and as well move some crops
    
    while has_free_slots() == true do
        
        
        robot.useDown()
        energy_count = energy_count - 5  --> The amount of energy it takes a robot to perform a useDown()
        robot.forward()
        energy_count = energy_count - 15  --> The amount of energy it takes a robot to move forward is 15

        if robot.detect() then
            if turnRight then
                robot.turnRight()
                energy_count = energy_count - 2.5  --> The amount of energy it takes a robot to perform a 90 degree turn is 2.5.
                if robot.forward() == nil then
                    robot.turnAround() 
                    energy_count = energy_count - 5  --> The amount of energy it takes a robot to perform a 180 degree turn is 5.
                end
                robot.turnRight()
                energy_count = energy_count - 2.5  --> The amount of energy it takes a robot to perform a 90 degree turn is 2.5.
                turnRight = false
            else
                robot.turnLeft()
                if robot.forward() == nil then
                    robot.turnAround()
                    energy_count = energy_count - 5  --> The amount of energy it takes a robot to perform a 180 degree turn is 5.
                end
                energy_count = energy_count - 15  --> The amount of energy it takes a robot to move forward is 15
                robot.turnLeft()
                energy_count = energy_count - 2.5  --> The amount of energy it takes a robot to perform a 90 degree turn is 2.5.
                turnRight = true
            end
        end
    end
end
function move_crops() 
    if energy_count < energy_to_go_home or has_free_slots() == false then
        print("Moving crops to the chest")
        while robot.detectUp() == false do
            print("energy_count = ", energy_count)
            if robot.forward() == nil then
                robot.turnRight()
                energy_count = energy_count - 2.5  --> The amount of energy it takes a robot to perform a 90 degree turn is 2.5.
            end
            energy_count = energy_count - 15  --> The amount of energy it takes a robot to move forward is 15
        end
        for i = 1, robot.inventorySize() do
            robot.select(i)
            robot.dropUp(robot.count())
        end
        print("Crops have been delivered. Waiting for the robot energy to recover")
        sleep(20)
        energy_count = 30000
    end
end

while true do
    harvest_crops()
end