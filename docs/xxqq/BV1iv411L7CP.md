## 小小演示

### h-lua库sync演示

B站演示

> <a target="_blank" href="https://www.bilibili.com/video/BV1iv411L7CP">魔兽争霸h-lua库sync演示</a>

代码

```lua
local shop = hunit.create({
    whichPlayer = hplayer.players[1],
    id = hslk.n2i("商店"),
    x = 500,
    y = 500
})
tb = {}
hshop.item.add(shop, hslk.n2i("奖励"), 99)
--单位购买物品 触发UI
--注册出售物品事件
hevent.onItemSell(shop, function(evtData)
    hitem.del(evtData.soldItem)
    local p = hunit.getOwner(evtData.buyingUnit)
    tb[p] = {}
    local itTy = hslk.typeIds({ "skill" })
    for i = 1, 3 do
        table.insert(tb[p], table.random(itTy))
    end
    if (p == hplayer.loc()) then
        --设置UI图标 名称 和描述
        for i = 1, 3 do
            local itSlk = hslk.i2v(tb[p][i], "slk")
            hjapi.DzFrameSetTexture(hjapi.DzFrameFindByName("awar_jn_" .. i, 0), itSlk.Art, 0)
            hjapi.DzFrameSetText(hjapi.DzFrameFindByName("awar_jnname_" .. i, 0), itSlk.Name)
            hjapi.DzFrameSetText(hjapi.DzFrameFindByName("awar_jnsm_" .. i, 0), itSlk.Ubertip)
        end
        hjapi.DzFrameShow(awar, true)
    end
end)

UI = function()
    --加载toc
    hdzui.loadToc("UI\\frame.toc")
    --初始化
    awar = hdzui.frame("awar",hdzui.origin.game(),0)
    --设置位置
    hjapi.DzFrameSetAbsolutePoint(awar,4,0.388,0.350)
    hjapi.DzFrameShow(awar,false)

    
    --注册3个按钮点击事件
    hsync.onFrameMouse(hjapi.DzFrameFindByName("awar_1",0),1,function(syncData)
        --添加技能
        hskill.add(hero[syncData.triggerPlayer],tb[syncData.triggerPlayer][1],1)
        if (syncData.triggerPlayer ~= hplayer.loc()) then
            return
        end
        hjapi.DzFrameShow(awar,false)
    end)
    hsync.onFrameMouse(hjapi.DzFrameFindByName("awar_2",0),1,function(syncData)
        --添加技能
        hskill.add(hero[syncData.triggerPlayer],tb[syncData.triggerPlayer][2],1)
        if (syncData.triggerPlayer ~= hplayer.loc()) then
            return
        end
        hjapi.DzFrameShow(awar,false)
    end)
    hsync.onFrameMouse(hjapi.DzFrameFindByName("awar_3",0),1,function(syncData)
        --添加技能
        hskill.add(hero[syncData.triggerPlayer],tb[syncData.triggerPlayer][3],1)
        if (syncData.triggerPlayer ~= hplayer.loc()) then
            return
        end
        hjapi.DzFrameShow(awar,false)
    end)

end
```

fdf文件

