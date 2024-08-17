#!/bin/bash
# 前端打包CI流程中心脚本
# Power By Cry Fox (GXZ) 
# 2021年9月28日 
#       ___           ___           ___
#      /\  \         |\__\         /\  \
#     /::\  \        |:|  |        \:\  \
#    /:/\:\  \       |:|  |         \:\  \
#   /:/  \:\  \      |:|__|__        \:\  \
#  /:/__/_\:\__\ ____/::::\__\ _______\:\__\
#  \:\  /\ \/__/ \::::/~~/~    \::::::::/__/
#   \:\ \:\__\    ~~|:|~~|      \:\~~\~~
#    \:\/:/  /      |:|  |       \:\  \
#     \::/  /       |:|  |        \:\__\
#      \/__/         \|__|         \/__/
# 
# -------------------------------------- PART ZERO 
# 接受命令行传参用于脚本部署
# [product] [build_tool] [project_path] [git_path]
# [branch] [the_trigger] [the_commit] [build_parameter]
# [sub_dir] 
# 读取命令行传参:
# 
# 一般由gitlab-runner触发可以直接传入以下CI变量: 
# https://docs.gitlab.com/ee/ci/variables/predefined_variables.html
# 
# build_tool: 前端项目定制
# project_path: 部署人员确认 [empty 则不需要在测试环境部署]
# build_parameter: 前端项目定制 [empty 则不需要指定环境]
# product: CI_PROJECT_NAME 
# git_path: CI_PROJECT_PATH
# branch: CI_COMMIT_REF_NAME
# the_trigger: GITLAB_USER_NAME
# the_commit: CI_COMMIT_TITLE
# sub_dir: 项目为总的项目时, 在该项目下细分的子文件作为前端项目

if [[ ! $1 || ! $2 || ! $4 || ! $5 || ! $6 ]] 
then
    echo "脚本必须部署参数异常为空, 停止运行"
    exit -999
fi
# -------------------------------------- PART ONE 
# ************************************ 部署参数
# 前端CI项目地址命名(不能重复)
product=$4'_'$6
# 远程代码库路径、分支
git_path_origins=$5
# 部署分支
branch=$6
# 本CI脚本所在服务器需要更新的前端目录(前端CI均在测试服务器运行)
if [[ ! $2 || $2 == 'empty' ]] ;then
    project_path=""
else
    project_path=$2
fi
# ************************************ 固定脚本运行参数
# 是否初次构建
init_flag="normal"
# 运维手机号
ci_owner="15626145209"
# ci服务器
ci_server="47.107.176.36"
# 远程托管平台前缀地址
gitlab_web_url="http://47.107.176.36:9100/"$git_path_origins
# 依赖的gitlab ssh url
gitlab_ssh_url="ssh://git@47.107.176.36:8222/"
# 修改
git_path=$gitlab_ssh_url$git_path_origins'.git'
# CI项目的生成地址
ciproject_dir="/data/ciproject/"
# 依赖的gitlab ssh url
# 项目CI流程根目录 - 根据sub_sir参数配合判断
web_path=$ciproject_dir$product

# 前端VUE结构项目结构目录
node_modules_path="${web_path}/node_modules"
target_path="${web_path}/dist"
target_path_file="${target_path}/*"

# ************************************ 前端项目/项目环境 配置参数
# 本项目构建所需指定的环境变量(一般前端会分测试、正式 | 测试环境有时前端会配成空) 
if [[ ! $3 || $3 == 'empty' ]] ;then
    build_parameter=""
else
    build_parameter=$3
fi
# 本项目构建依赖的前端打包工具 npm / yarn
build_tool=$1
# ************************************ 依赖于gitlab-runer命令行传参
# 触发CI者
if [ ! $7 ] ;then
    the_trigger="no one"
else
    the_trigger=$7
fi
# CI触发提交内容
if [ ! $8 ] ;then
    the_commit="common commit"
else
    the_commit=$8
