<?php
ini_set("max_execution_time", "120");
ini_set("memory_limit ", "1024M");
date_default_timezone_set("PRC");

$update_day_file_arr = [
    'brand' => '/var/www/html/xuanxijia/uploadFiles/brand',
    'config' =>'/var/www/html/xuanxijia/uploadFiles/config/xxj',
    'user' =>'/var/www/html/xuanxijia/uploadFiles/userlicence',
    'avatar' =>'/var/www/html/xuanxijia/uploadFiles/avatar',
    'supplier' =>'/var/www/html/xuanxijia/uploadFiles/supplierlicence',
    'images' =>'/var/www/html/xuanxijia/xxj/images',
    'log' =>'/var/www/html/xuanxijia/Log/xxj',
];
$need_update_arr = array();

//1天更新一次的文件,没有特殊的层级结构。统一处理
foreach ($update_min_file_arr as $key => $value) {
    $dir_filetime = filemtime($value);//获取文件最近修改日期

    if ($time - $dir_filetime < 3600 * 24) { //文件的修改时间在一天内,进行更新
        $need_update_arr[] = $value;
    }
}   

# 把扫描出的修改的文件,需要更新的文件目录
if (!empty($need_update_arr)) {
    //组建sh命令并传参
    $content = date("Y年m月d h:i:s", $time).'--day-update--';

    //组建sh命令并传参
    $sh_excute = '/var/file_clone_script/file_clone.sh';
    foreach ($need_update_arr as $key => $param) {
        if (!empty($param)) {
            $sh_excute = $sh_excute .' '.$param;
        }
        //准备输出需要同步的信息到日志文件
        $content =  $content.$param. '            ';
    }
    $content = $content . "\r\n";
    $file_path  = '/var/file_clone_script/file_clone_log.txt';

    file_put_contents($file_path, $content, FILE_APPEND);

    //到此休眠,避免传输给目标服务器带来扫描差异,休眠期间更新的文件会被下次扫描列入
    sleep(20);
    @exec($sh_excute);
} 
