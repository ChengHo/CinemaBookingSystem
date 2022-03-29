# CinemaBookingSystem
基于SpringBoot + Vue 的电影售票及影院管理系统（前后端分离）

后端：Spring Boot + Mybatis

实现功能：

售票子系统：用户浏览电影信息，电影分类查看，搜索查看，购票操作（未实现支付沙箱），超时取消订单等

管理子系统：管理员管理影院信息，电影信息，用户角色，角色权限，查看订单信息等功能

安全校验：使用shiro安全框架进行用户请求过滤，密码加密

数据库连接池：druid

分页插件：pageHelper


vue安装对应的版本:

nodejs 14.xx

npm 6.xx

vue 2.x

C:\Users\dell>node -v
v14.17.6

C:\Users\dell>npm -v
6.14.15

C:\Users\dell>vue -V
2.9.6
