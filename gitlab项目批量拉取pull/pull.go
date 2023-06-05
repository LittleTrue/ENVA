package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"sync"

	"github.com/gogf/gf/frame/g"
)

// 先行运行：
// 1、inkedep get github.com/gogf/gf/frame/g
//    inkedep get github.com/gorilla/websocket
//    inkedep get github.com/gqcn/structs
//    inkedep get github.com/grokify/html-strip-tags-go
// 2、go run pull.go
func main() {
	for _, code := range target {
		switch code {
		case "seek":
			// for _, group := range getGroupId(seekGroupUrl) {
			// 	getNext(group.Id)
			// }
		case "pandora":
			// for _, group := range getGroupId(pandoraGroupUrl) {
			// 	getNext(group.Id)
			// }
		case "hp":
			for _, group := range getGroupId(hpGroupUrl) {
				getNext(group.Id)
			}
		case "phx":
			for _, group := range getGroupId(phxGroupUrl) {
				getNext(group.Id)
			}
		}

	}
}

type repoInfo struct {
	Url  string `json:"ssh_url_to_repo"`
	Name string `json:"path_with_namespace"`
}

type groupInfo struct {
	Id int `json:"id"`
}

// 需要开启拉取的项目
var (
	target = []string{
		//  "seek",
		//"pandora",
		//"hp",
		"phx",
	}
	// 音泡代号为cj  香芋味ms 77为ss  填满为拉取整个广州服务端后端代码
	seekGroupUrl    = "https://code.inke.cn/api/v4/groups/3165/subgroups"
	pandoraGroupUrl = "https://code.inke.cn/api/v4/groups/4309/subgroups"
	hpGroupUrl      = "https://code.inke.cn/api/v4/groups/5294/subgroups"
	phxGroupUrl     = "https://code.inke.cn/api/v4/groups/4085/subgroups"
)

// 把gitlab代码的所有代码拉取到指定目录
const (
	GoPath        = "G:/workspace/src/code.inke.cn/" // 拉取代码的目标目录
	//GoPath        = "G:/ENVA/go/workspace/src/code.inke.cn/" // 拉取代码的目标目录
	GitlabToken   = "oabvqhgAHZH-Py2vbEYJ"           // gitlabToken获取 从gitlab setting中的Access Tokens获取
	GitlabAddress = "code.inke.cn"
)

func getGroupId(url string) []*groupInfo {
	logHead := "getGroupId|"
	buildUrl := fmt.Sprintf("%s?private_token=%s", url, GitlabToken)
	content := g.Client().GetBytes(buildUrl)
	fmt.Printf(logHead+"get from url=%v\n", buildUrl)

	var groupInfoList []*groupInfo
	err := json.Unmarshal(content, &groupInfoList)
	if err != nil {
		fmt.Printf(logHead+"error=%v\n", err)
	}
	return groupInfoList
}

func getNext(groupId int) {
	url := genNextUrl(groupId)
	content := g.Client().GetBytes(url)
	var repoInfoList []*repoInfo
	err := json.Unmarshal(content, &repoInfoList)
	if err != nil {
		fmt.Println(err)
	}
	wg := sync.WaitGroup{}
	for _, v := range repoInfoList {
		fmt.Println(v.Url)
		wg.Add(1)
		go func(v *repoInfo) {
			defer wg.Done()
			var (
				command string
				out     bytes.Buffer
				stderr  bytes.Buffer
			)
			path := GoPath + v.Name
			_, err := os.Stat(path)
			if err != nil {
				command = fmt.Sprintf("git clone %s %s", v.Url, path)
			} else {
				command = fmt.Sprintf("git -C \"%s\" pull", path)
			}
			// liunx下为/bin/bash, windows下为 powershell
			cmd := exec.Command("powershell", "-c", command)
			cmd.Stdout = &out
			cmd.Stderr = &stderr
			if err = cmd.Run(); err != nil {
				fmt.Println("==========")
				fmt.Println(err, stderr.String())
				fmt.Println("拉取", v.Name, "失败")
				fmt.Println()
				fmt.Println("==========")
				return
			} else {
				fmt.Println("正在拉取 ", v.Name, "...")
				fmt.Println(out.String())
			}
		}(v)
	}
	wg.Wait()
}

func genNextUrl(groupId int) string {
	return fmt.Sprintf("https://%s/api/v4/groups/%d/projects?per_page=100&private_token=%s", GitlabAddress, groupId, GitlabToken)
}
