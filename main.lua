function love.run()

	if love.math then
		love.math.setRandomSeed(os.time())
	end

	if love.load then love.load() end

	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
	-- Main loop time.
	while true do
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
		-- Call update and draw
		if love.update then love.update() end -- will pass 0 if love.timer is disabled

		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end

		if love.timer then
      love.timer.sleep(0.001)
      love.timer.step()
    end
	end

end

function love.load()
    bunnies = {}
    gravity = 0.98

    maxX = love.graphics.getWidth( )
    minX = 0
    maxY = love.graphics.getHeight( )
    minY = 0

    baseLitterSize = 500
    litterSizeIncrement = 500
    litterSize = baseLitterSize

    bunnyCount = 0
    --Let's load our bunny texture and create a spriteBatch to render with later
    bunnyImg = love.graphics.newImage("bunny.png")
    bunnyBatch = love.graphics.newSpriteBatch(bunnyImg, 1000000)
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
    table.insert(bunnies, {x=argx, y=argy, sx=(math.random(0,10)) - 5, sy=(math.random(0,10)) - 5 })
end
