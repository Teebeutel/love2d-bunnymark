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
        love.graphics.draw(bunnyImg, value.x, value.y)
    end

end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    for variable = 1, litterSize do
      procreate(x, y)
    end
  end
end

function love.wheelmoved(x, y)
  if y > 0 then --the mousewheel was moved up
      litterSize = litterSize + litterSizeIncrement
  elseif y<0 then --the mousewheel was moved down
      if litterSize > baseLitterSize then
          litterSize = litterSize - litterSizeIncrement
      end
  end
end

function love.update(dt)

    for i=1,#bunnies do
        bunnies[i].x = bunnies[i].x + bunnies[i].sx;
        bunnies[i].y = bunnies[i].y + bunnies[i].sy;
        bunnies[i].sy = bunnies[i].sy + gravity;

        if (bunnies[i].x > maxX) then
            bunnies[i].sx = bunnies[i].sx * -0.9;
            bunnies[i].x = maxX;
        elseif (bunnies[i].x < minX) then
            bunnies[i].sx = bunnies[i].sx * -0.9;
            bunnies[i].x = minX;
        end

        if (bunnies[i].y > maxY) then
            bunnies[i].sy = bunnies[i].sy * -0.9;
            bunnies[i].y = maxY;
        elseif (bunnies[i].y < minY) then
            bunnies[i].sy = bunnies[i].sy * -0.9;
            bunnies[i].y = minY;
        end
    end
end
function love.quit()
    stdOutPrint("Quitting app!")
end
------------------------------------------------
-- Custom functions
------------------------------------------------

function procreate(argx,argy) -- this function creates a new bunny
    bunnyCount = bunnyCount + 1
    table.insert(bunnies, {id = bunnyCount, x=argx, y=argy, sx=(math.random() * 10) - 5, sy=(math.random() * 10) - 5 })
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
