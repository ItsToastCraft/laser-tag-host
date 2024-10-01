local logic = {}
local team, teams = require("teams")
local utils = require("utils")
local weapon = require("weapon")
local basicWeapons = require("basic_weapons")

local red = team:newTeam():setName("Red"):setColor(vectors.hexToRGB("#d4362b"))
local green = team:newTeam():setName("Green"):setColor(vectors.hexToRGB("#88bd0d"))
local blue = team:newTeam():setName("Blue"):setColor(vectors.hexToRGB("#4bd5cf"))
function events.entity_init()
    red:addPlayer(player)
    --printTable(teams:getTeams(), 3)
    -- printTable(teams:getTeams(), 5)
    -- print(red:getPlayers()["ItsToastCraft"])
end
for playerName, player in pairs(world.getPlayers()) do
    if playerName == "ToastTextures" or playerName == "Slymeball" or playerName == "OhItsElectric" or playerName == "CubixThree" then
        blue:addPlayer(player)
    end
end
function events.tick()
    for _, player in pairs(blue:getPlayers()) do
        particles:newParticle("dust " .. string.format("%f %f %f 1", blue:getColor().x, blue:getColor().y, blue:getColor().z), player["id"]:getPos() + vec(0,3,0) )
    end
    for _, player in pairs(red:getPlayers()) do
        particles:newParticle("dust 1 0 0 1", player["id"]:getPos() + vec(0,3,0) )
    end
end





return logic,teams