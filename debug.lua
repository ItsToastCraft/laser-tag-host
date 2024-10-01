local debug = {}
debug.enabled = true
function debug:enable()
    debug.enabled = true
end
function debug:isEnabled()
    return debug.enabled
end

function debug:spawnParticle(startPos, endPos, particle, amount)
    particle = particle or "minecraft:dust 0 1 0 1"
    amount = amount or 20

    -- Calculate the direction vector and distance between start and end points
    local direction = (endPos - startPos)
    local totalDistance = direction:length()

    -- Calculate the spacing (distance between each particle)
    local spacing = totalDistance / (amount - 1)

    -- Normalize the direction vector to get the unit vector along the line
    local dir = direction:normalize()

    -- Spawn particles along the line
    for i = 0, amount - 1 do
        local pos = startPos + dir * spacing * i

        -- Spawn particle at the calculated position
        particles:newParticle(particle, pos):lifetime(3)
    end
end

return debug