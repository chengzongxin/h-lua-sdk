## sync 同步

> 网易给我们提供的与同步数据有关的函数有4条：
> 
> hjapi已附带
```
DzSyncData
DzTriggerRegisterSyncData
DzGetTriggerSyncPlayer
DzGetTriggerSyncData
```
> 原理和服务器请求响应一样，简单易懂
> 
> 一个发，一个收（注意过程时间）

#### 若使用hsync库，例子

```lua
-- 通用型操作，两个配套
hsync.onSend("hzg", function(syncData)
    echo(syncData.triggerData[1] .. syncData.triggerData[2] .. "人类")
end)
local a = 0
htime.setInterval(2, function(curTimer)
    hsync.send("hzg", { "hunzsig", "是个" .. a .. "级" })
    a = a + 1
end)
```
