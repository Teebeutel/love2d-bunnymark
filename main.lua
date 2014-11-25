------------------------------------------------
-- Modules
------------------------------------------------

------------------------------------------------
-- Base functions
------------------------------------------------
function love.load()
    bunnies = {}
    gravity = 0.98
    
    maxX = love.graphics.getWidth( )
    minX = 0
    maxY = love.graphics.getHeight( )
    minY = 0

    baseLitterSize = 1000
    litterSizeIncrement = 1000
    litterSize = baseLitterSize
    
    stdOutText = ""

    bunnyCount = 0

    bunnyImg = love.graphics.newImage("bunny.png")
end

function love.draw()

    love.graphics.print(bunnyCount .. " Total Bunnies", 20, 10)
    
    love.graphics.print(litterSize .. " bunnies in each Litter", 20, 20)
    
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 20, 30)    
    
    for index,value in ipairs(bunnies) do
        local tempBunnyId = value[1]
        local tempBunnyPosX = value[2]
        local tempBunnyPosY = value[3]

        love.graphics.draw(bunnyImg, tempBunnyPosX, tempBunnyPosY)
    end

end

function love.mousepressed(x, y, button)
    if button == 'l' then
        for variable = 1, litterSize, 1 do
            procreate(x, y)
        end
    elseif button == 'wu' then
        litterSize = litterSize + litterSizeIncrement
    elseif button == 'wd' then
        if litterSize > baseLitterSize then 
            litterSize = litterSize - litterSizeIncrement 
        end
    end
end

function love.update(dt)
    
    for index,value in ipairs(bunnies) do
        local tempBunnyId = value[1]
        local tempBunnyPosX = value[2]
        local tempBunnyPosY = value[3]
        local tempBunnySpeedX = value[4]
        local tempBunnySpeedY = value[5]
        tempBunnyPosX = tempBunnyPosX + tempBunnySpeedX;    
        tempBunnyPosY = tempBunnyPosY + tempBunnySpeedY;

        tempBunnySpeedY = tempBunnySpeedY + gravity;
        
        if (tempBunnyPosX > maxX) then
            tempBunnySpeedX = tempBunnySpeedX * -0.9;
            tempBunnyPosX = maxX;
        elseif (tempBunnyPosX < minX) then
            tempBunnySpeedX = tempBunnySpeedX * -0.9;
            tempBunnyPosX = minX;
        end
        
        if (tempBunnyPosY > maxY) then
            tempBunnySpeedY = tempBunnySpeedY * -0.9;
            tempBunnyPosY = maxY;
        elseif (tempBunnyPosY < minY) then
            tempBunnySpeedY = tempBunnySpeedY * -0.9;
            tempBunnyPosY = minY;
        end
        
        -- push all values back in the tables
        local bunny = {tempBunnyId, tempBunnyPosX, tempBunnyPosY, tempBunnySpeedX, tempBunnySpeedY }
        bunnies[index] = bunny
    end
end
function love.quit()
    stdOutPrint("Quitting app!")
end
------------------------------------------------
-- Custom functions
------------------------------------------------

function procreate(x,y) -- this function creates a new bunny
    bunnyCount = bunnyCount + 1
    local bunnyId = bunnyCount
    local bunnyPosX = x
    local bunnyPosY = y
    local bunnySpeedX = (math.random() * 10) - 5  
    local bunnySpeedY = (math.random() * 10) - 5  
    local bunny = {bunnyId, bunnyPosX, bunnyPosY, bunnySpeedX, bunnySpeedY }
    
    
    table.insert(bunnies, bunny)

end

------------------------------------------------
-- Utils. Toolbelt stuff needed to run this app
------------------------------------------------

------------------------------------------------
-- Debug. Stuff here gets removed after debugging is done
------------------------------------------------

function stdOutPrint(text)
    stdOutText = text
    print(text)
end

function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end 

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end