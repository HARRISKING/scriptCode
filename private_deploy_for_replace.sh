#!/bin/sh
# 更新已经存在的git仓库项目

branch_name=private/pcTest/master

# 修改后的ip
modified_ip=192.168.42.119

# 要替换的端口
modifued_sigin_port=8085
modified_wo_port=8086

# 要修改的ip 非必要不要改!!!!!
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
  yes | git checkout $merge_target_branch
  yes | git push -d origin $branch_name
  yes | git branch -D $branch_name
  yes | git checkout -b $branch_name
  yes | git push --set-upstream origin $branch_name
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
title "修改私有文件中的登录地址"
gsed -i "s/$target_ip:8088/$modified_ip:$modifued_sigin_port/g" ~/code/uniubi-wo-controller-web/.umirc.private.ts
submitCode
title "打包代码"
yarn build:private
yes | tar -czvf controller.tar.gz dist/
yes | mv controller.tar.gz ~/Desktop/distAll


title ">>>>>>>>进入物联网，创建私有分支>>>>>>>>"
cd ~/code/uniubi-wo-isv-web
operateGit
title "修改私有文件中的登录地址"
gsed -i "s/$target_ip:8088/$modified_ip:$modifued_sigin_port/g" ~/code/uniubi-wo-isv-web/.umirc.private.ts
submitCode
title "打包代码"
yarn build:private
yes | tar -czvf isv.tar.gz dist/
yes | mv isv.tar.gz ~/Desktop/distAll


title ">>>>>>>>进入统一登录，创建私有分支>>>>>>>>"
cd ~/code/wo-developer-signin-web 
operateGit
title "修改私有文件中的登录地址"
gsed -i "s/$target_ip:8086/$modified_ip:$modified_wo_port/g" ~/code/wo-developer-signin-web/config/private.env.js
submitCode
title "打包代码"
yarn build:private
yes | tar -czvf signin.tar.gz dist/
yes | mv signin.tar.gz ~/Desktop/distAll

