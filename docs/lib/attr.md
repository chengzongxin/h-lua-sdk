## 属性系统

h-lua 有强大的属性系统

能轻松几行代码就实现绝大多数属性的实时改动

### hattribute.setRelation

属性每1单位映射 可以模拟三围加成等

### gold_ratio / lumber_ratio / exp_ratio / sell_ratio

黄金率 / 木头率 / 经验率 / 售卖率（%）

* 影响资源获取率 售卖率以默认的50%为准，假如某玩家作者设置TA的售卖率不等于50，那么会自动算出差值，给予扣款或补偿

### life / life_back

生命 / 生命恢复

* 单位的最大生命值 / 每秒对生命恢复的量 最小值 1

### mana / mana_back

魔法 / 魔法恢复

* 单位的最大魔法值 / 每秒对魔法恢复的量 最小值 1

### move

移动力

* [范围] 0～?取决于地图的平衡常数设置(一般设为522)
  每秒移动最大距离
* 数值无上限，但地图移动上限为522
* 假设移动力为2000，则实际移动仍为522，而其他由移动力影响的技能属性将以2000点计算

### defend / defend_white / defend_green

护甲（总/白/绿）

* 你可以使用hattr.set改动defend,实际改的是defend_green

### damage_reduction / damage_decrease

固定值减伤 / 百分比减伤

* 可以直接抵消伤害
* 减伤最低为0，也就是不能反增伤

### sight / sight_day /sight_night

视野(变化) / 白天视野 / 黑夜视野

* 单位的视野 sight指的是变化值，attr设定=时不是终点值而是“变化”的目标值
* 你可以使用hattr.set设置sight_day /sight_night,但并不能真的设置分别的视野，实际改动的变化值

### avoid

回避（%）

* 当英雄受到的是“攻击”造成的伤害时会有一定几率闪避抵抗，并且使攻击特效失效
* 闪避效果只有当英雄回避属性大于0%时才会开始生效 回避可以无限堆，回避率达到100%时一般情况下回避所有伤害 回避率=(回避-命中)（%）
* 如果该次伤害为无视回避，则回避失效（breakArmorType）

### aim

命中（%）

* aim 命中直接抵消回避生效的效果值 回避率=(回避-命中)（%）

### punish / punish_current

僵直 / 当前硬直

* 僵直的单位移动攻速会被限制 硬直扣减量与受到伤害相关
* 受到快速多段伤害或高伤害时，将很容易被击破而僵直 硬直被破坏时会僵直5秒,并重置硬直条，期间受到伤害可能会再次僵直
* 硬直的僵直5秒的体现是攻击速度和移动速度被极大地减少 硬直未被击破时每隔5秒恢复100点

### punish_oppose

僵直抵抗（%）

* 不造成伤害时，不减少硬直
* 硬直抵抗按百分比减少硬直的减速效果(减的是攻速及移速)
* 硬直抵抗的效果最高只能减少90% 力量（总/白/绿）

### str / str_white / str_green

力量（总/白/绿）

* 你可以使用hattr.set设置str,但实际改动的是str_green

### agi / agi_white / agi_green

敏捷（总/白/绿）

* 你可以使用hattr.set设置str,但实际改动的是agi_green

### int / int_white / int_green

智力（总/白/绿）

* 你可以使用hattr.set设置int,但实际改动的是int_green

### attack / attack_white / attack_green

攻击

* 一个单位的当前攻击浮动+白+绿
* 由于存在区间浮动，所以这个值每次get都会不一样
* 你可以使用hattr.set设置attack,但实际改动的是attack_green
* 在h-lua下所有单位造成的伤害都视为攻击attack（包括原生技能）
* 在调用攻击附魔后，攻击可以附带元素 单位进行攻击的能力，一般分为近战或者远程 攻击间隔

### attack_space

攻击间隔

* 根据原始攻速和攻击速度计算出的间隔值
* 但是set的时候实际设置的是原始间隔(attack_space_origin)

### attack_range

攻击范围

* 单位进行攻击的最大距离

### attack_speed

攻击速度（%）

* 攻击一次的间隔 假设当前攻速增益为 x% ： 攻击间隔公式：(基本间隔*100) / (100+x) [单位：击/秒]

### reborn

