## 命令行

### 使用WE编辑地形

```
> sdk.exe new demo //新建一个地图项目，名为demo
```

### 使用WE编辑地形

> 编辑完后在使用test时会自动将改动记录回你的项目中

```
> sdk.exe we demo //以WE打开项目demo，主要用于编辑地形
```

### 模型批量查看

> 模型默认scale1.00，方便对比

```
> sdk.exe model demo //查看项目demo的模型，默认第0页
> sdk.exe model demo 2 //查看项目demo的模型，第2页
> sdk.exe model demo ttg //查看项目demo的模型，只要路径带有ttg的
> sdk.exe model demo abc 1  //查看项目demo的模型，第1页且只要路径带有abc的
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

### 清理缓存

```
> sdk.exe clear demo //清理构建的临时文件
```
