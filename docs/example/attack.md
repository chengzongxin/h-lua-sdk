## 简单刷兵

每3秒在（0,0）刷2个步兵，攻击（100,100）坐标，一共刷10次

步兵的初始移动速度为175

```lua
local counter = 10;
htime.setInterval(3.00, function(curTimer)
    if (counter <= 0) then
        htime.delTimer(curTimer)
    end
    counter = counter - 1
    hunit.create({
        whichPlayer = hplayer.players[1], --归属玩家
        id = "hfoo", --类型id,如'H001'
        x = 0, --创建坐标X，可选
        y = 0, --创建坐标Y，可选
        qty = 2, --数量，可选，可选
        attackX = 100, --攻击X，可选
        attackY = 100, --攻击Y，可选
        attr = {  --自定义属性，可选
            move = '=175'
        },
    });
end)
```
