local love  = require "love"
local enemy = require "enemy"
local button = require "button"

math.randomseed(os.time())

local game = {
    difficulty = 1,
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

local buttons = {
    menu_state = {}
}

local enemies = {}

local function startNewGame()
    game.state["menu"] = false
    game.state["running"] = true

    table.insert(enemies,1,enemy())
end

function love.mousepressed(x,y,button,isTouch,presses)
    if not game.state['running'] then
        if button == 1 then
            if game.state["menu"] then
                for index in pairs(buttons.menu_state) do
                    buttons.menu_state[index]:checkPressed(x,y,player.radius)
                end
            end
        end
    end
end

function love.load()
    love.window.setTitle("Ball Saver")
    love.mouse.setVisible(false)

    buttons.menu_state.play_game = button("Play!",startNewGame,nil,130,40)
    buttons.menu_state.settings = button("Settings",nil,nil,130,40)
    buttons.menu_state.exit_game = button("Exit",love.event.quit,nil,130,40)
end


function love.update(dt)
    player.x,player.y = love.mouse.getPosition()

    if game.state["running"] then
        for i = 1, #enemies do
            enemies[i]:move(player.x,player.y)
        end
    end
end

function love.draw()
    love.graphics.printf("FPS: " .. love.timer.getFPS(),love.graphics.newFont(14),10,love.graphics.getHeight() - 30,love.graphics.getWidth())

    if game.state["running"] then
        for i = 1, #enemies do
            enemies[i]:draw()
        end
        love.graphics.circle("fill",player.x,player.y,player.radius)
    elseif game.state["menu"] then
        buttons.menu_state.play_game:draw(10,20,50,10)
        buttons.menu_state.settings:draw(10,80,40,10)
        buttons.menu_state.exit_game:draw(10,140,50,10)
    end

    if not game.state["running"] then
        love.graphics.circle("fill",player.x,player.y,player.radius / 2)
    end
end