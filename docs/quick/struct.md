## 目录结构

```
├── depend - 依赖的开发套件
│   ├── h-lua - h-lua(v:latest，随sdk更新的最新版)
│   ├── w3x2lni - w3x2lni工具(v:2.7.2)
│   └── YDWE - 马仔工具
├── projects - 用来放置你的地图项目目录，如 h-lua-sdk-helloworld
|   └── h-lua-sdk-helloworld
└── sdk.exe - sdk命令工具
```

### 项目结构

```
└── project_demo - 项目目录
├── hslk - 用来编写 hslk lua 物编配置, 不要把流程代码写里面
├── map - 地图文件
│   ├── implant - 用来强制更新替换【DZUI布局、命令位置、平衡性常数、原生界面】参数
│   ├── resource - F12导入
│   │   ├── hLua - h-lua需要的资源文件，请不要乱删除
│   │   ├── interface - 冷却时间UI，不需要可删除，然后需要修改 implant/war3mapSkin.txt
│   │   ├── ReplaceableTextures
│   │   ├── TerrainArt - 地形贴图，不需要可直接删除
│   │   │   ├── Cliff - 悬崖贴图，不需要可直接删除
│   │   │   ├── CommandButtonsDisabled - 暗图标目录
│   │   │   └── selection - 选择圈，不需要可直接删除
│   │   ├── UI - 命令等系统图形的修改（不包括dzui）不需要可删除，然后需要修改 implant/war3mapSkin.txt
│   │   ├── war3mapImported - 通用目录
│   │   └── war3mapMap.blp - 小地图文件，一般不会手动处理，交给 -yd
│   ├── slk - ini式的物编
│   └── w3x - 地图lni
├── scripts - lua脚本（*此乃建议，实际上你的lua只要在项目目录内，一般都能按路径访问）
└── main.lua - 项目代码入口
```
