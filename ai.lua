--[[
local bdst,bx,by=999,0,0
   for i=1,4 do
    local dx,dy=dirx[i],diry[i]
    local tx,ty=m.x+dx,m.y+dy
    if iswalkable(tx,ty,"checkmobs") then
     local dst=dist(tx,ty,m.tx,m.ty)
     if dst<bdst then
      bdst,bx,by=dst,dx,dy
     end
    end
   end

]]--

function ai_move()
    dirx={-size,size,0,0}
    diry={0,0,-size,size}
    for i=1,#enemy_list do
        if dist(x,y,enemy_list[i].x,enemy_list[i].y)>size then
            local best_dist=999
            local bx,by=0,0
            local tx,ty=0,0
            for ii=1, 4 do
                local dx,dy=dirx[ii],diry[ii]
                local temp_dist=dist(x,y,enemy_list[i].x+dx,enemy_list[i].y+dy)
                if walkable(i,dx,dy) then
                    if temp_dist<best_dist then
                        best_dist=temp_dist--save that distance
                        tx=dx
                        ty=dy
                    end
                end
            end
            if dist(x,y,enemy_list[i].x,enemy_list[i].y)<size*40 then
                bx=tx
                by=ty
                if not(enemy_list[i].x+bx==x and enemy_list[i].y+by==y) then
                    enemy_list[i].y=enemy_list[i].y+by--moving
                    enemy_list[i].x=enemy_list[i].x+bx--moving
                end
            end
        else--we're too close, fight!
            hp=hp-1
            add_message("You are hit")
        end
    end
    
end

function walkable(i,dx,dy)
    for h=1,#wall_list do--don't want through walls
        if enemy_list[i].x+dx==wall_list[h].x and enemy_list[i].y+dy==wall_list[h].y then
            return false
        end
    end
    for oe=1,#enemy_list do--don't step on other enemies
        if enemy_list[i].x+dx==enemy_list[oe].x and enemy_list[i].y+dy==enemy_list[oe].y then
            return false
        end
    end
    return true
end

--[[ OLD MOVEMENT BELOW

for i=1,#enemy_list do
        if dist(x,y,enemy_list[i].x,enemy_list[i].y)>16 then
            local bx,by=0,0
            if x<enemy_list[i].x then
                bx=bx-size
            elseif x>enemy_list[i].x then
                bx=bx+size
            elseif x==enemy_list[i].x then
                bx=bx+0
            end
            if y<enemy_list[i].y then
                by=by-size
            elseif y>enemy_list[i].y then
                by=by+size
            else
                by=by+0
            end
            for h=1,#wall_list do--don't want through walls
                if enemy_list[i].x+bx==wall_list[h].x and enemy_list[i].y+by==wall_list[h].y then
                    bx=0
                    by=0
                end
            end
            for oe=1,#enemy_list do--don't step on other enemies
                if enemy_list[i].x+bx==enemy_list[oe].x and enemy_list[i].y+by==enemy_list[oe].y then
                    bx=0
                    by=0
                end
            end
            if not(enemy_list[i].x+bx==x and enemy_list[i].y+by==y) then
                enemy_list[i].y=enemy_list[i].y+by--moving
                enemy_list[i].x=enemy_list[i].x+bx--moving
            end
        else
            hp=hp-1
            add_message("You are hit")
        end
    end
]]