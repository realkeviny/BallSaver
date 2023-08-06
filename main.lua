local love  = require "love"

local game = {
    state = {
        menu = true,
        paused = false,
        running = false,
        ended = false
    }
}

local player = {
    radius = 20,
    x = 40,
    y = 40
}

function love.load()
    love.window.setTitle("Ball Saver")
    love.mouse.setVisible(false)
end

function love.update()
    player.x,player.y = love.mouse.getPosition()
end

function love.draw()
    love.graphics.printf("FPS: " .. love.timer.getFPS(),love.graphics.newFont(14),10,love.graphics.getHeight() - 30,love.graphics.getWidth())

    if game.state["running"] then
        love.graphics.circle("fill",player.x,player.y,player.radius)
    end

    if not game.state["running"] then
        love.graphics.circle("fill",player.x,player.y,player.radius / 2)
    end
end