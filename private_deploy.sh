#!/bin/sh
branch_name=private/qualityManage/master
merge_target_branch=private/pcTest/master
isv=192.168.1.200:8087
controller=192.168.1.200:8086
signin=192.168.1.200:8088

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
gsed -i 's/192.168.42.119:8085/192.168.1.200:8088/g' ~/code/uniubi-wo-controller-web/.umirc.private.ts

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
gsed -i 's/192.168.42.119:8085/192.168.1.200:8088/g' ~/code/uniubi-wo-isv-web/.umirc.private.ts

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
gsed -i 's/192.168.42.119:8086/192.168.1.200:8086/g' ~/code/wo-developer-signin-web/config/private.env.js

title "提交代码"
yes | git add .
yes | git commit -m 'feat: 修改登录地址'  --no-verify
yes | git push

title "打包代码"
yarn build:private
yes | tar -czvf signin.tar.gz dist/
yes | mv signin.tar.gz ~/Desktop/distAll

