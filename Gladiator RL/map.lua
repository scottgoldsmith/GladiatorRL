function maze_generation()
    local room1x=128
    local room1y=160
    while room1x<=320 and room1y<=304 do
        room1x=room1x+16
        addwall(room1x,room1y)
        if room1x>320 then
            room1x=128
            room1y=room1y+16
        end
        
    end
    local room2x=128
    local room2y=336
    while room2x<=320 and room2y<=448 do
        room2x=room2x+16
        addwall(room2x,room2y)
        if room2x>320 then
            room2x=128
            room2y=room2y+16
        end
        
    end
end