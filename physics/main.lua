function love.load()
    love.physics.setMeter(64) -- a meter is 64px
    world = love.physics.newWorld(0,  9.81*64, true) -- vertical gravity of 9.81

    objects = {}

    -- ground
    objects.ground = {}
    objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2)
    objects.ground.shape = love.physics.newRectangleShape(650,50)
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape) -- attach shape to body
    
    -- ball
    objects.ball = {}
    objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic") -- place a dynamic ball int he centre of the space
    objects.ball.shape = love.physics.newCircleShape(20) -- radius = 20
    objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- density 1 attachment
    objects.ball.fixture:setRestitution(0.9) -- bouncing ball
    
    -- blocks
   objects.block1 = {} 
   objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
   objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
   objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5)
   
   objects.block2 = {} 
   objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
   objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
   objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)

    -- screem setup
    love.graphics.setBackgroundColor(104, 136, 248) -- blue sky
    love.graphics.setMode(650, 650, false, true, 0)
end

function love.update(dt)
    world:update(dt) -- makes the world turn
    if objects.ball.body:getX() < 0 then 
        objects.ball.body:setPosition(0, objects.ball.body:getY())
    elseif objects.ball.body:getX() > 650 then 
        objects.ball.body:setPosition(650, objects.ball.body:getY())
    elseif objects.ball.body:getY() > 650 then 
        objects.ball.body:setPosition(objects.ball.body:getX(), 650)
    end
    -- keyboard
    if love.keyboard.isDown("right") then -- right arrow
        objects.ball.body:applyForce(400, 0)
    elseif love.keyboard.isDown("left") then -- left arrow
        objects.ball.body:applyForce(-400, 0)
    elseif love.keyboard.isDown("up") then -- up arrow
        objects.ball.body:applyForce(0, -400)
    end
end

function love.draw()
    love.graphics.setColor(72, 160, 14) -- green grass
    love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- fill a poly for the ground

    love.graphics.setColor(193, 47, 14) -- red ball
    love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())

    love.graphics.setColor(50, 50, 50) -- gray block
    love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints())) -- fill the block1
    love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints())) -- fill the block2
end
