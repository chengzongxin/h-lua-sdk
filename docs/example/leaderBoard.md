## 使用排行榜

创建两种排行榜，一种木头，一种黄金；只记录玩家1、玩家2

并且每20秒换一种展示

```lua
hleaderBoard.create('gold', '黄金榜', 1, function(leaderBoardKey)
    print("leaderBoardKey", leaderBoardKey)
    return {
        { playerIndex = 1, value = hplayer.getGold(hplayer.players[1]) },
        { playerIndex = 2, value = hplayer.getGold(hplayer.players[2]) }
    }
end)
hleaderBoard.create('lumber', '木头榜', 1, function(leaderBoardKey)
    print("leaderBoardKey", leaderBoardKey)
    return {
        { playerIndex = 1, value = hplayer.getLumber(hplayer.players[1]) },
        { playerIndex = 2, value = hplayer.getLumber(hplayer.players[2]) }
    }
end)

htime.setInterval(20, function(_)
    if (hleaderBoard.CURRENT == 'gold') then
        hleaderBoard.show('lumber')
    else
        hleaderBoard.show('gold')
    end
end)
```
