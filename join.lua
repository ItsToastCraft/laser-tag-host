local skulls = {}

local team, teams = require("teams")
local mode, modes = require("modes")


local prevMode = modes.getMode()
local index = -1
local lastSwingTime = -1

local function getLookElement(viewer, elementPos, text, callback)
    local playerLookDir = viewer:getPos() + vec(0, viewer:getEyeHeight(), 0) + viewer:getLookDir() * 2
    
    if (playerLookDir - elementPos):applyFunc(math.abs) < vec(0.4, 0.2, 0.4) and modes.getMode() == text then
        local currentSwingTime = viewer:getSwingTime()

        if currentSwingTime == 5 and currentSwingTime ~= lastSwingTime then
            
            callback()
            
        end
        lastSwingTime = currentSwingTime
    end
    
end

local gameLobby = mode:new():setName("newGame"):setText("Banana "):setArrows(true):setOnSelect(function() end)

    
function events.SKULL_RENDER(delta,block,item,entity,mode)
    if mode == "BLOCK" then
        --models.model.Skull:setPos(0, 3 * math.sin(world.getTime(delta) / 10) + 4)
        local viewer = client:getViewer()
        local pos = block:getPos() + vec(0.5, 1.25, 0.5)
        local arrow1 = block:getPos() + vec(0.5, 1.5, 0.5)
        local arrow2 = block:getPos() + vec(0.5, 1, 0.5)
        particles:newParticle("dust 0 1 1 1", pos)
        local currentMode = "createGame"
            if currentMode == "createGame" then
                getLookElement(viewer, pos, "newGame", function() gameLobby:onSelect() end)
                end
            
        end
    end