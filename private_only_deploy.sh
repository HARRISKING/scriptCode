#!/bin/sh
# 更新已经存在的git仓库项目

branch_name=private/zhongjiaoziguang/master

# 修改后的ip
modified_ip=172.31.121.82

# 要替换的端口
modifued_sigin_port=8080
modified_wo_port=8081

# 要修改的ip 非必要不要改!!!!!!!!!!
target_ip=10.10.0.119
merge_target_branch=private/master


function title {
  echo 
  echo "###############################################################################"
  echo "## $1"
  echo "###############################################################################" 
  echo 
}

function operateGit {
  yes | git checkout $branch_name
  yes | git pull --rebase
}

function submitCode {
  title "提交代码"
  yes | git add .
  yes | git commit -m 'feat: 修改登录地址'  --no-verify
  yes | git push
}

title ">>>>>>>>进入开发者平台，创建私有分支>>>>>>>>"
cd ~/code/uniubi-wo-controller-web
operateGit
title "打包代码"
yarn build:private
yes | tar -czvf controller.tar.gz dist/
yes | mv controller.tar.gz ~/Desktop/distAll


title ">>>>>>>>进入物联网，创建私有分支>>>>>>>>"
cd ~/code/uniubi-wo-isv-web
operateGit
title "打包代码"
yarn build:private
yes | tar -czvf isv.tar.gz dist/
yes | mv isv.tar.gz ~/Desktop/distAll


title ">>>>>>>>进入统一登录，创建私有分支>>>>>>>>"
cd ~/code/wo-developer-signin-web 
operateGit
title "打包代码"
yarn build:private
yes | tar -czvf signin.tar.gz dist/
yes | mv signin.tar.gz ~/Desktop/distAll

