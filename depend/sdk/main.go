package main

import (
	"fmt"
	"sdk/cmd"
	"sdk/lib"
)

func main() {
	sdkData := lib.GetSdkData()
	switch sdkData.Args[1] {
	case "help":
		cmd.Help()
	case "api":
		cmd.Api(sdkData)
	case "new":
		cmd.New(sdkData)
	case "we":
		cmd.WE(sdkData)
	case "model":
		cmd.Model(sdkData)
	case "clear":
		cmd.Clear(sdkData)
	case "test":
		cmd.Test(sdkData)
	case "build":
		cmd.Build(sdkData)
	case "dist":
		cmd.Dist(sdkData)
	case "multi":
		cmd.Multi(sdkData)
	case "kill":
		cmd.Kill(sdkData)
	default:
		fmt.Println("Commands: <" + sdkData.Args[1] + "> not exist! Type 'help' for help.")
	}
}
