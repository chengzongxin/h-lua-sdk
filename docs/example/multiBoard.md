## 使用多面板

创建常见的英雄属性多面板，1.5秒更新一次数据

```lua
hmultiBoard.create(
    "player",
    1.5,
    function(mb)
        --拼凑多面板数据，二维数组，行列模式
        hmultiBoard.setTitle(mb, "剑圣求生多面板")
        --开始当然是title了
        local data = {}
        table.insert(data, {
            { value = "玩家", icon = nil },
            { value = "称号", icon = nil },
            { value = "战力", icon = nil },
            { value = "杀敌", icon = nil },
            { value = "英雄", icon = nil },
            { value = "回血", icon = nil },
            { value = "回魔", icon = nil },
            { value = "攻速", icon = nil },
            { value = "命中", icon = nil },
            { value = "增幅", icon = nil },
            { value = "减伤", icon = nil },
            { value = "魔抗", icon = nil },
            { value = "回避", icon = nil },
            { value = "背包", icon = nil },
            { value = "硬直", icon = nil },
            { value = "攻击类型", icon = nil },
        })
        --然后是form
        for pi = 1, hplayer.qty_max, 1 do
            local p = hplayer.players[pi]
            if (his.playing(p)) then
                local hero = "-"
                local prestige = "-"
                local power = "-"
                local kill = "-"
                local avatar = nil
                local name = "-"
                local life_back = "-"
                local mana_back = "-"
                local attack_speed = "-"
                local damage_extent = "-"
                local aim = "-"
                local toughness = "-"
                local resistance = "-"
                local avoid = "-"
                local weight = "-"
                local punish = "-"
                local attack_damage_type = "-"
                hero = hhero.player_heroes[pi][1]
                if (hero ~= nil) then
                    avatar = hunit.getAvatar(hero)
                    name = hunit.getName(hero)
                    prestige = hplayer.getPrestige(p)
                    power = math.integerFormat(game.playerData.power[pi] or 0)
                    kill = math.integerFormat(hplayer.getKill(p))
                    life_back = math.round(hattr.get(hero, "life_back")) .. "/秒"
                    mana_back = math.round(hattr.get(hero, "mana_back")) .. "/秒"
                    attack_speed = math.round(100 + hattr.get(hero, "attack_speed")) .. "%"
                    damage_extent = math.round(hattr.get(hero, "damage_extent")) .. "%"
                    aim = math.round(hattr.get(hero, "aim")) .. "%"
                    toughness = math.round(hattr.get(hero, "toughness"))
                    resistance = math.round(hattr.get(hero, "resistance")) .. "%"
                    avoid = math.round(hattr.get(hero, "avoid")) .. "%"
                    weight = math.round(hattr.get(hero, "weight_current")) .. "/"
                        .. math.round(hattr.get(hero, "weight")) .. "Kg"
                    punish = math.round(hattr.get(hero, "punish_current")) .. "/"
                        .. math.round(hattr.get(hero, "punish"))
                    local adt = {}
                    for _, v in ipairs(hattr.get(hero, "attack_damage_type")) do
                        local label = CONST_ATTR[v]
                        if (table.includes(label, adt) == false) then
                            table.insert(adt, label)
                        end
                    end
                    attack_damage_type = string.implode('、', adt)
                end
                table.insert(data, {
                    { value = "[" .. hplayer.getStatus(p) .. "]" .. cj.GetPlayerName(p), icon = nil },
                    { value = prestige, icon = nil },
                    { value = power, icon = nil },
                    { value = kill, icon = nil },
                    { value = name, icon = avatar },
                    { value = life_back, icon = nil },
                    { value = mana_back, icon = nil },
                    { value = attack_speed, icon = nil },
                    { value = aim, icon = nil },
                    { value = damage_extent, icon = nil },
                    { value = toughness, icon = nil },
                    { value = resistance, icon = nil },
                    { value = avoid, icon = nil },
                    { value = weight, icon = nil },
                    { value = punish, icon = nil },
                    { value = attack_damage_type, icon = nil },
                })
            end
        end
        return data
    end
)
```
