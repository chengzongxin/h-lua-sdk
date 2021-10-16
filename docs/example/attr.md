## 自定义Attr属性

想要添加一个自定义属性，需要改动下面这个文件

没错只需要改一个文件即可

* \h-lua-sdk\depend\h-lua\const\attribute.lua

找到 CONST_ATTR

> 格式 键值,名字,初始值
>
> 这些键值：primary,life,mana,move,defend_white,attack_range,attack_range_acquire
>
> 上述键值会在初始化时强行覆盖为slk的物编数据，初始值写了是没用的

```lua
ATTR_CONF = {
    { "life", "生命", 0 },
    { "mana", "魔法", 0 },
    { "move", "移动", 0 },
    { "defend", "护甲", 0 },
    -- ......
}
```

在 CONST_ATTR 添加你自己的参数，如：幸运值

```lua
ATTR_CONF = {
    { "life", "生命", 0 },
    { "mana", "魔法", 0 },
    { "move", "移动", 0 },
    { "defend", "护甲", 0 },
    -- ......
    { "lucky", "幸运", 0 }
}
```

### 至此！已经可以在attr里面使用了

```lua
hattr.set(u, "lucky", "+1")
hattr.get(u, "lucky") -- 1
```
