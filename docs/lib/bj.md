## BJ (Blizzard Jass)

### 因为BJ本质是多余的，所以YDlua引擎自带并没有BJ。

> 下面说明下为什么BJ是多余的？
>
> 因为BJ本质就是对CJ的封装，所以编写lua可以自己封装需要的而没必要用它的。
>
> 简单来说就是并不需要它来帮你封装

例如我们来看一个暴雪的BJ封装 （设置单位的生命周期）

```jass
UnitApplyTimedLifeBJ( 60, 'BTLF', GetTriggerUnit() )
```

那么这个BJ其实对应CJ的是什么呢？

> 在F4触发编辑器，将T转为jass自定义文本后，按住ctrl点击函数名即可查看WE的函数详情

```jass
function UnitApplyTimedLifeBJ takes real duration, integer buffId, unit whichUnit returns nothing
    call UnitApplyTimedLife(whichUnit, buffId, duration)
endfunction
```

可以看到，暴雪的BJ封装大多都是这种换个位置的无谓封装

假如说是在编写其他语种的代码（例如lua）需要封装就算了，在jass里面这样的封装根本毫无意义

所以一般认为BJ在自定义代码层面来讲是没用的

```jass
UnitApplyTimedLife(whichUnit, buffId, duration)
```

那么有的BJ函数是有用的，那怎么办呢？相信聪明的你已经明白了

没错，就和上面一样嘛。看看它的BJ怎么写的，然后写你自己的代码风格封装就好了

举个例子，玩家选择单位这个BJ方法

> 并不是名字有BJ才是BJ函数，在WE里面显示红名的就是BJ函数

```
SelectUnitForPlayerSingle( GetTriggerUnit(), Player(0) )

// 它的本质
function SelectUnitForPlayerSingle takes unit whichUnit, player whichPlayer returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call ClearSelection()
        call SelectUnit(whichUnit, true)
    endif
endfunction
```

那么你在lua里面就可以这样写

```lua
if (cj.GetLocalPlayer() == whichPlayer) then
    ClearSelection()
    SelectUnit(whichUnit, true)
end
```


