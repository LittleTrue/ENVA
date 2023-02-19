## GO ENV依赖处理相关
GOPRIVATE 当依赖了公司内网基础库时使用
go env -w GOPRIVATE=code.inke.cn,git.inke.cn
go env -w GOPROXY=https://goproxy.cn,direct
go env -w GO111MODULE=auto