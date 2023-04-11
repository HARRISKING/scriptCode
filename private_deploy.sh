#!/bin/sh
branch_name=private/qualityManage/master
merge_target_branch=private/master

# 要修改的ip
target_ip=10.10.0.119
# 修改后的ip
modified_ip=192.168.1.200
function title {
  echo 
  echo "###############################################################################"
  echo "## $1"
  echo "###############################################################################" 
  echo 
}

title "进入开发者平台，创建私有分支>>>>>>>>"
cd ~/code/uniubi-wo-controller-web
yes | git checkout $merge_target_branch
yes | git checkout -b $branch_name
yes | git push --set-upstream origin $branch_name

title "修改私有文件中的登录地址"
gsed -i "s/$target_ip:8088/$modified_ip:8088/g" ~/code/uniubi-wo-controller-web/.umirc.private.ts

title "提交代码"
yes | git add .
yes | git commit -m 'feat: 修改登录地址'  --no-verify
yes | git push

title "打包代码"
yarn build:private
yes | tar -czvf controller.tar.gz dist/
yes | mv controller.tar.gz ~/Desktop/distAll

title "进入物联网，创建私有分支>>>>>>>>"
cd ~/code/uniubi-wo-isv-web
yes | git checkout $merge_target_branch
yes | git checkout -b $branch_name
yes | git push --set-upstream origin $branch_name

title "修改私有文件中的登录地址"
gsed -i "s/$target_ip:8088/$modified_ip:8088/g" ~/code/uniubi-wo-isv-web/.umirc.private.ts

title "提交代码"
yes | git add .
yes | git commit -m 'feat: 修改登录地址'  --no-verify
yes | git push

title "打包代码"
yarn build:private
yes | tar -czvf isv.tar.gz dist/
yes | mv isv.tar.gz ~/Desktop/distAll

title "进入统一登录，创建私有分支>>>>>>>>"
cd ~/code/wo-developer-signin-web 
yes | git checkout $merge_target_branch
yes | git checkout -b $branch_name
yes | git push --set-upstream origin $branch_name

title "修改私有文件中的登录地址"
gsed -i "s/$target_ip:8086/$modified_ip:8086/g" ~/code/wo-developer-signin-web/config/private.env.js

title "提交代码"
yes | git add .
yes | git commit -m 'feat: 修改登录地址'  --no-verify
yes | git push

title "打包代码"
yarn build:private
yes | tar -czvf signin.tar.gz dist/
yes | mv signin.tar.gz ~/Desktop/distAll

