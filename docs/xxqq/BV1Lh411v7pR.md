## 小小演示

### 伤害排行榜

B站演示

> <a target="_blank" href="https://www.bilibili.com/video/BV1Lh411v7pR">魔兽争霸伤害排行榜</a>

伤害排行榜UI显示

```lua
UI = function()
    --加载toc
    hdzui.loadToc("UI\\frame.toc")
    --初始化
    awar = hdzui.frame("awar",hdzui.origin.game(),0)
    --设置位置
    hjapi.DzFrameSetAbsolutePoint(awar,4,0.388,0.350)
    hjapi.DzFrameShow(awar,false)

    --伤害榜初始化
    damUI = {}
    txtUI = {}
    barUI = {}
    --logo
    damUI[1] = hdzui.frameTag("BACKDROP","x1",hdzui.origin.game(),"")
    hjapi.DzFrameSetTexture(damUI[1],"war3mapImported\\dam.tga",false)
    hjapi.DzFrameSetAbsolutePoint(damUI[1],4,0.744,0.411)
    hjapi.DzFrameSetSize(damUI[1],0.108,0.026)
    hjapi.DzFrameShow(damUI[1],true)
    --忘记放我可爱的音乐了
    hplayer.forEach(function(enumPlayer, idx)
        --头像
        damUI[idx + 1] = hdzui.frameTag("BACKDROP","tx1" .. idx,hdzui.origin.game(),"")
        hjapi.DzFrameSetTexture(damUI[idx + 1],"war3mapImported\\tx.tga",false)
        hjapi.DzFrameSetPoint(damUI[idx + 1],2,damUI[1],8,0,0)
        hjapi.DzFrameSetSize(damUI[idx + 1],0.015,0.019)
        hjapi.DzFrameShow(damUI[idx + 1],false)

        --条条
        barUI[idx] = hdzui.frameTag("BACKDROP","txx" .. idx,damUI[idx + 1],"")
        hjapi.DzFrameSetTexture(barUI[idx],"war3mapImported\\green.tga",false)
        hjapi.DzFrameSetPoint(barUI[idx],5,damUI[idx + 1],3,0,0)
        hjapi.DzFrameSetSize(barUI[idx],0.107,0.019)
        hjapi.DzFrameShow(barUI[idx],true)

        --伤害文字
        txtUI[idx] = hdzui.frameTag("TEXT","tx" .. idx,damUI[idx + 1],"")
        hjapi.DzFrameSetText(txtUI[idx],"0")
        hjapi.DzFrameSetPoint(txtUI[idx],5,barUI[idx],3,0,0)
        hjapi.DzFrameSetSize(txtUI[idx],0.030,0.017)
        hjapi.DzFrameShow(txtUI[idx],true)
    end)
    --注册3个按钮点击事件
    hsync.onFrameMouse(hjapi.DzFrameFindByName("awar_1",0),1,function(syncData)
        --添加技能
        hskill.add(hero[syncData.triggerPlayer],tb[syncData.triggerPlayer][1],1)
        if (syncData.triggerPlayer ~= hplayer.loc()) then
            return
        end
        hjapi.DzFrameShow(awar,false)
    end)
    hsync.onFrameMouse(hjapi.DzFrameFindByName("awar_2",0),1,function(syncData)
        --添加技能
        hskill.add(hero[syncData.triggerPlayer],tb[syncData.triggerPlayer][2],1)
        if (syncData.triggerPlayer ~= hplayer.loc()) then
            return
        end
        hjapi.DzFrameShow(awar,false)
    end)
    hsync.onFrameMouse(hjapi.DzFrameFindByName("awar_3",0),1,function(syncData)
        --添加技能
        hskill.add(hero[syncData.triggerPlayer],tb[syncData.triggerPlayer][3],1)
        if (syncData.triggerPlayer ~= hplayer.loc()) then
            return
        end
        hjapi.DzFrameShow(awar,false)
    end)

    --然后计时器改变UI位置

    htime.setInterval(0.05,function(curTimer)
        local sort = {}
        hplayer.forEach(function(enumPlayer, idx)
            local s = {idx = idx , val = hplayer.getDamage(enumPlayer)}
            table.insert(sort,s)
        end)
        --排序
        table.sort(sort,function(a, b)
            if (a.val == b.val) then
                return b.idx > a.idx
            end
            return a.val > b.val
        end)
        --根据排序更改头像UI位置
        local dam = sort[1].val
        local i = 0
        for k,v in ipairs(sort)do
            if (k > 1) then
                --除了排第一的 其他条条根据第一名伤害来确定大小
                i = v.val / dam
                hjapi.DzFrameSetSize(barUI[v.idx],i * 0.107,0.019)
            else
                hjapi.DzFrameSetSize(barUI[v.idx],0.107,0.019)
            end
            --修改伤害文字
            hjapi.DzFrameSetText(txtUI[v.idx],math.round(hplayer.getDamage(hplayer.players[v.idx])))
            --修改头像图标
            hjapi.DzFrameSetTexture(damUI[v.idx + 1],hslk.i2v(hunit.getId(hero[v.idx]),"slk","Art"),false)
            --修改头像UI位置
            hjapi.DzFrameSetPoint(damUI[v.idx + 1],2,damUI[1],8,0,(k - 1) * -0.02)
            hjapi.DzFrameShow(damUI[v.idx + 1],true)
        end
    end)
end
```
