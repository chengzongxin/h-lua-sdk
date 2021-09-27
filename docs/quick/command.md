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

### 测试

> 在test调试中，你可以直接F10重启魔兽获得脚本的更新，而无需再次使用test命令
>
> 重启脚本不包括hslk目录以及resource资源的变更，只对框架脚本或项目脚本有效

```
> sdk.exe test demo //测试你的demo项目并测试
> sdk.exe test demo ? //可以在后面加个问号，从而生成地图而不进行测试，一般用于检查物编的生成结果
```

### 打包

> 在build调试中，F10重启魔兽不能获得脚本的更新，必须再次使用build命令
>
> build命令会引用打包流程的lua脚本，DEBUGGING会自动置为false

```
> sdk.exe build demo //打包你的demo项目并测试
> sdk.exe build demo ? //可以在后面加个问号，从而生成地图而不进行测试，一般用于检查物编的生成结果
```

### 模型命令拓展学习

```
> sdk.exe model demo //查看项目demo的模型，默认第0页
> sdk.exe model demo 2 //查看项目demo的模型，第2页
> sdk.exe model demo ttg //查看项目demo的模型，只要路径带有ttg的
> sdk.exe model demo abc 1  //查看项目demo的模型，第1页且只要路径带有abc的
```