复活时间（秒）

* 此值默认-999，无复活效果 当这个值大于等于0时，且单位是英雄，单位会拥有复活的效果 复活的流程执行是一个默认函数，有需要可修改 hevent_default_actions.hero.reborn

### cure

治疗效果（%）

* 增强治疗的效果 影响hunit.addLife/Mana的效果 life_back/mana_back已自动生效

### hemophagia / hemophagia_skill

吸血（%） / 技能吸血（%）

* 攻击 / 技能造成伤害时触发吸血 以实际伤害及吸血百分比为计算

### damage_amplitude

伤害增幅（%）

* 增幅属性可以提高所有的伤害（包括真实伤害）
* 如增幅100%，则攻击、物品、技能等所有伤害都会提高100% 伤害增幅在暴击分裂等之前 负重（Kg）

### weight / weight_current

负重（Kg）

* 负重决定你身上能够佩戴多少重量的物品装备
* 常规地图物品都设为0kg，所以负重是无效的

### invincible

无敌（%）

* 收到伤害时瞬间无敌抵消的的几率

### damage_rebound / damage_rebound_oppose

伤害反射（%） / 反伤抵抗（%）

* 可反射受到的一切伤害
* 反伤数值机制精度为0.01,小于0.01无效 默认最低为0%（无反射）最高无限定
* 以最终伤害值计算反射，反射的伤害不会再次成为反射源

### knocking_odds / knocking_extent / knocking_oppose

暴击几率（%）/ 暴击伤害加成（%） / 暴击抵抗（%）

* 这是单位本体的暴击，与xtras的无关，可线性叠加
* 本体暴击自动无视回避（模拟原生魔兽效果）
* 暴击抵抗阻碍物理暴击发生，包括本体的和xtras

### split_oppose

分裂抵抗（%）

* 阻碍分裂发生

### hemophagia_oppose / hemophagia_skill_oppose

吸血抵抗（%） / 技能吸血抵抗（%）

* 抵抗攻击吸血 / 技能吸血效果

### punish_oppose

僵直抵抗（%）

* 抵抗僵直效果

### split_oppose

分裂抵抗（%）

* 阻碍分裂发生

### swim_oppose

眩晕抵抗（%）

* 眩晕抵抗同时减少受到眩晕的几率及眩晕时间 眩晕几率=原眩晕几率%-眩晕抵抗（%）,最小0%即无效
* 眩晕时间=原眩晕时间*(100%-眩晕抵抗%)（s）,最小0秒即无效 沉默抵抗（%）

### silent_oppose

沉默抵抗（%）

* 阻碍沉默发生

### unarm_oppose

缴械抵抗（%）

* 阻碍缴械发生

### fetter_oppose

定身抵抗（%）

* 阻碍定身发生

### bomb_oppose

爆破抵抗（%）

* 阻碍爆破发生

### lightning_chain_oppose

闪电链抵抗（%）

* 阻碍闪电链发生

### crack_fly_oppose

击飞抵抗（%）

* 阻碍击飞发生

### buff_oppose

强化阻碍（%）

* 当xtras使用attr增强单位时，效果会被此值减轻

### debuff_oppose

负面抵抗（%）

* 当xtras使用attr削弱单位时，效果会被此值减轻

### BREAK_ARMOR_TYPE

无视装甲

* 详情请看const
* 无视护甲 defend
* 无视回避 avoid
* 无视无敌 invincible
* 无视附魔 enchant
* 无视只对正数值有效 额外特效

### xtras

以事件作驱动，引发额外限定效果的操作

* 由于非常复杂，请查看attr的xtras源码段注释说明 常见例子：

