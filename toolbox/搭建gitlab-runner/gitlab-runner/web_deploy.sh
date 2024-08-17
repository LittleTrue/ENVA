
#! /bin/sh
##
#将从gitlab-runner打包好的文件，拷贝到网站目录中作发布
##

webpath=/data/vhosts/vhosts.website/test_manage.zc.com
tar_file=$1
tar_path="/tmp/${tar_file}"

if [ ! -f "$tar_path" ]
then
    echo "打包文件${tar_path}不存在，无法作发布处理"
    exit
fi

echo "开始拷贝文件，从${tar_path}到${webpath}"
cp $tar_path  $webpath
echo "复制完成"

echo "进入网站目录"
cd $webpath

if [ ! -f "${webpath}/${tar_file}" ]
then
    echo "解压包${webpath}/${tar_file}不存在，无法发布"
    exit
fi

echo "删除原来的"
#rm -rf ${webpath}

echo  "解压"
tar xzf "${webpath}/${tar_file}"  --overwrite  .
echo "部署完成,执行清理操作"
chown -R nginx:nginx $webpath
rm "${webpath}/${tar_file}"