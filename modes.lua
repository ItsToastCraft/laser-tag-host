local mode = {}
local modes = {}
local allModes = {}

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
    allModes[name] = self
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

function mode:arrowUp(func)
    self.up = func
    return self
end

function mode:arrowDown(func)
    self.down = func
    return self
end

function mode:updateText()
    mainText:setText(self.text)
end

function mode:onArrowUp()
    self.up()
end

function mode:onArrowDown()
    self.down()
end

function mode:getName()
    return self.name
end

function modes.setMode(newMode)
    currentMode = newMode
    allModes[newMode]:onSelect()
end




function modes.getMode()
    return currentMode
end

function modes.getModes()
    return allModes
end

return mode, modes