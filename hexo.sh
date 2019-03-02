#!/bin/bash https://blog.xaoxuu.com

VERSION='1.0'

function typed_to_continue(){
	echo "按下任意键继续: "
	read -n 1 
}
function echo_fail(){
	echo -e "> \\033[0;31m操作失败！我们都有不顺利的时候。\\033[0;39m"
	typed_to_continue
}
function sleep_open_url(){
	sleep 3
	open http://localhost:4000/
}
function cmd_hexo_c(){
	echo '> hexo clean'
    hexo clean
}
function cmd_hexo_g(){
	echo '> hexo generate'
    hexo generate
}
function cmd_hexo_s(){
	echo '> hexo server'
    sleep_open_url &
    hexo server
}
function cmd_hexo_d(){
	echo '> hexo deploy'
    hexo deploy
}
function cmd_hexo_theme(){
	echo '> git clone https://github.com/xaoxuu/hexo-theme-material-x themes/material-x'
	git clone https://github.com/xaoxuu/hexo-theme-material-x themes/material-x
	echo '> 正在安装主题依赖包，马上就要成功了...'
	npm i -S hexo-generator-search hexo-generator-feed hexo-renderer-less hexo-autoprefixer hexo-generator-json-content hexo-recommended-posts
	echo '> 正在应用主题...'
	sed -i "" "s/^theme:\([^\"]\{1,\}\)/theme: material-x/g" '_config.yml'
}
function cmd_m_nodejs_i(){
	echo '> 请输入密码来安装node.js'
	sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"
}
function cmd_m_nodejs_d(){
	echo '> 现在开始下载node.js，这通常不会太久...'
	curl -o $HOME/Downloads/node-latest.pkg 'https://nodejs.org/dist/v8.11.3/node-v8.11.3.pkg' -#
}
function cmd_m_hexo(){
	echo '> 现在开始下载并安装hexo，这通常不会太久...'
	echo '> sudo npm install hexo-cli -g'
	sudo npm install hexo-cli -g
}

function cmd_m_hexo_blog(){
	read -p "请输入blog名称，例如“blog”: " BLOGNAME
	echo '> hexo init' ${BLOGNAME}
	hexo init ${BLOGNAME}
	mv hexo.sh ${BLOGNAME}/hexo.sh
	echo '> cd' ${BLOGNAME}
	cd ${BLOGNAME}
    echo '> npm install'
    npm install
}

