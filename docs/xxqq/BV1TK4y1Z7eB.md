## 小小演示

### hslk高级用法演示1

B站演示

> <a target="_blank" href="https://www.bilibili.com/video/BV1TK4y1Z7eB">魔兽争霸hslk高级用法演示1</a>

物品主动技能绑定

_onItemUsed

```lua
hslk_item({
    Name = "物理学圣剑",
    class = "Permanent",
    _cooldown = 1,
    _cooldownTarget = CONST_ABILITY_TARGET.location.value,
    _attr = _attr({
        attack_green = "+9999"
    }),
    _onItemUsed = _onItemUsed(function(evtData)
        hunit.portal(evtData.triggerUnit,evtData.targetX,evtData.targetY)
    end)
})
```

技能主动绑定

_onSkillEffect

```lua
hslk_ability({
    Name = "穿云箭",
    Art = "ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp",
    Ubertip = hcolor.yellow("穿云箭"),
    Hotkey = "E",
    _parent = "ANcl",
    _type = "skill",
    DataA = {0},
    DataC = {1},
    EffectArt = "",
    TargetArt = "",
    CasterArt = "",
    Cool = { 2 },
    DataB = { 2 },
    Cost = { 0 },
    DataD = { 0 },
    Rng = { 800 },
    DataF = {"berserk"},
    _onSkillEffect = _onSkillEffect(function(evtData)
        local xy = math.polarProjection(hunit.x(evtData.triggerUnit),hunit.y(evtData.triggerUnit),
                2000,math.getDegBetweenXY(hunit.x(evtData.triggerUnit),hunit.y(evtData.triggerUnit),evtData.targetX,evtData.targetY))
        hskill.leap({
            sourceUnit = evtData.triggerUnit, --伤害来源（必须有！不管有没有伤害）
            x = xy.x, --冲击的x坐标（可选的，对点冲击，与某目标无关）
            y = xy.y, --冲击的y坐标（可选的，对点冲击，与某目标无关）
            speed = 50, --冲击的速度（可选的，默认10，0.02秒的移动距离,大概1秒500px)
            acceleration = 0.05, --冲击加速度（可选的，每个周期都会增加0.02秒一次)
            filter = function(unit)
                return his.enemy(evtData.triggerUnit,unit) and his.alive(unit)
            end, --必须有
            tokenArrow = "war3mapImported\\aaaaaaaa.mdx", --前冲的特效（arrowUnit=nil时认为必须！自身冲击就是bind，否则为马甲本身，如冲击波的波）
            damageMovement = 200, --移动过程中的伤害（可选的，默认为0）
            damageMovementRadius = 100, --移动过程中的伤害（可选的，默认为0，易知0范围是无效的所以有伤害也无法体现）
            damageMovementRepeat = false, --移动过程中伤害是否可以重复造成（可选的，默认为不能）
            damageMovementDrag = false, --移动过程是否拖拽敌人（可选的，默认为不能）
            damageSrc = CONST_DAMAGE_SRC.skill, --伤害的种类（可选）
            damageType = {CONST_DAMAGE_TYPE.thunder} --伤害的类型,注意是table（可选）
        })
    end)
})
```
