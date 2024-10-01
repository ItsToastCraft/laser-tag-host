local utils = {}
function utils.contains(list, element, callback)
    for key, value in pairs(list) do
      if key == element or value == element then
        return true
      end
    end
    callback(list, element)
  end

function utils.getKeys(tables)
    local list = {}
    for k,v in pairs(tables) do
        table.insert(list, k)
      end
    return list
end

function utils.getCount(tables)
local count = 0
for _ in pairs(tables) do
    count = count + 1
end
return count
end

return utils