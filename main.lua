-- Dwarf

-- Use this function to perform your initial setup
function setup()
    xmar = (WIDTH - HEIGHT)/2
    ymar = 0
    
    xmar = 200
    ymar = 100
    
    res()
    
    parameter.boolean("hideforthumb", false)
    
    tiles = {
    ["grass"]    = Tile("grass",   ",", color( 42, 126,  49, 255), "ground",  true ),
    ["tree"]     = Tile("tree",    "t", color( 97,  61,  37, 255), "object",  true ),
    ["flwater"]  = Tile("flwater", "~", color( 52, 106, 119, 255), "fluid",   true ),
    ["stone"]    = Tile("stone",   ".", color( 80,  80,  80, 255), "mineral", false),
    ["mincoal"]  = Tile("mincoal", "c", color( 60,  60,  60, 255), "mineral", false),
    ["air"]      = Tile("air",     "~", color(203, 203, 203,  50), "air",     true ),
    ["bedrock"]  = Tile("bedrock", "#", color( 50,  50,  50, 255), "wlimit",  false),
    ["riverbed"] = Tile("riverbed",".", color( 40,  90,  110, 255), "ground" , true)
    }
    -- fill(31, 39, 85, 255)
    sortedTiles = {
    ["ground"]  = {},
    ["object"]  = {},
    ["fluid"]   = {},
    ["mineral"] = {},
    ["air"]     = {},
    ["wlimit"]  = {}
    }
    
    -- revealTiles = {}
    -- print(tiles["grass"]["typ"])
    for k, v in pairs(tiles) do
        -- print(v["typ"])
        table.insert(sortedTiles[v:getType()], v)
        -- table.insert(revealTiles, v)
        -- revealTiles[v:getName()] = v
        -- revealTiles[v:getName()]:discover()
    end
    revealTiles = {
    ["grass"]    = Tile("grass",   ",", color( 42, 126,  49, 255), "ground",  true),
    ["tree"]     = Tile("tree",    "t", color( 97,  61,  37, 255), "object",  true),
    ["flwater"]  = Tile("flwater", "~", color( 52, 106, 119, 255), "fluid",   true),
    ["stone"]    = Tile("stone",   ".", color( 80,  80,  80, 255), "mineral", true),
    ["mincoal"]  = Tile("mincoal", "c", color( 60,  60,  60, 255), "mineral", true),
    ["air"]      = Tile("air",     "~", color(203, 203, 203,  50), "air",     true),
    ["bedrock"]  = Tile("bedrock", "#", color( 50,  50,  50, 255), "mineral", true), 
    ["riverbed"] = Tile("riverbed",".", color( 40,  90, 110, 255), "ground" , true)
    }
    
    fill(52, 106, 119, 255)
    
    world = {
    {{tiles["bedrock"], tiles["bedrock"],  tiles["bedrock"] },
    {tiles["bedrock"], tiles["bedrock"],  tiles["bedrock"]},
    {tiles["bedrock"],  tiles["bedrock"], tiles["bedrock"] }},
    
    {{tiles["stone"], tiles["stone"],  tiles["stone"] },
    {tiles["mincoal"], tiles["mincoal"],  tiles["stone"]},
    {tiles["stone"],  tiles["stone"], tiles["stone"] }},
    
    {{tiles["grass"], tiles["grass"],  tiles["tree"] },
    {tiles["grass"], tiles["grass"],  tiles["tree"]},
    {tiles["grass"],  tiles["grass"], tiles["grass"] }},
    
    {{tiles["air"], tiles["air"],  tiles["tree"] },
    {tiles["air"], tiles["air"],  tiles["air"]},
    {tiles["air"],  tiles["air"], tiles["air"] }},
    
    {{tiles["air"], tiles["air"],  tiles["air"] },
    {tiles["air"], tiles["air"],  tiles["air"]},
    {tiles["air"],  tiles["air"], tiles["air"] }}
    }
    zeroInd = 4
    -- renderDepth = 0
    parameter.integer("renderDepth", 1, 9, zeroInd)
    parameter.boolean("devMode", false)
    
    walkables = {"ground", "air", "fluid"}
    
    -- INITIAL creation -----
    
    -- worldX = #(world[1][1])
    -- worldY = #(world[1])
    -- worldZ = #(world)
    
    worldX = 55
    worldY = 55
    worldZ = 9
    
    alphamode = true
    
    if alphamode then
        alphaWorld = {}
        --[[
        for cz = 1, worldZ do
        table.insert(alphaWorld, {})
        for cy = 1, worldY do
        for tz = 1, worldZ do
        table.insert(alphaWorld[tz], {})
    end
        for cx = 1, worldX do
        for tz = 1, worldZ do
        for ty = 1, worldY do
        table.insert(alphaWorld[tz][ty], {})
    end
    end
    end
    end
    end
        ]]
        
        for cz = 1, worldZ do
            table.insert(alphaWorld, {})
        end
        
        for cz = 1, worldZ do
            for cy = 1, worldY do
                table.insert(alphaWorld[cz], {})
            end
        end
        
        for cz = 1, worldZ do
            for cy = 1, worldY do
                for cx = 1, worldX do
                    if cz == 1 then
                        -- table.insert(alphaWorld[cz][cy], tiles["bedrock"])
                        alphaWorld[cz][cy][cx] = tiles["bedrock"]
                    elseif cz < zeroInd then --Below ground
                        -- table.insert(alphaWorld[cz][cy], sortedTiles["mineral"][math.random(1, #sortedTiles["mineral"])])
                        alphaWorld[cz][cy][cx] = sortedTiles["mineral"][math.random(1, #sortedTiles["mineral"])]
                    elseif cz == zeroInd then
                        -- table.insert(alphaWorld[cz][cy], tiles["grass"])
                        alphaWorld[cz][cy][cx] = tiles["grass"]
                    else
                        -- table.insert(alphaWorld[cz][cy], tiles["air"])
                        alphaWorld[cz][cy][cx] = tiles["air"]
                    end
                end
            end
        end
        
        -- Add rivers!
        
        for r = 1, math.ceil(worldX*worldY/200) do
            if math.random(1, 2) > 1 then
                if math.random(1, 2) > 1 then
                    cx = 1
                    dr = "e"
                else
                    cx = worldX
                    dr = "w"
                end
                cy = math.random(1, worldY)
            else
                cx = math.random(1, worldX)
                if math.random(1, 2) > 1 then
                    cy = 1
                    dr = "n"
                else
                    cy = worldX
                    dr = "s"
                end
            end
            
            -- print("Starting river at "..cx..", "..cy)
            
            ss = 1
            sm = 2
            sl = 6
            
            sum = sl + 2*sm + 2*ss
            
            while (cx > 0) and (cx < worldX + 1) and (cy > 0) and (cy < worldY + 1) do
                tg = math.random(0, sum)
                -- print("Generated random "..tg)
                if dr == "n" then
                    -- print("Repos n")
                    if tg < ss then case = 7
                    elseif tg < sm + ss then case = 8
                    elseif tg < sl + sm + ss then case = 1
                    elseif tg < sl + 2*sm + ss then case = 2
                    else case = 3 end
                elseif dr == "ne" then
                    -- print("Repos ne")
                    if tg < ss then case = 8
                    elseif tg < sm + ss then case = 1
                    elseif tg < sl + sm + ss then case = 2
                    elseif tg < sl + 2*sm + ss then case = 3
                    else case = 4 end
                elseif dr == "e" then
                    if tg < ss then case = 1
                    elseif tg < sm + ss then case = 2
                    elseif tg < sl + sm + ss then case = 3
                    elseif tg < sl + 2*sm + ss then case = 4
                    else case = 5 end
                elseif dr == "se" then
                    if tg < ss then case = 2
                    elseif tg < sm + ss then case = 3
                    elseif tg < sl + sm + ss then case = 4
                    elseif tg < sl + 2*sm + ss then case = 5
                    else case = 6 end
                elseif dr == "s" then
                    if tg < ss then case = 3
                    elseif tg < sm + ss then case = 4
                    elseif tg < sl + sm + ss then case = 5
                    elseif tg < sl + 2*sm + ss then case = 6
                    else case = 7 end
                elseif dr == "sw" then
                    if tg < ss then case = 4
                    elseif tg < sm + ss then case = 5
                    elseif tg < sl + sm + ss then case = 6
                    elseif tg < sl + 2*sm + ss then case = 7
                    else case = 8 end
                elseif dr == "w" then
                    if tg < ss then case = 5
                    elseif tg < sm + ss then case = 6
                    elseif tg < sl + sm + ss then case = 7
                    elseif tg < sl + 2*sm + ss then case = 8
                    else case = 1 end
                else
                    if tg < ss then case = 6
                    elseif tg < sm + ss then case = 7
                    elseif tg < sl + sm + ss then case = 8
                    elseif tg < sl + 2*sm + ss then case = 1
                    else case = 2 end
                end
                
                -- print("Got case "..case)
                
                nx = cx
                ny = cy
                
                if case == 1 then
                    nx = cx
                    ny = cy + 1
                    ndr = "n"
                elseif case == 2 then
                    nx = cx + 1
                    ny = cy + 1
                    ndr = "ne"
                elseif case == 3 then
                    nx = cx + 1
                    ny = cy
                    ndr =  "e"
                elseif case == 4 then
                    nx = cx + 1
                    ny = cy - 1
                    ndr = "se"
                elseif case == 5 then
                    nx = cx
                    ny = cy - 1
                    ndr = "s"
                elseif case == 6 then
                    nx = cx - 1
                    ny = cy - 1
                    ndr = "sw"
                elseif case == 7 then
                    nx = cx - 1
                    ny = cy
                    ndr = "w"
                else
                    nx = cx - 1
                    ny = cy + 1
                    ndr = "nw"
                end
                
                if (nx > 0) and (nx < worldX + 1) and (ny > 0) and (ny < worldY + 1) then
                    -- print("Adding water to "..nx..", "..ny)
                    alphaWorld[zeroInd][ny][nx] = tiles["flwater"]
                    alphaWorld[zeroInd - 1][ny][nx] = tiles["riverbed"]
                    -- print("Block is now "..alphaWorld[zeroInd][ny][nx]:getName())
                end
                
                cx = nx
                cy = ny
                dr = ndr
                
                -- print("Looping")
            end
        end
        
        -- Make the river thicker
        
        for cx = 1, worldX do
            for cy = 1, worldY do
                if alphaWorld[zeroInd - 1][cy][cx]:getName() == "riverbed" then
                    for ix = -1, 1 do
                        for iy = -1, 1 do
                            if cy + iy > 0 and cy + iy <= worldY and cx + ix > 0 and cx + ix <= worldX then
                                if alphaWorld[zeroInd][cy + iy][cx + ix]:getName() ~= "flwater" then
                                    alphaWorld[zeroInd][cy + iy][cx + ix] = tiles["riverbed"]
                                end
                            end
                        end
                    end
                end
            end
        end
        
        -- Add trees! (around 1/4m^2)
        
        for t = 1, math.floor(worldX*worldY/4) do
            hei = math.random(1, worldZ - zeroInd + 1)
            tx = math.random(1, worldX)
            ty = math.random(1, worldY)
            for h = 1, hei do
                if tx ~= math.ceil(worldX/2) and ty ~= math.ceil(worldY/2) then
                    if alphaWorld[zeroInd][ty][tx]:getName() ~= "flwater" then 
                        alphaWorld[h+ zeroInd - 1][ty][tx] = tiles["tree"] 
                    end
                end
            end
        end
    end
    
    -----------
    
    world = alphaWorld
    
    playerX = math.ceil(worldX/2)
    playerY = math.ceil(worldY/2)
    playerZ = renderDepth
    
    playerChar = ":)"
    
    pFacing = "u"
    
    parameter.action("Left", mLeft)
    parameter.action("Right", mRight)
    parameter.action("Up", mUp)
    parameter.action("Down", mDown)
    
    parameter.action("Turn clockwise", turncl)
    
    parameter.action("Inventory", printinv)
    parameter.action("Look", look)
    
    parameter.action("Dig Straight", digstr)
    parameter.action("Dig Diagonal", digdiag)
    
    -- mov("player", "u", playerX, playerY)
    
    inventory = {}
    -- world[2][1][2]:discover()
    
    bdist = 48
    cdist = 70
    bcx = 110
    bcy = 200
    
    controls = {
    Button(bcx,  bcy - bdist, "Documents:buttonDown", 72, 89, mDown),
    Button(bcx,  bcy + bdist, "Documents:buttonUp",   72, 89, mUp),
    Button(bcx - bdist,  bcy, "Documents:buttonLeft", 89, 72, mLeft),
    Button(bcx + bdist,  bcy, "Documents:buttonRight",89, 72, mRight),
    
    Button(100,         HEIGHT - 100, "Documents:buttonL",80, 80, turnccl),
    Button(WIDTH - 100, HEIGHT - 100, "Documents:buttonR",80, 80, turncl ),
    
    Button(WIDTH - (bcx),  bcy + cdist, "Documents:buttonX",80, 80, donothing),
    Button(WIDTH - (bcx + cdist),  bcy, "Documents:buttonY",80, 80, donothing),
    Button(WIDTH - (bcx - cdist),  bcy, "Documents:buttonA",80, 80, digstr),
    Button(WIDTH - (bcx),  bcy - cdist, "Documents:buttonB",80, 80, digdiag),
    }
    
    oktouch = true
    screenmode = "world"
end

function donothing()
    
end

function turncl()
    turn("cl")
end

function turnccl()
    turn("ccl")
end

function turn(dir)
    if dir == "cl" then
        trn = {["u"] = "r", ["r"] = "d", ["d"] = "l", ["l"] = "u"}
    else
        trn = {["u"] = "l", ["l"] = "d", ["d"] = "r", ["r"] = "u"}
    end
    pFacing = trn[pFacing]
    print("Now facing "..pFacing)
end

function printinv()
    -- print("Youre not crazy")
    txt = ""
    for i, v in ipairs(inventory) do
        txt = txt..v.."; "
    end
    print(txt)
    
    -- InventoryScreen:draw()
end

function discTile(x, y, z)
    if (x > 0 and x < worldX + 1) and (y > 0 and y < worldY + 1) and (z > 0 and z < worldZ + 1) then
        -- print("Successfully discovered "..x..", "..y..", "..z)
        -- world[z][y][x]:discover()
        -- world[z][y][x].stats["vis"] = true
        world[z][y][x] = revealTiles[world[z][y][x]:getName()]
    end
end

function digstr()
    dig("str")
end

function digdiag()
    dig("diag")
end

function look()
    dir = pFacing
    
    -- if checkIfHas(walkables, world[playerZ][playerY][playerX]:getType()) then
    if world[playerZ][playerY][playerX]:getType() == "ground" then
        txt = world[playerZ][playerY][playerX]:getName()
    else
        txt = world[playerZ - 1][playerY][playerX]:getName()
    end
    
    print("You are stepping on "..txt)
    print("Youre looking towards "..dir)
    anOk = false
    if     (dir == "l" and playerX > 1)      then
        anOk = true
        anX = playerX - 1
        anY = playerY
    elseif (dir == "r" and playerX < worldX) then
        anOk = true
        anX = playerX + 1
        anY = playerY
    elseif (dir == "d" and playerY > 1)      then
        anOk = true
        anX = playerX
        anY = playerY - 1
    elseif (dir == "u" and playerY < worldY) then
        anOk = true
        anX = playerX
        anY = playerY + 1
    else
        print("You're looking into the oblivion")
    end
    if anOk then print("You're looking at "..world[playerZ][anY][anX]:getName()) end
end

function mLeft()
    mov("player", "l", playerX, playerY, playerZ)
end

function mRight()
    mov("player", "r", playerX, playerY, playerZ)
end

function mUp()
    mov("player", "u", playerX, playerY, playerZ)
end

function mDown()
    mov("player", "d", playerX, playerY, playerZ)
end

function dig(where)
    anOk = false
    dir = pFacing
    if     (dir == "l" and playerX > 1)      then
        anOk = true
        anX = playerX - 1
        anY = playerY
    elseif (dir == "r" and playerX < worldX) then
        anOk = true
        anX = playerX + 1
        anY = playerY
    elseif (dir == "d" and playerY > 1)      then
        anOk = true
        anX = playerX
        anY = playerY - 1
    elseif (dir == "u" and playerY < worldY) then
        anOk = true
        anX = playerX
        anY = playerY + 1
    else
        print("There is nothing there to dig")
    end
    
    if anOk then
        digSite = world[playerZ][anY][anX]
        if digSite:getName() ~= "air" and digSite:getName() ~= "bedrock" then
            print("You dug up the "..digSite:getName())
            table.insert(inventory, digSite:getName())
            world[playerZ][anY][anX] = tiles["air"]
            
            discTile(anX, anY, playerZ - 1)
        end
    end
    if where == "diag" and anOk and playerZ > 2 then
        if world[playerZ - 1][anY][anX]:getName() ~= "air" and world[playerZ - 1][anY][anX]:getName() ~= "bedrock" then
            print("You also dug up the "..world[playerZ - 1][anY][anX]:getName())
            table.insert(inventory, world[playerZ - 1][anY][anX]:getName())
            world[playerZ - 1][anY][anX] = tiles["air"]
            
            discTile(anX, anY, playerZ - 2)
        end
    end
end

function checkIfHas(tabl, el)
    has = false
    for k, v in pairs(tabl) do
        if has == false and v == el then has = true end
    end
    return has
end

function mov(creature, dir, x, y, z)
    
    if creature == "player" then pFacing = dir end
    -- print("Player facing "..pFacing)
    newX = x
    newY = y
    newZ = z
    
    if     (dir == "l" and (x-1) > 0)      then
        if checkIfHas(walkables, world[z][y][x - 1]:getType()) then
            newX = newX - 1
        elseif z < worldZ and checkIfHas(walkables, world[z + 1][y][x - 1]:getType()) and (world[z+1][y][x]:getType() == "air" or world[newZ+1][newY][newX]:getType() == "fluid") then
            newX = newX - 1
            newZ = newZ + 1
        end
    elseif (dir == "r" and (x) < worldX) then
        if checkIfHas(walkables, world[z][y][x + 1]:getType()) then
            newX = newX + 1
        elseif z < worldZ and checkIfHas(walkables, world[z + 1][y][x + 1]:getType()) and (world[z+1][y][x]:getType() == "air" or world[newZ+1][newY][newX]:getType() == "fluid") then
            newX = newX + 1
            newZ = newZ + 1
        end
    elseif (dir == "d" and (y-1) > 0)      then
        if checkIfHas(walkables, world[z][y - 1][x]:getType()) then
            newY = newY - 1
        elseif z < worldZ and checkIfHas(walkables, world[z + 1][y - 1][x]:getType()) and (world[z+1][y][x]:getType() == "air" or world[newZ+1][newY][newX]:getType() == "fluid") then
            newY = newY - 1
            newZ = newZ + 1
        end
    elseif (dir == "u" and (y) < worldY) then
        if checkIfHas(walkables, world[z][y + 1][x]:getType()) then
            newY = newY + 1
        elseif z < worldZ and checkIfHas(walkables, world[z + 1][y + 1][x]:getType()) and (world[z+1][y][x]:getType() == "air" or world[newZ+1][newY][newX]:getType() == "fluid") then
            newY = newY + 1
            newZ = newZ + 1
        end
    end
    
    if creature == "player" then
        for l = 0, 2 do
            for c = 0, 2 do
                -- print("Discovering "..(newX + l - 1)..", "..(newY + c - 1))
                discTile(newX + l - 1, newY + c - 1, newZ)
            end
        end
    end
    
    while (world[newZ][newY][newX]:getType() == "air" and checkIfHas(walkables, world[newZ - 1][newY][newX]:getType())) or world[newZ][newY][newX]:getType() == "fluid" do
        newZ = newZ - 1
        if creature == "player" then
            print("You fell down a level")
            for l = 0, 2 do
                for c = 0, 2 do
                    -- print("Discovering "..(newX + l - 1)..", "..(newY + c - 1))
                    discTile(newX + l - 1, newY + c - 1, newZ)
                end
            end
        end
    end
    
    if creature == "player" then
        playerX = newX
        playerY = newY
        playerZ = newZ
    else
        return {newX, newY, newZ}
    end
end

function pmat(mat)
    for i = 1, #mat do print(mat[i]..", ") end
end

function res()
    resetStyle()
    font("HoeflerText-Black")
    fontSize(18)
    textAlign(CENTER)
    textMode(CENTER)
end

function addLayer(layer, ind)
    table.insert(world, ind, layer)
end

function printMatrix(mat)
    xSz = #mat
    ySz = #mat[1]
    res()
    if devMode == false then renderDepth = playerZ end
    for y = 1, #mat do
        for x = 1, #mat[y] do
            el = mat[y][x]
            stats = el:fetchStats()
            if x == playerX and y == playerY and renderDepth == playerZ then
                res()
                text(playerChar, xmar + (WIDTH - 2*xmar)*x/(xSz + 1), ymar + (HEIGHT - 2*ymar)*y/(ySz + 1))
            elseif stats["vis"] or devMode then
                fill(stats["col"])
                text(stats["chr"], xmar + (WIDTH - 2*xmar)*x/(xSz + 1), ymar + (HEIGHT - 2*ymar)*y/(ySz + 1))
            end
        end
    end
end

function draw()
    background(0, 0, 0, 255)
    strokeWidth(1)
    
    -- printMatrix(world[renderDepth])
    
    if screenmode == "world" then
        if hideforthumb == false then
            for i, v in ipairs(controls) do
                v:draw()
                v:touched(CurrentTouch)
                if CurrentTouch.state == ENDED then oktouch = true end
            end
            
            fill(31, 38, 77, 255)
            if pFacing == "u" then
                rpf = "up"
            elseif pFacing == "d" then
                rpf = "down"
            elseif pFacing == "l" then
                rpf = "left"
            else
                rpf = "right"
            end
            
            font("GillSans")
            fontSize(32)
            text("Facing "..rpf, WIDTH/2, HEIGHT - 60)
        end
        printMatrix(world[renderDepth])
    end
end