function cmd_git_commit(){
	echo '> 正在提交文件改动到git...'
	git add hexo.sh && git commit -m "update hexo.sh" 
	git push origin && echo -e "> \\033[0;32m提交成功！\\033[0;39m"
}
function cmd_git_commit_all(){
	echo '> 正在提交文件改动到git...'
	git add --all && git commit -am "update all"
	git push origin && echo -e "> \\033[0;32m提交成功！\\033[0;39m"
}
function cmd_update(){
	echo '> 正在更新...'
	curl -O 'https://raw.githubusercontent.com/xaoxuu/hexo.sh/master/hexo.sh' -# && chmod 777 hexo.sh && cmd_update_s || echo_fail
}
# 更新失败后，撤销对hexo.sh的修改
function cmd_update_f(){
	echo -e "> \\033[0;31m更新失败！我们都有不顺利的时候。\\033[0;39m"
	git checkout hexo.sh
	PARAM1=""
	PARAM2=""
	typed_to_continue
}
# 更新成功之后，重启脚本并把当前的版本传递过去
function cmd_update_s(){
	sleep 1 && . hexo.sh 'cmd_updated' $VERSION || cmd_update_f
}
# 在新的脚本中，输出更新信息，并提交文件改动
function cmd_updated(){
	echo -e "> \\033[0;32m更新成功！\\033[0;39m    ${PARAM2} -> ${VERSION}"
	PARAM2=""
	cmd_git_commit
}
function cmd_m(){
	PARAM1=""
	while :
	do
		if [ "$PARAM2" == "" ];then
			clear
			echo '=================== Hexo Utilities ==================='
			echo '搭建环境:'
			echo '  n     安装node.js'
			echo '  h     安装hexo (npm install hexo-cli -g)'
			echo ''
			echo '创建博客:'
			echo '  b     创建博客 (hexo init blog, npm install, hexo s)'
			echo '  x     安装并应用【Material-X】主题【强烈推荐】'
			echo ''
			echo '安装依赖:'
			echo '  i     安装依赖包 (npm install)'
			echo '' 
			echo '小白套餐:'
			echo '  hbx   安装hexo 并搭建【Material-X】主题博客'
			echo '  nhbx  安装node.js、hexo并搭建【Material-X】主题博客'
			echo ''
			echo '脚本菜单:'
			echo '  .     返回上一层'
			echo '------------------------------------------------------'
			read -p "请选择操作: " PARAM2
		fi
        
	    if [ $PARAM2 == 'n' ];then
	    	cmd_m_nodejs_d && cmd_m_nodejs_i
	    elif [ $PARAM2 == 'h' ];then
	    	cmd_m_hexo
		elif [ $PARAM2 == 'b' ];then
			cmd_m_hexo_blog
			cmd_hexo_s
		elif [ $PARAM2 == 'x' ];then
			cmd_hexo_theme && cmd_hexo_s
		    PARAM2=""
			break
	    elif [ $PARAM2 == 'i' ];then
	    	echo '> npm install'
	    	npm install
		    PARAM2=""
	    	break
	    elif [ $PARAM2 == 'hbx' ];then
	    	echo '> 请坐和放宽，我正在帮你搞定一切...'
	    	cmd_m_hexo && cmd_m_hexo_blog && cmd_hexo_theme && cmd_hexo_s || echo_fail
		    PARAM2=""
	    	break
	    elif [ $PARAM2 == 'nhbx' ];then
	    	echo '> 请坐和放宽，我正在帮你搞定一切...'
	    	cmd_m_nodejs_d && cmd_m_nodejs_i && cmd_m_hexo && cmd_m_hexo_blog && cmd_hexo_theme && cmd_hexo_s || echo_fail
		    PARAM2=""
	    	break
		elif [ $PARAM2 == '.' ];then
		    PARAM2=""
			break
		else 
		    PARAM2=""
	        continue
	    fi
	    PARAM2=""
	done

}

function start(){

	while :
	do
		if [ "$PARAM1" == "" ];then
			clear
			echo '==================== Hexo Utilities ===================='
			echo '单个指令:'
			echo '  c     hexo clean'
			echo '  g     hexo generate'
			echo '  s     hexo server'
			echo '  d     hexo deploy'
			echo ''
			echo '组合指令:'
			echo '  cs    hexo clean, hexo server'
			echo '  cg    hexo clean, hexo generate'
			echo '  cgd   hexo clean, hexo generate, hexo deploy'
			echo ''
			echo '脚本菜单:'
			echo '  m     搭建环境、创建博客、安装主题、安装依赖包等'
			echo "  u     更新脚本（当前版本：${VERSION}）"
			echo '--------------------------------------------------------'
		    read -p "请选择操作: " PARAM1
		fi
        
	    if [ $PARAM1 == 'c' ];then
	    	cmd_hexo_c && typed_to_continue || echo_fail
	    elif [ $PARAM1 == 'g' ];then
			cmd_hexo_g && typed_to_continue || echo_fail
		elif [ $PARAM1 == 's' ];then
	        cmd_hexo_s
	    elif [ $PARAM1 == 'd' ];then
			cmd_hexo_d && typed_to_continue || echo_fail
		elif [ $PARAM1 == 'cs' ];then
	        cmd_hexo_c && cmd_hexo_s
		elif [ $PARAM1 == 'cg' ];then
	        cmd_hexo_c && cmd_hexo_g && typed_to_continue || echo_fail
		elif [ $PARAM1 == 'cgd' ];then
	        cmd_hexo_c && cmd_hexo_g && cmd_hexo_d && cmd_git_commit_all && typed_to_continue || echo_fail
		elif [ $PARAM1 == 'm' ];then
			cmd_m
		elif [ $PARAM1 == 'u' ];then
			cmd_update
		elif [ $PARAM1 == 'cmd_updated' ];then
			cmd_updated && sleep 2 || echo_fail
		else 
		    PARAM1=""
	        continue
	    fi
	    PARAM1=""
	done
}

PARAM1=$1
PARAM2=$2
start

