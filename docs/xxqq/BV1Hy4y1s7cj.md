## 小小演示

### 构建酒馆与小地图UI显示头像

B站演示

> <a target="_blank" href="https://www.bilibili.com/video/BV1Hy4y1s7cj">魔兽争霸构建酒馆与小地图UI显示头像</a>

小地图UI显示头像

> h-lua已添加此完整功能接口，建议直接使用，不必像下方自己实现

```lua
--[[
    绑定一个单位在"小地图"上显示你想要的贴图
    options = {
        frequency = 0.05, --刷新频率
        whichUnit = nil, --某单位
        texture = {file="",w=0.1,h=0.12,opacity}, --是用的单位标志：贴图文件、宽、高、透明[0.0-1.0]
        miniMap = {frame=0,w=0,h=0}, -- 小地图大小位置参数：UI—id、宽、高
        action = function(trackOptions){}, -- 每周期行为
    }
]]
---@param options pilotDZUIMiniMapTrack
hdzui.miniMapTrack = function(options)
    if (options.whichUnit == nil or his.deleted(options.whichUnit)) then
        return
    end
    options.frequency = options.frequency or 0.05
    options.texture = options.texture or {}
    options.texture.file = options.texture.file or hunit.getAvatar(hunit.getId(options.whichUnit))
    options.texture.w = options.texture.w or 0.016
    options.texture.h = options.texture.h or 0.016
    options.texture.opacity = options.texture.opacity or 1.0
    options.miniMap = options.miniMap or {}
    options.miniMap.frame = options.miniMap.frame or hdzui.origin.miniMap()
    options.miniMap.w = options.miniMap.w or 0.13875
    options.miniMap.h = options.miniMap.h or 0.1375
    if (type(options.action) ~= "function") then
        options.action = function(_t)
            -- 设_t.deleted=true则中止追踪
            if (his.dead(_t.whichUnit)) then
                hjapi.DzFrameShow(_t.frame, false)
                return
            end
            hplayer.forEach(function(enumPlayer, _)
                if (enumPlayer == hplayer.loc()) then
                    hjapi.DzFrameShow(_t.frame, his.allyPlayer(_t.whichUnit, enumPlayer))
                end
            end)
        end
    end
    local track = hdzui.frameTag("BACKDROP", "StandardMenuTinyButtonBaseBackdrop", hdzui.origin.game())
    if (track <= 0) then
        return
    end
    hjapi.DzFrameSetTexture(track, options.texture.file)
    hjapi.DzFrameSetAlpha(track, 255 * options.texture.opacity)
    hjapi.DzFrameSetSize(track, options.texture.w, options.texture.h)
    hjapi.DzFrameShow(track, false)
    options.frame = track
    options.deleted = false
    htime.setInterval(options.frequency, function(curTimer)
        if (options.deleted == true or his.deleted(options.whichUnit)) then
            htime.delTimer(curTimer)
            hjapi.DzFrameShow(options.frame, false)
            hjapi.DzFrameSetEnable(options.frame, false)
            return
        end
        local x = (hunit.x(options.whichUnit) - hrect.getMinX(hrect.world())) / hrect.getWidth(hrect.world()) * options.miniMap.w
        local y = (hunit.y(options.whichUnit) - hrect.getMinY(hrect.world())) / hrect.getHeight(hrect.world()) * options.miniMap.h
        hdzui.framePoint(options.frame, options.miniMap.frame, FRAME_ALIGN_CENTER, FRAME_ALIGN_LEFT_BOTTOM, x, y)
        options.action(options)
    end)
end
```
