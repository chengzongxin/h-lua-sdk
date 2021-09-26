## 难度选择对话框

创建一个难度选择对话框，自动挑选第一位玩家，让他选

```lua
hdialog.create(
    nil, --自动挑选第一位玩家，让他选
    {
        title = "选择难度",
        buttons = {
            "一般困难",
            "非常困难",
            "极奇困难",
            "破天荒难",
        }
    },
    function(btnIdx)
        if (btnIdx == "非常困难") then
            --搞点事情
        elseif (btnIdx == "极奇困难") then
            --搞点事情
        elseif (btnIdx == "破天荒难") then
            --搞点事情
        else
            --搞点事情
        end
        echo("选择了：" .. btnIdx)
    end
)
```

创建一个带热键的难度选择对话框，自动挑选玩家3，让他选

```lua
hdialog.create(
    hplayer.players[3],
    {
        title = "选择难度",
        buttons = {
            { value = "Q", label = "一般困难" },
            { value = "W", label = "非常困难" },
            { value = "E", label = "极奇困难" },
            { value = "R", label = "破天荒难" },
        }
    },
    function(btnIdx)
        if (btnIdx == "Q") then
            --搞点事情
        elseif (btnIdx == "W") then
            --搞点事情
        elseif (btnIdx == "E") then
            --搞点事情
        elseif (btnIdx == "R") then
            --搞点事情
        end
        echo("选择了：" .. btnIdx)
    end
)
```
