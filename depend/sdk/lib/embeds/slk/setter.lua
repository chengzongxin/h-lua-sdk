--- F6 物编
--- 固定配置项
local F6_CONF = {
    courierSkill = {
        -- 信使技能-名称、热键、图标位置、冷却
        blink = {
            Name = "信使-闪烁",
            Ubertip = "闪烁到任何地方", Art = "ReplaceableTextures\\CommandButtons\\BTNBlink.blp",
            Hotkey = 'Q', Buttonpos_1 = 0, Buttonpos_2 = 2, Cool1 = 10
        },
        rangePickUp = {
            Name = "信使-拾取",
            Ubertip = "将附近地上的物品拾取到身上", Art = "ReplaceableTextures\\CommandButtons\\BTNPickUpItem.blp",
            Hotkey = 'W', Buttonpos_1 = 1, Buttonpos_2 = 2, Cool1 = 5
        },
        separate = {
            Name = "信使-拆分物品",
            Ubertip = "将合成或重叠的物品拆分成零件", Art = "ReplaceableTextures\\CommandButtons\\BTNRepair.blp",
            Hotkey = 'E', Buttonpos_1 = 2, Buttonpos_2 = 2, Cool1 = 5
        },
        deliver = {
            Name = "信使-传递",
            Ubertip = "将所有物品依照顺序传送给英雄，当你的英雄没有空余物品位置，物品会返回给信使", Art = "ReplaceableTextures\\CommandButtons\\BTNLoadPeon.blp",
            Hotkey = 'R', Buttonpos_1 = 3, Buttonpos_2 = 2, Cool1 = 5
        },
    },
    -- 描述文本颜色,可配置 hcolor 里拥有的颜色函数，也可以配置 hex 6位颜色码
    color = {
        hotKey = "ffcc00", -- 热键
        itemCoolDown = "ccffff", -- 物品冷却时间
        itemAttr = "b0f26e", -- 物品属性
        itemOverlie = "ff59ff", -- 物品叠加
        itemWeight = "ee82ee", -- 物品重量
        itemRemarks = "969696", -- 物品备注
        itemFragment = hcolor.orange, -- 物品零部件
        itemProfit = "ffd88c", -- 物品合成品
        itemRing = "99ccff", -- 物品光环
        abilityCoolDown = "ccffff", -- 技能冷却时间
        abilityAttr = "b0f26e", -- 技能属性
        abilityRemarks = "969696", -- 技能备注
        abilityRing = "99ccff", --技能光环
        abilityResearch0 = "FFFFE0", --学习说明0
        abilityResearch1 = "FFD700", --学习说明1
        heroWeapon = "ff3939", -- 英雄攻击武器类型
        heroAttack = "ff8080", -- 英雄基础攻击
        heroRange = "99ccff", -- 英雄攻击范围
        heroPrimary = "ffff00", -- 英雄主属性
        heroSecondary = "ffffcc", -- 英雄主属性
        heroMove = "ccffcc", -- 英雄移动
    },
}
F6_CONF_SET = function(conf)
    F6_CONF = conf
end

local F6_IDX = 0
local F6_NAME = function(name)
    F6_IDX = F6_IDX + 1
    return (name or "hslk-name") .. "-" .. F6_IDX
end

local F6S = {}
F6S.txt = function(v, key, txt, sep)
    sep = sep or "|n"
    if (v[key] == nil) then
        v[key] = txt
    else
        v[key] = v[key] .. sep .. txt
    end
