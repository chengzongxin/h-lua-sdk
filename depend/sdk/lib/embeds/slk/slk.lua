hslk_conf = function(conf)
    F6_CONF_SET(conf)
end

hslk_ability = function(_v)
    _v = F6V_A(_v)
    _v._id = SLK_ID(_v)
    SLK_GO_SET(_v)
    return _v
end

hslk_ability_empty = function(_v)
    _v._parent = "Aamk"
    _v._type = "empty"
    _v.levels = _v.levels or 1
    _v.hero = _v.hero or 0
    local data = {}
    for _ = 1, _v.levels do
        table.insert(data, 0)
    end
    _v.DataA = data
    _v.DataB = data
    _v.DataC = data
    _v = F6V_A(_v)
    _v._id = SLK_ID(_v)
    SLK_GO_SET(_v)
    return _v
end

hslk_ability_ring = function(_v)
    _v._parent = "Aamk"
    _v._type = "ring"
    _v.levels = _v.levels or 1
    _v.hero = _v.hero or 0
    local data = {}
    for _ = 1, _v.levels do
        table.insert(data, 0)
    end
    _v.DataA = data
    _v.DataB = data
    _v.DataC = data
    _v = F6V_A(_v)
    _v._id = SLK_ID(_v)
    SLK_GO_SET(_v)
    return _v
end

hslk_unit = function(_v)
    _v = F6V_U(_v)
    _v._id = SLK_ID(_v)
    SLK_GO_SET(_v)
    return _v
end

hslk_hero = function(_v)
    _v._parent = "Hpal"
    _v._type = "hero"
    _v = F6V_U(_v)
    _v._id = SLK_ID(_v)
    SLK_GO_SET(_v)
    return _v
end

hslk_courier = function(_v)
    _v._parent = "ogru"
    _v._type = "courier"
    _v.type = "Peon"
    _v.weapsOn = 0
    _v.abilList = F6V_COURIER_SKILL()
    _v = F6V_U(_v)
    _v._id = SLK_ID(_v)
    SLK_GO_SET(_v)
    return _v
end

hslk_item_synthesis = function(formula)
    CONST_UBERTIP_SYNTHESIS_REGISTER(formula)
end

hslk_item = function(_v)
    _v = F6V_I(_v)
    _v._id = SLK_ID(_v)
    if (type(_v._shadow) == "boolean" and true == _v._shadow) then
        local _vs = F6V_I_SHADOW(table.clone(_v))
        _vs._id = SLK_ID(_vs)
        _v._shadow_id = _vs._id
        _vs._shadow_id = _v._id
        SLK_GO_SET(_v)
        SLK_GO_SET(_vs)
    else
        SLK_GO_SET(_v)
    end
    return _v
end

hslk_item_fleeting = function(Name, file, modelScale, moveHeight)
    if (Name == nil or file == nil or modelScale == nil or moveHeight == nil) then
        return
    end
    local _v = {
        _parent = "ogru",
        _type = "system",
        EditorSuffix = "",
        Name = Name,
        special = 1,
        abilList = "Avul,Aloc",
        upgrade = "",
        collision = 0.00,
        modelScale = modelScale,
        file = file,
        unitShadow = "",
        Art = "",
        movetp = "",
        moveHeight = moveHeight,
        spd = 0,
        turnRate = 0.1,
        weapsOn = 0,
        race = "other",
        fused = 0,
        sight = 0,
        nsight = 0,
    }
    _v = F6V_U(_v)
    _v._id = SLK_ID(_v)
    SLK_GO_SET(_v)
    return _v
end

hslk_buff = function(_v)
    _v = F6V_B(_v)
    _v._id = SLK_ID(_v)
    SLK_GO_SET(_v)
    return _v
end

hslk_upgrade = function(_v)
    _v = F6V_UP(_v)
    _v._id = SLK_ID(_v)
    SLK_GO_SET(_v)
    return _v
end
