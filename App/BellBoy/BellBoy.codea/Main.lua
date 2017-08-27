-- BellBoy
displayMode(FULLSCREEN_NO_BUTTONS)
supportedOrientations(LANDSCAPE_ANY)
-- Use this function to perform your initial setup
function setup()
    initial = 0
    touched = true
    rectMode(CENTER)
    spriteMode(CENTER)
    delivered = 0
    textMode(CENTER)
    FPS = 60
    username = ""
    room = 0
    screen = 4
    boyTimer = 0
    xw = WIDTH/1024
    textWhite = color(250,244,244,255)
    textGrey = color(149,152,154,255)
    string = ""
    screenList = {"Project:room","Project:name","Project:home","Project:roomservice","Project:roomservice","Project:roomservice","Project:roomserviceerror","Project:luggage","Project:luggage","Project:luggageerror","Project:towels","Project:towels","Project:towelserror","Project:ice","Project:ice","Project:iceerror"}
    faceList = {"Project:normal","Project:blink","Project:wink"}
end

function keyboard(key)
    if screen < 3 then
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
end

function complete(phrase)
    font("DS-Digital")
    fontSize(100)
    fill(textGrey)
    text(phrase,WIDTH/2, HEIGHT-597*xw)
end

-- This function gets called once every frame
function draw()
        FPS = FPS * 0.9 + 0.1 / DeltaTime
    -- This sets a dark background color 
        background(255, 255, 255, 255)
        sprite(screenList[screen],WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
        if screen <= 2 and isKeyboardShowing() == false then
            showKeyboard()
        end
if CurrentTouch.state == ENDED then
touched = true
end
        if screen <= 2 then
            fill(255)
            fontSize(60*xw)
            font("Arial")
            buffer = keyboardBuffer()
            text(buffer,WIDTH/2,HEIGHT*3.3/4)
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
        if (screen-1)%3 ~= 0 and screen > 2 and screen ~= 4 then
        fill(255,255,255,.89*255)
        rect(WIDTH/2,HEIGHT-597,WIDTH,194*xw)

        if math.floor(delivered) > 0 then
            sprite("Project:cancel",717*xw,HEIGHT-596*xw,477*xw)
            delivered = delivered - 1./FPS
            fill(87,87,87,255)
            x = 141*xw
            y = 172*xw
            for i=0,math.floor(100*delivered/initial) do
                ellipse(x+72.5*xw*math.cos((i)*2*math.pi/100+math.pi/2),y+72.5*xw*math.sin(i*2*math.pi/100+math.pi/2),16)
            end
            if math.floor(delivered) == 0 then
                delivered = 0
                screen = screen + 1
            end
            fill(textGrey)
            fontSize(120*xw)
            font("DS-Digital")
            if math.floor(delivered%60) > 9 then
                text((math.floor(delivered/60))..":"..math.floor(delivered%60),350*xw,HEIGHT-596*xw)
            else
                text((math.floor(delivered/60))..":0"..math.floor(delivered%60),350*xw,HEIGHT-596*xw)
            end
            if CurrentTouch.state == BEGAN and touched and CurrentTouch.x > 683*xw and CurrentTouch.y < HEIGHT*3/8 then
                touched = false
                delivered = 0
                screen = 3
            end
        end

        if screen == 6 then
           complete("ROOM SERVICE DELIVERED")
        end
        if screen == 9 then
            complete("LUGGAGE DELIVERED")
        end
        if screen == 12 then
            complete("TOWELS DELIVERED")
        end
        if screen == 15 then
            complete("ICE DELIVERED")
        end
        fill(0,0,0,181)
        rect(201.5*xw,HEIGHT-192*xw,290*xw,271*xw)
        font("DS-Digital")
        fill(textWhite)
        fontSize(60*xw)
        text("BELLBOY",188*xw,HEIGHT-115*xw)
        fontSize(25*xw)
        font("Arial")
        fontSize(22*xw)
        if CurrentTouch.state == BEGAN and touched and CurrentTouch.x > 56.5*xw and CurrentTouch.x < (56.5+201.5)*xw then
            touched = false
            if delivered > 0 then
                screen = screen + 2
            end
            for i=1,4 do
                if CurrentTouch.y < HEIGHT-(201-25)*xw-(50*(i-1))*xw and CurrentTouch.y > HEIGHT-(201+25)*xw-(50*(i-1))*xw then
                    screen = 4+(i-1)*3
                    if i > 1 then screen = screen + 1 end
                end
            end
        end
        text("Make an order:",159*xw,HEIGHT-167*xw)
        text("Towels",119*xw,HEIGHT-xw*263)
        text("Room Service",154*xw,HEIGHT-xw*201)
        text("Ice",100*xw,HEIGHT-xw*294)
        text("Luggage",128*xw,HEIGHT-xw*232)
        elseif CurrentTouch.state == BEGAN and touched and screen ~= 4 then
            touched = false
            screen = screen - 2
        elseif delivered > 0 then
            delivered = delivered - 1./FPS
        end
        if screen == 3 then
            text(username.." - "..room,WIDTH*3.4/5,HEIGHT*7/8)
            boyTimer = boyTimer + 1./FPS
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
            fill(textGrey)
            fontSize(70)
            font("DS-Digital")
            text("WELCOME, HOW CAN BELLBOY",WIDTH/2,HEIGHT-555*xw)
            text("BE OF ASSISTANCE",WIDTH/2,HEIGHT-639*xw)
        end
        if screen == 4 then
            fill(255,255,255,.89*255)
            rect(WIDTH/2,97*xw,WIDTH,194*xw)
            sprite("Project:place",WIDTH/2,97*xw,400*xw)
            fill(0,0,0,181)
            rect(WIDTH/2,HEIGHT-304*xw,900*xw,500*xw)
            sprite("Project:menu",WIDTH/2,HEIGHT-342*xw,734*xw)
            font("DS-Digital")
            fill(textWhite)
            fontSize(60*xw)
            text("BELLBOY",188*xw,HEIGHT-115*xw)
            fontSize(35*xw)
            text("BACK",885*xw,HEIGHT-112*xw)
            sprite("Project:back",825*xw,HEIGHT-115*xw,53*xw)
            if CurrentTouch.state == BEGAN and touched then
                if CurrentTouch.y < HEIGHT-575*xw then
                    touched = false
                    screen = screen + 1
                    delivered = math.random(300,900)
                    initial = delivered
                end
                if CurrentTouch.y > HEIGHT/4*3 and CurrentTouch.x > WIDTH*6.5/8 then
                    touched = false
                    screen = 3
                end
            end
        end
end



