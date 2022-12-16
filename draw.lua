function love.draw()
    love.graphics.scale(1.5, 1.5)
    --love.graphics.print(text[2],x,y)
    --draw all floors
    for i=1,#floor_list do
        love.graphics.print(".",floor_list[i].x+4,floor_list[i].y)
    end
    --draw all walls
    for i=1,#wall_list do
        love.graphics.print("#",wall_list[i].x,wall_list[i].y)
    end
    --draw enemies
    if #enemy_list>0 then
        for i=1,#enemy_list do
            if enemy_list[i].hp>0 and enemy_list[i].x<=9997 then
                love.graphics.print("e",enemy_list[i].x,enemy_list[i].y)
                local start_hp=1
                while start_hp<=enemy_list[i].hp do
                    love.graphics.print("*",enemy_list[i].x+(6*start_hp),enemy_list[i].y-8)
                    start_hp=start_hp+1
                end
            elseif enemy_list[i].hp<=0 then--remove dead enemies here
                enemy_list[i].x=999999
                enemy_list[i].y=999999
                table.remove(enemy_list[i],i)
                thyme()--move message list so we don't put a message over a hit
                add_message("An enemy has died.")
                enemy_list[i].hp=9999--need better solution than this.
            end
        end
    end
    --draw items
    for i=1,#item_list do
        if item_list[i].s=="stairs" then
            love.graphics.print("$",item_list[i].x,item_list[i].y)
        end
    end
    --
    --draw messages
        for i=1,#msg_list do
            love.graphics.print(msg_list[i].tx,msg_list[i].x,msg_list[i].y)
        end
    --
    love.graphics.print("HP "..hp.."   Love Roguelike ",180,15)
    love.graphics.print("@",x,y)
    love.graphics.print(#msg_list,140,440)
    love.graphics.print(t,150,450)
    love.graphics.print("Events:",125,260)--message bar (messages go below this @y=450)
    love.graphics.print("_____________________________________",50,265)

    --draw inventory
    if #inventory>0 then
        for i=1,#inventory do
            love.graphics.print(inventory[i].num..": "..inventory[i].tx,300,inventory[i].y)
        end
    end
    ----

    --pixel of blood
    love.graphics.setColor(255, 0, 0) -- Red point.
    love.graphics.points(290, 200)
    love.graphics.setColor(255, 255, 255) -- white point.
    love.graphics.print(x.."/"..y,x,y-20)
end