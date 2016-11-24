InventoryScreen = class()

function InventoryScreen:init(x)
    -- you can accept and set parameters here
    self.x = x
end

function InventoryScreen:draw()
    -- Sort the inventory
    sortedInv = {}
    for i, v in ipairs(inventory) do
        if sortedInv[v] == nil then
            -- table.insert(sortedInv[v], 1)
            sortedInv[v] = 1
        else
            sortedInv[v] = sortedInv[v] + 1
        end
    end
    
    for k, v in pairs(sortedInv) do
        print(k..": "..v)
    end
end

function InventoryScreen:touched(touch)
    -- Codea does not automatically call this method
end
