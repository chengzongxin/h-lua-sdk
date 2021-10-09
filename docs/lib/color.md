## hcolor 文本颜色


> 框架提供了文本颜色修改的库

#### hex 方法，使用6位长度颜色

```lua
hcolor.hex("一个字符串", "FF0000")
```

#### hex衍生方法

> 自带的一些常用颜色，你也可以自己拓展

```lua
--- 耀金
hcolor.gold("一个字符串")

--- 纯白
hcolor.white("一个字符串")

--- 纯黑
hcolor.black("一个字符串")

--- 浅灰
hcolor.grey("一个字符串")

--- 深灰
hcolor.greyDeep("一个字符串")

--- 亮红
hcolor.redLight("一个字符串")

--- 大红
hcolor.red("一个字符串")

--- 浅绿
hcolor.greenLight("一个字符串")

--- 深绿
hcolor.green("一个字符串")

--- 浅黄
hcolor.yellowLight("一个字符串")

--- 亮黄
hcolor.yellow("一个字符串")

--- 浅橙
hcolor.orangeLight("一个字符串")

--- 橙色
hcolor.orange("一个字符串")

--- 天空蓝
hcolor.skyLight("一个字符串")

--- 青空蓝
hcolor.sky("一个字符串")

--- 浅海蓝
hcolor.seaLight("一个字符串")

--- 深海蓝
hcolor.sea("一个字符串")

--- 浅紫
hcolor.purpleLight("一个字符串")

--- 亮紫
hcolor.purple("一个字符串")
```

#### format 方法

> 适用于复杂文本颜色处理

```lua
-- 例子
local txt = hcolor.format("%s在%s里观摩%s，结果弄坏了，赔了%s", hcolor.white, {
    { "80ff00", "剑圣" },
    { "ff59ff", "武器屋" },
    { "ff0000", "[圣剑·火之高兴]" },
    { hcolor.gold, "100W" },
})

print_mb(txt)
echo(txt)
```
