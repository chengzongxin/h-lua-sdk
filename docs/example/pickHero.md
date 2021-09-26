## 常见两种选英雄

酒馆模式

```lua
hhero.setBornXY(0, -300) --设定英雄出生点
hhero.buildSelector({
    during = 60,
    type = "tavern",
    buildX = -512, -- 酒馆构建点X
    buildY = 512, -- 酒馆构建点Y
    buildDistance = 256,--酒馆间距离
    buildRowQty = 5,--酒馆一个横行有几个
    tavernUnitQty = 12 --酒馆内最多有几种英雄
})
```

双击模式

```lua
hhero.setBornXY(0, -300) --设定英雄出生点
hhero.buildSelector({
    during = 60,
    type = "click",
    buildX = -512, -- 第一个英雄构建点X
    buildY = 512, -- 第一个英雄构建点Y
    buildDistance = 256,--每位英雄间距离
    buildRowQty = 5 --一个横行有几个英雄
})
```
