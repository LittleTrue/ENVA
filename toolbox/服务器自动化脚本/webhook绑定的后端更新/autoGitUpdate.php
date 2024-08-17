<?php
/**
 * 自动进行git操作更新的脚本, 当在生产服务器上进行项目部署时.
 * 绑定远程仓库的webhook为该脚本, 并且根据不同的仓库项目参数有不同的传值识别.
 * 需要进行同一仓库, 但是项目在不同服务器的webhook转发
 * 本机进行自动化维护的仓库有: 服务后台小程序版(带一键海淘) 服务后台小程序版(不带一键海淘) 服务后台报关版 
 * 注意: 后期会引入异主机部署,到时候需要写针对某些分支的webhook请求转发
 */

//获取请求参数
$request_ID = $_GET["id"];

if (empty($request_ID)) {
    die('request is empty');
}

//根据id识别需要更新的是哪个仓库,触发启动其对应仓库的专属shell自动更新脚本
switch ($request_ID) {
    case 'XQQ7neKF':
        // 服务后台小程序版(带一键海淘)
        echo('success');
        exec('/var/webhook/mid_with_haitao/githook.sh');
        break;
    // case 'XQQ7neKF':
    //     // 服务后台小程序版(带一键海淘)
    //     echo('success');
    //     exec();
        break;
    default:
        echo('fail');
        break;
}



