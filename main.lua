function love.run()

	if love.math then
		love.math.setRandomSeed(os.time())
	end

	love.load()
	-- Main loop time.
	while true do
		-- Process events.
		love.event.pump()
		for name, a,b,c,d,e,f in love.event.poll() do
			if name == "quit" then
				if not love.quit or not love.quit() then
					return a
				end
			end
			love.handlers[name](a,b,c,d,e,f)
		end

		-- Call update and draw
		love.update()
		love.graphics.clear(0,0,0)
		love.draw()
		love.graphics.present()

    love.timer.step()

	end

end

function love.load()
		--Let's load our texture and create a spritebatch to render with later
		bunnyImg = love.graphics.newImage("bunny.png")
		bunnyBatch = love.graphics.newSpriteBatch(bunnyImg, 1000000)

    bunnies = {}
    gravity = 0.98

    maxX = love.graphics.getWidth( ) - bunnyImg:getWidth()
    minX = 0
    maxY = love.graphics.getHeight( ) - bunnyImg:getHeight()
    minY = 0

    baseLitterSize = 500
    litterSizeIncrement = 500
    litterSize = baseLitterSize

    bunnyCount = 0
end

function love.draw()
    --Render the bunnies
    bunnyBatch:clear()
    for i=1,#bunnies do
        bunnyBatch:add(bunnies[i].x,bunnies[i].y)
    end
    bunnyBatch:flush()
    love.graphics.draw(bunnyBatch)
    --Print some useful information (We print this afterwards so it's on top of the bunnies and doesnt get lost)
    love.graphics.print(bunnyCount .. " Total Bunnies", 20, 10)

    love.graphics.print(litterSize .. " bunnies in each Litter", 20, 20)

    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 20, 30)

		love.graphics.print("Current Frametime: "..tostring(love.timer.getDelta( )), 20, 40)

end

function love.mousepressed(x, y, button)--We need to create some bunnies when the primary mousebutton is pressed
  if button == 1 then
    for variable = 1, litterSize do
      procreate(x, y)
    end
  end
end

function  love.keyreleased(key)--Quit the game if escape is released
  if(key == "escape") then
    love.event.push('quit')
  end
end

function love.wheelmoved(x, y)--We want to be able to change how many bunnies are created per mousebutton press
  if y > 0 then --the mousewheel was moved up
      litterSize = litterSize + litterSizeIncrement
  elseif y < 0 then --the mousewheel was moved down
      if litterSize > baseLitterSize then
          litterSize = litterSize - litterSizeIncrement
      end
  end
end

function love.update()
    --Let's move our bunnies around


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
    print("Quitting app!")
end

function procreate(argx,argy) -- this function creates a new bunny
    bunnyCount = bunnyCount + 1
		--Make sure our new bunny doesnt get stuck outside the bounds
		argx = math.max(argx, 10)
		argy = math.max(argy, 10)
		argx = math.min(argx,maxX-10)
		argy = math.min(argy,maxY-10)
		--Add our new bunny
    table.insert(bunnies, {x=argx, y=argy, sx=(math.random(0,100)/10) - 5, sy=(math.random(0,100)/10) - 5 })
end
