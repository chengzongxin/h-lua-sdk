package lib

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"path/filepath"
	"reflect"
	"runtime"
	"strings"
)

func stack() string {
	var buf [2 << 10]byte
	res := string(buf[:runtime.Stack(buf[:], true)])
	res = strings.Replace(res, "Z:/Workspace/war3/hunzsig-warcraft3/h-lua-sdk/sdk", "SDK::", -1)
	return res
}

func Panic(what interface{}) {
	t := reflect.TypeOf(what)
	switch t.Kind() {
	case reflect.String:
		fmt.Println("<ERROR>", what)
	case reflect.Ptr:
		fmt.Println("<ERROR>", what)
		fmt.Println("<STACK>", stack())
	default:
		fmt.Println("<KIND>", t.Kind())
	}
	os.Exit(0)
}

// GetModTime 获取文件(架)修改时间 返回unix时间戳
func GetModTime(path string) int64 {
	modTime := int64(0)
	err := filepath.Walk(path, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return nil
		}
		u := info.ModTime().Unix()
		if u > modTime {
			modTime = u
		}
		return nil
	})
	if err != nil {
		return 0
	}
	return modTime
}

func ExeRunningQty(names []string) int {
	buf := bytes.Buffer{}
	cmd := exec.Command("wmic", "process", "get", "name,executablepath")
	cmd.Stdout = &buf
	cmd.Run()
	qty := 0
	for _, n := range names {
		cmd2 := exec.Command("findstr", n)
		cmd2.Stdin = &buf
		data, _ := cmd2.CombinedOutput()
		if len(data) != 0 {
			qty = strings.Count(string(data), n)
			break
		}
	}
	return qty
}

// IsFile is_file()
func IsFile(filename string) bool {
	_, err := os.Stat(filename)
	if err != nil && os.IsNotExist(err) {
		return false
	}
	return true
}

// IsDir is_dir()
func IsDir(filename string) (bool, error) {
	fd, err := os.Stat(filename)
	if err != nil {
		return false, err
	}
	fm := fd.Mode()
	return fm.IsDir(), nil
}

// FilePutContents file_put_contents()
func FilePutContents(filename string, data string, mode os.FileMode) error {
	return ioutil.WriteFile(filename, []byte(data), mode)
}

// FileGetContents file_get_contents()
func FileGetContents(filename string) (string, error) {
	data, err := ioutil.ReadFile(filename)
	return string(data), err
}
