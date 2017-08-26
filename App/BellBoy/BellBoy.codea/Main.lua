-- BellBoy
displayMode(FULLSCREEN_NO_BUTTONS)
supportedOrientations(LANDSCAPE_ANY)
-- Use this function to perform your initial setup
function setup()
    rectMode(CENTER)
    spriteMode(CENTER)
    
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(255, 255, 255, 255)
    sprite("Project:normal",WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
end

