local _chain = require('chain')
local _player = require('player')
local _enemyList = require('enemy_manager')
local _walls = require('walls')
local _audio = require('audio')

function love.conf(t)

	t.window.width = 1024
	t.window.height = 800
	t.console = true

end

function love.load()

	gameState = {mainMenu = true, gameStart = false, gameOver = false}

	love.window.setMode(1024,800, {vsync=true})
	love.keyboard.setKeyRepeat(false)
	love.physics.setMeter(32) -- One meter is 32 px

	world = love.physics.newWorld(0, 9.81*32, true) -- Horizontal gravity 0, Vertical gravity 9.81, allow bodies to sleep
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	player = _player.new(world)
	enemies = _enemyList.new(world)
	walls = _walls.new(world)
	audio = _audio.new()

	love.graphics.setNewFont("Fonts/White Submarine.ttf", 15)
	mainMenu = love.graphics.newImage("Sprites/MainMenu.png")
	gameOver = love.graphics.newImage("Sprites/GameOver.png")

	Collision = ""

	bubble_ps = love.graphics.newParticleSystem(love.graphics.newImage("Sprites/BubbleParticle.png"), 12)
	bubble_ps:setParticleLifetime(2,3)
	bubble_ps:setLinearAcceleration(-10, 10, -30, -50 )
	bubble_ps:setSpread(2)

	hit_ps = love.graphics.newParticleSystem(love.graphics.newImage("Sprites/SparkParticle.png"), 12)
	hit_ps:setParticleLifetime(0.1,0.1)
	hit_ps:setLinearAcceleration(-500, 500, 500, -500)
	hit_ps:setSpread(2)
end

function love.update(dt)

 if(gameState.gameStart) then

	player.updatePosition()
	px,py = player.getPosition()
	enemies.addEnemy(px,py, player.getDepth())
	enemies.updateEnemies()

	--Important! -> break down update intervals into several small steps
	--One large interval will break joints due to large generated forces
	--Split this up and box2D can limit forces on joints
	world:update(dt/3) 
	world:update(dt/3)
	world:update(dt/3)

	if(player.playerLife() <= 1) then
		gameState.gameStart = false
		gameState.gameOver = true
	end


	bubble_ps:update(dt)
	hit_ps:update(dt)

end


end

function love.keypressed(key, isrepeat)

	if love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
		player.shortenChain()
	end

	if love.keyboard.isDown("down") then --press the up arrow key to set the ball in the air
		player.lengthenChain()
	end

	if(love.keyboard.isDown("return")) then

		if(gameState.mainMenu) then
			audio.playBGM()
			gameState.mainMenu = false
			gameState.gameStart = true
		elseif(gameState.gameOver) then
			love.load()
			audio.stopBGM()
		end
	end

	if(love.keyboard.isDown("m")) then
		audio.stopBGM()
	end

	if(love.keyboard.isDown("n")) then
		audio.resumeBGM();
	end



end


function love.mousemoved(x,y,dx,dy)
		
		player.setTarget(x,y)

		if(bubble_ps:getCount() == 0) then
			bubble_ps:setPosition(player.getPosition())
			bubble_ps:emit(math.random(1,12))
		end

 
end

function love.draw()

	if(gameState.mainMenu) then
		love.graphics.draw(mainMenu,0,0)
	elseif(gameState.gameOver) then
		love.graphics.draw(gameOver,0,0)
		player.drawPlayer()
		enemies.drawEnemies()
		love.graphics.print("Final Depth: " .. player.getDepth() .. "m", 475,0)
	else
		walls.drawWalls()
		love.graphics.draw(hit_ps,0,0)
		love.graphics.draw(bubble_ps,0,0)		
		player.drawPlayer()
		enemies.drawEnemies()
		love.graphics.print("Depth: " .. player.getDepth() .. "m", 475,0)



		--love.graphics.print("COLLISION WITH: " .. Collision, 450,15)
	end

end

--a is first fixture object
--b is second fixture object
--coll is contact object
function beginContact(a, b, coll)


 	local function playCollision(id)
		audio.playCollision(id)
		hit_ps:setPosition(x1,y1)
		hit_ps:emit(math.random(1,12))
 	end

	x1,y1,x2,y2 = coll:getPositions()
	

	if(b:getUserData():sub(1,1) == "E" and a:getUserData():sub(1,1) == "F") then

		if (math.abs(a:getBody():getLinearVelocity()) > 400) then
			enemies.enemyHit(b:getUserData(), false)
			Collision = b:getUserData()
			audio.playCollision(1)
		else
			audio.playCollision(2)
		end

		hit_ps:setPosition(x1,y1)
		hit_ps:emit(math.random(1,12))
	end
 
 	--_E_nemy colliding with _W_all
	if(a:getUserData():sub(1,1) == "E" and b:getUserData():sub(1,1) == "W") then
		
		if(math.abs(a:getBody():getLinearVelocity()) > 400) then
			enemies.enemyHit(a:getUserData())
		end

		playCollision(3)

	elseif(b:getUserData():sub(1,1) == "E" and a:getUserData():sub(1,1) == "W") then
		
		if(math.abs(b:getBody():getLinearVelocity()) > 400) then
			enemies.enemyHit(b:getUserData())
		end		
		playCollision(3)
	end

	--_E_nemy colliding with _P_layer
	if(b:getUserData():sub(1,1) == "E" and a:getUserData():sub(1,1) == "P") then
		enemies.enemyHit(b:getUserData(), true)
		player.playerHit()
		Collision = b:getUserData()
		hit_ps:setPosition(x1,y1)
		hit_ps:emit(math.random(1,12))
	end

	--_F_inal link colliding with _W_all
	if(a:getUserData():sub(1,1) == "F" and b:getUserData():sub(1,1) == "W") then		
		playCollision(1)
	elseif(b:getUserData():sub(1,1) == "F" and a:getUserData():sub(1,1) == "W") then		
		playCollision(1)
	end

	--_E_nemey hits another _Enemy
	if(a:getUserData():sub(1,1) == "E" and b:getUserData():sub(1,1) == "E") then
		playCollision(1)
 	end

end
 
function endContact(a, b, coll) 
end
 
function preSolve(a, b, coll) 
end
 
function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end