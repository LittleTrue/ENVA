<?php  

// 定义要下载的图片 URLs 数组  
$imageUrls = [  
    "https://img.phxyuyin.com/MTcxNTY3MzQ3OTY0NyMyOTgjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzM3NTQxNjE1NCM1MjIjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzczMDQ0Nzk1MyM5NTEjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzM4NTE1Mjg1MCMzMTgjanBn.jpg",
 "https://img.phxyuyin.com/MTcxNzgyMDYyNzYwMiM2MDUjanBn.jpg",
 "https://waha-img.zhengluhk.cn/MTcwODU5MjcxNTI0NSMzMzAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjU5OTk4NDc5OSM0OTcjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzcxNDU0NDM1MyM2ODQjanBn.jpg",
 "https://waha-img.zhengluhk.cn/MTcwMjg2NTg1OTkzOSMgMzMjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMDg2MTA2MjQ5MyM2OTEjanBn.jpg",
 "https://img.phxyuyin.com/MTcxOTMyOTYwMTU1NyMyMDcjanBn.jpg",
 "https://img.phxyuyin.com/MTcxOTA3MTY5NjMzNyM4MTgjanBn.jpg",
 "https://waha-img.zhengluhk.cn/MTcwNzY2MzI2NDYxMiMyODcjanBn.jpg",
 "https://waha-img.zhengluhk.cn/MTcwMTU5NjQzODA5NyMgMTkjanBn.jpg",
 "https://img.phxyuyin.com/MTY5ODY3ODg1NTQzOSMzNzAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzgzOTc5NDc4NCM0MzMjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMTU0MjUzOTAzOSMzMzAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMDk4MDczNjMyOSM3ODAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjE1OTI2Njg4OCM0NjIjanBn.jpg",
 "https://img.phxyuyin.com/MTcxOTk5MjA4OTU5NyMxNDAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzc5Mzk4MTE2OCMzMzAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzg0NjIzMTUwMSM5OTQjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjk0NjA5Nzg3NCM5OTgjanBn.jpg",
 "https://img.phxyuyin.com/MTcxNzg1MTY3NDY4MSM0NzUjanBn.jpg",
 "https://img.phxyuyin.com/MTcxMTA5Nzg3ODA5MiM3MjUjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjI1NTI0MTQ1NyMgNTkjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMTgyMzYxNDYyOCMzMDUjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzIyMzcxMDc0NyM1MzkjanBn.jpg",
 "https://img.phxyuyin.com/MTcxOTEyOTEzODk2NiMgNzYjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzQ2NDU4NjQwNiM4NzQjanBn.jpg",
 "https://img.phxyuyin.com/MTcxMDMyNTYzMDEwMyM3NTkjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzcwOTIyNTA4MCM4MTUjanBn.jpg",
 "https://img.phxyuyin.com/MTcxODk2NjU4Njk5OCM0NDIjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMTIwNzE2NDQyMSM2NjkjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzcyODA2NDE3NiM4ODEjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzg1MDU3MzI2MyMyMzYjanBn.jpg",
 "https://img.phxyuyin.com/MTcxOTg0NjEwOTU3MCMzNTUjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjgwMzQzMjkyMCMzNTcjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjE4NzAwNzUyNiM1NTMjanBn.jpg",
 "https://img.phxyuyin.com/MTcxOTU1MTEwMzQzMiM5MzEjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzQ2MDE4MTE2OSM3MTAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjk2Nzg1MTYwNSM0OTcjanBn.jpg",
 "https://waha-img.zhengluhk.cn/MTY5OTAyMDI1MjkxOSM5MzQjanBn.jpg",
 "https://img.phxyuyin.com/MTcxNzEyNDI4MzY0MSMxNTIjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzc0NzE2ODgyNyM5ODYjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMTYzOTMyNDgxOCMgMTYjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzg0MzExNTI0MSM4NDcjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMDcyMDIxMjY5MSM1MTcjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMDY3MTc5Mjg2MyM2NDcjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzc2MDY4MDUyOCM2NTkjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzI1NzkyNTYyMyM0NDAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzU4ODYzMjkyNiM0ODkjanBn.jpg",
 "https://img.phxyuyin.com/MTcxMjY3NjIwMzE1MiM3NTYjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzE3MDAwNzYyMyMgMzQjanBn.jpg",
 "https://img.hainanzhilan.com/MTcyMzM4MDM5MTEzOCM5NjQjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjMyMTUyNzM3NyMgNDUjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzYyODE3MDMzMyMxNDIjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMTU3MzQxMjc2NSMyOTUjanBn.jpg",
 "https://img.phxyuyin.com/MTcxNTAxNjI0NjQ5MCM5NzcjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMDkzODE4ODkxNiM2NzUjanBn.jpg",
 "https://img.hainanzhilan.com/MTcyMjkzOTMxMzQ2OSM2OTkjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzc2MDQxNzMwNiM4ODMjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMDA5MDU3MzAwNiMxMjAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzA5NTQyNTk5OCMgNjUjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMDQ3MDk3NzAzMSMgIDQjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzY1NDU0Nzc3MiM0NDEjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzgxNTQ0NDUyMCM5OTIjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjIzMzMzNjM5NCMyMDIjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjg4NTc5NjMzMiM4ODkjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzg2MTEwMTM3NiMyMTYjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzg4MDYwMTg3NCM4MzIjanBn.jpg",
 "https://waha-img.zhengluhk.cn/MTY5ODAzMzEzNzA1MyMzOTMjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzY5NzIxODMxOCM3MTEjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMTI0MzA2OTcyNiM4MjMjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMDc0MjU2NTg3NiMgNTMjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzYxMjEwMTU0MyM5MzUjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjU3OTM5NTc5NSM5MzIjanBn.jpg",
 "https://img.phxyuyin.com/MTcxNTY2ODE4MzA2OSM5ODIjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzc0MjMyMTg0MyMxODIjanBn.jpg",
 "https://img.phxyuyin.com/MTcxODQwOTYzNjI5MiM4NTUjanBn.jpg",
 "https://waha-img.zhengluhk.cn/MTY4MjY5NDAxMjg1MiM2ODQjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzU2NTIxMDU4NiM3NDkjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMTkyNjc0MDI2NiM4MTgjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzU5Mjc1MzQ0NyMyMDAjanBn.jpg",
 "https://img.phxyuyin.com/MTcxNjQ3NTA0MDcxMyMgMzcjanBn.jpg",
 "https://img.phxyuyin.com/MTcxMzE3ODk1ODY1OCM2NDIjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMjc4Nzg4OTkzMiM0MTIjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzE0MDgxNzk2NSM5OTEjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMTkyMjQwMTgxOSM1NDgjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzEwOTc0NjA5MCM0ODEjanBn.jpg",
 "https://img.phxyuyin.com/MTY3NjUzMzUxMjQzMCMyMzAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzc1MjA1ODM3OCM3OTgjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzIzNjk2NjIzMiMyMTUjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMTc5NzE1OTk4OSMxMjUjanBn.jpg",
 "https://img.phxyuyin.com/MTcwNjcwNzExNjE5NSM2NTAjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzgyNDQzMDU3MCM4NDkjanBn.jpg",
 "https://img.phxyuyin.com/MTcxOTQ5NTQ4MTIxMSMzNzgjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzI2NDM0NTM0OSM4MjcjanBn.jpg",
 "https://img.phxyuyin.com/MTcyMzg1NTA5MjkxOCM4NTgjanBn.jpg",
 "https://img.phxyuyin.com/MTcxODcwMTkwNzcwOSM4MDkjanBn.jpg",
 "https://img.phxyuyin.com/MTcxMzQzMTE1NjI2OCM3NDUjanBn.jpg"
];  

// 定义保存图片的本地路径  
$saveDir = 'D:\\waha_anchor_image\\'; // 请确保该目录存在并有写入权限  

// 创建目录，如果不存在  
if (!file_exists($saveDir)) {  
    mkdir($saveDir, 0777, true); // 创建目录  
}  

// 遍历图片 URL  
foreach ($imageUrls as $imageUrl) {  
    // 获取图片的文件名  
    $imageName = basename($imageUrl);  
    
    // 定义保存路径  
    $savePath = $saveDir . $imageName;  

    // 下载并保存图片  
    $imageData = file_get_contents($imageUrl);  
    if ($imageData !== false) {  
        file_put_contents($savePath, $imageData);  
        echo "成功下载: $imageName\n";  
    } else {  
        echo "下载失败: $imageUrl\n";  
    }  
}  