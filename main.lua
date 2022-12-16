function love.load()
    inventory={}
    require("draw")
    require("map")
    require("ai")
    local seed_val = love.timer.getTime()
    love.math.setRandomSeed(seed_val)
    love.math.random()
    size=16--size of each "tile"
    level_size=240
    new_level()
    attack=1
    t=0--timer
    
end

function addwall(xx,yy)
    local w={x=xx,y=yy}
    table.insert(wall_list,w)
    remove_double()
end

function add_enemy(xx,yy,typ,h)
    local e={x=xx,y=yy,s=typ,hp=h}
    table.insert(enemy_list,e)
end

function add_message(text)
    thyme()
    local t={tx=text,life=5,x=80,y=280}
    table.insert(msg_list,t)
end

function add_inventory(numb,txx,yy)
    local inv={num=numb,tx=txx,y=yy}
    table.insert(inventory,inv)
end

function remove_msg()
    local i=1
    local ii=1
    while #msg_list>=i do
        for ii=1,#msg_list do
        if msg_list[i].life <=0 then
            table.remove(msg_list,i)
        end
        end
        i=i+1
    end
end

function add_item(xx,yy,typ)
    local i={x=xx,y=yy,s=typ}
    table.insert(item_list,i)
end

function remove_enemy(xx,yy)
    local i=1
    local ii=1
    while #enemy_list>i do
        for ii=1,#enemy_list do
        if enemy_list[i].x==xx and enemy_list[i].y==yy then
            table.remove(enemy_list,i)
        end
        end
        i=i+1
    end
end

function remove_double()
    local i=1
    local ii=1
    while #floor_list>i do
        for ii=1,#wall_list do
        if wall_list[ii].x==floor_list[i].x and wall_list[ii].y==floor_list[i].y then
            table.remove(floor_list,i)
        end
        end
        i=i+1
    end
end

function new_level()
    xxtable={96,112,128,144,160,176,192}
    xxrow= xxtable[math.random(#xxtable)] --Outputs a random value
    x=128
    y=128
    msg=0
    hp=3
    enemy_list={}
    wall_list={}
    item_list={}
    msg_list={}
    floor_list={}--open floor
    wallsx=64
    wallsy=32
     
  while wallsx<=level_size and wallsy<=level_size do
	if wallsx==64 or wallsx==level_size or wallsy==32 or wallsy==level_size then
     local w={x=wallsx,y=wallsy}
     table.insert(wall_list,w)
   else--open floor
   		local e={x=wallsx,y=wallsy}
   		table.insert(floor_list,e)
	end
	wallsx=wallsx+16
	if wallsx>level_size then
	    wallsx=64
		wallsy=wallsy+16
	end
  end
    --maze_generation()
    --random wall
    --between 32 and 464
    --addwall(160,128)
    addwall(128,96)
    addwall(128,112)
    addwall(144,80)
    addwall(160,80)
    addwall(176,80)
    --
    add_inventory(#inventory+1,"Nuke",75+(#inventory*15))
    add_inventory(#inventory+1,"Blessing",75+(#inventory*15))
    --add enemy
    add_enemy(176,48,0,2)
    add_enemy(160,48,0,1)
    --stairs
    add_item(160,144,"stairs")
    --
    add_message("this is a test")
end

function move()
    --move enemy/combat
    ai_move()
end

function thyme()--time happens
    --t=t+1
    --
    local i=1
    while #msg_list>=i do
        if msg_list[i].life>0 then
            msg_list[i].y=msg_list[i].y+size--move us
            msg_list[i].life=msg_list[i].life-1--closer to death
            remove_msg()--see if we should remove anyting
        end
        i=i+1
    end
end

function love.keypressed(key)
    if key=="up" or key=="w" or key=="kp8" then
        --thyme()
        add_message("You walk")
        local neither=true
    	for i=1,#wall_list do
    		if y-size==wall_list[i].y and x==wall_list[i].x then
                neither=false
    		end
    	end
        for i=1,#enemy_list do
            if enemy_list[i].y==y-size and enemy_list[i].x==x then
                enemy_list[i].hp=enemy_list[i].hp-attack
                neither=false
            end
        end
        if neither==true then
            y=y-size
        end
    elseif key=="down" or key=="s" or key=="kp2"  then
        --thyme()
        add_message("You walk")
        local neither=true
    	for i=1,#wall_list do
    		if y+size==wall_list[i].y and x==wall_list[i].x then
                neither=false
    		end
    	end
        for i=1,#enemy_list do
            if enemy_list[i].y==y+size and enemy_list[i].x==x then
                enemy_list[i].hp=enemy_list[i].hp-attack
                neither=false
            end
        end
        if neither==true then
            y=y+size
        end
    elseif key=="left" or key=="a" or key=="kp4"  then
        --thyme()
        add_message("You walk")
        local neither=true
    	for i=1,#wall_list do
    		if y==wall_list[i].y and x-size==wall_list[i].x then
                neither=false
    		end
    	end
        for i=1,#enemy_list do
            if enemy_list[i].x==x-size and enemy_list[i].y==y then
                enemy_list[i].hp=enemy_list[i].hp-attack
               neither=false
            end
        end
        if neither==true then
            x=x-size
        end
    elseif key=="right" or key=="d" or key=="kp6"  then
        --thyme()
        add_message("You walk")
        neither=true
    	for i=1,#wall_list do
    		if y==wall_list[i].y and x+size==wall_list[i].x then
                neither=false
    		end
    	end
        for i=1,#enemy_list do
            if enemy_list[i].x==x+size and enemy_list[i].y==y then
                enemy_list[i].hp=enemy_list[i].hp-attack
               neither=false
            end
        end
        if neither==true then
            x=x+size
        end
    elseif key=="1" then
        if #inventory>=1 then
            for i=1, #inventory do
                if inventory[i].tx=="Nuke" and i==1 then
                    for i=1,#enemy_list do
                        enemy_list[i].hp=0
                    end
               end
            end
        end
    
    elseif key=="r" then
        love.load() 
    end

    --collission with items
    for i=1,#item_list do
        if item_list[i].x==x and item_list[i].y==y then
            if item_list[i].s=="stairs" then
                new_level()
            end
        end
    end
    --
    move()--enemy movement after we move
end

function love.update()
    
end

function dist ( x1, y1, x2, y2 )
	return math.sqrt ( math.pow ( x2 - x1, 2 ) + math.pow ( y2 - y1, 2 ) )
end

