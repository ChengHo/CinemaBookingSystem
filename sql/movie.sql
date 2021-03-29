/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : localhost:3306
 Source Schema         : movie

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 17/11/2020 22:19:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_actor
-- ----------------------------
DROP TABLE IF EXISTS `sys_actor`;
CREATE TABLE `sys_actor`  (
  `actor_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '演员id',
  `actor_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '演员名字',
  `actor_photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '演员照片',
  `actor_height` decimal(10, 0) UNSIGNED NOT NULL COMMENT '演员身高',
  `actor_age` tinyint(0) UNSIGNED NOT NULL COMMENT '演员年龄',
  `actor_gender` tinyint(0) UNSIGNED NOT NULL COMMENT '演员性别,1为男，0为女',
  `actor_school` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '毕业院校',
  PRIMARY KEY (`actor_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_actor
-- ----------------------------

-- ----------------------------
-- Table structure for sys_actor_movie
-- ----------------------------
DROP TABLE IF EXISTS `sys_actor_movie`;
CREATE TABLE `sys_actor_movie`  (
  `movie_id` bigint(0) UNSIGNED NOT NULL COMMENT '电影id',
  `actor_id` bigint(0) UNSIGNED NOT NULL COMMENT '演员id',
  `actor_role_Id` bigint(0) UNSIGNED NOT NULL COMMENT '参演角色id',
  PRIMARY KEY (`movie_id`, `actor_id`, `actor_role_Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_actor_movie
-- ----------------------------

-- ----------------------------
-- Table structure for sys_actor_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_actor_role`;
CREATE TABLE `sys_actor_role`  (
  `actor_role_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '参演角色id',
  `actor_role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参演角色名称',
  PRIMARY KEY (`actor_role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_actor_role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_bill
-- ----------------------------
DROP TABLE IF EXISTS `sys_bill`;
CREATE TABLE `sys_bill`  (
  `bill_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `bill_state` tinyint(0) UNSIGNED NOT NULL COMMENT '订单状态，1表示已完成，0表示未支付',
  `user_id` bigint(0) UNSIGNED NOT NULL COMMENT '用户id',
  `session_id` bigint(0) UNSIGNED NOT NULL COMMENT '场次id',
  `seat` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '座位号',
  `bill_date` datetime(0) NOT NULL COMMENT '订单日期',
  PRIMARY KEY (`bill_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_bill
-- ----------------------------

-- ----------------------------
-- Table structure for sys_cinema
-- ----------------------------
DROP TABLE IF EXISTS `sys_cinema`;
CREATE TABLE `sys_cinema`  (
  `cinema_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '影院id',
  `cinema_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '影院名',
  `cinema_brand` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '影院品牌',
  `cinema_picture` json NULL COMMENT '影院图片，json类型存储多张图片',
  `is_ticket_changed` tinyint(0) UNSIGNED NULL DEFAULT NULL COMMENT '能否改签，1表示可以，0表示不能',
  `is_refunded` tinyint(0) UNSIGNED NULL DEFAULT NULL COMMENT '能否退款，1表示可以，0表示不能',
  `cinema_area_id` bigint(0) UNSIGNED NOT NULL COMMENT '所属区域id',
  `cinema_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细地址',
  `user_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '联系人(负责人)id',
  `entry_date` date NULL DEFAULT NULL COMMENT '影院入驻日期',
  PRIMARY KEY (`cinema_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_cinema
-- ----------------------------

-- ----------------------------
-- Table structure for sys_cinema_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_cinema_area`;
CREATE TABLE `sys_cinema_area`  (
  `cinema_area_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键区域id',
  `province` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区域所属省份',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区域所属市',
  `cinema_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区域名称',
  PRIMARY KEY (`cinema_area_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_cinema_area
-- ----------------------------

-- ----------------------------
-- Table structure for sys_hall
-- ----------------------------
DROP TABLE IF EXISTS `sys_hall`;
CREATE TABLE `sys_hall`  (
  `hall_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '影厅id',
  `hall_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '影厅名称',
  `cinema_id` bigint(0) UNSIGNED NOT NULL COMMENT '影院id',
  `hall_category_id` bigint(0) UNSIGNED NOT NULL COMMENT '影厅类别id',
  `row_nums` smallint(0) UNSIGNED NULL DEFAULT NULL COMMENT '排数',
  `seat_nums` smallint(0) UNSIGNED NULL DEFAULT NULL COMMENT '每排的座位数',
  `hall_state` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '影厅状态',
  PRIMARY KEY (`hall_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_hall
-- ----------------------------

-- ----------------------------
-- Table structure for sys_hall_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_hall_category`;
CREATE TABLE `sys_hall_category`  (
  `hall_category_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '影厅类别ID',
  `hall_category_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '影厅类别名称',
  PRIMARY KEY (`hall_category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_hall_category
-- ----------------------------

-- ----------------------------
-- Table structure for sys_movie
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie`;
CREATE TABLE `sys_movie`  (
  `movie_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键电影id',
  `movie_name_cn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电影中文名',
  `movie_name_en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电影英文名',
  `movie_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电影图片',
  `movie_area_id` bigint(0) UNSIGNED NOT NULL COMMENT '电影区域id',
  `movie_category_id` bigint(0) UNSIGNED NOT NULL COMMENT '电影类别id',
  `movie_age_id` bigint(0) UNSIGNED NOT NULL COMMENT '影片年代id',
  `release_date` datetime(0) NOT NULL COMMENT '上映时间',
  PRIMARY KEY (`movie_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_movie
-- ----------------------------

-- ----------------------------
-- Table structure for sys_movie_age
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_age`;
CREATE TABLE `sys_movie_age`  (
  `movie_age_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `movie_age_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '年代名称',
  PRIMARY KEY (`movie_age_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_movie_age
-- ----------------------------
INSERT INTO `sys_movie_age` VALUES (1, '2020');
INSERT INTO `sys_movie_age` VALUES (2, '2019');
INSERT INTO `sys_movie_age` VALUES (3, '2018');
INSERT INTO `sys_movie_age` VALUES (4, '2017');
INSERT INTO `sys_movie_age` VALUES (5, '2016');
INSERT INTO `sys_movie_age` VALUES (6, '2015');
INSERT INTO `sys_movie_age` VALUES (7, '2014');
INSERT INTO `sys_movie_age` VALUES (8, '2013');
INSERT INTO `sys_movie_age` VALUES (9, '2012');
INSERT INTO `sys_movie_age` VALUES (10, '2011');
INSERT INTO `sys_movie_age` VALUES (11, '2000-2010');
INSERT INTO `sys_movie_age` VALUES (12, '90年代');
INSERT INTO `sys_movie_age` VALUES (13, '80年代');
INSERT INTO `sys_movie_age` VALUES (14, '70年代');
INSERT INTO `sys_movie_age` VALUES (15, '更早');
INSERT INTO `sys_movie_age` VALUES (16, 'test');
INSERT INTO `sys_movie_age` VALUES (17, 'test1');

-- ----------------------------
-- Table structure for sys_movie_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_area`;
CREATE TABLE `sys_movie_area`  (
  `movie_area_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '电影区域id',
  `movie_area_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电影区域名称',
  PRIMARY KEY (`movie_area_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_movie_area
-- ----------------------------

-- ----------------------------
-- Table structure for sys_movie_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_category`;
CREATE TABLE `sys_movie_category`  (
  `movie_category_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键电影类别id',
  `movie_category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电影类别名称',
  PRIMARY KEY (`movie_category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_movie_category
-- ----------------------------

-- ----------------------------
-- Table structure for sys_movie_comment
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_comment`;
CREATE TABLE `sys_movie_comment`  (
  `movie_id` bigint(0) UNSIGNED NOT NULL COMMENT '电影id',
  `user_id` bigint(0) UNSIGNED NOT NULL COMMENT '用户id',
  `comment_time` datetime(0) NOT NULL COMMENT '评论时间',
  `comment_context` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论',
  PRIMARY KEY (`movie_id`, `user_id`, `comment_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_movie_comment
-- ----------------------------

-- ----------------------------
-- Table structure for sys_movie_runtime
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_runtime`;
CREATE TABLE `sys_movie_runtime`  (
  `movie_runtime_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '播放时段id',
  `movie_runtime_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '播放时段名',
  `begin_time` time(0) NOT NULL COMMENT '开始时间',
  `end_time` time(0) NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`movie_runtime_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_movie_runtime
-- ----------------------------

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource`  (
  `resource_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '资源id',
  `page_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面URL，用于保存页面地址',
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_resource
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource`;
CREATE TABLE `sys_role_resource`  (
  `role_id` bigint(0) UNSIGNED NOT NULL COMMENT '角色id',
  `resource_id` bigint(0) UNSIGNED NOT NULL COMMENT '资源id',
  PRIMARY KEY (`role_id`, `resource_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_resource
-- ----------------------------
INSERT INTO `sys_role_resource` VALUES (1, 1);
INSERT INTO `sys_role_resource` VALUES (1222, 144);

-- ----------------------------
-- Table structure for sys_session
-- ----------------------------
DROP TABLE IF EXISTS `sys_session`;
CREATE TABLE `sys_session`  (
  `session_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键场次id',
  `cinema_id` bigint(0) UNSIGNED NOT NULL COMMENT '影院id',
  `hall_id` bigint(0) UNSIGNED NOT NULL COMMENT '影厅id',
  `film_id` bigint(0) UNSIGNED NOT NULL COMMENT '电影id',
  `movie_runtime_id` bigint(0) UNSIGNED NOT NULL COMMENT '放映时段id',
  `movie_runtime_date` date NOT NULL COMMENT '排片日期',
  `price` decimal(10, 2) NOT NULL COMMENT '票价',
  `tips` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '影厅提示(如是否需要戴口罩，有什么福利，显示在选座购票位置的影厅后边，格式类似：6号Barco厅-（戴口罩勿饮食）凭票领券免费停车3小时)',
  `seats` json NOT NULL COMMENT '排片对应座位信息，采用数组存储每一个座位的状态，值为1表示可选，值为0表示已售出',
  PRIMARY KEY (`session_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_session
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户登录时所用的密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户邮箱，记录个人信息和发送通知',
  `phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户电话号码，用于注册和发送通知',
  `sex` tinyint(0) UNSIGNED NOT NULL COMMENT '用户性别，1为男性0为女性',
  `user_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户头像',
  `information` json NULL COMMENT '存储用户的基本信息，如生日、生活状态(生活状态用字符串表示)、兴趣(兴趣用id数组表示)、个性签名',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_hobby
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_hobby`;
CREATE TABLE `sys_user_hobby`  (
  `hobby_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '个人爱好id',
  `hobby_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '爱好名称',
  PRIMARY KEY (`hobby_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_hobby
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(0) UNSIGNED NOT NULL COMMENT '用户id',
  `role_id` bigint(0) UNSIGNED NOT NULL COMMENT '角色id',
  INDEX `用户id`(`user_id`) USING BTREE,
  INDEX `角色id`(`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
