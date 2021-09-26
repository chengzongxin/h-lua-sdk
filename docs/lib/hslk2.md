## hslk 使用入门

### 物品主动技能绑定

```lua
hslk_item({
  Name = "跳跳剑",
  _cooldown = 2,
  _cooldownTarget = CONST_ABILITY_TARGET.location.value,
  _onItemUsed = _onItemUsed(function(evtData)
    hunit.portal(evtData.triggerUnit, evtData.targetX, evtData.targetY)
  end),
})
```

### 技能主动绑定

```lua
hslk_ability({
  Name = "主动技能一个",
  _onSkillEffect = _onSkillEffect(function(evtData)
    -- 技能搞起来
  end)
})
```

### 多级技能配置

```lua
hslk_ability({
  Name = "多级的技能",
  levels= 3,
  DataA = {0,0,0},
  DataB = {0,0,0},
  Cool = {0,0,0},
  Cost = {0,0,0},
})
```

### hslk属性的获取

> hslk生成的物编，在游戏脚本运行时，可以超级方便地自由读取数据

```lua
hslk.i2v(id) --根据物编ID，获取全数据
hslk.n2v(id) --根据物编Name，获取全数据，如果名字有重复，会返回多组数据
hslk.n2i(id) --根据物编Name，获取物编ID，如果名字有重复，只返回第一个ID
```

### hslk属性的获取slk数据

```lua
hslk.i2v(id,"slk") --slk数据放在第1级的slk的key里
hslk.i2v(id,"_id") --hlua的自定义数据也在第1级里
```

> 注意，slk数据的值，一开始获取都是字符串，需要自己转换

### hslk.i2v的多级获取写法

```lua
hslk.i2v(id,"slk","Primary") --获取一个英雄的主属性串 STR|AGI|INT|_
```

> 无效路径，则返回nil

### hslk的 _class 字段

```
hslk每组数据都必定会含有一个_class字段，是构建时用来记录数据类别的
技能时 _class = ability
单位时 _class = unit
物品时 _class = item
魔法效果时 _class = buff
科技时 _class = upgrade
在运行时，可以一次性获取所有某 class 下的ID字符串数组
hslk.classIds({"ability","item"})
```

### hslk的 _type 字段

```
hslk每组数据都必定会含有一个 _type 字段，是构建时用来记录数据类别的
_type 字段一般情况下都是 common
而引用hslk官方的拓展函数，如hslk_ability_empty,会有固定的搭配

_type 可以在定义时自定义值，你写什么就是什么，可用于后续脚本中的ID集合获取

在运行时，可以一次性获取所有某  type 下的ID字符串数组
hslk.typeIds({"hero"})
```

### hslk的 Misc

```
hslk里面可以获取misc数据,如：
hslk.misc("Misc","FadeBuffMinDuration") --"10"

misc数据就是平衡常数界面等等的一些游戏框架式数据
如果你不清楚有什么值，可以参考 h-lua/docs/slk-misc.md
```

### hslk的 自定义数据

```lua
-- hslk配置时，table里面可以像设置_type一样，定义你自己随心的值
hslk_unit({
    _id_force = "xTYG",
    Name = "一个单位",
    _myData1 = 1,
    _myData2 = {0},
})

-- 在脚本中就可以像平时获取值一样获取

hslk.i2v("xTYG","_myData1")
hslk.i2v("xTYG","_myData2")

hslk.i2v(hslk.n2i("一个单位"),"_myData1")
hslk.i2v(hslk.n2i("一个单位"),"_myData2")

hslk.n2v("一个单位","_myData1")
hslk.n2v("一个单位","_myData2")
```

### hslk为单位添加技能例子

```lua
-- hslk可以自定义值上面已讲过，所以我们可以设定一些技能后面调用
hslk_unit({
    _id_force = "xTYG",
    Name = "一个单位",
    _mySkillIds = {"A001","A002"},
})
-- 后面脚本里：
local unitId = "xTYG"
local whichUnit= hunit.create({whichPlayer=hplayer.players[1],id = unitId,x=0,y=0})
local mySkillIds = hslk.i2v(unitId,"_mySkillIds")
for _,id in ipairs(mySkillIds)do
  hskill.add(whichUnit,id)
end

-- 除此之外，你可以和原生一样直接在hslk设定技能：
hslk_unit({
    _id_force = "xTYG",
    Name = "一个单位",
    abilList = "A001,A002",
})
-- 后面框架会自动帮你处理数据，完事
```
