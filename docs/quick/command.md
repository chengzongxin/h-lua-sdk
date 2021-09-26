## 命令行

```
* 必填 ~ 选填
> sdk.exe help  //提示cmd工具命令
> sdk.exe new [*PROJECT_NAME]  //新建一个地图项目
> sdk.exe we [*PROJECT_NAME]  //以WE打开地图项目
> sdk.exe clear [*PROJECT_NAME]  //清理构建的临时文件
> sdk.exe test [*PROJECT_NAME] ~? //构建测试版本并开启游戏进行调试,加个?参数可以不测试
> sdk.exe build [*PROJECT_NAME] ~? //构建上线版本并开启游戏进行调试,加个?参数可以不测试
```

### 模型命令拓展学习

```
> sdk.exe model demo //查看项目demo的模型，默认第0页
> sdk.exe model demo 2 //查看项目demo的模型，第2页
> sdk.exe model demo ttg //查看项目demo的模型，只要路径带有ttg的
> sdk.exe model demo abc 1  //查看项目demo的模型，第1页且只要路径带有abc的
```
