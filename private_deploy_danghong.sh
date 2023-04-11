#!/bin/sh
branch_name=private/zhongjiaoziguang/master
merge_target_branch=private/pcTest/master
isv=10.10.0.119:8087
controller=10.10.0.119:8086
signin=10.10.0.119:8088
target_ip=172.31.121.82:8080
modified_ip=192.168.11.101:8088
function title {
  echo 
  echo "###############################################################################"
  echo "## $1"
  echo "###############################################################################" 
  echo 
}

title "进入开发者平台，创建私有分支>>>>>>>>"
cd ~/code/uniubi-wo-controller-web
yes | git checkout $branch_name
# yes | git checkout -b $branch_name
# yes | git push --set-upstream origin $branch_name

title "修改私有文件中的登录地址"
gsed -i "s/$target_ip/$modified_ip/g" ~/code/uniubi-wo-controller-web/.umirc.private.ts

# title "提交代码"
# yes | git add .
# yes | git commit -m 'feat: 修改登录地址'  --no-verify
# yes | git push

title "打包代码"
yarn build:private
yes | tar -czvf controller.tar.gz dist/
yes | mv controller.tar.gz ~/Desktop/distAll

title "进入物联网，创建私有分支>>>>>>>>"
cd ~/code/uniubi-wo-isv-web
yes | git checkout $branch_name
# yes | git checkout -b $branch_name
# yes | git push --set-upstream origin $branch_name

title "修改私有文件中的登录地址"
gsed -i "s/$target_ip/$modified_ip/g" ~/code/uniubi-wo-isv-web/.umirc.private.ts

# title "提交代码"
# yes | git add .
# yes | git commit -m 'feat: 修改登录地址'  --no-verify
# yes | git push

title "打包代码"
yarn build:private
yes | tar -czvf isv.tar.gz dist/
yes | mv isv.tar.gz ~/Desktop/distAll

title "进入统一登录，创建私有分支>>>>>>>>"
cd ~/code/wo-developer-signin-web 
yes | git checkout $branch_name
# yes | git checkout -b $branch_name
# yes | git push --set-upstream origin $branch_name

title "修改私有文件中的登录地址"
gsed -i "s/172.31.121.82:8086/192.168.11.101:8086/g" ~/code/wo-developer-signin-web/config/private.env.js

# title "提交代码"
# yes | git add .
# yes | git commit -m 'feat: 修改登录地址'  --no-verify
# yes | git push

title "打包代码"
yarn build:private
yes | tar -czvf signin.tar.gz dist/
yes | mv signin.tar.gz ~/Desktop/distAll

