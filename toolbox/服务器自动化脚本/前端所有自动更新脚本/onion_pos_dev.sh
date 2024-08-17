
product=onion_pos_html
web_path=/tmp/$product
node_modules_path="${web_path}/node_modules"
target_path="${web_path}/dist"
target_path_file="${target_path}/*"
git_path=ssh://git@47.107.176.36:8222/dezhi-front/pos.git
project_path=/var/www/html/onion_pos/html/
branch=onion

function display(){
if [ $? -ne 0 ]
    then
        exit -999
    fi
}

if [ ! -d "$web_path" ]
then
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

check_results=`sudo git pull origin $branch`

echo "results are: $check_results"

if [[ $check_results =~ "Already up-to-date" ]] 
    then 
        echo "no updates need to be published."
        exit 0
fi
display

if [ -d "$target_path" ]
then
    echo "清除原先的dist打包文件夹"
    sudo rm -rf $target_path
    display
fi

if [ ! -d "$node_modules_path" ]
then
    echo " 安装依赖"
    npm install
    display
fi

echo "开始打包"
npm run build
display

if [ ! -d "$target_path" ]
then
    echo "打包失败,dist未生成 "
    exit 1
fi

echo "进入打包目录${target_path}"
cd   $target_path
display

echo "======================================"
echo "开始复制文件到部署服务器"
sudo cp -rfp $target_path_file $project_path
display
exit 0