#!/bin/bash
# -*- coding: UTF-8 -*-

DOMAIN=ngrok.littletrue.cn
port=8080

nohup /usr/local/ngrok/bin/ngrokd -domain=$DOMAIN -httpAddr=":$port"