```lua
{ on = CONST_EVENT.attack, action = "triggerUnit.attr.attack_speed", odds = 20.0, val = 1.5, during = 3.0, effect = nil },
{ on = CONST_EVENT.attack, action = "attackUnit.attr.attack_speed", odds = 20.0, val = 1.5, during = 3.0, effect = nil },
{ on = CONST_EVENT.skill, action = "castUnit.attr.attack_green", odds = 20.0, val = 2, during = 3.0, effect = nil },
{ on = CONST_EVENT.item, action = "useUnit.attr.int_white", odds = 20.0, val = 2, during = 3.0, effect = nil },
{ on = CONST_EVENT.attack, action = "targetUnit.spec.knocking", odds = 100, percent = 100, effect = nil },
{ on = CONST_EVENT.skill, action = "targetUnit.spec.knocking", odds = 100, percent = 100, effect = nil },
{ on = CONST_EVENT.attack, action = "targetUnit.spec.split", odds = 100, percent = {30,50}, radius = 250 },
{ on = CONST_EVENT.attack, action = "targetUnit.spec.swim",odds = 0.0, val = 0.0, during = 0.0, effect = nil},
{ on = CONST_EVENT.attack, action = "targetUnit.spec.broken",odds = 0.0, val = 0.0, effect = nil},
{ on = CONST_EVENT.attack, action = "targetUnit.spec.silent",odds = 0.0, val = 0.0, during = 0.0, effect = nil},
{ on = CONST_EVENT.attack, action = "targetUnit.spec.unarm",odds = 0.0, val = 0.0, during = 0.0, effect = nil},
{ on = CONST_EVENT.attack, action = "targetUnit.spec.fetter",odds = 0.0, val = 0.0, during = 0.0, effect = nil},
{ on = CONST_EVENT.attack, action = "targetUnit.spec.bomb",odds = 0.0, radius = 0.0, val = 0.0, effect = nil},
{ on = CONST_EVENT.damage, action = "targetUnit.spec.lightning_chain", odds = 50, val = 100, qty = 0, rate = 0.0 },
{ on = CONST_EVENT.beDamage, action = "sourceUnit.spec.crack_fly", odds = 50, val = 100, distance = 300, height = 200, during = 0.5 },
{ on = CONST_EVENT.attack, action = "sourceUnit.spec.paw", odds = 50, val = 'damage', effect = 'Abilities\\Weapons\\GargoyleMissile\\GargoyleMissile.mdl', radius = 50, odds = 50, speed = 10, deg = 30, distance = 500, qty = 3 }
```

### enchant

附魔系统介绍

* e_开头的系列设定 如：e_fire / e_fire_attack / e_fire_oppose 附魔，是框架内定义的一种概念 附魔带出元素集合，它们有：物理、魔法、火、焰、水、风、雷、木、毒等等很多种
  附魔被伤害类型和attr引用，独立存在，仅呈现辅助式伤害
* 每个属性在造成对应的伤害时，会获得百分比加成，无上限，而抵抗则直接减少加成比例
* 下列例子不考虑其他因素： 默认+10%参考henchant.INTRINSIC_ADDITION 原伤100%，类型包含火。火加成为100%，火抵抗为40%，最终伤害170%（默认会+10%）
  原伤100%，类型包含火。火加成为40%，火抵抗为40%，最终伤害110%（默认会+10%） 原伤100%，类型包含火。火加成为0%，火抵抗为40%，最终伤害70%（反而不如无类型了）
  原伤100%，类型不包含火。火加成为40%，火抵抗为40%，最终伤害100%（类型无火，则火加成/抵抗皆无效） 伤害类型(伤害类型绑定附魔的元素)

### DAMAGE_TYPE

伤害类型一般指伤害的类型，类型之间可以随意的重复叠加

* 详情请看const
* 例如一个伤害类型：可以是{physical,fire,fire}物理+火，而且火占到了三分之二的比例。 一般情况下，一次伤害总是各种类型混合的，各个类型会按照各自的规则来计算削弱和加强，不必担心混乱
  例如{magic,fire}这种类型，这次伤害是200点，他们会各自平分伤害：magic100，fire100，如果魔法就按魔抗计算被抵消，火伤害依然是有100点的 伤害来源

### DAMAGE_SRC

伤害方式共 4 种

* 详情请看const
* [未知方式]没有被定义的都会是未知来源，一种概念
* [攻击方式]普通攻击、魔兽原生技能造成的伤害
* [技能方式]技能设定（触发技能buff、技能debuff、技能特效）
* [物品方式]物品伤害，一种概念
* 伤害一般计算优先级：原生护甲伤害计算->方式类型判定->无视判定->附魔数值整合->暴击及抵抗->回避、命中->减伤->造成伤害->分裂、吸血、技能吸血->僵直、反伤->额外特效