end
F6S.a = {
    tip = function(v)
        if (v.Tip == nil) then
            local txt = v.Name
            if (v.Hotkey ~= nil) then
                txt = txt .. "[" .. hcolor.mixed(v.Hotkey, F6_CONF.color.hotKey) .. "]"
            end
            if (v.levels > 1) then
                v.Tip = {}
                for i = 1, v.levels do
                    table.insert(v.Tip, txt .. " - [|cffffcc00" .. CONST_UBERTIP_I18N.lv .. " " .. i .. "|r]")
                end
            else
                v.Tip = txt
            end
        end
    end,
    Researchtip = function(v)
        if (v.Researchtip == nil) then
            local txt = CONST_UBERTIP_I18N.learn .. v.Name
            if (v.Hotkey ~= nil) then
                txt = txt .. "(" .. hcolor.mixed(v.Hotkey, F6_CONF.color.hotKey) .. ")"
            end
            v.Researchtip = txt .. " - [|cffffcc00" .. CONST_UBERTIP_I18N.lv .. " %d|r]"
        end
    end,
    ubertip = function(v)
        if (v.Ubertip == nil) then
            v.Ubertip = { "" }
        elseif (type(v.Ubertip) == "string") then
            v.Ubertip = { v.Ubertip }
        elseif (type(v.Ubertip) == "table") then
            return
        end
        if (v.levels > 1 and #v.Ubertip < v.levels) then
            local lastUbertip = v.Ubertip[#v.Ubertip]
            for i = (#v.Ubertip + 1), v.levels, 1 do
                v.Ubertip[i] = lastUbertip
            end
        end
        local ux = {}
        for i = 1, v.levels, 1 do
            ux[i] = { v.Ubertip[i] }
        end
        if (type(v.Cool) == "table") then
            local lastCool = v.Cool[#v.Cool]
            for i = (#v.Cool + 1), v.levels, 1 do
                v.Cool[i] = lastCool
            end
            for i = 1, v.levels, 1 do
                table.insert(ux[i], hcolor.mixed(CONST_UBERTIP_I18N.cd .. CONST_UBERTIP_I18N.colon .. v.Cool[i] .. CONST_UBERTIP_I18N.sec, F6_CONF.color.abilityCoolDown))
            end
        end
        if (v._attr ~= nil) then
            if (#v._attr == 0) then
                v._attr = { v._attr }
            end
            local lastAttr = v._attr[#v._attr]
            for i = (#v._attr + 1), v.levels, 1 do
                v._attr[i] = lastAttr
            end
            for i = 1, v.levels, 1 do
                table.insert(ux[i], hcolor.mixed(CONST_UBERTIP_ATTR(v._attr[i], "|n"), F6_CONF.color.abilityAttr))
            end
        end
        if (v._ring ~= nil) then
            if (#v._ring == 0) then
                v._ring = { v._ring }
            end
            local lastRing = v._ring[#v._ring]
            for i = (#v._ring + 1), v.levels, 1 do
                v._ring[i] = lastRing
            end
            for i = 1, v.levels, 1 do
                local d = CONST_UBERTIP_RING_ABILITY(v._ring[i])
                if (#d > 0) then
                    table.insert(ux[i], hcolor.mixed(string.implode("|n", d), F6_CONF.color.abilityRing))
                end
            end
        end
        if (v._remarks ~= nil and v._remarks ~= "") then
            for i = 1, v.levels, 1 do
                table.insert(ux[i], hcolor.mixed(v._remarks, F6_CONF.color.abilityRemarks))
            end
        end
        for i = 1, v.levels, 1 do
            v.Ubertip[i] = string.implode("|n", ux[i])
        end
        if (#v.Ubertip == 1) then
            v.Ubertip = v.Ubertip[1]
        end
    end,
    Researchubertip = function(v)
        local rbt = {}
        if (v.Researchubertip == nil) then
            if (v.Ubertip == nil) then
                rbt = {}
            elseif (type(v.Ubertip) == "string") then
                rbt = { v.Ubertip }
            end
        end
        local cd = {}
        local extent = {}
        for i = 1, v.levels, 1 do
            if (type(v.Cool) == "table") then
                table.insert(cd, v.Cool[i] or v.Cool[#v.Cool])
            end
            extent[i] = ""
            if (v._attr ~= nil) then
                if (#v._attr == 0) then
                    extent[i] = extent[i] .. CONST_UBERTIP_RESEARCH_ATTR(v._attr)
                else
                    extent[i] = extent[i] .. CONST_UBERTIP_RESEARCH_ATTR(v._attr[i] or v._attr[#v._attr])
                end
            end
            if (v._ring ~= nil) then
                local d
                if (#v._ring == 0) then
                    d = CONST_UBERTIP_RESEARCH_RING_ABILITY(v._ring)
                else
                    d = CONST_UBERTIP_RESEARCH_RING_ABILITY(v._ring[i] or v._ring[#v._ring])
                end
                if (#d > 0) then
                    extent[i] = extent[i] .. "," .. string.implode("", d)
                end
            end
        end
        if (#cd > 0) then
            table.insert(rbt, hcolor.mixed(CONST_UBERTIP_I18N.cd .. CONST_UBERTIP_I18N.colon .. string.implode("/", cd) .. CONST_UBERTIP_I18N.sec, F6_CONF.color.abilityCoolDown))
        end
        for i = 1, v.levels, 1 do
            table.insert(rbt, hcolor.mixed(CONST_UBERTIP_I18N.lv .. i .. CONST_UBERTIP_I18N.colon .. extent[i], F6_CONF.color["abilityResearch" .. i % 2]))
        end
        if (v._remarks ~= nil and v._remarks ~= "") then
            table.insert(rbt, hcolor.mixed(v._remarks, F6_CONF.color.abilityRemarks))
        end
        if (#rbt > 0) then
            v.Researchubertip = string.implode("|n", rbt)
        end
    end,
}

F6S.i = {
    description = {
        _attr = function(v)
            if (v._attr ~= nil) then
                F6S.txt(v, "Description", CONST_UBERTIP_ATTR(v._attr, ","), ';')
            end
        end,
        _overlie = function(v)
            if (v._overlie ~= nil and v._overlie > 0) then
                local o = tostring(math.floor(v._overlie))
                F6S.txt(v, "Description", CONST_UBERTIP_I18N.overlie .. CONST_UBERTIP_I18N.colon .. o, ';')
            end
        end,
        _weight = function(v)
            if (v._weight ~= nil) then
                local w = tostring(math.round(v._weight))
                F6S.txt(v, "Description", CONST_UBERTIP_I18N.weight .. CONST_UBERTIP_I18N.colon .. w .. CONST_UBERTIP_I18N.kg, ';')
            end
        end,
        _remarks = function(v)
            if (v._remarks ~= nil and v._remarks ~= "") then
                F6S.txt(v, "Description", v._remarks, ';')
            end
        end,
    },
    ubertip = {
        _cooldown = function(v)
            if (v._cooldown ~= nil and v._cooldown > 0) then
                F6S.txt(v, "Ubertip", hcolor.mixed(CONST_UBERTIP_I18N.cd .. CONST_UBERTIP_I18N.colon .. v._cooldown .. CONST_UBERTIP_I18N.sec, F6_CONF.color.itemCoolDown))
            end
        end,
        _ring = function(v)
            if (v._ring ~= nil) then
                if (v._ring.attr ~= nil and v._ring.radius ~= nil and (type(v._ring.target) == 'table' and #v._ring.target > 0)) then
                    F6S.txt(v, "Ubertip", hcolor.mixed(CONST_UBERTIP_RING_ITEM(v._ring), F6_CONF.color.itemRing))
                end
            end
        end,
        _attr = function(v)
            if (v._attr ~= nil) then
                F6S.txt(v, "Ubertip", hcolor.mixed(CONST_UBERTIP_ATTR(v._attr, "|n", nil), F6_CONF.color.itemAttr))
            end
        end,
        _fragment = function(v)
            local txt = CONST_UBERTIP_SYNTHESIS_FRAGMENT(v)
            if (txt) then
                F6S.txt(v, "Ubertip", hcolor.mixed(txt, F6_CONF.color.itemFragment))
            end
        end,
        _profit = function(v)
            local txt = CONST_UBERTIP_SYNTHESIS_PROFIT(v)
            if (txt) then
                F6S.txt(v, "Ubertip", hcolor.mixed(txt, F6_CONF.color.itemProfit))
            end
        end,
        _overlie = function(v)
            if (v._overlie ~= nil and v._overlie > 0) then
                local o = tostring(math.floor(v._overlie))
                F6S.txt(v, "Ubertip", hcolor.mixed(CONST_UBERTIP_I18N.overlie .. CONST_UBERTIP_I18N.colon .. o, F6_CONF.color.itemOverlie))
            end
        end,
        _weight = function(v)
            if (v._weight ~= nil) then
                local w = tostring(math.round(v._weight))
                F6S.txt(v, "Ubertip", hcolor.mixed(CONST_UBERTIP_I18N.weight .. CONST_UBERTIP_I18N.colon .. w .. CONST_UBERTIP_I18N.kg, F6_CONF.color.itemWeight))
            end
        end,
        _remarks = function(v)
            if (v._remarks ~= nil and v._remarks ~= "") then
                F6S.txt(v, "Ubertip", hcolor.mixed(v._remarks, F6_CONF.color.itemRemarks))
            end
        end,
    },
}
F6S.u = {}

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

local F6_RING_SINGLE = function(_r)
    _r.effect = _r.effect or nil
    _r.effectTarget = _r.effectTarget or "Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl"
    _r.attach = _r.attach or "origin"
    _r.attachTarget = _r.attachTarget or "origin"
    _r.radius = _r.radius or 600
    -- target请参考物编的目标允许
    local target
    if (type(_r.target) == 'table' and #_r.target > 0) then
        target = _r.target
    elseif (type(_r.target) == 'string' and string.len(_r.target) > 0) then
        target = string.explode(',', _r.target)
    else
        target = { 'air', 'ground', 'friend', 'self', 'vuln', 'invu' }
    end
    _r.target = target
end
local F6_RING = function(_v)
    if (type(_v._ring) == "table") then
        if (#_v._ring == 0) then
            F6_RING_SINGLE(_v._ring)
        else
            for i = 1, #_v._ring, 1 do
                F6_RING_SINGLE(_v._ring[i])
            end
        end
    end
end

local F6_HERO = function(_v)
    _v.Primary = _v.Primary or "STR"
    _v.weapTp1 = _v.weapTp1 or "normal"
    _v.cool1 = _v.cool1 or 2
    _v.dmgplus1 = _v.dmgplus1 or 10
    _v.rangeN1 = _v.rangeN1 or 100
    _v.STR = _v.STR or 10
    _v.AGI = _v.AGI or 10
    _v.INT = _v.INT or 10
    _v.STRplus = _v.STRplus or 1
    _v.AGIplus = _v.AGIplus or 1
    _v.INTplus = _v.INTplus or 1
    _v.spd = _v.spd or 300
    _v.movetp = _v.movetp or "foot"
    local Ubertip
    if (_v.Ubertip == nil or _v.Ubertip == "") then
        Ubertip = ""
    else
        Ubertip = _v.Ubertip .. "|n"
    end
    Ubertip = Ubertip .. hcolor.mixed(CONST_UBERTIP_I18N.weapTp1 .. CONST_UBERTIP_I18N.colon .. CONST_WEAPON_TYPE[_v.weapTp1].label .. "(" .. _v.cool1 .. CONST_UBERTIP_I18N.cool1 .. ")", F6_CONF.color.heroWeapon)
    Ubertip = Ubertip .. "|n" .. hcolor.mixed(CONST_UBERTIP_I18N.dmgplus1 .. CONST_UBERTIP_I18N.colon .. _v.dmgplus1, F6_CONF.color.heroAttack)
    Ubertip = Ubertip .. "|n" .. hcolor.mixed(CONST_UBERTIP_I18N.rangeN1 .. CONST_UBERTIP_I18N.colon .. _v.rangeN1, F6_CONF.color.heroRange)
    if (_v.Primary == "STR") then
        Ubertip = Ubertip .. "|n" .. hcolor.mixed(CONST_UBERTIP_I18N.STR .. CONST_UBERTIP_I18N.colon .. _v.STR .. "(+" .. _v.STRplus .. ")", F6_CONF.color.heroPrimary)
    else
        Ubertip = Ubertip .. "|n" .. hcolor.mixed(CONST_UBERTIP_I18N.STR .. CONST_UBERTIP_I18N.colon .. _v.STR .. "(+" .. _v.STRplus .. ")", F6_CONF.color.heroSecondary)
    end
    if (_v.Primary == "AGI") then
        Ubertip = Ubertip .. "|n" .. hcolor.mixed(CONST_UBERTIP_I18N.AGI .. CONST_UBERTIP_I18N.colon .. _v.AGI .. "(+" .. _v.AGIplus .. ")", F6_CONF.color.heroPrimary)
    else
        Ubertip = Ubertip .. "|n" .. hcolor.mixed(CONST_UBERTIP_I18N.AGI .. CONST_UBERTIP_I18N.colon .. _v.AGI .. "(+" .. _v.AGIplus .. ")", F6_CONF.color.heroSecondary)
    end
    if (_v.Primary == "INT") then
        Ubertip = Ubertip .. "|n" .. hcolor.mixed(CONST_UBERTIP_I18N.INT .. CONST_UBERTIP_I18N.colon .. _v.INT .. "(+" .. _v.INTplus .. ")", F6_CONF.color.heroPrimary)
    else
        Ubertip = Ubertip .. "|n" .. hcolor.mixed(CONST_UBERTIP_I18N.INT .. CONST_UBERTIP_I18N.colon .. _v.INT .. "(+" .. _v.INTplus .. ")", F6_CONF.color.heroSecondary)
    end
    Ubertip = Ubertip .. "|n" .. hcolor.mixed(CONST_UBERTIP_I18N.spd .. CONST_UBERTIP_I18N.colon .. _v.spd .. " " .. CONST_MOVE_TYPE[_v.movetp].label, F6_CONF.color.heroMove)
    _v.Ubertip = Ubertip
end

F6V_A = function(_v)
    _v._class = "ability"
    _v._type = _v._type or "common"
    if (_v._parent == nil) then
        _v._parent = "ANcl"
    end
    if (_v.Name == nil) then
        if (_v._type == "empty") then
            _v.Name = F6_NAME(CONST_UBERTIP_I18N.def_passive)
        elseif (_v._type == "ring") then
            _v.Name = F6_NAME(CONST_UBERTIP_I18N.def_ring)
        else
            _v.Name = F6_NAME(CONST_UBERTIP_I18N.def_skill)
        end
    end
    if (_v.levels == nil) then
        _v.levels = 1
    end
    -- 处理 _ring光环
    F6_RING(_v)
    if (_v.Hotkey ~= nil) then
        _v.Buttonpos_1 = _v.Buttonpos_1 or CONST_HOTKEY_ABILITY_KV[_v.Hotkey].Buttonpos_1 or 0
        _v.Buttonpos_2 = _v.Buttonpos_2 or CONST_HOTKEY_ABILITY_KV[_v.Hotkey].Buttonpos_2 or 0
        if (_v.hero == 1) then
            _v.ResearchArt = _v.ResearchArt or _v.Art
            _v.ResearchHotkey = _v.ResearchHotkey or _v.Hotkey
            _v.Researchbuttonpos_1 = _v.Researchbuttonpos_1 or _v.Buttonpos_1
            _v.Researchbuttonpos_2 = _v.Researchbuttonpos_2 or _v.Buttonpos_2
            F6S.a.Researchtip(_v)
            F6S.a.Researchubertip(_v)
        end
    end
    F6S.a.tip(_v)
    F6S.a.ubertip(_v)
    return _v
end

F6V_U = function(_v)
    _v._class = "unit"
    _v._type = _v._type or "common"
    if (_v._parent == nil) then
        _v._parent = "nfrp"
    end
    if (_v.Name == nil) then
        if (_v._type == "hero") then
            _v.Name = F6_NAME(CONST_UBERTIP_I18N.def_hero)
        else
            _v.Name = F6_NAME(CONST_UBERTIP_I18N.def_unit)
        end
    end
    if (_v._type == "hero") then
        F6_HERO(_v)
    end
    if (_v.Hotkey ~= nil) then
        _v.Buttonpos_1 = _v.Buttonpos_1 or CONST_HOTKEY_FULL_KV[_v.Hotkey].Buttonpos_1 or 0
        _v.Buttonpos_2 = _v.Buttonpos_2 or CONST_HOTKEY_FULL_KV[_v.Hotkey].Buttonpos_2 or 0
        _v.Tip = CONST_UBERTIP_I18N.choose .. CONST_UBERTIP_I18N.colon .. _v.Name .. "(" .. hcolor.mixed(_v.Hotkey, F6_CONF.color.hotKey) .. ")"
    else
        _v.Buttonpos_1 = _v.Buttonpos_1 or 0
        _v.Buttonpos_2 = _v.Buttonpos_2 or 0
        _v.Tip = CONST_UBERTIP_I18N.choose .. CONST_UBERTIP_I18N.colon .. _v.Name
    end
    _v.goldcost = _v.goldcost or 0
    _v.lumbercost = _v.lumbercost or 0
    _v.fmade = _v.fmade or 0
    _v.fused = _v.fused or 0
    _v.regenMana = _v.regenMana or 0
    _v.regenHP = _v.regenHP or 0
    _v.regenType = _v.regenType or "none"
    local targs1 = _v.targs1 or "vulnerable,ground,ward,structure,organic,mechanical,debris,air" --攻击目标
    if (_v.weapTp1 ~= nil) then
        if (_v.weapTp1 ~= "normal") then
            _v.weapType1 = "" --攻击声音
            _v.Missileart_1 = _v.Missileart_1 -- 箭矢模型
            _v.Missilespeed_1 = _v.Missilespeed_1 or 900 -- 箭矢速度
            _v.Missilearc_1 = _v.Missilearc_1 or 0.10
        end
        if (_v.weapTp1 == "normal") then
            _v.weapType1 = _v.weapType1 or "" --攻击声音
            _v.Missileart_1 = ""
            _v.Missilespeed_1 = 0
            _v.Missilearc_1 = 0
        elseif (_v.weapTp1 == "msplash" or _v.weapTp1 == "artillery") then
            --溅射/炮火
            _v.Farea1 = _v.Farea1 or 1
            _v.Qfact1 = _v.Qfact1 or 0.05
            _v.Qarea1 = _v.Qarea1 or 500
            _v.Hfact1 = _v.Hfact1 or 0.15
            _v.Harea1 = _v.Harea1 or 350
            _v.splashTargs1 = targs1 .. ",enemies"
        elseif (_v.weapTp1 == "mbounce") then
            --弹射
            _v.Farea1 = _v.Farea1 or 450
            _v.targCount1 = _v.targCount1 or 4
            _v.damageLoss1 = _v.damageLoss1 or 0.3
            _v.splashTargs1 = targs1 .. ",enemies"
        elseif (_v.weapTp1 == "mline") then
            --穿透
            _v.spillRadius1 = _v.spillRadius1 or 300
            _v.spillDist1 = _v.spillDist1 or 450
            _v.damageLoss1 = _v.damageLoss1 or 0.3
            _v.splashTargs1 = targs1 .. ",enemies"
        elseif (_v.weapTp1 == "aline") then
            --炮火穿透
            _v.Farea1 = _v.Farea1 or 1
            _v.Qfact1 = _v.Qfact1 or 0.05
            _v.Qarea1 = _v.Qarea1 or 500
            _v.Hfact1 = _v.Hfact1 or 0.15
            _v.Harea1 = _v.Harea1 or 350
            _v.spillRadius1 = _v.spillRadius1 or 300
            _v.spillDist1 = _v.spillDist1 or 450
            _v.damageLoss1 = _v.damageLoss1 or 0.3
            _v.splashTargs1 = targs1 .. ",enemies"
        end
    end
    local targs2 = _v.targs2 or "vulnerable,ground,ward,structure,organic,mechanical,debris,air" --攻击目标
    if (_v.weapTp2 ~= nil) then
        if (_v.weapTp2 ~= "normal") then
            _v.weapType2 = "" --攻击声音
            _v.Missileart_2 = _v.Missileart_2 -- 箭矢模型
            _v.Missilespeed_2 = _v.Missilespeed_2 or 900 -- 箭矢速度
            _v.Missilearc_2 = _v.Missilearc_2 or 0.10
        end
        if (_v.weapTp2 == "normal") then
            _v.weapType2 = _v.weapType2 or "" --攻击声音
            _v.Missileart_2 = ""
            _v.Missilespeed_2 = 0
            _v.Missilearc_2 = 0
        elseif (_v.weapTp2 == "msplash" or _v.weapTp2 == "artillery") then
            --溅射/炮火
            _v.Farea2 = _v.Farea2 or 1
            _v.Qfact2 = _v.Qfact2 or 0.05
            _v.Qarea2 = _v.Qarea2 or 500
            _v.Hfact2 = _v.Hfact2 or 0.15
            _v.Harea2 = _v.Harea2 or 350
            _v.splashTargs2 = targs2 .. ",enemies"
        elseif (_v.weapTp2 == "mbounce") then
            --弹射
            _v.Farea2 = _v.Farea2 or 450
            _v.targCount2 = _v.targCount2 or 4
            _v.damageLoss2 = _v.damageLoss2 or 0.3
            _v.splashTargs2 = targs2 .. ",enemies"
        elseif (_v.weapTp2 == "mline") then
            --穿透
            _v.spillRadius2 = _v.spillRadius2 or 300
            _v.spillDist2 = _v.spillDist2 or 450
            _v.damageLoss2 = _v.damageLoss2 or 0.3
            _v.splashTargs2 = targs2 .. ",enemies"
        elseif (_v.weapTp2 == "aline") then
            --炮火穿透
            _v.Farea2 = _v.Farea2 or 1
            _v.Qfact2 = _v.Qfact2 or 0.05
            _v.Qarea2 = _v.Qarea2 or 500
            _v.Hfact2 = _v.Hfact2 or 0.15
            _v.Harea2 = _v.Harea2 or 350
            _v.spillRadius2 = _v.spillRadius2 or 300
            _v.spillDist2 = _v.spillDist2 or 450
            _v.damageLoss2 = _v.damageLoss2 or 0.3
            _v.splashTargs2 = targs2 .. ",enemies"
        end
    end
    if (_v.Propernames ~= nil) then
        _v.nameCount = #string.explode(',', _v.Propernames)
    end
    return _v
end

local courier_skill_ids
F6V_COURIER_SKILL = function()
    if (courier_skill_ids == nil) then
        courier_skill_ids = { "AInv", "Avul" }
        local Name = F6_CONF.courierSkill.blink.Name
        local tmp = {
            _parent = "AEbl",
            _type = "courier",
            Name = Name,
            Ubertip = F6_CONF.courierSkill.blink.Ubertip,
            Hotkey = F6_CONF.courierSkill.blink.Hotkey,
            Buttonpos_1 = F6_CONF.courierSkill.blink.Buttonpos_1,
            Buttonpos_2 = F6_CONF.courierSkill.blink.Buttonpos_2,
            hero = 0,
            levels = 1,
            Art = F6_CONF.courierSkill.blink.Art,
            SpecialArt = "Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl",
            Areaeffectart = "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl",
            race = "other",
            DataA = { 99999 },
            DataB = { 0 },
            Cool = { F6_CONF.courierSkill.blink.Cool1 },
            Cost = { 0 },
        }
        table.insert(courier_skill_ids, hslk_ability(tmp)._id)
        Name = F6_CONF.courierSkill.rangePickUp.Name
        tmp = {
            _parent = "ANcl",
            _type = "courier",
            Name = Name,
            Tip = Name .. "(" .. hcolor.mixed(F6_CONF.courierSkill.rangePickUp.Hotkey, F6_CONF.color.hotKey) .. ")",
            Order = "manaburn",
            Hotkey = F6_CONF.courierSkill.rangePickUp.Hotkey,
            Ubertip = F6_CONF.courierSkill.rangePickUp.Ubertip,
            Buttonpos_1 = F6_CONF.courierSkill.rangePickUp.Buttonpos_1,
            Buttonpos_2 = F6_CONF.courierSkill.rangePickUp.Buttonpos_2,
            hero = 0,
            levels = 1,
            Art = F6_CONF.courierSkill.rangePickUp.Art,
            CasterArt = "",
            EffectArt = "",
            TargetArt = "",
            race = "other",
            DataA = { 0 },
            DataB = { 0 },
            DataC = { 1 },
            DataD = { 0.01 },
            DataF = { "manaburn" },
            Cool = { F6_CONF.courierSkill.rangePickUp.Cool1 },
            Cost = { 0 },
        }
        table.insert(courier_skill_ids, hslk_ability(tmp)._id)
        Name = F6_CONF.courierSkill.separate.Name
        tmp = {
            _parent = "ANtm",
            _type = "courier",
            Name = Name,
            Tip = Name .. "(" .. hcolor.mixed(F6_CONF.courierSkill.separate.Hotkey, F6_CONF.color.hotKey) .. ")",
            Ubertip = F6_CONF.courierSkill.separate.Ubertip,
            Art = F6_CONF.courierSkill.separate.Art,
            Hotkey = F6_CONF.courierSkill.separate.Hotkey,
            Buttonpos_1 = F6_CONF.courierSkill.separate.Buttonpos_1,
            Buttonpos_2 = F6_CONF.courierSkill.separate.Buttonpos_2,
            Missileart = "",
            Missilespeed = 99999,
            Missilearc = 0.00,
            Animnames = "",
            hero = 0,
            race = "other",
            DataD = { 0 },
            DataA = { 0 },
            BuffID = { "" },
            Cool = { F6_CONF.courierSkill.separate.Cool1 },
            targs = { "item,nonhero" },
            Cost = { 0 },
            Rng = { 200.00 },
        }
        table.insert(courier_skill_ids, hslk_ability(tmp)._id)
        Name = F6_CONF.courierSkill.deliver.Name
        tmp = {
            _parent = "ANcl",
            _type = "courier",
            Name = Name,
            Tip = Name .. "(" .. hcolor.mixed(F6_CONF.courierSkill.deliver.Hotkey, F6_CONF.color.hotKey) .. ")",
            Order = "polymorph",
            Hotkey = F6_CONF.courierSkill.deliver.Hotkey,
            Ubertip = F6_CONF.courierSkill.deliver.Ubertip,
            Buttonpos_1 = F6_CONF.courierSkill.deliver.Buttonpos_1,
            Buttonpos_2 = F6_CONF.courierSkill.deliver.Buttonpos_2,
            hero = 0,
            levels = 1,
            Art = F6_CONF.courierSkill.deliver.Art,
            CasterArt = "",
            EffectArt = "",
            TargetArt = "",
            race = "other",
            DataA = { 0 },
            DataB = { 0 },
            DataC = { 1 },
            DataD = { 0.01 },
            DataF = { "polymorph" },
            Cool = { F6_CONF.courierSkill.deliver.Cool1 },
            Cost = { 0 },
        }
        table.insert(courier_skill_ids, hslk_ability(tmp)._id)
        courier_skill_ids = string.implode(",", courier_skill_ids)
    end
    return courier_skill_ids
end

F6V_I_CD = function(_v)
    if (_v._cooldown < 0) then
        _v._cooldown = 0
    end
    local adTips = "H_LUA_ICD_" .. _v.Name
    local cdID
    local ad = {
        Effectsound = "",
        Name = adTips,
        Tip = adTips,
        Ubertip = adTips,
        TargetArt = _v.TargetArt or "",
        Targetattach = _v.Targetattach or "",
        Animnames = _v.Animnames or "spell",
        CasterArt = _v.CasterArt or "",
        Art = "",
        unArt = "",
        item = 1,
        hero = 0,
        Requires = "",
        Hotkey = "",
        Buttonpos_1 = 0,
        Buttonpos_2 = 0,
        race = "other",
        Cast = _v.Cast or { _v._cast or 0 },
        Cost = _v.Cost or { _v._cost or 0 },
        Cool = { _v._cooldown },
    }
    if (_v._cooldownTarget == CONST_ABILITY_TARGET.location.value) then
        -- 对点（模版 照明弹）
        ad._parent = "Afla"
        ad.DataA = { 0 }
        ad.EfctID = { "" }
        ad.Dur = { 0.01 }
        ad.HeroDur = { 0.01 }
        ad.Rng = _v.Rng or { 600 }
        ad.Area = { 0 }
        ad.DataA = { 0 }
        ad.DataB = { 0 }
        local av = hslk_ability(ad)
        cdID = av._id
    elseif (_v.cooldownTarget == CONST_ABILITY_TARGET.range.value) then
        -- 对点范围（模版 暴风雪）
        ad._parent = "ACbz"
        ad.BuffID = { "" }
        ad.EfctID = { "" }
        ad.Rng = _v.Rng or { 300 }
        ad.Area = _v.Area or { 300 }
        ad.DataA = { 0 }
        ad.DataB = { 0 }
        ad.DataC = { 0 }
        ad.DataD = { 0 }
        ad.DataE = { 0 }
        ad.DataF = { 0 }
        local av = hslk_ability(ad)
        cdID = av._id
    elseif (_v._cooldownTarget == CONST_ABILITY_TARGET.unit.value) then
        -- 对单位（模版 残废）
        ad._parent = "ACcr"
        ad.levels = 1
        ad.targs = _v.targs or { "air,ground,organic,enemy,neutral" }
        ad.Rng = _v.Rng or { 800 }
        ad.Area = _v.Area or { 0 }
        ad.BuffID = { "" }
        ad.Dur = { 0.01 }
        ad.HeroDur = { 0.01 }
        ad.DataA = { 0 }
        local av = hslk_ability(ad)
        cdID = av._id
    else
        -- 立刻（模版 金箱子）
        ad._parent = "AIgo"
        ad.DataA = { 0 }
        local av = hslk_ability(ad)
        cdID = av._id
    end
    return cdID
end

F6V_I_SHADOW = function(_v)
    _v._parent = "gold"
    _v._class = "item"
    _v._type = "shadow"
    _v.Name = "　" .. _v.Name .. "　"
    _v.class = "Charged"
    _v.abilList = ""
    _v.cooldownID = "AIat"
    _v.ignoreCD = 1
    _v.perishable = 1
    _v.usable = 1
    _v.powerup = 1
    return _v
end

F6V_I = function(_v)
    _v._class = "item"
    _v._type = _v._type or "common"
    if (_v._cooldown ~= nil) then
        local cd = F6V_I_CD(_v)
        _v.abilList = cd
        _v.cooldownID = cd
        _v.usable = 1
        if (_v.powerup == 1) then
            _v.class = "PowerUp"
        elseif (_v.perishable == 1) then
            _v.class = "Charged"
        end
    end
    if (_v._parent == nil) then
        _v.abilList = _v.abilList or ""
        if (_v.class == "Charged") then
            _v._parent = "hlst"
        elseif (_v.class == "PowerUp") then
            _v._parent = "gold"
        else
            _v._parent = "rat9"
        end
    end
    if (_v.Name == nil) then
        _v.Name = F6_NAME(CONST_UBERTIP_I18N.def_item)
    end
    if (_v.file == nil) then
        if (_v.class == "PowerUp") then
            _v.file = "Objects\\InventoryItems\\tomeRed\\tomeRed.mdl"
        else
            _v.file = "Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl"
        end
    end
    -- 处理 _shadow
    if (type(_v._shadow) ~= 'boolean') then
        _v._shadow = false
    end
    -- 处理 _ring光环
    F6_RING(_v)
    -- 处理文本
    F6S.i.description._attr(_v)
    F6S.i.description._overlie(_v)
    F6S.i.description._weight(_v)
    F6S.i.description._remarks(_v)
    F6S.i.ubertip._cooldown(_v)
    F6S.i.ubertip._ring(_v)
    F6S.i.ubertip._attr(_v)
    F6S.i.ubertip._fragment(_v)
    F6S.i.ubertip._profit(_v)
    F6S.i.ubertip._overlie(_v)
    F6S.i.ubertip._weight(_v)
    F6S.i.ubertip._remarks(_v)
    if (_v.uses == nil) then
        _v.uses = 1
    end
    if (_v._overlie == nil or _v._overlie < _v.uses) then
        _v._overlie = _v.uses
    end
    if (_v.goldcost == nil) then
        _v.goldcost = 1000000
    end
    if (_v.lumbercost == nil) then
        _v.lumbercost = 0
    end
    if (_v.Level == nil) then
        _v.Level = math.floor((_v.goldcost + _v.lumbercost) / 500)
    end
    if (_v.oldLevel == nil) then
        _v.oldLevel = _v.Level
    end
    if (_v.Hotkey ~= nil) then
        _v.Buttonpos_1 = _v.Buttonpos_1 or CONST_HOTKEY_FULL_KV[_v.Hotkey].Buttonpos_1 or 0
        _v.Buttonpos_2 = _v.Buttonpos_2 or CONST_HOTKEY_FULL_KV[_v.Hotkey].Buttonpos_2 or 0
        _v.Tip = "获得" .. _v.Name .. "(" .. hcolor.mixed(_v.Hotkey, F6_CONF.color.hotKey) .. ")"
    else
        _v.Buttonpos_1 = _v.Buttonpos_1 or 0
        _v.Buttonpos_2 = _v.Buttonpos_2 or 0
        _v.Tip = "获得" .. _v.Name
    end
    return _v
end

F6V_B = function(_v)
    _v._class = "buff"
    _v._type = _v._type or "common"
    if (_v.Name == nil) then
        _v.Name = F6_NAME(CONST_UBERTIP_I18N.def_buff)
    end
    return _v
end

F6V_UP = function(_v)
    _v._class = "upgrade"
    _v._type = _v._type or "common"
    if (_v.Name == nil) then
        _v.Name = F6_NAME(CONST_UBERTIP_I18N.def_upgrade)
    end
    return _v
end