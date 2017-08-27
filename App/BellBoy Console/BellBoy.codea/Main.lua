-- BellBoy
displayMode(FULLSCREEN_NO_BUTTONS)
supportedOrientations(LANDSCAPE_ANY)
-- Use this function to perform your initial setup
function setup()
    faceList = {"Project:normal","Project:blink","Project:wink"}
    spriteMode(CENTER)
    word = 1
    boyTimer = 0
    FPS = 60
    speech.pitch = 1.7
    speech.voice = speech.voices[8]
    counter = 0
    words = {"Beep Beep Coming Through","Please excuse me, I have a very important delivery","Do you need assistance today, please use the bell boy app to request for assistance","Please be careful and have a nice day","Watch out, progress coming through","You look very nice today","Make sure to look down","Hell low Ev urree one I am Behll Boy","I'm here to help","How is your day","Please watch out","I can bring luggage or room service or even toiletries and towels", "I'm on my way","How are you folks doing","Whatever you need, I am available 24 hours a day","Let's make this a home away from home","Have a nice day"}
    speech.rate = 0.4
    speech.postDelay = 2
    speech.say("Hell low Ev urree one I am Behll Boy")
    counter2 = 0
    completed = false
    speaking = true
end


-- This function gets called once every frame
function draw()
        FPS = FPS * 0.9 + 0.1 / DeltaTime
        background(255, 255, 255, 255)
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
            sprite(faceList[face],WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)

            if speech.speaking == false and UserAcceleration.y > 0.2 then
                speaking = true
                completed = true
                speech.say(words[word])
                word = word + 1
                if word > #words then
                    word = 1
                end
                counter = 0
            end
            if speaking and speech.speaking == false then
                counter2 = counter2 + 1
                if counter2 == 150 then
                   -- sound(DATA, "ZgJARABAQEBAPkBAAAAAAJqZmT75IhE/QABAf0BAQEBAQEBi")
                    counter2 = 0
                    speaking = false
                end
            end
            if UserAcceleration.y <= 0.1 then
                counter = counter + 1
            end
            if speech.speaking and counter > 300 and completed then
                completed = false
                speech.say("Delivery Complete")

            end
end



