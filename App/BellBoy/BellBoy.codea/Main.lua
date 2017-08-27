-- BellBoy
displayMode(FULLSCREEN_NO_BUTTONS)
supportedOrientations(LANDSCAPE_ANY)
-- Use this function to perform your initial setup
function setup()
    touched = true
    rectMode(CENTER)
    spriteMode(CENTER)
    textMode(CENTER)
    minutes = 0
    username = ""
    room = 0
    seconds = 0
    screen = 1
    boyTimer = 0
    xw = WIDTH/1024
    textWhite = color(250,244,244,255)
    string = ""
    screenList = {"Project:room","Project:name","Project:home"}
    faceList = {"Project:normal","Project:blink","Project:wink"}
end

function keyboard(key)
    if key == RETURN then
        if screen == 1 then
            room = buffer
        else
            username = buffer
        end
        screen = screen + 1
        hideKeyboard()
    end
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
        background(255, 255, 255, 255)
        sprite(screenList[screen],WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
        if screen <= 2 and isKeyboardShowing() == false then
            showKeyboard()
        end
        if screen <= 2 then
            fill(255)
            fontSize(60*xw)
            font("Arial")
            buffer = keyboardBuffer()
            text(buffer,WIDTH/2,HEIGHT*3.3/4)
            if CurrentTouch.state == ENDED then
                touched = true
            end
            if CurrentTouch.state == BEGAN and touched then
                touched = false
                if screen == 1 then
                    room = buffer
                else
                    username = buffer
                end
                screen = screen + 1
                hideKeyboard()
            end
        end
        if (screen%3 ~= 0 or screen == 3) and screen > 2 then
        fill(255,255,255,.89*255)
        rect(WIDTH/2,HEIGHT-597,WIDTH,194)
        fill(0,0,0,181)
        rect(201.5*xw,HEIGHT-192*xw,290*xw,271*xw)
        font("DS-Digital")
        fill(textWhite)
        fontSize(60*xw)
        text("BELLBOY",188*xw,HEIGHT-115*xw)
        fontSize(25*xw)
        text(username.." - "..room,WIDTH*3.4/5,HEIGHT*7/8)
        font("Arial")
        fontSize(22*xw)
        text("Make an order:",159*xw,HEIGHT-167*xw)
        text("Towels",119*xw,HEIGHT-xw*201)
        text("Room Service",154*xw,HEIGHT-xw*232)
        text("Ice",100*xw,HEIGHT-xw*263)
        text("Luggage",128*xw,HEIGHT-xw*294)
        boyTimer = boyTimer + 1./30.
        if boyTimer <= 5 or (boyTimer <= 10.2 and boyTimer >= 5.2) or (boyTimer >= 10.4 and boyTimer <= 15.4) then
            face = 1
        elseif (boyTimer > 5 and boyTimer < 5.2) or (boyTimer > 10 and boyTimer < 10.2) then
            face = 2
        elseif boyTimer > 15.4 and boyTimer < 16 then
            face = 3
        else
            boyTimer = 0
        end
        sprite(faceList[face],699*xw,HEIGHT-264*xw,411*xw,300*xw)
        end
        if screen == 3 then
            fill(149,152,154,255)
            fontSize(70)
            font("DS-Digital")
            text("WELCOME, HOW CAN BELLBOY",WIDTH/2,HEIGHT-555*xw)
            text("BE OF ASSISTANCE",WIDTH/2,HEIGHT-639*xw)
        end
end



