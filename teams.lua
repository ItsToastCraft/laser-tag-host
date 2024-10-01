local team = {}
local teams = {}
local Teams = {}
local weapons = require("weapon")
local utils = require("utils")

local empty = weapons:new():setName("None"):setDamage(0):setRange(0):setCooldown(0)
function team:newTeam(instance)
    instance = instance or {}   -- create object if user does not provide one
    setmetatable(instance, self)
    self.__index = self
    instance["players"] = {}
    return instance
    end

function team:setName(name)
    self.name = name
    teams[name] = self
    return self
end

function team:setColor(color)
    self.color = color
    return self
end

function team:addPlayer(player)
    utils.contains(self.players, player, function(a, b) a[b:getName()] = {["id"] = b, ["health"] = 100, ["damageDealt"] = 0, ["kills"] = 0, ["heldWeapon"] = empty, ["currentCooldown"] = 0} end)
    return self
end
function team:removePlayer(player)
    if self.players[player:getName()] ~= nil then
        self.players[player:getName()] = nil
    end
    return self
end

function team:getPlayers()
    return self.players
end

function team:getColor()
    return self.color.xyz
end

function Teams:getTeams()
    return teams
end

function Teams:getPlayerTeam(player)
    for _, allTeams in pairs(teams) do
        local a = utils.contains(allTeams.players, player, function(table, element) end)
        if a then
            return allTeams
        end
        
    end
end

return team, Teams