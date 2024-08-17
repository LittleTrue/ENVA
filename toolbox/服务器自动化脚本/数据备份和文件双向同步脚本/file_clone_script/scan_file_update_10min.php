<?php
ini_set("max_execution_time", "120");
ini_set("memory_limit ", "1024M");
date_default_timezone_set("PRC");

# 当前脚本执行时间
$time = time();

$update_min_file_arr = [
    '/var/www/html/xuanxijia/uploadFiles/Activity/pic',
    '/var/www/html/xuanxijia/uploadFiles/attachment',
    '/var/www/html/xuanxijia/uploadFiles/service',
];

$update_min_sp_file_arr = [
    '/var/www/html/xuanxijia/uploadFiles/goods',//多级目录特殊处理
    '/var/www/html/xuanxijia/xxj/src/vendor/php/upload/image',//多级目录特殊处理
];

$need_update_arr = array();

//5分钟更新一次的文件夹, 需要对不同的文件夹做不同的扫描更新策略
foreach ($update_min_file_arr as $key => $value) {
    //更新策略,每10分钟,如果检测有文件的修改时间在这5分钟内, 则记录到更新列表 (文件夹为单位)
    //使用syscn命令对这些文件夹进行同步, syscn命令会自动跳过这些文件夹中重复文件
    $dir_filetime = filemtime($value);//获取文件最近修改日期

    if ($time - $dir_filetime < 600) { //文件的修改时间在最近的10分钟,进行更新
        $need_update_arr[] = $value;
    }
}

foreach ($update_min_sp_file_arr as $key => $value) {
    $res_arr = dir_scan($value, $time, 600);//10分钟内有效修改会返回

    if (!empty($res_arr)) {
        $need_update_arr = array_merge($need_update_arr, $res_arr);
    }
}

# 把扫描出的修改的文件,需要更新的文件目录
if (!empty($need_update_arr)) {

    $content = date("Y年m月d h:i:s", $time).'--10min-update--';

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

/**
 * 扫描一个文件夹下一级子目录中于一定时间内修改过的文件/文件夹, 记录并返回一个数组
 * @param 需要扫描的文件夹目录设置目录，用于含有子目录的情况,本方法只遍历一层
 * @param 依据的判断时间
 * @param 与判断时间相差时间, 在这个时间内则该文件会被
 * add by guo  2019年1月23日
 */
function dir_scan($scan_dir, $time, $interval)
{
    $files_stream = @opendir($scan_dir);  //打开目录，返回一个目录流
    $ret_update_arr = array();

    while ($file = @readdir($files_stream)) {    //循环读取目录下的文件
        if ($file!='.' and $file!='..') {
            $path = $scan_dir.'/'.$file;    

            $filetime = filemtime($path);//获取文件最近修改日期
            if ($time - $filetime < $interval) { //文件的修改时间在最近的7分钟,进行更新
                $ret_update_arr[] = $path;
            }
        }
    }

    @closedir($files_stream);  
    return $ret_update_arr;
}