fi
# 企业微信机器人地址
the_robbit_url="https://oapi.dingtalk.com/robot/send?access_token=fa74f8f65d42a29169b8368b665f8955b9e3bc214f80e4bf0841034905ef692c"
# CI通知消息
the_trigger_message_content="ROBOT ERROR -- \n前端项目 : $product 自动更新构建错误 \n线上环境 : $build_parameter  \n开发人员 : $the_trigger \n提交信息为 : $the_commit \n服务器: $ci_server \n前端项目目录: $web_path\n前端仓库地址: $gitlab_web_url \n运维请跟进。"
the_trigger_message_content_warn="ROBOT WARNING -- \n前端项目 : $product 组件重新安装触发 \n线上环境 : $build_parameter  \n开发人员 : $the_trigger \n提交信息为 : $the_commit \n请开发人员重新commit触发CI即可正常。"

# CI通知消息模板
the_trigger_message='{
    "msgtype": "text",
    "at": {
        "atMobiles":[
            "'$ci_owner'"
        ]
    },
    "text": {
        "content":"'$the_trigger_message_content'"
    }
}'
the_trigger_message_warn='{
    "msgtype": "text",
    "text": {
        "content":"'$the_trigger_message_content_warn'"
    }
}'

# -------------------------------------- PART TWO
function display(){
if [ $? -ne 0 ]
    then
        exit -999
    fi
}

# 一、创建线上CI目录
if [ ! -d "$web_path" ]
then
    init_flag="first"
    echo "创建文件夹${web_path}"
    sudo mkdir -p $web_path
    echo "进入项目路径:${web_path}"
    cd $web_path
    sudo git clone -b $branch $git_path . 
    display
else
    echo "进入项目路径:${web_path}"
    cd $web_path
    display
fi

# 二、兼容CI目录的部分修改去除
check_lose=`sudo git status`

echo "lose results are: $check_lose"

if [[ $check_lose =~ "nothing to commit" ]] 
    then 
        echo "nothing fix."
        display
    else
        sudo git reset --hard
        display
fi


# 三、CI目录下的修改屏蔽
check_results=`sudo git pull origin $branch`

echo "results are: $check_results"

if [[ $check_results =~ "Already up-to-date"  &&  $init_flag == "normal" ]] 
    then 
        echo "no updates need to be published."
        exit 0
fi
display

# 子项目目录
if [[ ! $9 || $9 == 'empty' ]] ;then
    echo "no sub path."
    display
else
    # 判断是否有效目录结构 -- 固定只支持分销的子目录结构
    if [[ $9 == 'wxh5_saler' || $9 == 'wxh5_customer' || $9 == 'webfront_admin' ]] ;then
    echo "exist sub path !"
    sub_web_path=$web_path"/"$9
    cd $sub_web_path
    # 根据子项目目录重新定义结构
    node_modules_path="${sub_web_path}/node_modules"
    target_path="${sub_web_path}/dist"
    target_path_file="${target_path}/*"
    display
    fi  
fi

# 依赖判断
if [ ! -d "$node_modules_path" ]
then
    echo " 安装依赖"
    $build_tool install
    display
fi

# 四、打包并控制错误
# set +e 控制打包错误, 如果是因为组件安装产生的错误, 触发插件自行安装以排除问题
echo "开始打包"
set +e 
cmd=`$build_tool run build$build_parameter`
echo "build results are: $cmd";
set -e 

# 匹配依赖缺失的问题 - 自行修复依赖问题
if [[ $cmd =~ "This dependency was not found"  || $cmd =~ "Cannot find module" ]]
then
    echo "WARNING: 因为依赖问题打包失败, 自动执行插件依赖安装以排除问题_______"
    $build_tool install
    display
    echo "WARNING: 安装依赖完成, 请稍后重新推送额外的 CI FIX COMMIT_______"
    curl $the_robbit_url \
    -H 'Content-Type: application/json' \
    -d "$the_trigger_message_warn"
    exit 1
fi

# 其余类型构建异常
if [[ $cmd =~ "failed" || $cmd =~ "ERROR" ]]
then
    echo "ERROR: 更新异常, 通知运维_______"
    curl $the_robbit_url \
    -H 'Content-Type: application/json' \
    -d "$the_trigger_message"
    exit 1
fi

# 五、复制打包内容到应用服务器映射相关的项目 -- 前端文件目录
# 以下在运行更新正式环境的时候不需要
# 检测是否需要本地部署
if [ ! $project_path ] ;then
    echo "不需部署到测试服务器_______"
    exit 0
fi

echo "进入打包目录${target_path}"
cd   $target_path
display

echo "======================================"
echo "开始复制文件到部署服务器"
sudo cp -rfp $target_path_file $project_path
display
exit 0