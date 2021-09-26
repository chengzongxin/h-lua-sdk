## 上线官方对战平台须知

> 上线的地图需要在发布后台勾选上启用平台的 japi 选项，否则无法调用 lua引擎库

1、第一步做好你的图，做不好就不用看后面了

2、使用sdk将项目打包,如我的项目叫h-lua-sdk-helloworld

```
.\sdk.exe build h-lua-sdk-helloworld
或缩写
.\sdk.exe -b h-lua-sdk-helloworld
```

3、项目打包完会启动测试，此时已经在你的war3根目录的map/test目录内有了结果文件，如：

> \Warcraft3\Maps\Test\WorldEditTestMap.w3x 这个文件已经经过slk加密

4、把优化好的地图文件改个名，例如你的地图是剑圣求生之路：jsqszl.v1.0.0.w3x,就可以上传地图到官方对战平台了！

> 如果你够强还可以对脚本进行加密，由于是很简单的东西，这里不做赘述。

### CONGRATULATIONS！
