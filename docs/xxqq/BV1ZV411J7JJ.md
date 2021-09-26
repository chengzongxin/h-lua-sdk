## 小小演示

### hslk高级用法演示3

B站演示

> <a target="_blank" href="https://www.bilibili.com/video/BV1ZV411J7JJ">魔兽争霸hslk高级用法演示3</a>

hslk的 _type 字段

```lua
-- 循环创建10把武器，type设置成”aaa"
for i = 1, 10 do
    table.insert(it,{
        Name = "小刀【等级】" .. i,
        _type = "aaa",
        _attr = _attr({
            attack_green = "+" .. 100 * i
        })
    })
end

for i = 1, 10 do
    local un = henemy.create({
        teamNo = 1,
        id = hslk.n2i("天选勇者"),
        x = 0,
        y = 0
    })
    --给这几个单位注册个死亡事件
    hevent.onDead(un, function(evtData)
        --获取
        local id = hslk.typeIds({ "aaa" })
        hitem.create({
            id = table.random(id),
            x = hunit.x(evtData.triggerUnit),
            y = hunit.y(evtData.triggerUnit)
        })
    end)
end
```
