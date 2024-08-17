#!/bin/bash
env_file_path=$1
env_file_path_finally=$(echo -ne ${env_file_path} | od -An -tx1 | tr ' ' % | xargs printf "%s")
project_path=$2
personal_project_token=W45u2yEcj_U6nxu7qB1n
env_center_api_before="http://47.107.176.36:9100/api/v4/projects/63/repository/files/"
env_center_api_end="%2f.env?ref=master&private_token="$personal_project_token

env_center_api_finally=$env_center_api_before$env_file_path_finally$env_center_api_end

if [ -z "$env_file_path" ]; then
    echo "empty env_file_path"
	exit -999
fi

if [ -z "$project_path" ]; then
    echo "empty project_path"
    exit -999
fi

result_env_json=$(curl -X GET --header 'Accept: application/json' $env_center_api_finally | jq '.content') 

if [ -z "$result_env_json" ]; then
    echo "error env content"
    exit -999
fi

if [ "$result_env_json" == "null" ]; then
    echo "null env content"
    exit -999
fi

result_env_json="${result_env_json%\"}"
result_env_json="${result_env_json#\"}"

echo -n "$result_env_json" | base64 -d > $project_path/.env

echo "success"
exit 0