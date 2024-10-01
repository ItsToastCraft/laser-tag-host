local Weapon = require("weapon")
local utils = require("utils")
local _, teams = require("teams")

local function basicAttack(source, target, weapon)
    local attackerTeam = teams:getPlayerTeam(source:getName())
    local targetTeam = teams:getPlayerTeam(target:getName())
    if attackerTeam ~= targetTeam and targetTeam ~= nil then
        targetTeam:getPlayers()[target:getName()].health = targetTeam:getPlayers()[target:getName()].health - weapon:getDamage()
    end
end

local function onAttack(source, weapon, callback)
    local startPos = source:getPos() + vec(0, source:getEyeHeight(), 0)
    local endPos = startPos + (source:getLookDir() * weapon:getRange())
    weapon:checkCollision(startPos, endPos, function(target, weaponUsed) callback(source, target, weaponUsed) end)
end

local gun = Weapon:new():setDamage(5):setName("Gun"):setRange(20)
local keybind = keybinds:fromVanilla("key.use")

function pings.a()
    onAttack(player, gun, basicAttack)
    
end
keybind:onPress(function() if player:getTargetedEntity(gun:getRange()) and teams:getPlayerTeam(player:getTargetedEntity(gun:getRange()):getName()) then pings.a() end end)
--printTable(teams:getTeams(), 5)

