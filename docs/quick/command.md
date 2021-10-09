## 命令行

### 新建项目

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
>
> 一个批次最大289个模型，不足289的模型位置会变为黑色方块

```
> sdk.exe model demo //查看项目demo的模型，默认第0页
> sdk.exe model demo 2 //查看项目demo的模型，第2页
> sdk.exe model demo ttg //查看项目demo的模型，只要路径带有ttg的
> sdk.exe model demo abc 1  //查看项目demo的模型，第1页且只要路径带有abc的
```

### test 测试

> 在test调试中，你可以直接F10重启魔兽获得脚本的更新，而无需再次使用test命令
>
> 重启脚本不包括hslk目录以及resource资源的变更，只对框架脚本或项目脚本有效
>
> 这个test模式的测试图是可以上传平台测试的，也会打开调试窗口，但是只有你本人有效

```
> sdk.exe test demo //测试你的demo项目并测试
> sdk.exe test demo ? //可以在后面加个问号，从而生成地图而不进行测试，一般用于检查物编的生成结果
```

### build 打包预测试

> 在build调试中，F10重启魔兽不能获得脚本的更新，必须再次使用build命令
>
> build命令会引用打包流程的lua脚本，DEBUGGING依然为true，方便查看打包后可能出现的未知错误

```
> sdk.exe build demo //打包你的demo项目并测试
> sdk.exe build demo ? //可以在后面加个问号，从而生成地图而不进行测试，一般用于检查物编的生成结果
```

### dist 打包上线

> 在dist调试中，F10重启魔兽不能获得脚本的更新，必须再次使用build命令
>
> dist命令会引用打包流程的lua脚本，DEBUGGING会自动置为false

```
> sdk.exe dist demo //打包你的demo项目并测试
> sdk.exe dist demo ? //可以在后面加个问号，从而生成地图而不进行测试，一般用于检查物编的生成结果
```

* !!!不管是test、build还是dist
* 完整的测试图都是放在 \Warcraft III Frozen Throne\Maps\Test\WorldEditTestMap.w3x
* 这个地图可以上传到平台测试，包括test版本的，只是test只有你有效，因为地图里面不包含lua脚本

### 同时开启N个魔兽客户端（支持JAPI）

> 默认打开2个，最多一次性打开9个(并不建议，单人4个足矣)

```
> sdk.exe multi 4 //打开4个
```

### 关闭所有War3客户端

> 此命令需要管理员权限，请留意

```
> sdk.exe kill
```

### 清理缓存

```
> sdk.exe clear demo //清理构建的临时文件
```
