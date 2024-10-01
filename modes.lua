local mode = {}
local modes = {}

local currentMode = "newGame"

local mainText = models.model.Skull.Camera:newText("Main Text"):setText("New Game"):setOutline(true):setAlignment("CENTER"):setScale(0.5)
local upArrow = models.model.Skull.Camera.bone2:newText("Up Arrow"):setText("<"):setRot(0,0,90):setOutline(true):setAlignment("CENTER"):setVisible(false):setScale(0.5)
local downArrow = models.model.Skull.Camera.bone3:newText("Down Arrow"):setText(">"):setRot(0,0,90):setAlignment("CENTER"):setOutline(true):setVisible(false):setScale(0.5)

function mode:new(instance)
    instance = instance or {}   -- create object if user does not provide one
    setmetatable(instance, self)
    self.__index = self
    return instance
    end

---@param name string
function mode:setName(name)
    self.name = name
    modes[name] = self
    return self
end

---@param arrows boolean
function mode:setArrows(arrows)
    self.arrows = arrows
    return self
end

---@param select function
function mode:setOnSelect(select)
    self.select = select
    return self
end


---@param text string
function mode:setText(text)
    self.text = text
    
    return self
end

function mode:requiresArrows()
    return self.arrows
end

function mode:onSelect()
    upArrow:setVisible(self:requiresArrows())
    downArrow:setVisible(self:requiresArrows())

    mainText:setText(self.text)
    self.select()
end

function modes.setMode(newMode)
    currentMode = newMode
    modes[newMode]:onSelect()
end

function modes.getMode()
    return currentMode
end

return mode, modes