```fdf
Frame "FRAME" "awar"{
    Width 0.400,
    Height 0.258,
    LayerStyle "IGNORETRACKEVENTS",
    Frame "BACKDROP" "awarbakc" {
    Width 0.400,
    Height 0.258,
    BackdropBackground  "war3mapImported\awarTB.blp",
    BackdropBlendAll,
    SetPoint TOPLEFT, "awar", TOPLEFT, 0, 0,
        Frame "BUTTON" "awar_1" {
            Height 0.213,
            Width 0.125,
            ControlStyle "AUTOTRACK|HIGHLIGHTONMOUSEOVER",
            SetPoint LEFT, "awar", LEFT , 0.010, 0,

            //背景
            ControlBackdrop "awara",
            Frame "BACKDROP" "awara" {
                BackdropBackground  "war3mapImported\awarAND.blp",
                BackdropBlendAll,
            }
            //按下
            ControlPushedBackdrop "awaraa",
            Frame "BACKDROP" "awaraa" {
                BackdropBackground  "war3mapImported\awarANX.blp",
                BackdropBlendAll,
            }
            //高亮
            ControlMouseOverHighlight "awarga",
            Frame "HIGHLIGHT" "awarga" {
                HighlightType "FILETEXTURE",
                HighlightAlphaFile "UI\Widgets\BattleNet\bnet-button01-highlight-mouse.blp",
                HighlightAlphaMode "ADD",
            }
            Frame "BACKDROP" "awar_jn_1" {

                Width 0.034,
                Height 0.042,
                BackdropBackground  "ReplaceableTextures\PassiveButtons\PASBTNScatterRockets.blp",
                BackdropBlendAll,
                SetPoint TOPLEFT, "awar_1", TOPLEFT, 0.040, -0.040,
                }
            Frame "TEXT" "awar_jnname_1" {
                Width 0.12,
                Height 0.1,
                DecorateFileNames,
                FrameFont "MasterFont", 0.015, "",
                FontJustificationH JUSTIFYCENTER,
                UseActiveContext,
                FontJustificationV JUSTIFYMIDDLE,
                LayerStyle "IGNORETRACKEVENTS",
                SetPoint CENTER, "awar_jn_1", CENTER, 0, -0.035,
                Text "弹幕攻击",
            }
            Frame "TEXT" "awar_jnsm_1" {
                Width 0.080,
                Height 0.1,
                DecorateFileNames,
                FrameFont "MasterFont", 0.01, "",
                FontJustificationH JUSTIFYCENTER,
                UseActiveContext,
                FontJustificationV JUSTIFYMIDDLE,
                LayerStyle "IGNORETRACKEVENTS",
                SetPoint CENTER, "awar_jnname_1", CENTER, 0, -0.035,
                Text "对周围的敌方空中单位进行强有力的弹幕攻击",
            }
        }
        Frame "BUTTON" "awar_2" {
            Height 0.213,
            Width 0.125,
            ControlStyle "AUTOTRACK|HIGHLIGHTONMOUSEOVER",
            SetPoint LEFT, "awar_1", RIGHT , 0, 0,

            //背景
            ControlBackdrop "awarb",
            Frame "BACKDROP" "awarb" {
                BackdropBackground  "war3mapImported\awarAND.blp",
                BackdropBlendAll,
            }
            //按下
            ControlPushedBackdrop "awarab",
            Frame "BACKDROP" "awarab" {
                BackdropBackground  "war3mapImported\awarANX.blp",
                BackdropBlendAll,
            }
            //高亮
            ControlMouseOverHighlight "awargb",
            Frame "HIGHLIGHT" "awargb" {
                HighlightType "FILETEXTURE",
                HighlightAlphaFile "UI\Widgets\BattleNet\bnet-button01-highlight-mouse.blp",
                HighlightAlphaMode "ADD",
            }
            Frame "BACKDROP" "awar_jn_2" {

                Width 0.034,
                Height 0.042,
                BackdropBackground  "ReplaceableTextures\PassiveButtons\PASBTNScatterRockets.blp",
                BackdropBlendAll,
                SetPoint TOPLEFT, "awar_2", TOPLEFT, 0.040, -0.040,
                }
            Frame "TEXT" "awar_jnname_2" {
                Width 0.12,
                Height 0.1,
                DecorateFileNames,
                FrameFont "MasterFont", 0.015, "",
                FontJustificationH JUSTIFYCENTER,
                UseActiveContext,
                FontJustificationV JUSTIFYMIDDLE,
                LayerStyle "IGNORETRACKEVENTS",
                SetPoint CENTER, "awar_jn_2", CENTER, 0, -0.035,
                Text "弹幕攻击",
            }
            Frame "TEXT" "awar_jnsm_2" {
                Width 0.080,
                Height 0.1,
                DecorateFileNames,
                FrameFont "MasterFont", 0.01, "",
                FontJustificationH JUSTIFYCENTER,
                UseActiveContext,
                FontJustificationV JUSTIFYMIDDLE,
                LayerStyle "IGNORETRACKEVENTS",
                SetPoint CENTER, "awar_jnname_2", CENTER, 0, -0.035,
                Text "对周围的敌方空中单位进行强有力的弹幕攻击",
            }
        }
        Frame "BUTTON" "awar_3" {
            Height 0.213,
            Width 0.125,
            ControlStyle "AUTOTRACK|HIGHLIGHTONMOUSEOVER",
            SetPoint LEFT, "awar_2", RIGHT , 0, 0,

            //背景
            ControlBackdrop "awarc",
            Frame "BACKDROP" "awarc" {
                BackdropBackground  "war3mapImported\awarAND.blp",
                BackdropBlendAll,
            }
            //按下
            ControlPushedBackdrop "awarac",
            Frame "BACKDROP" "awarac" {
                BackdropBackground  "war3mapImported\awarANX.blp",
                BackdropBlendAll,
            }
            //高亮
            ControlMouseOverHighlight "awargc",
            Frame "HIGHLIGHT" "awargc" {
                HighlightType "FILETEXTURE",
                HighlightAlphaFile "UI\Widgets\BattleNet\bnet-button01-highlight-mouse.blp",
                HighlightAlphaMode "ADD",
            }
            Frame "BACKDROP" "awar_jn_3" {

                Width 0.034,
                Height 0.042,
                BackdropBackground  "ReplaceableTextures\PassiveButtons\PASBTNScatterRockets.blp",
                BackdropBlendAll,
                SetPoint TOPLEFT, "awar_3", TOPLEFT, 0.040, -0.040,
                }
            Frame "TEXT" "awar_jnname_3" {
                Width 0.12,
                Height 0.1,
                DecorateFileNames,
                FrameFont "MasterFont", 0.015, "",
                FontJustificationH JUSTIFYCENTER,
                UseActiveContext,
                FontJustificationV JUSTIFYMIDDLE,
                LayerStyle "IGNORETRACKEVENTS",
                SetPoint CENTER, "awar_jn_3", CENTER, 0, -0.035,
                Text "弹幕攻击",
            }
            Frame "TEXT" "awar_jnsm_3" {
                Width 0.080,
                Height 0.1,
                DecorateFileNames,
                FrameFont "MasterFont", 0.01, "",
                FontJustificationH JUSTIFYCENTER,
                UseActiveContext,
                FontJustificationV JUSTIFYMIDDLE,
                LayerStyle "IGNORETRACKEVENTS",
                SetPoint CENTER, "awar_jnname_3", CENTER, 0, -0.035,
                Text "对周围的敌方空中单位进行强有力的弹幕攻击",
            }
        }
    }
}
```
