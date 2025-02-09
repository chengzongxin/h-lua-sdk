package cmd

import (
	"embed"
	"encoding/json"
	"fmt"
	"github.com/yuin/gopher-lua"
	"io/fs"
	"path/filepath"
	"reflect"
	"regexp"
	"sdk/lib"
	"strconv"
	"strings"
)

func require(L *lua.LState, file string) {
	err := L.DoFile(file)
	if err != nil {
		lib.Panic(err)
	}
}

func requireEmbed(L *lua.LState, e embed.FS, file string) {
	s, _ := e.ReadFile(file)
	err := L.DoString(string(s))
	if err != nil {
		lib.Panic(err)
	}
}

func ini(file string) string {
	content, errIni := lib.FileGetContents(file)
	if errIni != nil {
		return ""
	}
	return content
}

// Lua lua
func Lua(sdkData lib.SdkData, createSrc string) {
	L := lua.NewState()
	defer L.Close()
	//
	require(L, sdkData.HLua+"/console/hslk.lua")
	require(L, sdkData.HLua+"/const/enchant.lua")
	require(L, sdkData.HLua+"/const/abilityTarget.lua")
	require(L, sdkData.HLua+"/const/attribute.lua")
	require(L, sdkData.HLua+"/const/attributeXtras.lua")
	require(L, sdkData.HLua+"/const/ubertip.lua")
	require(L, sdkData.HLua+"/const/breakArmorType.lua")
	require(L, sdkData.HLua+"/const/cache.lua")
	require(L, sdkData.HLua+"/const/damageSource.lua")
	require(L, sdkData.HLua+"/const/damageType.lua")
	require(L, sdkData.HLua+"/const/event.lua")
	require(L, sdkData.HLua+"/const/hero.lua")
	require(L, sdkData.HLua+"/const/hotKey.lua")
	require(L, sdkData.HLua+"/const/item.lua")
	require(L, sdkData.HLua+"/const/monitor.lua")
	require(L, sdkData.HLua+"/const/target.lua")
	require(L, sdkData.HLua+"/const/unit.lua")
	require(L, sdkData.HLua+"/const/orderStr.lua")
	require(L, sdkData.HLua+"/foundation/color.lua")
	require(L, sdkData.HLua+"/foundation/json.lua")
	require(L, sdkData.HLua+"/foundation/array.lua")
	require(L, sdkData.HLua+"/foundation/math.lua")
	require(L, sdkData.HLua+"/foundation/string.lua")
	require(L, sdkData.HLua+"/foundation/table.lua")
	require(L, sdkData.HLua+"/slk/pilot.lua")
	// embeds
	requireEmbed(L, sdkData.Embeds, "embeds/slk/go.lua")
	requireEmbed(L, sdkData.Embeds, "embeds/slk/setter.lua")
	requireEmbed(L, sdkData.Embeds, "embeds/slk/slk.lua")
	// 初始化
	projectName := sdkData.Args[2]
	tableIni := sdkData.Temp + "/" + projectName + "/table"
	itemIni := ini(tableIni + "/item.ini")
	abilityIni := ini(tableIni + "/ability.ini")
	unitIni := ini(tableIni + "/unit.ini")
	buffIni := ini(tableIni + "/buff.ini")
	upgradeIni := ini(tableIni + "/upgrade.ini")
	reg, _ := regexp.Compile("\\[[A-Za-z][A-Za-z0-9]{3}]")
	itemIniMatches := reg.FindAllString(itemIni, -1)
	abilityIniMatches := reg.FindAllString(abilityIni, -1)
	unitIniMatches := reg.FindAllString(unitIni, -1)
	buffIniMatches := reg.FindAllString(buffIni, -1)
	upgradeIniMatches := reg.FindAllString(upgradeIni, -1)
	var idIni []string
	for _, v := range itemIniMatches {
		v = strings.Replace(v, "[", "", 1)
		v = strings.Replace(v, "]", "", 1)
		idIni = append(idIni, v)
	}
	for _, v := range abilityIniMatches {
		v = strings.Replace(v, "[", "", 1)
		v = strings.Replace(v, "]", "", 1)
		idIni = append(idIni, v)
	}
	for _, v := range unitIniMatches {
		v = strings.Replace(v, "[", "", 1)
		v = strings.Replace(v, "]", "", 1)
		idIni = append(idIni, v)
	}
	for _, v := range buffIniMatches {
		v = strings.Replace(v, "[", "", 1)
		v = strings.Replace(v, "]", "", 1)
		idIni = append(idIni, v)
	}
	for _, v := range upgradeIniMatches {
		v = strings.Replace(v, "[", "", 1)
		v = strings.Replace(v, "]", "", 1)
		idIni = append(idIni, v)
	}
	idIniByte, _ := json.Marshal(idIni)
	fn := L.GetGlobal("SLK_GO_INI")
	if err := L.CallByParam(lua.P{
		Fn:      fn,
		NRet:    0,
		Protect: true,
	}, lua.LString(idIniByte)); err != nil {
		lib.Panic(err)
	}
	// 加载 h-lua slk
	requireEmbed(L, sdkData.Embeds, "embeds/slk/system.lua")
	// 加载 项目 slk
	projectSlk := sdkData.Projects + "/" + projectName + "/hslk"
	check, err := lib.IsDir(projectSlk)
	if err != nil {
		lib.Panic(err)
	}
	if check == true {
		err := filepath.Walk(projectSlk, func(path string, info fs.FileInfo, err error) error {
			if err != nil {
				return err
			}
			pLen := len(path)
			if path[pLen-4:pLen] == ".lua" {
				require(L, path)
			}
			return nil
		})
		if err != nil {
			lib.Panic(err)
		}
	}
	fn = L.GetGlobal("SLK_GO_JSON")
	if err := L.CallByParam(lua.P{
		Fn:      fn,
		NRet:    1,
		Protect: true,
	}, lua.LString(idIniByte)); err != nil {
		lib.Panic(err)
	}
	// get lua function results
	slkData := L.ToString(-1)
	var sData []map[string]interface{}
	err = json.Unmarshal([]byte(slkData), &sData)
	if err != nil {
		fmt.Println(slkData)
		lib.Panic(err)
	}
	// 拼接魔码
	var _slkIniBuilderItem strings.Builder
	var _slkIniBuilderAbility strings.Builder
	var _slkIniBuilderUnit strings.Builder
	var _slkIniBuilderBuff strings.Builder
	var _slkIniBuilderUpgrade strings.Builder
	var idCli []string
	for _, sda := range sData {
		_slk := make(map[string]string)
		_hash := make(map[string]interface{})
		_id := ""
		_parent := ""
		for key, val := range sda {
			if key[:1] == "_" {
				_hash[key] = val
				if key == "_id" {
					switch v := val.(type) {
					case string:
						_id = v
					}
				} else if key == "_parent" {
					switch v := val.(type) {
					case string:
						_parent = "\"" + strings.Replace(v, "\\", "\\\\", -1) + "\""
					}
				}
			} else {
				var newVal string
				v := reflect.ValueOf(val)
				valType := reflect.TypeOf(val).Kind()
				switch valType {
				case reflect.String:
					newVal = "\"" + strings.Replace(v.String(), "\\", "\\\\", -1) + "\""
				case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64,
					reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64:
					newVal = strconv.FormatInt(v.Int(), 10)
				case reflect.Float32, reflect.Float64:
					d := fmt.Sprintf("%v", v)
					if -1 == strings.Index(d, ".") {
						newVal = strconv.FormatInt(int64(v.Float()), 10)
					} else {
						newVal = strconv.FormatFloat(v.Float(), 'f', 2, 64)
					}
				case reflect.Slice, reflect.Array:
					newVal = "{"
					for i := 0; i < v.Len(); i++ {
						var n string
						vv := v.Index(i)
						ve := vv.Elem()
						d := fmt.Sprintf("%v", vv)
						switch ve.Kind() {
						case reflect.String:
							n = "\"" + d + "\""
						case reflect.Float64:
							if -1 == strings.Index(d, ".") {
								n = strconv.FormatInt(int64(ve.Float()), 10)
							} else {
								n = strconv.FormatFloat(ve.Float(), 'f', 2, 64)
							}
						}
						if newVal == "{" {
							newVal += n
						} else {
							newVal += "," + n
						}
					}
					newVal += "}"
				}
				_slk[key] = newVal
			}
		}
		if _id != "" && _parent != "" && len(_slk) > 0 {
			idIni = append(idIni, _id)
			idCli = append(idCli, _id)
			_class := _hash["_class"]
			if _class == "item" {
				_slkIniBuilderItem.WriteString("[" + _id + "]")
				_slkIniBuilderItem.WriteString("\n_parent=" + _parent)
				for k, v := range _slk {
					_slkIniBuilderItem.WriteString("\n" + k + "=" + v)
				}
				_slkIniBuilderItem.WriteString("\n\n")
			} else if _class == "ability" {
				_slkIniBuilderAbility.WriteString("[" + _id + "]")
				_slkIniBuilderAbility.WriteString("\n_parent=" + _parent)
				for k, v := range _slk {
					_slkIniBuilderAbility.WriteString("\n" + k + "=" + v)
				}
				_slkIniBuilderAbility.WriteString("\n\n")
			} else if _class == "unit" {
				_slkIniBuilderUnit.WriteString("[" + _id + "]")
				_slkIniBuilderUnit.WriteString("\n_parent=" + _parent)
				for k, v := range _slk {
					_slkIniBuilderUnit.WriteString("\n" + k + "=" + v)
				}
				_slkIniBuilderUnit.WriteString("\n\n")
			} else if _class == "buff" {
				_slkIniBuilderBuff.WriteString("[" + _id + "]")
				_slkIniBuilderBuff.WriteString("\n_parent=" + _parent)
				for k, v := range _slk {
					_slkIniBuilderBuff.WriteString("\n" + k + "=" + v)
				}
				_slkIniBuilderBuff.WriteString("\n\n")
			} else if _class == "upgrade" {
				_slkIniBuilderUpgrade.WriteString("[" + _id + "]")
				_slkIniBuilderUpgrade.WriteString("\n_parent=" + _parent)
				for k, v := range _slk {
					_slkIniBuilderUpgrade.WriteString("\n" + k + "=" + v)
				}
				_slkIniBuilderUpgrade.WriteString("\n\n")
			}
		}
	}
	// 合并ini
	if itemIni == "" {
		itemIni += _slkIniBuilderItem.String()
	} else {
		itemIni += "\n\n" + _slkIniBuilderItem.String()
	}
	createSrcTableDir := sdkData.Temp + "/" + createSrc + "/table"
	err = lib.FilePutContents(createSrcTableDir+"/item.ini", itemIni, fs.ModePerm)
	if err != nil {
		lib.Panic(err)
	}
	if unitIni == "" {
		unitIni += _slkIniBuilderUnit.String()
	} else {
		unitIni += "\n\n" + _slkIniBuilderUnit.String()
	}
	err = lib.FilePutContents(createSrcTableDir+"/unit.ini", unitIni, fs.ModePerm)
	if err != nil {
		lib.Panic(err)
	}
	if abilityIni == "" {
		abilityIni += _slkIniBuilderAbility.String()
	} else {
		abilityIni += "\n\n" + _slkIniBuilderAbility.String()
	}
	err = lib.FilePutContents(createSrcTableDir+"/ability.ini", abilityIni, fs.ModePerm)
	if err != nil {
		lib.Panic(err)
	}
	if buffIni == "" {
		buffIni += _slkIniBuilderBuff.String()
	} else {
		buffIni += "\n\n" + _slkIniBuilderBuff.String()
	}
	err = lib.FilePutContents(createSrcTableDir+"/buff.ini", buffIni, fs.ModePerm)
	if err != nil {
		lib.Panic(err)
	}
	if upgradeIni == "" {
		upgradeIni += _slkIniBuilderUpgrade.String()
	} else {
		upgradeIni += "\n\n" + _slkIniBuilderUpgrade.String()
	}
	err = lib.FilePutContents(createSrcTableDir+"/upgrade.ini", upgradeIni, fs.ModePerm)
	if err != nil {
		lib.Panic(err)
	}
	// 为 cliSlk 补充物编ID
	cliSlkFile := sdkData.Temp + "/" + createSrc + "/map/h-lua-slk/slk.lua"
	cliSlkContent, _ := lib.FileGetContents(cliSlkFile)
	if len(idIni) > 0 {
		for k, v := range idIni {
			idIni[k] = "'" + v + "'"
		}
		idIniStrs := strings.Join(idIni, ",")
		cliSlkContent = strings.Replace(cliSlkContent, "local hslk_cli_ids = {}", "local hslk_cli_ids = {"+idIniStrs+"}", 1)
	}
	if len(idCli) > 0 {
		for k, v := range idCli {
			idCli[k] = "'" + v + "'"
		}
		idCliStrs := strings.Join(idCli, ",")
		cliSlkContent = strings.Replace(cliSlkContent, "HSLK_CLI_H_IDS = {}", "HSLK_CLI_H_IDS = {"+idCliStrs+"}", 1)
	}
	_ = lib.FilePutContents(cliSlkFile, cliSlkContent, fs.ModePerm)
}
