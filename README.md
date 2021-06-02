# 狗眼电影在线售票系统

Forked from https://gitee.com/chaos-chou/gouyan

#### 介绍
基于SpringBoot + Vue 的电影售票系统和影院后台管理系统

# 程序运行环境说明

## 运行环境

1. java 8
2. vue 2.6.12
3. vue_cli 3.0
4. maven 3.6.3
5. nodeJS 12

## 后端配置

1. 找到`panda-admin`模块下的`resources`文件夹内的`application.yml`，端口在最下方配置
2. 同目录下的`application-druid.yml`文件内配置`mysql`的数据源
3. 之后重新导入maven依赖即可

## 前端配置

### 狗眼后台管理系统前端

1. 进入`panda`文件夹内，执行`npm install`命令
2. 在根目录下`vue.config.js`文件中修改运行端口
3. 进入`src->components`目录，找到`global_variable.vue`文件，其中有两个属性，
`base`属性表示访问后端图片的路径，`baseUrl`表示通过`axios`访问后端接口的默认路径
(若本地运行，均修改为`http://127.0.0.1:8181`即可，端口为后端配置的端口号)
4. 运行前端vue项目，进入`panda-ui`文件夹，执行`npm run serve`命令即可运行

### 狗眼前台在线选座售票系统前端

整体步骤与上述一致，只需要进入`panda-user`目录即可

## 运行后部分信息

运行后通过控制台显示的指定地址即可访问前台和后台，
默认登录用户为：`用户名：admin 密码：123456 `，
数据库中其他用户的密码也均为`123456`

PS: 请注意修改数据库运行的时区，否则可能会影响订单生成的计时。

帐号有效登录时间为1小时，权限设置需要先登录获取token后再访问资源页面
