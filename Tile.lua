Tile = class()

function Tile:init(name, chr, col, typ, visi)
    self.stats = {["name"] = name, ["chr"] = chr, ["col"] = col, ["typ"] = typ, ["vis"] = visi}
    self.visibl = visi
end

function Tile:fetchStats()
    return self.stats
end

function Tile:getCol()
    return self.stats["col"]
end

function Tile:getName()
    return self.stats["name"]
end

function Tile:getType()
    return self.stats["typ"]
end

function Tile:discover()
    self.stats["vis"] = true
end
