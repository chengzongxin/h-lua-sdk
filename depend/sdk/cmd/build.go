package cmd

import (
	"fmt"
	"os"
	"os/exec"
	"sdk/lib"
	"time"
)

func runBuild(sdkData lib.SdkData, w3xFire string, times int) {
	cmd := exec.Command(sdkData.YDWE+"/bin/YDWEconfig.exe", "-launchwar3", "-loadfile", w3xFire)
	_, _ = cmd.Output()
	fmt.Println("尝试启动中")
	ticker := time.NewTicker(time.Second)
	fmt.Println(<-ticker.C)
	exes := []string{"War3.exe", "war3.exe", "Frozen Throne.exe"}
	if lib.ExeRunningQty(exes) > 0 {
		fmt.Println("War3已启动")
	} else {
		if times >= 3 {
			fmt.Println("War3启动失败，请检查环境")
			return
		} else {
			fmt.Println("War3启动失败,1秒后再次重试")
		}
		time.Sleep(time.Second)
		runTest(sdkData, w3xFire, times+1)
	}
}

func Build(sdkData lib.SdkData) {
	projectName := ProjectName(sdkData)
	if !ProjectExist(sdkData) {
		lib.Panic("项目" + projectName + "不存在")
	}
	Pickup(sdkData)
	temProjectDir := sdkData.Temp + "/" + projectName
	temProjectW3xFire := sdkData.Temp + "/" + projectName + ".w3x"
	buoyFire := sdkData.Temp + "/" + projectName + "/.ydwe"
	mtW := lib.GetModTime(temProjectW3xFire)
	mtB := lib.GetModTime(buoyFire)
	if mtW > mtB {
		// 如果地图文件比yd打开时新（说明有额外保存过）把保存后的文件拆包并同步
		cmd := exec.Command(sdkData.W3x2lni+"/w2l.exe", "lni", temProjectW3xFire)
		_, err := cmd.Output()
		if err != nil {
			lib.Panic(err)
		}
		lib.CopyFile(sdkData.Depend+"/lni/.ydwe", buoyFire)
		Backup(sdkData) // 以编辑器为主版本
		fmt.Println("同步完毕[检测到有新的地图保存行为，以‘YDWE’为主版本]")
	} else {
		Pickup(sdkData) // 以project为主版本
		fmt.Println("同步完毕[检测到没有新的地图保存行为，以‘project’为主版本]")
	}
	// 复制一份最新的临时文件到build区
	buildProjectDir := sdkData.Temp + "/_build"
	buildProjectW3xFire := buildProjectDir + "/build.w3x"
	_ = os.RemoveAll(buildProjectDir)
	lib.CopyPath(temProjectDir, buildProjectDir)
	fmt.Println("构建完毕[_build]")
	// 调整代码，以支持war3
	t1 := time.Now()
	War3(sdkData, "_build")
	fmt.Println("代码完成（" + time.Since(t1).String() + "）")
	fmt.Println("开始生成地图[build.w3x]")
	// 生成地图
	t2 := time.Now()
	cmd := exec.Command(sdkData.W3x2lni+"/w2l.exe", "obj", buildProjectDir, buildProjectW3xFire)
	_, err := cmd.Output()
	if err != nil {
		fmt.Println("w2l启动失败")
		lib.Panic(err)
	}
	we := sdkData.YDWE
	// 提供war3目录情况下，检查是否有构建版本的WE，改用它
	if sdkData.CWar3 != "" && sdkData.CWeBuild != "" {
		we = sdkData.CWeBuild
		fmt.Println("已切换构建WE: " + we)
		lib.CopyFile(we+"/dz_w3_plugin.dll", sdkData.CWar3+"/dz_w3_plugin.dll")
		lib.CopyFile(we+"/version.dll", sdkData.CWar3+"/version.dll")
		fmt.Println("已接入构建弹窗")
	}
	// 检查标志
	fmt.Println("w2l打包完成（" + time.Since(t2).String() + "）")
	if len(sdkData.Args) > 3 && sdkData.Args[3] == "?" {
		fmt.Println(">>>>>>> 临时地图已生成，可自行检查:" + buildProjectW3xFire + " <<<<<<<")
		return
	} else {
		fmt.Println("地图已生成[build.w3x]")
	}
	exes := []string{"War3.exe", "war3.exe"}
	if lib.ExeRunningQty(exes) > 0 {
		fmt.Println(">>>>>>> 请先关闭当前war3!!! <<<<<<<")
		return
	}
	// 跑
	runBuild(sdkData, buildProjectW3xFire, 0)
}
