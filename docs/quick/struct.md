## 目录结构

```
    ├── depend - 依赖的开发套件
    │   ├── h-lua - h-lua(v:latest，随sdk更新的最新版)
    │   ├── w3x2lni - w3x2lni工具(v:2.7.2)
    │   └── YDWE - 马仔工具
    ├── projects - 用来放置你的地图项目目录，如 helloworld
    |   └── helloworld
    └── sdk.exe - sdk命令工具
```

### 项目结构

```
    └── project_demo - 项目目录
        ├── hslk - 专门用来编写物编配置的目录，目录内按顺序加载配置，所以不需要require[不要编写业务代码]F10重启无效
        ├── map - 地图文件
        │   ├── resource - F12导入
        │   │   ├── hLua - h-lua需要的资源文件，请不要乱删除
        │   │   ├── ReplaceableTextures
        │   │   │   ├── Cliff - 悬崖贴图，结合TerrainArt使用，不需要可直接删除
        │   │   │   ├── CommandButtonsDisabled - 暗图标安置处
        │   │   │   └── selection - 选择圈，不需要可直接删除
        │   │   ├── TerrainArt - 地形贴图，不需要可直接删除
        │   │   ├── UI - 命令等系统图形的修改（不包括dzui）不需要可删除，然后需要修改 map/w3x/war3mapSkin.txt
        │   │   ├── war3mapImported - 通用目录
        │   │   └── war3mapMap.blp - 小地图文件，一般不会手动处理，交给 -yd
        │   ├── slk - ini物编（没事别乱改，使用we命令改完地图会备份）
        │   └── w3x - 地图lni（没事别乱改，易崩，使用we命令改完地图会备份）
        │       ├── UI - fdf格式UI文件存放位置，dzui相关的放在此处（可修改）
        │       ├── units
        │       │   └── CommandFunc.txt - 单位指令按钮设置，攻击、停止等（可修改）
        │       ├── fonts.ttf - 游戏字体文件（可替换，结合war3mapSkin.txt）
        │       ├── war3mapSkin.txt - 游戏界面配置（可修改）
        │       └── 其他文件，备份用
        ├── scripts - lua脚本（*此乃建议，实际上你的lua只要在项目目录内，都能按路径访问）
        └── main.lua - 项目代码入口
```
