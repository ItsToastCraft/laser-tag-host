local skulls = {}

local team, teams = require("teams")
local mode, modes = require("modes")
local utils = require("utils")

local prevMode = modes.getMode()
local index = -1
local lastSwingTime = -1

local function getLookElement(viewer, elementPos, text, callback)
    local playerLookDir = viewer:getPos() + vec(0, viewer:getEyeHeight(), 0) + viewer:getLookDir() * 2
    
    if (playerLookDir - elementPos):applyFunc(math.abs) < vec(0.5, 0.2, 0.5) and modes.getMode() == text then
        local currentSwingTime = viewer:getSwingTime()

        if currentSwingTime == 5 and currentSwingTime ~= lastSwingTime then
            
            callback()
            
        end
        lastSwingTime = currentSwingTime
    end
    
end
local pageIndex = 0
local newGame = mode:new():setName("newGame"):setText("Banana"):setArrows(false):setOnSelect(function() modes.setMode("gameLobby") end)
local gameLobby = mode:new():setName("gameLobby"):setText("a"):setArrows(true):setOnSelect(function() print("a") end)
gameLobby:arrowUp(
function() 
    pageIndex = pageIndex % #utils.getKeys(teams.getTeams()) + 1 
    local teamName = utils.getKeys(teams.getTeams())[pageIndex]
    gameLobby:setText(toJson({{text = "Join Team "}, {text = teamName, color = "#" ..vectors.rgbToHex(teams.getTeams()[teamName]:getColor())}})) 
    gameLobby:updateText() 
end)
gameLobby:arrowDown(
function() 
    pageIndex = (pageIndex - 2) % #utils.getKeys(teams.getTeams()) + 1
    local teamName = utils.getKeys(teams.getTeams())[pageIndex]
    gameLobby:setText(toJson({{text = "Join Team "}, {text = teamName, color = "#" ..vectors.rgbToHex(teams.getTeams()[teamName]:getColor())}})) 
    gameLobby:updateText() 
end)
printTable(modes.getModes(),3)
    
function events.SKULL_RENDER(delta,block,item,entity,mode)
    if mode == "BLOCK" then
        
        --models.model.Skull:setPos(0, 3 * math.sin(world.getTime(delta) / 10) + 4)
        local viewer = client:getViewer()
        local pos = block:getPos() + vec(0.5, 1.25, 0.5)
        local arrow1 = block:getPos() + vec(0.5, 1.75, 0.5)
        local arrow2 = block:getPos() + vec(0.5, 0.75, 0.5)
        particles:newParticle("dust 0 1 1 1", pos)
        particles:newParticle("dust 0 1 1 1", arrow1)
        particles:newParticle("dust 0 1 1 1", arrow2)
        local currentMode = modes.getMode()
            if currentMode == "newGame" then
                getLookElement(viewer, pos, "newGame", function() newGame:onSelect() end)
                
            elseif currentMode == "gameLobby" then 
                getLookElement(viewer, arrow1, "gameLobby", function() gameLobby:onArrowUp() end)
                getLookElement(viewer, arrow2, "gameLobby", function() gameLobby:onArrowDown() end)
                end
            
        end
    end