function sleep(n)
  os.execute("sleep " .. tonumber(n))
end
component = require("component")
robot = require("robot")

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

    while has_free_slots() == true do
        print("Collecting crops...")
        sleep(5) --> wait till robot recovers its energy
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
end
function try_put_in_chest()
    while robot.dropUp(robot.count()) == false do
        --> just wait till someone releases space in storage...    
    end
end
function move_crops() 
    if has_free_slots() == false then
        print("Moving crops to the chest")
        while robot.detectUp() == false do
            sleep(5) --> wait till robot recovers its energy
            if robot.forward() == nil then
                robot.turnRight()
            end
        end
        for i = 1, robot.inventorySize() do
            robot.select(i)
            try_put_in_chest()
        end
        print("Crops have been delivered")
    end
end

while true do
    move_crops()
    harvest_crops()
end