local Weapon = {}
local debug = require("debug")
function Weapon:checkCollision(startPos, endPos, callback)
    local block
    
    local entity = raycast:entity(startPos, endPos,
        function(x)
            if x == player then   -- ignore self
                return false
            elseif x:isPlayer() then   -- don't target non-entities
                block = raycast:block(startPos, x:getPos() + vec(0, 0.5, 0), "VISUAL")
                return true
            end
        end)
        if debug:isEnabled() and entity ~= nil then
            debug:spawnParticle(startPos,entity:getPos() + vec(0,1,0))
        end
    if entity ~= nil and block.id == "minecraft:air" then
        callback(entity, self)
end
end

function Weapon:new(instance)
    instance = instance or {}   -- create object if user does not provide one
    setmetatable(instance, self)
    self.__index = self
    return instance
    end

---=SETTERS=---

---@param damage number 
---Sets the damage of the weapon, and returns itself for chaining.
function Weapon:setDamage(damage)
    self.damage = damage
    return self
end

---@param cooldown number 
---Sets the cooldown per attack, and returns itself for chaining.
function Weapon:setCooldown(cooldown)
    self.cooldown = cooldown
    return self
end

---@param name string 
---Sets the name of the weapon, and returns itself for chaining.
function Weapon:setName(name)
    self.name = name
    return self
end

function Weapon:setAttackType(attack)
    self.attackFunc = attack
    return self
end

function Weapon:setRange(range)
    self.range = math.clamp(range, 5, 20)
    return self
end

function Weapon:attack()
    self.attackFunc()
end

function Weapon:getDamage()
    return self.damage
end

function Weapon:getCooldown()
    return self.cooldown
end

function Weapon:getName()
    return self.name
end

function Weapon:getAttackType()
    return self.attackFunc
end

function Weapon:getRange()
    return self.range
end


return Weapon