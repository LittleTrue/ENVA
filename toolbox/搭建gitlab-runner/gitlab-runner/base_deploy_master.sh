
node_path=/data/scripts/node/bin/node
npm_path=/data/scripts/node/bin/npm

product=web_cloudTax_manage_dev #不能重复
web_path=/tmp/$product
target_path="${web_path}/dist"
git_path=git@172.1.1.22:WEB-Developer/cloud_manage.git

function display(){
if [ $? -ne 0 ]
    then
        exit -999
    fi
}


if [ ! -d $web_path ]
then
    echo "创建文件夹${web_path}"
    sudo mkdir -p $web_path
    echo "进入项目路径:${web_path}"
    cd $web_path
    sudo git clone $git_path .
    display
else
    echo "进入项目路径:${web_path}"
    cd $web_path
    display
fi

sudo chown -R gitlab-runner:gitlab-runner $web_path

if [ -d $target_path ]
then
    sudo chown -R gitlab-runner:gitlab-runner $target_path
fi
display

sudo git checkout test-dev
sudo git pull
display
#echo "进入项目路径:${web_path}"
#cd $web_path

echo "清除原先的dist打包文件夹"
sudo rm -rf $target_path
display

echo "安装依赖"
node_depency="${npm_path} i"
$node_depency
display

echo "开始打包"
build="${npm_path} run build:dev"
$build
display

if [ ! -d "$target_path" ]
then
    echo "打包失败,dist未生成"
    exit 1
fi

echo "进入打包目录${target_path}"
cd   ${target_path}
echo "开始创建压缩包/tmp/${product}.tar.gz"
sudo tar  cvzf "/tmp/${product}.tar.gz" .
display

echo "======================================"
echo "开始复制文件到部署服务器"

scp /tmp/${product}.tar.gz  lc@172.11.10.68:/tmp
echo "文件复制完成到部署服务器"
display

echo "开始服务器部署"

ssh lc@172.11.10.68 /data/scripts/ci/web_deploy.sh $product.tar.gz
display

echo "清除原始压缩包"
sudo rm -rf "/tmp/${product}.tar.gz"
display
exit 0