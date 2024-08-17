#!/bin/bash

#配合宿主机定时任务执行 docker exec gitlab sh /docker/gitlab/data/backups/gitlab_backups.sh
#手动将需要的备份放入阿里云NAS中
#执行备份命令
gitlab-rake gitlab:backup:create