-- BellBoy
displayMode(FULLSCREEN_NO_BUTTONS)
supportedOrientations(LANDSCAPE_ANY)
-- Use this function to perform your initial setup
function setup()
    rectMode(CENTER)
    spriteMode(CENTER)
    textMode(CENTER)
    minutes = 0
    seconds = 0
    screen = 2
    boyTimer = 0
    xw = WIDTH/1024
    textWhite = color(250,244,244,255)
    screenList = {"Project:home","Project:home"}
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(255, 255, 255, 255)
        sprite(screenList[screen],WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
        if screen%3 ~= 0 then
        fill(255,255,255,.89*255)
        rect(WIDTH/2,HEIGHT-597,WIDTH,194)
        fill(0,0,0,181)
        rect(201.5*xw,HEIGHT-192*xw,290*xw,271*xw)
        font("DS-Digital")
        fill(textWhite)
        fontSize(60*xw)
        text("BELLBOY",188*xw,HEIGHT-115*xw)
        font("Arial")
        fontSize(22*xw)
        text("Make an order:",159*xw,HEIGHT-167*xw)
        text("Towels",119*xw,HEIGHT-xw*201)
        text("Room Service",154*xw,HEIGHT-xw*232)
        text("Ice",100*xw,HEIGHT-xw*263)
        text("Luggage",128*xw,HEIGHT-xw*294)
        end
        if screen == 2 then
            fill(149,152,154,255)
            fontSize(70)
            font("DS-Digital")
            text("WELCOME, HOW CAN BELLBOY",WIDTH/2,HEIGHT-555*xw)
            text("BE OF ASSISTANCE",WIDTH/2,HEIGHT-639*xw)
        end
end

