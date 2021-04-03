/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : movie

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 04/04/2021 01:15:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for logging_event
-- ----------------------------
DROP TABLE IF EXISTS `logging_event`;
CREATE TABLE `logging_event`  (
  `timestmp` bigint(20) NOT NULL,
  `formatted_message` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `logger_name` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `level_string` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `thread_name` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reference_flag` smallint(6) NULL DEFAULT NULL,
  `arg0` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `arg1` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `arg2` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `arg3` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `caller_filename` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `caller_class` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `caller_method` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `caller_line` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `event_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`event_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logging_event
-- ----------------------------

-- ----------------------------
-- Table structure for logging_event_exception
-- ----------------------------
DROP TABLE IF EXISTS `logging_event_exception`;
CREATE TABLE `logging_event_exception`  (
  `event_id` bigint(20) NOT NULL,
  `i` smallint(6) NOT NULL,
  `trace_line` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`event_id`, `i`) USING BTREE,
  CONSTRAINT `logging_event_exception_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `logging_event` (`event_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logging_event_exception
-- ----------------------------

-- ----------------------------
-- Table structure for logging_event_property
-- ----------------------------
DROP TABLE IF EXISTS `logging_event_property`;
CREATE TABLE `logging_event_property`  (
  `event_id` bigint(20) NOT NULL,
  `mapped_key` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mapped_value` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`event_id`, `mapped_key`) USING BTREE,
  CONSTRAINT `logging_event_property_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `logging_event` (`event_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logging_event_property
-- ----------------------------

-- ----------------------------
-- Table structure for operating_record_log
-- ----------------------------
DROP TABLE IF EXISTS `operating_record_log`;
CREATE TABLE `operating_record_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求token',
  `member_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户id',
  `api_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '接口路径',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求方法',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operating_record_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_actor
-- ----------------------------
DROP TABLE IF EXISTS `sys_actor`;
CREATE TABLE `sys_actor`  (
  `actor_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '演员id',
  `actor_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '演员名字',
  `actor_photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '演员照片',
  `actor_height` decimal(10, 2) UNSIGNED NULL DEFAULT NULL COMMENT '演员身高',
  `actor_age` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '演员年龄',
  `actor_gender` tinyint(3) UNSIGNED NOT NULL COMMENT '演员性别,1为男，0为女',
  `actor_school` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业院校',
  `actor_nation` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '演员民族',
  `actor_blood_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '演员血型',
  `actor_constellation` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '演员信息',
  `actor_nationality` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '演员国籍',
  `actor_information` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '演员详细信息',
  PRIMARY KEY (`actor_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_actor
-- ----------------------------
INSERT INTO `sys_actor` VALUES (1, '张译', '[\"/images/actor/2020/12/15/38e18649714344e99f7b34bbb3de82e3.jpg\"]', 178.00, 42, 1, NULL, '汉族', ' A型', '水瓶座', '中国', '张译，1997年至2006年服役于北京军区政治部战友话剧团。2006年，主演电视剧《士兵突击》。2009年，主演抗战剧《我的团长我的团》，并凭借该角色获得2009中国电视榜“最深入人心电视形象”的荣誉；9月，主演孔笙执导的抗战剧《生死线》。2014年9月，主演打拐题材电影《亲爱的》，并凭借饰演的韩德忠一角获得第30届中国电影金鸡奖最佳男配角奖。2015年5月，主演电影《山河故人》。2016年9月，主演悬疑影片《追凶者也》，并凭借该片获得第八届中国电影导演协会年度男演员奖。2017年6月，凭借电视剧《鸡毛飞上天》获第23届上海电视节白玉兰奖最佳男主角奖。2018年2月16日，主演中国首部现代化海军题材电影《红海行动》全国上映，获得36亿的票房成绩。2019年1月，主演的剧情片《一秒钟》入围柏林电影节主竞赛单元，电影《攀登者》《我和我的祖国》于国庆档上映 。');
INSERT INTO `sys_actor` VALUES (2, '乔杉', '[\"/images/actor/2020/12/15/0bea348e519b4e19a9f4745275de1550.jpg\"]', 175.00, 36, 1, ' 中央戏剧学院表演系', '汉族', 'O型', '巨蟹座', '中国', '乔杉，演员，毕业于中央戏剧学院表演系。2010年，以爱笑兄弟的身份开始在辽宁卫视播出的综艺节目《谁是主角》中担任表演嘉宾。2012年，开始在系列网络喜剧《屌丝男士》中饰演大保健金牌会员。2014年，主演年代喜剧《傻儿传奇》。2015年4月，主演都市浪漫爱情电影《约定倒计时》；7月，因主演《三分之三场婚礼》而获得中国国际微电影节最佳男演员。2016年，参演《傻儿传奇之抗战到底》；同年，主演的电影《情圣》上映。2016年2月7日，在央视春晚联欢晚会上表演小品《快递小乔》；9月8日，宣布乔杉工作室暨杉宇文化传媒公司成立。2017年6月，其加盟的综艺《挑战的法则》播出；7月13日，其参演的电影《悟空传》上映；21日，其参演的电影《父子雄兵》上映；9月29日，其主演的喜剧电影《缝纫机乐队》上映。2018年2月17日，主演的都市轻喜剧《越活越来劲》播出。其他作品有《王者联盟》《爱笑会议室》《爱情的士》《大村官》《转型团伙》《欢乐喜剧人 第三季》《笑声传奇 第一季》《爱上试睡师》等。');
INSERT INTO `sys_actor` VALUES (3, '吴京', '[\"/images/actor/2020/12/15/fd0e1006adb14f39818608ef8ecfb988.jpg\"]', 175.00, 46, 1, '北京体育大学', '满族', 'A型', ' 白羊座', '中国', '吴京，著名功夫演员、导演、编剧，毕业于北京体育大学。1989年，进入北京市武术队。1994年，获得全国武术比赛精英赛枪术、对练冠军。1995年，参演个人首部电影《功夫小子闯情关》，正式进入演艺圈。1998年，主演电视剧《太极宗师》。1999年，出演袁和平导演的电视剧《小李飞刀》，并饰演阿飞一角。2001年，主演电视剧《江山儿女几多情》。2005年，参演叶伟信执导的电影《杀破狼》。2007年，凭借电影《男儿本色》获第44届台湾电影金马奖最佳男配角提名。2008年，自导自演电影《狼牙》。2010年，主演警匪动作电影《西风烈》。2012年，主演的电视剧《我是特种兵2》播出。2013年1月，获得搜狐时尚盛典年度时尚男明星奖。2014年5月11日，与主持人谢楠在北京举行结婚；8月25日，二人的儿子出生，取名吴所谓。2015年4月2日，自编自导自演的电影《战狼》在全国上映，并凭借该片荣获第20届华鼎奖最佳编剧奖、最佳新锐导演奖；6月18日，主演电影《杀破狼2》全国上映。2016年11月，当选中国文学艺术界联合会第十届全委会委员。2017年7月27日，执导并主演的电影《战狼2》上映，该片打破中国内地票房纪录以及全球单一市场单片票房纪录；11月12日，参演的电影《功守道》上映。2018年1月，荣获2017微博之夜年度导演奖；2月16日，主演的电影《祖宗十九代》全国上映；3月9日，参加的大型人文艺术类节目《信中国》播出。其他作品还有《分手大师》《危城》《大话西游3》等；参与的节目有《真星话大冒险 第一季》《春妮的周末时光》《开心剧乐部 第一季》等。');
INSERT INTO `sys_actor` VALUES (4, '刘浩存', '[\"/images/actor/2020/12/15/e6ac22bf74f344bd8d27e266bb21737d.jpg\"]', NULL, 20, 0, '北京舞蹈学院', '汉族', NULL, '金牛座', '中国', '刘浩存，中国内地影视女演员，毕业于北京舞蹈学院中国民族民间舞系。 2018年7月，还在上大学的刘浩存被张艺谋导演挖掘，成为首位“00后谋女郎”，与张译共同主演电影《一秒钟》，这也是她第一次担任电影女主角，该电影进入柏林电影节主竞赛单元。 2019年12月，刘浩存主演张艺谋导演执导电影《悬崖之上》，成为继巩俐、章子怡、周冬雨后又一位与张艺谋导演多次合作的“谋女郎”。 2020年6月，刘浩存主演的电影《送你一朵小红花》开机，该片由韩延导演执导、易烊千玺主演。');
INSERT INTO `sys_actor` VALUES (5, '金晨', '[\"/images/actor/2020/12/15/b12b7d473a0b4795a5f46252ea41635f.jpg\"]', 171.00, 30, 0, '北京舞蹈学院', ' 回族', ' B型', '处女座', '中国', '金晨，演员、模特，毕业于北京舞蹈学院民族舞专业。2011年1月，在古龙武侠剧《孔雀翎》中饰演后简，从此开始演艺事业；7月，与黎诺懿搭档参加舞蹈节目《舞动奇迹 第三季》，并获得冠军。2012年，在古装历史战争剧《楚汉争雄》中饰演虞姬。2013年，凭借主演的悬疑惊悚电影《诡拼车》提名第16届上海国际电影节传媒大奖最佳新人女演员。2014年5月2日，与王强联袂主演由陈冠龙执导的抗战剧《雪鹰》，并在剧中饰演乱世传奇女子洛雪。2015年7月，在玄幻剧《无心法师》中饰演女主角李月牙，并凭借该剧获得广泛关注；11月，在古装武侠剧《秦时明月》中饰演赤练。2016年2月8日，主演的古装玄幻剧《青丘狐传说》播出；3月，加盟明星旅行真人秀节目《花样姐姐 第二季》；5月23日，主演的古装玄幻剧《仙剑云之凡》首播；11月，在古装喜剧《极品家丁》中饰演萧玉若。2017年4月，出演了浪漫爱情喜剧片《傲娇与偏见》；5月，主演的电视剧《小情人》播出，在剧中饰演正值青春期的叛逆女孩单单单；6月，加盟的明星旅行体验类真人秀节目《花样的旅途》播出；7月，主演的网剧《鬼吹灯之牧野诡事》播出；同年，主演科幻剧《光明战纪》。2018年6月8日，主演的古装剧《萌妃驾到》在优酷视频独播；12月10日，参演的电视剧《大江大河》播出。2019年5月8日，主演的电视剧《我们都要好好的》播出。其他作品有《特警队》《桐柏英雄》《女医明妃传》《鬼吹灯之牧野诡事2》等。');
INSERT INTO `sys_actor` VALUES (6, ' 彭昱畅', '[\"/images/actor/2020/12/15/480e75c3a16c4acab09453cf387a66cb.jpg\"]', 178.00, 26, 1, '上海戏剧学院12级木偶表演系', ' 汉族', ' B型', '天蝎座', '中国', '彭昱畅，毕业于上海戏剧学院。2015年首次参演电视剧《太子妃升职记》，开启演艺之路。2016年在湖南卫视综艺节目《天天向上》中以“天天小兄弟”主持团成员之一身份登场；同年出演明星养成网络剧《明星志愿》和搜狐自制剧《刺客列传》；同年在都市玄幻网剧《器灵》中首次担任男主角。2017年主演青春励志电影《闪光少女》和青春励志剧《浪花一朵朵》。');
INSERT INTO `sys_actor` VALUES (7, ' 刘德华', '[\"/images/actor/2020/12/15/577678514b424481a23893b69fad082e.jpg\"]', 174.00, 59, 1, '可立中学,第十期无线艺员训练班', '汉族', ' AB型', '天秤座', '中国', '刘德华，歌手、演员、作词、制片人、监制，香港太平绅士，中国残疾人福利基金会副理事长，香港残疾人奥委会暨伤残人士体育协会副会长。曾获香港特别行政区荣誉勋章，是华人娱乐圈影、视、歌多栖发展的代表之一。作为歌手，他是90年代香港乐坛“四大天王”之一，吉尼斯世界纪录大全中获奖最多的香港歌手，《忘情水》《笨小孩》《爱你一万年》等均成为金曲佳作。作为演员，他曾因《暗战》《大块头有大智慧》等电影获香港电影金像奖最佳男主角。1981年，出演电影《彩云曲》。1985年，加入华星唱片公司；同年，发行首张个人专辑《只知道此刻爱你》。1989年2月，发行个人首张国语专辑《回到你身边·法内情》。1991年，创办天幕电影公司。2004年，凭借《无间道3:终极无间》获台湾金马奖最佳男主角；同年第六次获得十大劲歌金曲最受欢迎男歌星奖。2005年，获得香港UA院线颁发的“1985-2005年全港最高累积票房香港男演员”奖。2006年，获得釜山国际电影节亚洲最有贡献电影人奖。2008年6月23日，与朱丽倩注册结婚。2010年5月2日，获颁第12届世界杰出华人奖，同时获颁加拿大纽奔驰域蓝仕桥大学荣誉博士学位。2011年，主演剧情片《桃姐》，并凭借该片先后获得台湾金马奖最佳男主角奖、香港电影金像奖最佳男主角奖；同年，担任第49届台湾电影金马奖评审团主席。2012年5月9日，妻子朱丽倩生下一女。2013年1月16日，担任第7届亚洲电影大奖评审团主席；6月9日，主演的3D特工电影《富春山居图》在中国内地上映；同年，主演3D警匪动作片《风暴》。2014年5月，主演中国首部打拐题材的电影《失孤》，并凭借此片获得第16届中国电影华表奖优秀男演员奖。2015年，阔别十年再登央视羊年春晚，并演唱歌曲《回家的路》。2016年2月8日，主演的电影《澳门风云3》上映；10月1日，主演的喜剧动作片《王牌逗王牌》上映；同年，连任中国残疾人福利基金会副理事长，并参与填词的歌曲《原谅我》正式发行。2017年4月28日，主演并担任制作人的警匪动作片《拆弹专家》在中国内地上映，在片中饰演一名卧底拆弹专家；8月11日，主演的电影《侠盗联盟》中国内地上映；9月30日，主演的电影《追龙》上映；同年，作词并演唱歌曲《慢慢习惯》。影视作品还有《天狼劫》《盲探》《墨攻》《未来警察》《解救吾先生》《长城》《我的特工爷爷》《我的少女时代》等。');
INSERT INTO `sys_actor` VALUES (8, ' 陈立农', '[\"/images/actor/2020/12/15/41d2adfd444e4ff1a25452657f017e6b.jpg\"]', 185.00, 20, 1, NULL, NULL, ' A型', ' 天秤座', '中国', '陈立农，2000年10月3日出生于台湾省高雄市，中国台湾流行乐男歌手，男子演唱组合 NINE PERCENT成员。 2018年，参加爱奇艺偶像男团竞演养成类真人秀节目《 偶像练习生》，获得第2名，并加入男子演唱组合NINE PERCENT，从而正式出道；5月5日，随NINE PERCENT在上海举行“FAN MEETING TOUR-THX with LOVE”巡演首站；6月20日，为电影《 解码游戏》演唱的同名主题曲《 解码游戏》正式上线；9月，作为常驻嘉宾参加生活纪实观察类慢综艺《 Hi室友》；10月3日，推出个人抒情单曲《 我是你的》；11月20日，随NINE PERCENT推出组合首张音乐专辑《 TO THE NINES》。');
INSERT INTO `sys_actor` VALUES (9, ' 宋佳', '[\"/images/actor/2020/12/15/8e527c37e1b04fe5a589b5c06314c9ea.jpg\"]', 173.00, NULL, 0, '上海戏剧学院', ' 汉族', ' O型', '天蝎座', '中国', '宋佳，1980年11月13日出生于黑龙江省哈尔滨市南岗区，毕业于上海戏剧学院表演系，中国女演员、歌手，因有同名的前辈女演员宋佳，故多被媒体称为“小宋佳”。 2006年出演电影《好奇害死猫》开始崭露头角，并获第26届中国电影金鸡奖最佳女配角提名。 2012年凭借《悬崖》获第18届上海电视节最佳电视剧女演员奖及第9届中国金鹰电视艺术节最佳艺术表演女演员奖。 2013年凭借《萧红》获29届中国电影金鸡奖最佳女主角、第9届中美电影节金天使奖最佳女演员、第1届温哥华华语电影节红枫叶奖最佳女主角。 2015年12月10日，宋佳担任第21届上海电视节白玉兰奖电视剧单元评委。 2016年1月5日，联合国正式授予“联合国环境署可持续消费项目倡导者”称谓，宋佳成为首位被联合国授予官方身份的80后公众人物。同年9月7号，凭借《师父》荣获第20届华鼎奖中国最佳女主角奖。 2017年，主演电影《冰之下》入围第20届上海国际电影节。 2018年，宋佳当选第21届上海国际电影节“亚洲新人奖”国际影片评选委员会评委，任中国电影家协会第十届理事会理事，主演电影《诗人》入围第31届东京电影节主竞赛单元。 2019年，担任第13届FIRST青年电影展创投会评委。2019年12月16日，粤港澳大湾区电影行业大会暨电影之夜获得年度女主角。2019年12月19日，获得MAHB时尚先生盛典“年度电影演员”年度电影演员。 2020年02月，演唱文艺界抗击疫情主题MV《坚信爱会赢》。');
INSERT INTO `sys_actor` VALUES (10, '王彦霖', '[\"/images/actor/2020/12/15/2cd2bfc44d144b60acbc9d5e4dee8338.jpg\"]', 184.00, 31, 1, '上海戏剧学院', '汉族', 'B型', '狮子座', '中国', '王彦霖，中国内地新生代男演员，2012年毕业于上海戏剧学院表演系本科班，毕业后出演过多部话剧及影视剧作品。');
INSERT INTO `sys_actor` VALUES (11, '尹正', '[\"/images/actor/2020/12/15/3288ccae34964023983ec6ad880a71bc.jpg\"]', 178.00, 34, 1, ' 星海音乐学院', ' 汉族', 'O型', '摩羯座', '中国', '尹正，1986年12月30日出生，毕业于星海音乐学院流行音乐系2006级本科，中国内地男演员。 2011年，参演了中文版音乐剧《妈妈咪呀》。2012年，参演话剧《鹿鼎记》。2013年，在古装喜剧《 龙门镖局》中饰演“山鸡”一角，正式进入演艺圈。2014年，参演的奇幻惊悚题材好莱坞电影《 绝命航班》上映。2015年，主演校园励志电视剧《 红色青橄榄》，首次担任男主角；同年，主演喜剧电影《 夏洛特烦恼》；并主演悬爱侦探剧《 他来了，请闭眼》，凭借该剧获得第19届华鼎奖“最佳新锐演员”的称号。 2016年，主演民国谍战剧《 麻雀》，凭借苏三省一角色获得国剧盛典观众最喜爱的角色演员的荣誉。2017年，主演魔幻爱情喜剧《 大话西游之爱你一万年》；同年，主演悬疑动作片《 大侦探霍桑》。2018年，主演电视剧《 原生之罪》饰演陆离。');
INSERT INTO `sys_actor` VALUES (12, '陈思诚', '[\"/images/actor/2020/12/15/fa0718013075446cab59a00f29b8bdfb.jpg\"]', 180.00, 42, 1, ' 中央戏剧学院', '汉族', 'B型', '双鱼座', '中国', '陈思诚（原名陈思成）1978年2月22日生于辽宁省沈阳市，中国大陆男导演、演员、编剧。2001年凭第一部电影《法官妈妈》中张帅一角获得第八届电影“华表奖”最佳新人奖，第九届大学电影节最佳新人奖以及第二十五届百花奖最佳男演员奖的提名。2006年，因在电视剧《士兵突击》饰演角色“成才”而被大众熟知 ；同年，凭借电影《春风沉醉的夜晚》获第62届戛纳电影节最佳男演员奖提名 ；凭借《守望者：罪恶迷途》中“周栋”一角获第三届英国万像国际华语电影节“优秀男配角奖”。2012年，凭借其自编自导自演的电视剧《北京爱情故事》获得MSN新锐导演奖及乐视年度最期待导演等奖项。2014年，凭借自编自导自演的同名电影《北京爱情故事》获得第21届北京大学生电影节最佳导演处女作奖，该电影票房4.05亿。2015年，凭借其自编自导的电影《唐人街探案》获得第23届北京大学生电影节最佳编剧，该电影中国内地票房超8.24亿元。2018年，其自编自导的喜剧冒险探案系列电影《唐人街探案2》中国内地票房超33.8亿元。同年，担任监制和总编剧并主演电视剧《远大前程》。2018年10月，获颁首届“初心榜中国十大青年电视剧编剧”奖项。2019年1月20日，获得2018—2019中国文娱金数据发布盛典年度影响力编剧奖。');
INSERT INTO `sys_actor` VALUES (13, '佟丽娅', '[\"/images/actor/2020/12/15/41e4a4fb888742d79b04c14b3864674b.jpg\"]', 164.00, 37, 0, '中央戏剧学院', ' 锡伯族', 'A型', '狮子座', '中国', '佟丽娅，毕业于中央戏剧学院表演系04级本科班。锡伯族。2006年因出演尔冬升执导的情感剧《新不了情》而正式出道演艺圈。2011年因在电视剧《宫锁心玉》而走红。电视剧代表作有《怪侠一枝梅》《北京爱情故事》《平凡的世界》等。电影代表作有《全民目击》《智取威虎山》《谜城》等。凭借《平凡的世界》获得第21届上海电视节白玉兰奖最佳女主角提名。2018 年 6 月 23 日获得上海国际电影节最受传媒关注女主 角。');
INSERT INTO `sys_actor` VALUES (14, '杨幂', '[\"/images/actor/2020/12/15/24a9618b56ff4df7a74a067d4c512bda.jpg\"]', 168.00, 34, 0, '北京电影学院表演系', '汉族', 'B型', '处女座', '中国', '杨幂，1986年9月12日出生于北京市，中国内地影视女演员、流行乐歌手、影视制片人。2005年，杨幂进入北京电影学院表演系本科班就读。2006年，杨幂因出演金庸武侠剧《神雕侠侣》而崭露头角。2008年，杨幂凭借历史剧《王昭君》获得了第24届中国电视金鹰奖观众喜爱的电视剧女演员奖提名。2009年，杨幂在“80后新生代娱乐大明星”评选活动中与其她三位女演员共同被评为“四小花旦”。2011年，杨幂凭借穿越剧《宫锁心玉》赢得广泛关注，并获得了第17届上海电视节白玉兰奖观众票选最具人气女演员奖。2012年，杨幂工作室成立，而她则凭借都市剧《北京爱情故事》相继获得第9届金鹰电视艺术节最具人气女演员奖、第26届中国电视金鹰奖观众喜爱的电视剧女演员奖提名。2015年，杨幂主演的《小时代》系列电影取得了近18亿人民币的票房成绩。2016年，其主演的职场剧《亲爱的翻译官》取得全国年度电视剧收视冠军。2017年，杨幂主演的仙侠剧《三生三世十里桃花》获得颇高关注；同年，她还凭借科幻片《逆时营救》获得休斯顿国际电影节最佳女主角奖。');
INSERT INTO `sys_actor` VALUES (15, '迪丽热巴', '[\"/images/actor/2020/12/15/f1cd4a9370b04c5ca38340a90c4db079.jpg\"]', 168.00, NULL, 0, ' 上海戏剧学院', '维吾尔族', 'AB型', ' 双子座', '中国', '迪丽热巴，1992年6月3日出生于新疆乌鲁木齐市，中国内地影视女演员。2013年，因主演个人首部电视剧《阿娜尔罕》而出道。2014年，主演了奇幻剧《逆光之恋》。2015年，凭借爱情剧《克拉恋人》赢得高人气，并获得国剧盛典最受欢迎新人女演员奖。2016年，主演的现代剧《麻辣变形计》播出；同年，凭借喜剧片《傲娇与偏见》获得中英电影节最佳新人奖。2017年，因在玄幻剧《三生三世十里桃花》中饰演青丘白凤九而获得白玉兰奖最佳女配角提名。');
INSERT INTO `sys_actor` VALUES (16, ' 陈伟霆', '[\"/images/actor/2020/12/15/ab3cddcf04f74b84bf3c527fbfb53710.jpg\"]', 182.00, NULL, 1, '圣若瑟书院', '汉族', 'A型', '天蝎座', '中国', '陈伟霆（William Chan），出生于中国香港，华语影视男演员、歌手、主持人。2003年，因参加全球华人新秀香港区选拔赛而进入演艺圈 。2006年成为Sun Boy’z组合一员。2008年开始独立发展，随后推出个人首张专辑《Will Power》，并获香港十大劲歌金曲颁奖礼最受欢迎男新人金奖及香港十大中文金曲最有前途新人金奖 。 2013年，陈伟霆凭借灾难电影《救火英雄》获得澳门国际电影节最佳男配角奖。2014年，因主演古装仙侠偶像剧《古剑奇谭》被内地观众熟知，并获得国剧盛典年度最受欢迎全能艺人及年度电视剧媒体最期待演员；同年，他还因励志喜剧电影《男人不可以穷》获得英国万像国际华语电影节最佳青年男演员奖 。2015年，主演古装仙侠剧《蜀山战纪之剑侠传奇》 ，随后，凭借《古剑奇谭》入围上海电视节白玉兰奖最佳男配角提名 。2016年，其主演的民国悬疑剧《老九门》获得颇高关注；2017年，陈伟霆首次登上春晚演唱歌曲《爱你一万年》；同年，他还主演古装奇幻权谋剧《醉玲珑》。');
INSERT INTO `sys_actor` VALUES (17, '关晓彤', '[\"/images/actor/2020/12/15/c39fd63a52cf4949aa9ad0f3ff47f8aa.jpg\"]', 173.00, 23, 0, '北京电影学院表演系（在读）', ' 满族', 'O型', '处女座', '中国', '关晓彤，就读于北京电影学院表演系。2001年出演个人首部电视剧《烟海沉浮》，开启演艺生涯。2003年出演电影《电影往事》和《暖》。2005年因在奇幻动作片《无极》中饰演“小倾城”一角而成名。2007年出演古装剧《再生缘》。2008年因出演年代情感剧《幸福还有多远》而崭露头角。2009年出演寻宝探险片《刺陵》。2011年出演古装剧《孔子春秋》。2014年凭借都市情感剧《一仆二主》荣获国剧盛典观众喜爱的新人女演员奖。2015年出演古装传奇剧《班淑传奇》和青春校园网剧《老师晚上好》。电视剧代表作有《九州·天空城》《轩辕剑之汉之云》《极光之恋》等。电影代表作有《私人订制》《左耳》《浪漫天降》等。2017年主演古装言情剧《凤囚凰》和青春励志剧《甜蜜暴击》；同年凭借电视剧《好先生》获得第23届上海电视节最佳女配角奖。');
INSERT INTO `sys_actor` VALUES (18, ' 王宝强', '[\"/images/actor/2020/12/15/236137fdcec24986bc814b9771ca1610.jpg\"]', 165.00, 38, 1, ' 河南嵩山少林寺武术学院', '汉族', 'AB型', '金牛座', '中国', '王宝强，6岁时开始练习武术，8到14岁在嵩山少林寺做俗家弟子，之后来到北京闯天下，在各个剧组当武行做群众演员。16岁被李扬导演相中，参演独立电影《盲井》而崭露头角，并获得第40届台湾电影金马奖最佳新人奖。2004年因参演冯小刚的贺岁片《天下无贼》而被大众熟知。2008年凭借电视剧《士兵突击》大红大紫。代表作有电视剧《暗算》《士兵突击》《我的兄弟叫顺溜》等，电影《人在囧途》《Hello！树先生》《唐人街探案》等。凭借《Hello！树先生》获得第5届亚太电影大奖最佳男演员奖。凭借《一个人的武林》获得第34届香港电影金像奖最佳男配角奖提名。2016年，执导个人电影处女作《大闹天竺》；2016年8月14号，在个人官方微博发文宣布与马蓉解除婚约。');
INSERT INTO `sys_actor` VALUES (19, '程潇', '[\"/images/actor/2020/12/15/54668eee2db144d9934b3c35a088cff3.jpg\"]', 167.00, 22, 0, '首尔表演艺术高中', '汉族', 'B型', '巨蟹座', '中国', '程潇，1998年7月15日出生于广东省深圳市，中国内地流行乐女歌手，女子演唱组合 宇宙少女成员，毕业于深圳艺术学校。 2016年2月，程潇以宇宙少女WONDER组成员的身份出道，并随组合发行首张迷你专辑《WOULD YOU LIKE？》；3月，程潇随宇宙少女在中国出道；5月，随组合获得M-Countdown in China亚洲强音盛典最佳新人奖；8月，随组合发行第二张迷你专辑《 THE SECRET》。2017年1月，程潇随宇宙少女推出第三张迷你专辑《From. WJSN》；4月，程潇获得第十七届音乐风云榜年度盛典”偶像新势力“奖。');
INSERT INTO `sys_actor` VALUES (20, '曾茂军', '[\"/images/actor/2020/12/15/55136c5750754172b38d7eb74ff236bd.jpg\"]', NULL, 49, 1, '中国人民大学', NULL, NULL, NULL, '中国', '曾茂军，男，1971年出生。毕业于中国人民大学，工商管理硕士学位，工程师。1994年起历任北京航空材料研究院工程师，北京百慕航材高科技股份有限公司人力资源部部长，恒宝股份有限公司助理总裁。2006年加入万达集团，历任万达集团人力资源部副总经理，万达酒店建设有限公司副总经理，万达商业管理有限公司副总经理，万达电影常务副总经理，2014年3月任万达电影董事、总裁。2017年万达影视集团成立后，任万达影视集团总裁兼万达电影总裁。2019年兼任万达影视法定代表人、执行董事及经理。');
INSERT INTO `sys_actor` VALUES (21, '郑志昊', '[\"/images/actor/2020/12/15/c97cfde7f9024504bc8b27b91eb1dd90.jpg\"]', NULL, NULL, 1, '美国肯塔基大学计算机硕士学位', '汉', NULL, '摩羯座', '中国', '郑志昊，在出任猫眼CEO前，曾任美团大众点评平台事业群总裁、大众点评总裁和腾讯副总裁。加入腾讯前曾负责微软MSN Space、Expo和Shopping等在中国的产品和研发，还曾在Intel、波音等国际知名企业从事研发和管理工作。 郑志昊拥有丰富的互联网公司管理经验，多年以来成功领导了微软MSN Spaces、腾讯QQ空间、腾讯社交平台、腾讯开放平台、腾讯广点通、新美大平台事业群等重要业务的创新。 现在，他正带领新猫眼朝“互联网+”综合娱乐平台的发展目标，展开商业模式、生态与产业链创新。 郑先生拥有美国肯塔基大学计算机硕士学位，美国西北理工大学工商管理硕士学位，以及中国山东大学学士学位。');
INSERT INTO `sys_actor` VALUES (22, '姜伟', '[\"/images/actor/2020/12/15/9ddfdedcb7e24a5391282109dfd49416.jpg\"]', NULL, NULL, 1, NULL, '汉族', NULL, '水瓶座', '中国', '姜伟，1994年4月加入索尼公司。1997年初开始，在索尼影视娱乐公司负责公司电影在中国大陆的发行，参与策划发行电影《卧虎藏龙》。2001年6月加入香港安乐影片有限公司，任中国区总代表，负责经营管理中国大陆地区百老汇影院。2005年出任安乐（北京）电影发行有限公司总经理，负责公司电影在大陆发行，并代理美国环球影片公司电影在中国大陆地区的发行工作，同时任职中国电影发行放映协会城市影院分会副会长职务。期间参与制作并发行影片《霍元甲》、《功夫》、《不能说的秘密》、《色戒》、《木乃伊3》、《非常完美》、《海洋天堂》、《北京遇上西雅图》、《寒战》等优秀华语影片，并成功在中国大陆地区引进发行电影《憨豆的黄金周》、《谍影重重3、4》、《贫民窟的百万富翁》、《速度与激情5、6》、《夺命深渊》、《三傻大闹宝莱坞》、《悲惨世界》、《侏罗纪公园3D》等，获得极佳的票房与口碑。2013年9月出任引力影视投资有限公司执行董事，成功制作并发行《痞子英雄2》、《匆匆那年》、《有一个地方只有我们知道》、《咱们结婚吧》等影片，并开发制作与华纳兄弟影业联合制作的全球电影《巨齿鲨》。2016年10月，正式出任邵氏兄弟控股有限公司执行董事。');
INSERT INTO `sys_actor` VALUES (23, ' 杜杰', '[\"/images/actor/2020/12/15/6b6957b25e2a437a80009906e0645896.jpg\"]', NULL, 44, 1, '北京电影学院摄影系', NULL, NULL, '处女座', '中国', '杜杰，1976年9月出生于河北省，1997年毕业于中央美术学院附中，2001年毕业于北京电影学院摄影系本科。 自2004年杜杰与中国著名导演宁浩相继合作拍摄电影《绿草地》《疯狂的石头》《疯狂的赛车》《无人区》逐渐成为中国当代最为活跃的一线年轻摄影师 随着中国电影市场的繁荣，杜杰与其它多位导演共同拍摄多部获得极大商业成功的电影，包括：《唐人街探案1》、《唐人街探案2》《厨子戏子痞子》《大笑江湖》《分手大师》等，其中取景纽约拍摄的《唐人街探案2》更是取得了33亿元人民币的中国影史第三高票房的成绩。 在拍摄商业电影的同时，杜杰也同时拍摄了一些极具价值的艺术电影，包括：《罗曼蒂克消亡史》《雪暴》《转山》《静静的玛尼石》《走着瞧》《边境风云》等。');
INSERT INTO `sys_actor` VALUES (24, '李淼', '[\"/images/actor/2020/12/15/7ad9949c113143d58079ad0e582544f4.jpg\"]', NULL, NULL, 1, '中国传媒大学', NULL, NULL, ' 射手座', '中国', '李淼，电影美术指导、造型指导，2004年毕业于中国传媒大学戏剧影视美术专业。 代表作品：《唐人街探案1》，《唐人街探案2》，《我不是药神》，《嫌疑人X的献身》，《左耳》，《天台爱情》等');
INSERT INTO `sys_actor` VALUES (25, '王钢', '[\"/images/actor/2020/12/15/3397f270491049e386178c7464a06876.jpg\"]', 165.00, 47, 1, NULL, NULL, 'O型', NULL, '中国', '王钢，男，国家中影数字制作基地后期制作公司录音指导、声音设计、混录师。代表作品有《夜店》、《无人区》、《王的盛宴》、《让子弹飞》、《决战刹马镇》、《我愿意》、《中国合伙人》等。2011年《让子弹飞》获得第48届台湾电影金马奖最佳音效提名。2013年《画皮Ⅱ》获得2012年度中国电影电视技术学会声音制作优秀作品奖一等奖。2014年《温故一九四二》获得2013年度中国电影电视技术学会声音制作优秀作品奖一等奖。2015年《无人区》获得2014年度中国电影电视技术学会声音制作优秀作品奖一等奖。2014年《一代宗师》获得第61届美国音效剪辑者协会（MPSE）“金卷轴”奖（Golden Reel Awards）最佳外语片音效剪辑奖。2015年《狼图腾》获得第30届中国电影金鸡奖最佳录音提名。2018年《绣春刀Ⅱ：修罗战场》获得第12届亚洲电影大奖最佳音响提名。2019年《动物世界》获得第32届中国电影金鸡奖最佳录音提名。');

-- ----------------------------
-- Table structure for sys_actor_movie
-- ----------------------------
DROP TABLE IF EXISTS `sys_actor_movie`;
CREATE TABLE `sys_actor_movie`  (
  `movie_id` bigint(20) UNSIGNED NOT NULL COMMENT '电影id',
  `actor_id` bigint(20) UNSIGNED NOT NULL COMMENT '演员id',
  `actor_role_Id` bigint(20) UNSIGNED NOT NULL COMMENT '参演角色id',
  PRIMARY KEY (`movie_id`, `actor_id`, `actor_role_Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_actor_movie
-- ----------------------------
INSERT INTO `sys_actor_movie` VALUES (1, 1, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 2, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 3, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 4, 3);
INSERT INTO `sys_actor_movie` VALUES (1, 6, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 7, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 8, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 9, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 10, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 11, 1);
INSERT INTO `sys_actor_movie` VALUES (1, 13, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 15, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 17, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 20, 4);
INSERT INTO `sys_actor_movie` VALUES (1, 21, 6);
INSERT INTO `sys_actor_movie` VALUES (1, 22, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 22, 8);
INSERT INTO `sys_actor_movie` VALUES (1, 23, 2);
INSERT INTO `sys_actor_movie` VALUES (1, 24, 12);
INSERT INTO `sys_actor_movie` VALUES (1, 25, 14);
INSERT INTO `sys_actor_movie` VALUES (2, 3, 2);
INSERT INTO `sys_actor_movie` VALUES (2, 4, 2);
INSERT INTO `sys_actor_movie` VALUES (2, 5, 2);
INSERT INTO `sys_actor_movie` VALUES (2, 6, 2);
INSERT INTO `sys_actor_movie` VALUES (2, 9, 2);
INSERT INTO `sys_actor_movie` VALUES (2, 11, 2);
INSERT INTO `sys_actor_movie` VALUES (2, 21, 12);
INSERT INTO `sys_actor_movie` VALUES (2, 22, 1);
INSERT INTO `sys_actor_movie` VALUES (2, 22, 3);
INSERT INTO `sys_actor_movie` VALUES (2, 23, 14);
INSERT INTO `sys_actor_movie` VALUES (2, 24, 10);
INSERT INTO `sys_actor_movie` VALUES (3, 5, 1);
INSERT INTO `sys_actor_movie` VALUES (3, 6, 2);
INSERT INTO `sys_actor_movie` VALUES (3, 7, 2);
INSERT INTO `sys_actor_movie` VALUES (3, 8, 2);
INSERT INTO `sys_actor_movie` VALUES (3, 9, 2);
INSERT INTO `sys_actor_movie` VALUES (3, 11, 3);
INSERT INTO `sys_actor_movie` VALUES (3, 13, 4);
INSERT INTO `sys_actor_movie` VALUES (3, 15, 7);
INSERT INTO `sys_actor_movie` VALUES (3, 21, 8);
INSERT INTO `sys_actor_movie` VALUES (4, 2, 1);
INSERT INTO `sys_actor_movie` VALUES (4, 3, 2);
INSERT INTO `sys_actor_movie` VALUES (5, 1, 2);
INSERT INTO `sys_actor_movie` VALUES (5, 5, 1);
INSERT INTO `sys_actor_movie` VALUES (6, 1, 1);
INSERT INTO `sys_actor_movie` VALUES (6, 2, 2);
INSERT INTO `sys_actor_movie` VALUES (7, 10, 1);
INSERT INTO `sys_actor_movie` VALUES (7, 12, 2);
INSERT INTO `sys_actor_movie` VALUES (8, 5, 1);
INSERT INTO `sys_actor_movie` VALUES (8, 11, 2);
INSERT INTO `sys_actor_movie` VALUES (8, 14, 2);
INSERT INTO `sys_actor_movie` VALUES (8, 15, 2);
INSERT INTO `sys_actor_movie` VALUES (8, 16, 2);
INSERT INTO `sys_actor_movie` VALUES (8, 17, 2);
INSERT INTO `sys_actor_movie` VALUES (8, 18, 2);
INSERT INTO `sys_actor_movie` VALUES (8, 19, 3);
INSERT INTO `sys_actor_movie` VALUES (8, 20, 4);
INSERT INTO `sys_actor_movie` VALUES (9, 1, 1);
INSERT INTO `sys_actor_movie` VALUES (9, 2, 2);
INSERT INTO `sys_actor_movie` VALUES (10, 3, 1);
INSERT INTO `sys_actor_movie` VALUES (10, 6, 2);
INSERT INTO `sys_actor_movie` VALUES (11, 3, 1);
INSERT INTO `sys_actor_movie` VALUES (11, 13, 2);
INSERT INTO `sys_actor_movie` VALUES (12, 5, 1);
INSERT INTO `sys_actor_movie` VALUES (12, 20, 2);
INSERT INTO `sys_actor_movie` VALUES (13, 8, 1);
INSERT INTO `sys_actor_movie` VALUES (13, 14, 2);
INSERT INTO `sys_actor_movie` VALUES (14, 3, 1);
INSERT INTO `sys_actor_movie` VALUES (14, 3, 2);
INSERT INTO `sys_actor_movie` VALUES (14, 5, 2);
INSERT INTO `sys_actor_movie` VALUES (14, 6, 2);
INSERT INTO `sys_actor_movie` VALUES (14, 7, 2);
INSERT INTO `sys_actor_movie` VALUES (15, 1, 1);
INSERT INTO `sys_actor_movie` VALUES (15, 3, 2);
INSERT INTO `sys_actor_movie` VALUES (16, 1, 1);
INSERT INTO `sys_actor_movie` VALUES (16, 3, 2);
INSERT INTO `sys_actor_movie` VALUES (16, 5, 7);
INSERT INTO `sys_actor_movie` VALUES (17, 15, 2);
INSERT INTO `sys_actor_movie` VALUES (17, 17, 1);
INSERT INTO `sys_actor_movie` VALUES (18, 5, 1);
INSERT INTO `sys_actor_movie` VALUES (18, 7, 2);
INSERT INTO `sys_actor_movie` VALUES (19, 16, 2);
INSERT INTO `sys_actor_movie` VALUES (19, 20, 1);
INSERT INTO `sys_actor_movie` VALUES (20, 16, 2);
INSERT INTO `sys_actor_movie` VALUES (20, 18, 1);

-- ----------------------------
-- Table structure for sys_actor_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_actor_role`;
CREATE TABLE `sys_actor_role`  (
  `actor_role_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '参演角色id',
  `actor_role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参演角色名称',
  PRIMARY KEY (`actor_role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_actor_role
-- ----------------------------
INSERT INTO `sys_actor_role` VALUES (1, '导演');
INSERT INTO `sys_actor_role` VALUES (2, '演员');
INSERT INTO `sys_actor_role` VALUES (3, '编剧');
INSERT INTO `sys_actor_role` VALUES (4, '制片人');
INSERT INTO `sys_actor_role` VALUES (6, '摄影指导');
INSERT INTO `sys_actor_role` VALUES (7, '摄影师');
INSERT INTO `sys_actor_role` VALUES (8, '美术指导');
INSERT INTO `sys_actor_role` VALUES (9, '录音指导');
INSERT INTO `sys_actor_role` VALUES (10, '剪辑师');
INSERT INTO `sys_actor_role` VALUES (11, '作曲');
INSERT INTO `sys_actor_role` VALUES (12, '音乐');
INSERT INTO `sys_actor_role` VALUES (13, '副导演');
INSERT INTO `sys_actor_role` VALUES (14, '音效');
INSERT INTO `sys_actor_role` VALUES (15, '其他');

-- ----------------------------
-- Table structure for sys_bill
-- ----------------------------
DROP TABLE IF EXISTS `sys_bill`;
CREATE TABLE `sys_bill`  (
  `bill_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `bill_state` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单状态，1表示已完成，0表示未支付',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `session_id` bigint(20) UNSIGNED NOT NULL COMMENT '场次id',
  `seats` json NOT NULL COMMENT '购买的座位号，可能为多个，使用json传输',
  `bill_date` datetime(0) NOT NULL COMMENT '订单日期',
  PRIMARY KEY (`bill_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_bill
-- ----------------------------
INSERT INTO `sys_bill` VALUES (1, 1, 1, 17, '[\"1排4号\", \"1排1号\"]', '2020-11-30 16:44:02');
INSERT INTO `sys_bill` VALUES (2, 1, 1, 16, '[\"3排4号\", \"2排5号\"]', '2020-12-24 16:15:04');
INSERT INTO `sys_bill` VALUES (3, 1, 2, 6, '[\"3排4号\", \"2排5号\"]', '2020-12-01 16:42:33');
INSERT INTO `sys_bill` VALUES (4, 1, 3, 4, '[\"2排5号\", \"2排6号\", \"2排7号\", \"2排8号\"]', '2020-12-03 21:47:31');
INSERT INTO `sys_bill` VALUES (6, 1, 1, 19, '[\"3排4号\", \"2排5号\"]', '2020-11-30 16:42:33');

-- ----------------------------
-- Table structure for sys_cinema
-- ----------------------------
DROP TABLE IF EXISTS `sys_cinema`;
CREATE TABLE `sys_cinema`  (
  `cinema_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '影院id',
  `cinema_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '影院名',
  `cinema_brand_id` bigint(20) UNSIGNED NOT NULL COMMENT '影院品牌id',
  `cinema_picture` json NULL COMMENT '影院图片，json类型存储多张图片',
  `is_ticket_changed` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '能否改签，1表示可以，0表示不能',
  `is_refunded` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '能否退款，1表示可以，0表示不能',
  `cinema_area_id` bigint(20) UNSIGNED NOT NULL COMMENT '所属区域id',
  `cinema_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '联系人(负责人)id',
  `entry_date` date NULL DEFAULT NULL COMMENT '影院入驻日期',
  PRIMARY KEY (`cinema_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_cinema
-- ----------------------------
INSERT INTO `sys_cinema` VALUES (1, '万达影城（经开万达广场店）', 1, '[\"/images/cinema/2020/12/15/7637f53964374e1294732dd37509648a.jpg\", \"/images/cinema/2020/12/15/32865c43eb424de08d1c2c65e0588f10.jpg\"]', 1, 0, 2, '金州区经济技术开发区辽河西路117号万达广场四楼', 1, '2020-02-02');
INSERT INTO `sys_cinema` VALUES (2, '万达影城（港汇店）', 1, '[\"/images/cinema/2020/12/15/e55fa50224ce42caa0e1b1871663fb79.jpg\", \"/images/cinema/2020/12/15/4f18270b91ea47e691d4f2e71321ec89.jpg\", \"/images/cinema/2020/12/15/de03f508ee8f4c0181254bcf9cc5a2ab.jpg\"]', 1, 0, 3, '中山区天津街国泰港汇中心6层（新世界百货西侧）', 2, '2019-02-13');
INSERT INTO `sys_cinema` VALUES (3, '中影华臣影城（黑石礁富丽庭店）', 2, '[\"/images/cinema/2020/12/15/4bfaf8909ea845139b176ae0c60d152b.jpg\", \"/images/cinema/2020/12/15/a8a9ce5f97fc4e8f94af491981e0098f.jpg\"]', 1, 1, 4, '沙河口区中山路673号富丽庭生活广场3F', 3, '2019-12-27');
INSERT INTO `sys_cinema` VALUES (4, '博纳国际影城IMAX（中央大道店）', 3, '[\"/images/cinema/2020/12/15/04e185afd6a8457a9f960240af8cbebe.jpg\"]', 1, 0, 4, '沙河口区西安路103号中央大道旅游购物中心5层', 4, '2018-12-12');
INSERT INTO `sys_cinema` VALUES (5, '苏宁影城（亿锋广场店）', 8, '[\"/images/cinema/2020/12/15/f0e69a1d126c42be951337251884a8a6.jpg\"]', 1, 1, 2, '金州区开发区金马路169号亿锋苏宁易购2层苏宁影城', 5, '2020-05-19');
INSERT INTO `sys_cinema` VALUES (6, '上影国际影城（百年港湾IMAX店）', 12, '[\"/images/cinema/2020/12/15/5d8a4ae389b44cf3af73587259a47c02.jpg\"]', 1, 1, 8, '西岗区香炉礁百年港湾奥特莱斯A2区2楼', 6, '2020-10-06');
INSERT INTO `sys_cinema` VALUES (7, '百丽宫（LUXE巨幕）影城恒隆广场店', 16, '[\"/images/cinema/2020/12/15/730319251df54095b3d54a908d78534a.jpg\", \"/images/cinema/2020/12/15/65c44173e32c469dbac7d075b7c49dda.jpg\"]', 1, 0, 8, '西岗区五四路66号恒隆广场4层', 7, '2020-02-07');
INSERT INTO `sys_cinema` VALUES (8, '橙天嘉禾影城（万和汇店）', 11, '[\"/images/cinema/2020/12/15/c02cb0c58a5e4c469bdb2dea83ef16eb.jpg\", \"/images/cinema/2020/12/15/4dad1006d9b24ee8b72115b57949fcf2.jpg\", \"/images/cinema/2020/12/15/5e85858b73aa40c2b65be423d09ca71e.jpg\"]', 1, 1, 2, '金州区开发区金马路万和汇购物广场4-5楼', 9, '2020-07-16');
INSERT INTO `sys_cinema` VALUES (9, 'CGV影城（东港IMAX店）', 6, '[\"/images/cinema/2020/12/15/6e24bb8ca77a4ba29c03fc4b461153e1.jpg\", \"/images/cinema/2020/12/15/1f3f8b869c174c35ba314c5169dc2cf8.jpg\", \"/images/cinema/2020/12/15/d81a78634dd94d2d891664a5a1fa8381.jpg\"]', 0, 0, 3, '中山区长江东路80号凯丹购物广场4层', 10, '2020-12-01');
INSERT INTO `sys_cinema` VALUES (10, ' 中影北方国际影城', 18, '[\"/images/cinema/2020/12/15/1f5bf7570a6f4a2db9155b39c4346f96.jpg\"]', 1, 1, 1, '甘井子区泉水瑞沃广场3楼', 11, '2020-11-13');
INSERT INTO `sys_cinema` VALUES (11, '佳兆业国际影城（佳兆业店）', 18, '[\"/images/cinema/2020/12/15/01afb74db476472e913285607d2f0e11.jpg\", \"/images/cinema/2020/12/15/f2a709ff33774840930a85fca3cfe331.jpg\"]', 1, 1, 3, '中山区天津街271号佳兆业广场3楼L301号（近新世界百货）', 12, '2020-10-12');

-- ----------------------------
-- Table structure for sys_cinema_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_cinema_area`;
CREATE TABLE `sys_cinema_area`  (
  `cinema_area_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键区域id',
  `province` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区域所属省份',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区域所属市',
  `cinema_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区域名称',
  PRIMARY KEY (`cinema_area_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_cinema_area
-- ----------------------------
INSERT INTO `sys_cinema_area` VALUES (1, '辽宁省', '大连市', '甘井子区');
INSERT INTO `sys_cinema_area` VALUES (2, '辽宁省', '大连市', '金州区');
INSERT INTO `sys_cinema_area` VALUES (3, '辽宁省', '大连市', '中山区');
INSERT INTO `sys_cinema_area` VALUES (4, '辽宁省', '大连市', '沙河口区');
INSERT INTO `sys_cinema_area` VALUES (5, '辽宁省', '大连市', '瓦房店市');
INSERT INTO `sys_cinema_area` VALUES (6, '辽宁省', '大连市', '普兰店市');
INSERT INTO `sys_cinema_area` VALUES (7, '辽宁省', '大连市', '旅顺口区');
INSERT INTO `sys_cinema_area` VALUES (8, '辽宁省', '大连市', '西岚区');
INSERT INTO `sys_cinema_area` VALUES (9, '辽宁省', '大连市', '庄河市');
INSERT INTO `sys_cinema_area` VALUES (10, '辽宁省', '大连市', '长海县');
INSERT INTO `sys_cinema_area` VALUES (11, '辽宁省', '大连市', '金石滩');

-- ----------------------------
-- Table structure for sys_cinema_brand
-- ----------------------------
DROP TABLE IF EXISTS `sys_cinema_brand`;
CREATE TABLE `sys_cinema_brand`  (
  `cinema_brand_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '影院品牌id',
  `cinema_brand_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '影院品牌名称',
  PRIMARY KEY (`cinema_brand_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_cinema_brand
-- ----------------------------
INSERT INTO `sys_cinema_brand` VALUES (1, '万达影城');
INSERT INTO `sys_cinema_brand` VALUES (2, '华臣影城');
INSERT INTO `sys_cinema_brand` VALUES (3, '博纳国际影城');
INSERT INTO `sys_cinema_brand` VALUES (4, '金逸影城');
INSERT INTO `sys_cinema_brand` VALUES (5, '中影星感觉影城');
INSERT INTO `sys_cinema_brand` VALUES (6, 'CGV影城');
INSERT INTO `sys_cinema_brand` VALUES (7, '大地影院');
INSERT INTO `sys_cinema_brand` VALUES (8, '苏宁影城');
INSERT INTO `sys_cinema_brand` VALUES (9, '中影星美国际影城');
INSERT INTO `sys_cinema_brand` VALUES (10, '今世界影城');
INSERT INTO `sys_cinema_brand` VALUES (11, '橙天嘉禾影城');
INSERT INTO `sys_cinema_brand` VALUES (12, '上影国际影城');
INSERT INTO `sys_cinema_brand` VALUES (13, '大商影城');
INSERT INTO `sys_cinema_brand` VALUES (14, '米高梅国际影城');
INSERT INTO `sys_cinema_brand` VALUES (15, '恒大嘉凯影城');
INSERT INTO `sys_cinema_brand` VALUES (16, '百丽宫影城');
INSERT INTO `sys_cinema_brand` VALUES (17, '明星时代影城');
INSERT INTO `sys_cinema_brand` VALUES (18, '其他');

-- ----------------------------
-- Table structure for sys_hall
-- ----------------------------
DROP TABLE IF EXISTS `sys_hall`;
CREATE TABLE `sys_hall`  (
  `cinema_id` bigint(20) UNSIGNED NOT NULL COMMENT '影院id',
  `hall_id` bigint(20) UNSIGNED NOT NULL COMMENT '影厅id',
  `hall_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '影厅名称',
  `hall_category_id` bigint(20) UNSIGNED NOT NULL COMMENT '影厅类别id',
  `row_start` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '排开始编号，如1排/A排，默认1排',
  `row_nums` smallint(5) UNSIGNED NULL DEFAULT 10 COMMENT '排数，默认10',
  `seat_nums_row` smallint(5) UNSIGNED NULL DEFAULT 18 COMMENT '每排的座位数，默认18',
  `seat_nums` smallint(5) UNSIGNED NULL DEFAULT 180 COMMENT '总可用座位数，用于判断影厅是否做满，默认180',
  `seat_state` json NULL COMMENT '所有座位的状态，0表示可用，1表示禁用，2表示售出，在场次表中体现',
  `hall_state` tinyint(4) NULL DEFAULT NULL COMMENT '影厅状态，1表示启用，0表示未启用',
  PRIMARY KEY (`cinema_id`, `hall_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_hall
-- ----------------------------
INSERT INTO `sys_hall` VALUES (1, 1, '1号激光厅', 1, '1', 10, 10, 94, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (1, 2, '2号厅', 2, '1', 10, 18, 160, '{\"1\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"2\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"3\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"4\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"5\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"6\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"7\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"8\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"9\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"10\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (1, 3, '3号厅', 4, '1', 7, 7, 49, '{\"1\": [0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (1, 4, '4号厅', 7, '1', 15, 18, 270, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (1, 5, '5号厅', 10, '1', 10, 10, 92, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"8\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"9\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"10\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1]}', 1);
INSERT INTO `sys_hall` VALUES (1, 6, '6号厅', 14, '1', 20, 18, 360, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"16\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"17\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"18\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"19\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"20\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (1, 7, '7号IMAX4D厅', 15, '1', 15, 18, 246, '{\"1\": [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1], \"2\": [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], \"3\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"14\": [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], \"15\": [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1]}', 1);
INSERT INTO `sys_hall` VALUES (2, 1, '1号厅', 1, '1', 10, 18, 170, '{\"1\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (2, 2, '2号IMAX厅', 2, '1', 18, 18, 324, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"16\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"17\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"18\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (3, 1, '1号激光厅', 1, '1', 15, 16, 210, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (3, 2, '2号厅', 14, '1', 15, 25, 346, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"9\": [0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"10\": [0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"11\": [0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"12\": [0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"13\": [0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"14\": [0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], \"15\": [0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (4, 1, '1号厅', 3, '1', 15, 20, 300, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (4, 2, '2号激光厅', 1, '1', 15, 10, 150, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (5, 1, '1号儿童厅', 11, '1', 10, 10, 100, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 1);
INSERT INTO `sys_hall` VALUES (5, 2, '2号60帧厅', 13, '1', 10, 10, 100, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 1);

-- ----------------------------
-- Table structure for sys_hall_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_hall_category`;
CREATE TABLE `sys_hall_category`  (
  `hall_category_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '影厅类别ID',
  `hall_category_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '影厅类别名称',
  PRIMARY KEY (`hall_category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_hall_category
-- ----------------------------
INSERT INTO `sys_hall_category` VALUES (1, '激光厅');
INSERT INTO `sys_hall_category` VALUES (2, 'IMAX厅');
INSERT INTO `sys_hall_category` VALUES (3, 'CGS中国巨幕厅');
INSERT INTO `sys_hall_category` VALUES (4, '杜比全景声厅');
INSERT INTO `sys_hall_category` VALUES (5, 'Dolby Cinema厅');
INSERT INTO `sys_hall_category` VALUES (6, 'RealD厅');
INSERT INTO `sys_hall_category` VALUES (7, 'RealD 6FLag厅');
INSERT INTO `sys_hall_category` VALUES (8, 'LUXE巨幕厅');
INSERT INTO `sys_hall_category` VALUES (9, '4DX厅');
INSERT INTO `sys_hall_category` VALUES (10, 'DTS:X 临镜音厅');
INSERT INTO `sys_hall_category` VALUES (11, '儿童厅');
INSERT INTO `sys_hall_category` VALUES (12, '4K厅');
INSERT INTO `sys_hall_category` VALUES (13, '60帧厅');
INSERT INTO `sys_hall_category` VALUES (14, '巨幕厅');
INSERT INTO `sys_hall_category` VALUES (15, 'MX4D厅');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `params` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `start_time` timestamp(0) NULL DEFAULT NULL COMMENT '操作时间',
  `spend_time` int(11) NULL DEFAULT NULL COMMENT '执行时间（ms）',
  `base_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '根路径',
  `req_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求路径',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `req_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求类型',
  `user_agent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户标识',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `result` tinyint(255) NULL DEFAULT NULL COMMENT '结果',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 176 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_movie
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie`;
CREATE TABLE `sys_movie`  (
  `movie_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键电影id',
  `movie_name_cn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电影中文名',
  `movie_name_en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电影英文名',
  `movie_length` int(11) NULL DEFAULT NULL COMMENT '电影时长(单位: 分钟)',
  `movie_poster` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电影海报',
  `movie_area_id` bigint(20) UNSIGNED NOT NULL COMMENT '电影区域id',
  `movie_age_id` bigint(20) UNSIGNED NOT NULL COMMENT '影片年代id',
  `release_date` datetime(0) NULL DEFAULT NULL COMMENT '上映时间',
  `movie_score` decimal(3, 1) UNSIGNED NOT NULL DEFAULT 0.0 COMMENT '电影评分',
  `movie_box_office` decimal(20, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '电影总票房',
  `movie_rate_num` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '评分人数',
  `movie_introduction` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电影简介',
  `movie_pictures` json NULL COMMENT '电影图集',
  PRIMARY KEY (`movie_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie
-- ----------------------------
INSERT INTO `sys_movie` VALUES (1, '送你一朵小红花', 'A Little Red Flower', 128, '[\"/images/movie/2020/12/15/4425e22bc1264164a2fbdd01d56cd939.jpg\"]', 1, 1, '2020-12-31 18:00:00', 8.6, 0.00, 7, '两个抗癌家庭，两组生活轨迹。影片讲述了一个温情的现实故事，思考和直面了每一个普通人都会面临的终极问题——想象死亡随时可能到来，我们唯一要做的就是爱和珍惜。', '[\"/images/movie/2020/12/15/2886b23c40ba4c57829c8938b10aeedb.jpg\", \"/images/movie/2020/12/15/00733b7ceb284b26ac43fa93f20fd991.jpg\", \"/images/movie/2020/12/15/208998f6cd4e410f85db05631faca4c4.jpg\", \"/images/movie/2020/12/15/16fabc3258a843f28beccab37041fa80.jpg\"]');
INSERT INTO `sys_movie` VALUES (2, '如果声音不记得', 'The End of Endless Love', 102, '[\"/images/movie/2020/12/15/9fc80b23da4847cc8a98c65abb14148f.jpg\"]', 1, 1, '2020-12-04 00:00:00', 7.2, 0.00, 7, '如果你喜欢的女孩，得了抑郁症，你该怎么办？辛唐（孙晨竣 饰）拥有通过声音给他人制造快乐的能力，但对同一人使用三次后，性命就会和此人绑定，只有对方开心，辛唐才能活命。偶然，辛唐救下准备自杀的同校网络红人吉择（章若楠 饰），两人借此绑定。吉择表面开朗，但实际患了抑郁症。辛唐最初为了活下去，费尽心思让吉择开心，而后续也真的投入深情。遗憾辛唐的秘密总会败露，而吉择暗黑的过往也在网络上被人揭开....愿爱情的温暖，能治愈抑郁的青春。', '[\"/images/movie/2020/12/15/75caecc71ba345a690e1e2c661ea7f3a.jpg\"]');
INSERT INTO `sys_movie` VALUES (3, '金刚川', 'The Sacrifice', 122, '[\"/images/movie/2020/12/15/cd079baa53ab4caa8bf7e984ff59b11c.jpg\"]', 1, 1, '2020-10-23 08:00:00', 9.0, 0.00, 1, '1953年，抗美援朝战争进入最终阶段，志愿军在金城发动最后一场大型战役。为在指定时间到达，向 金城前线投放更多战力，志愿军战士们在物资匮乏、武装悬殊的情况下，不断抵御敌机狂轰滥炸，以血肉之躯一次次修补战火中的木桥。一段鲜为人知的历史，在暗流涌动的金刚川上徐徐展开......', '[]');
INSERT INTO `sys_movie` VALUES (4, '沐浴之王', 'Bath Buddy', 103, '[\"/images/movie/2020/12/15/7d886589922f45fbb4b9bfdc20a62a91.jpg\"]', 1, 1, '2020-12-11 08:00:00', 9.0, 0.00, 2, '在一次搓澡服务中，富二代肖翔（彭昱畅 饰）和搓澡工周东海（乔杉 饰）发生矛盾，让周东海面临生活困境。肖翔因跳伞事故被送到医院记忆全失，周东海恰巧撞见，心生一计，骗肖翔是自己的弟弟并骗回周家澡堂当搓澡工，于是一个富二代开始了一段终身难忘的搓澡生涯……', '[]');
INSERT INTO `sys_movie` VALUES (5, '赤狐书生', '春江花月夜', 125, '[\"/images/movie/2020/12/15/94baa78550e34794823db457c27870a6.jpg\"]', 1, 1, '2020-12-04 10:00:00', 7.0, 0.00, 1, '清贫书生王子进（陈立农 饰）进京赶考，被来到人界取丹的狐妖白十三（李现 饰）盯上。为了骗取书生信任，狐妖联合各路妖鬼，设下重重陷阱。一场奇幻旅程等待着他们……', '[]');
INSERT INTO `sys_movie` VALUES (6, ' 我和我的家乡', 'My People My Homeland', 153, '[\"/images/movie/2020/12/15/5c6e503dc6154a9ab120256796acba34.jpg\"]', 1, 1, '2020-10-01 08:00:00', 9.5, 0.00, 1, '电影《我和我的家乡》定档2020年国庆，延续《我和我的祖国》集体创作的方式，由张艺谋担当总监制，宁浩担任总导演，张一白担任总策划，宁浩、徐峥、陈思诚、闫非&彭大魔、邓超&俞白眉分别执导五个故事。', '[]');
INSERT INTO `sys_movie` VALUES (7, '棒！少年', 'Tough Out', 108, '[\"/images/movie/2020/12/15/ad8e89daada24ab9b76b972894fa4418.jpg\"]', 1, 1, '2020-12-11 00:00:00', 6.0, 0.00, 2, '一群来自全国各地的困境少年，被选进北京市郊一个爱心棒球基地，组成了一支特殊的棒球队，跟着70岁传奇教练“师爷”从零开始学习打棒球。少年马虎以“刺头”状态闯进了基地，天天打架干仗；而“元老球员”小双心思细腻敏感，对未来满是怀疑和不确定。不同家庭背景和心性习惯的少年在一起训练、生活，一支棒球棍，把他们带进无尽的冲突和欢乐，也带给他们久违的热血与梦想。几个月后，他们将飞往美国，代表中国登上世界少棒的顶级赛场，但基地的球场和宿舍却面临拆迁……少年们能否逆风挥棒，叫板自己的命运？', '[]');
INSERT INTO `sys_movie` VALUES (8, '唐人街探案3', 'Detective Chinatown 3', 136, '[\"/images/movie/2020/12/15/3c856a4e413b4dd89cfd41a0d71faea9.jpg\"]', 1, 1, '2021-02-12 00:00:00', 9.0, 0.00, 1, '继曼谷、纽约之后，东京再出大案。唐人街神探唐仁（王宝强 饰）、秦风（刘昊然 饰）受侦探野田昊（妻夫木聪 饰）的邀请前往破案。“CRIMASTER世界侦探排行榜”中的侦探们闻讯后也齐聚东京，加入挑战，而排名第一Q的现身，让这个大案更加扑朔迷离，一场亚洲最强神探之间的较量即将爆笑展开……', '[]');
INSERT INTO `sys_movie` VALUES (9, '温暖的抱抱', 'WARM HUG', 112, '[\"/images/movie/2020/12/15/a0dc7fecccf2483391ee08070cd66832.jpg\"]', 1, 1, '2020-12-31 00:00:00', 5.0, 0.00, 1, '对整洁和计划有着超乎常人执念的鲍抱(常远 饰)，本以为自己是一个友情爱情的绝缘体，但在遇到个性率真宋温暖(李沁 饰) 、妙手“神经”贾医生(沈腾 饰)和假仁假义王为仁（乔杉 饰）之后，上演了一段阴差阳错的喜剧故事……', '[]');
INSERT INTO `sys_movie` VALUES (10, '阳光劫匪', 'Tiger Robbers', 104, '[\"/images/movie/2020/12/15/69aec299204e46bcb9174d80e30961fd.jpg\"]', 1, 1, '2020-12-31 00:00:00', 7.0, 0.00, 1, '电影《阳光劫匪》讲述了晓雪（宋佳 饰）在寻找丢失的“爱女”途中，偶然遇到了开宠物店的阳光（马丽 饰），晓雪央求阳光一行人帮助寻找爱女娜娜。但娜娜竟然是只老虎，被富豪刘神奇（曾志伟 饰）绑架。阳光决定帮晓雪抢回娜娜，一行人开始了一场惊心动魄又令人捧腹的冒险之旅……', '[]');
INSERT INTO `sys_movie` VALUES (11, '神奇女侠1984', 'Wonder Woman 1984', 151, '[\"/images/movie/2020/12/15/d40ac8629a9b47629f927454a0c345e9.jpg\"]', 2, 1, '2020-12-18 00:00:00', 9.9, 0.00, 1, '神奇女侠的全新大银幕冒险来到了1980年代。神奇女侠戴安娜在华盛顿的自然历史博物馆过着与普通人无异的生活，然而在阻止了一场看似平常的劫案后，身边的一切都发生了变化。在强大的神力诱惑下，两位全新劲敌悄然出现——与神奇女侠“相爱相杀”的顶级掠食者豹女，以及掌控着能改变世界力量的麦克斯·洛德，一场惊天大战在所难免。另外一边，旧爱史蒂夫突然“死而复生”，与戴安娜再续前缘，然而浪漫感动之余，史蒂夫的回归也疑窦丛生。', '[]');
INSERT INTO `sys_movie` VALUES (12, '摔跤吧！爸爸', 'Dangal', 161, '[\"/images/movie/2020/12/15/2ba31ac24b334fef80a4555f7cef5298.jpg\"]', 8, 4, '2017-05-05 00:00:00', 7.7, 0.00, 1, '这是一个温暖幽默的励志故事。马哈维亚 辛格·珀尕（阿米尔汗 饰）曾是印度国家摔跤冠军，因生活所迫放弃摔跤。他希望让儿子可以帮他完成梦想：赢得世界级金牌。结果生了四个女儿。本以为梦想就此破碎的辛格却意外发现女儿身上的惊人天赋，看到冠军希望的他决定不能让女儿的天赋浪费，像其他女孩一样只能洗衣做饭过一生，再三考虑之后，与妻子约定一年时间按照摔跤手的标准训练两个女儿：换掉裙子 、剪掉了长发，让她们练习摔跤，并赢得一个又一个冠军，最终赢来了成为榜样激励千千万万女性的机会……', '[]');
INSERT INTO `sys_movie` VALUES (13, '我和我的祖国', 'My People，My Country', 155, '[\"/images/movie/2020/12/15/8341c3cdce0840c7b14dc88ce4dc5e0a.jpg\"]', 1, 2, '2019-09-30 00:00:00', 6.5, 0.00, 1, '七位导演分别取材新中国成立70周年以来，祖国经历的无数个历史性经典瞬间。讲述普通人与国家之间息息相关密不可分的动人故事。聚焦大时代大事件下，小人物和国家之间，看似遥远实则密切的关联，唤醒全球华人共同回忆。', '[]');
INSERT INTO `sys_movie` VALUES (14, '战狼2', 'Wolf Warrior 2', 123, '[\"/images/movie/2020/12/15/b410a941952d4612b07f18b0622bc73e.jpg\"]', 1, 4, '2017-07-27 00:00:00', 9.0, 0.00, 1, '故事发生在非洲附近的大海上，主人公冷锋遭遇人生滑铁卢，被“开除军籍”，本想漂泊一生的他，正当他打算这么做的时候，一场突如其来的意外打破了他的计划，突然被卷入了一场非洲国家叛乱，本可以安全撤离，却因无法忘记曾经为军人的使命，孤身犯险冲回沦陷区，带领身陷屠杀中的同胞和难民，展开生死逃亡。随着斗争的持续，体内的狼性逐渐复苏，最终孤身闯入战乱区域，为同胞而战斗。', '[]');
INSERT INTO `sys_movie` VALUES (15, ' 速度与激情7', 'Furious 7', 137, '[\"/images/movie/2020/12/15/da999ff2914447e38cc854b1294d6c2a.jpg\"]', 2, 6, '2015-04-12 00:00:00', 10.0, 0.00, 1, '经历了紧张刺激的伦敦大战，多米尼克·托雷托（范·迪塞尔 饰）和他的伙伴们重新回归平静的生活，但是江湖的恩恩怨怨却决不允许他们轻易抽身而去。棘手的死对头欧文·肖瘫在医院，不得动弹，他的哥哥戴克·肖（杰森·斯坦森 饰）则发誓要为弟弟复仇。戴克曾是美国特种部队的王牌杀手，不仅身怀绝技，而且心狠手辣。他干掉了远在东京的韩，还几乎把探长卢克·霍布斯（道恩·强森 饰）送到另一个世界，甚至多米尼克那世外桃源般的家也被对方炸毁。复仇的利刃已经架在脖子上，多米尼克再也没有选择，他找到长久以来最为信赖的团队，与来势汹汹的戴克展开生死对决……', '[]');
INSERT INTO `sys_movie` VALUES (16, '哪吒之魔童降世', 'Ne Zha', 110, '[\"/images/movie/2020/12/15/2f69dce23efe4db99e189ca4886bed48.jpg\"]', 1, 2, '2019-07-26 00:00:00', 8.0, 0.00, 1, '天地灵气孕育出一颗能量巨大的混元珠，元始天尊将混元珠提炼成灵珠和魔丸，灵珠投胎为人，助周伐纣时可堪大用；而魔丸则会诞出魔王，为祸人间。元始天尊启动了天劫咒语，3年后天雷将会降临，摧毁魔丸。太乙受命将灵珠托生于陈塘关李靖家的儿子哪吒身上。然而阴差阳错，灵珠和魔丸竟然被掉包。本应是灵珠英雄的哪吒却成了混世大魔王。调皮捣蛋顽劣不堪的哪吒却徒有一颗做英雄的心。然而面对众人对魔丸的误解和即将来临的天雷的降临，哪吒是否命中注定会立地成魔？他将何去何从？', '[]');
INSERT INTO `sys_movie` VALUES (17, '寻梦环游记', 'Coco', 105, '[\"/images/movie/2020/12/15/0b5191875a844e27bd52caf7048b354d.jpg\"]', 2, 4, '2017-11-24 00:00:00', 10.0, 0.00, 1, '热爱音乐的米格尔（安东尼·冈萨雷兹 Anthony Gonzalez 配音）不幸地出生在一个视音乐为洪水猛兽的大家庭之中，一家人只盼着米格尔快快长大，好继承家里传承了数代的制鞋产业。一年一度的亡灵节即将来临，每逢这一天，去世的亲人们的魂魄便可凭借着摆在祭坛上的照片返回现世和生者团圆。 在一场意外中，米格尔竟然穿越到了亡灵国度之中，在太阳升起之前，他必须得到一位亲人的祝福，否则就将会永远地留在这个世界里。米格尔决定去寻找已故的歌神德拉库斯（本杰明·布拉特 Benjamin Bratt 配音），因为他很有可能就是自己的祖父。途中，米格尔邂逅了落魄乐手埃克托（盖尔·加西亚·贝纳尔 Gael García Bernal 配音），也渐渐发现了德拉库斯隐藏已久的秘密。', '[]');
INSERT INTO `sys_movie` VALUES (18, '我不是药神', 'Dying To Survive', 117, '[\"/images/movie/2020/12/15/5711f4fa70ec4d53b714af51b2dc1819.jpg\"]', 1, 3, '2018-07-05 00:00:00', 4.0, 0.00, 2, '一位不速之客的意外到访，打破了神油店老板程勇（徐峥 饰）的平凡人生，他从一个交不起房租的男性保健品商贩，一跃成为印度仿制药“格列宁”的独家代理商。收获巨额利润的他，生活剧烈变化，被病患们冠以“药神”的称号。但是，一场关于救赎的拉锯战也在波涛暗涌中慢慢展开......', '[]');
INSERT INTO `sys_movie` VALUES (19, '火力全开', 'Open Fire', 85, '[\"/images/movie/2020/12/15/e29341a6bf4640f7a6fb69442cade734.jpg\"]', 6, 4, '2017-10-20 00:00:00', 8.5, 0.00, 1, '《火力全开》主要描述了王力宏火力全开演唱会从台前幕后准备到成型再到演出的全纪实，并且在其中穿插很多他从小到大的励志往事。《火力全开》记录的不只是场表演，更记录了这场演唱会从筹备到完成的思想和精神。这部电影忠实记录华语流行演唱会在现今的状态，并呈现出王力宏的音乐创作概念与历程、舞台下平易近人又生活化的一面，以及对梦想的坚持和发光。无论观众是不是王力宏的歌迷，都能从中一窥音乐之于世界的力量，成为东西方文化交流的种子。', '[]');
INSERT INTO `sys_movie` VALUES (20, '疯狂动物城', 'Zootopia', 109, '[\"/images/movie/2020/12/15/190e45b2f62e414aae5f25c54df23c6d.jpg\"]', 2, 5, '2016-03-04 00:00:00', 9.5, 0.00, 2, '故事发生在一个所有哺乳类动物和谐共存的美好世界中，兔子朱迪（金妮弗·古德温 Ginnifer Goodwin 配音）从小就梦想着能够成为一名惩恶扬善的刑警，凭借着智慧和努力，朱迪成功的从警校中毕业进入了疯狂动物城警察局，殊不知这里是大型肉食类动物的领地，作为第一只，也是唯一的小型食草类动物，朱迪会遇到怎样的故事呢？ 近日里，城中接连发生动物失踪案件，就在全部警员都致力于调查案件真相之时，朱迪却被局长（伊德瑞斯·艾尔巴 Idris Elba 配音）发配成为了一名无足轻重的交警。某日，正在执勤的兔子遇见了名为尼克（杰森·贝特曼 Jason Bateman 配音）的狐狸，两人不打不相识，之后又误打误撞的接受了寻找失踪的水獭先生的任务，如果不能在两天之内找到水獭先生，朱迪就必须自愿离开警局。朱迪找到了尼克，两人联手揭露了一个隐藏在疯狂动物城之中的惊天秘密。', '[]');

-- ----------------------------
-- Table structure for sys_movie_age
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_age`;
CREATE TABLE `sys_movie_age`  (
  `movie_age_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `movie_age_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '年代名称',
  PRIMARY KEY (`movie_age_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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

-- ----------------------------
-- Table structure for sys_movie_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_area`;
CREATE TABLE `sys_movie_area`  (
  `movie_area_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '电影区域id',
  `movie_area_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电影区域名称',
  PRIMARY KEY (`movie_area_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie_area
-- ----------------------------
INSERT INTO `sys_movie_area` VALUES (1, '大陆');
INSERT INTO `sys_movie_area` VALUES (2, '美国');
INSERT INTO `sys_movie_area` VALUES (3, '韩国');
INSERT INTO `sys_movie_area` VALUES (4, '日本');
INSERT INTO `sys_movie_area` VALUES (5, '中国香港');
INSERT INTO `sys_movie_area` VALUES (6, '中国台湾');
INSERT INTO `sys_movie_area` VALUES (7, '泰国');
INSERT INTO `sys_movie_area` VALUES (8, '印度');
INSERT INTO `sys_movie_area` VALUES (9, '法国');
INSERT INTO `sys_movie_area` VALUES (10, '英国');
INSERT INTO `sys_movie_area` VALUES (11, '俄罗斯');
INSERT INTO `sys_movie_area` VALUES (12, '意大利');
INSERT INTO `sys_movie_area` VALUES (13, '西班牙');
INSERT INTO `sys_movie_area` VALUES (14, '德国');
INSERT INTO `sys_movie_area` VALUES (15, '波兰');
INSERT INTO `sys_movie_area` VALUES (16, '澳大利亚');
INSERT INTO `sys_movie_area` VALUES (17, '伊朗');
INSERT INTO `sys_movie_area` VALUES (18, '其他');

-- ----------------------------
-- Table structure for sys_movie_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_category`;
CREATE TABLE `sys_movie_category`  (
  `movie_category_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键电影类别id',
  `movie_category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电影类别名称',
  PRIMARY KEY (`movie_category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie_category
-- ----------------------------
INSERT INTO `sys_movie_category` VALUES (1, '爱情');
INSERT INTO `sys_movie_category` VALUES (2, '喜剧');
INSERT INTO `sys_movie_category` VALUES (3, '动画');
INSERT INTO `sys_movie_category` VALUES (4, '剧情');
INSERT INTO `sys_movie_category` VALUES (5, '恐怖');
INSERT INTO `sys_movie_category` VALUES (6, '动作');
INSERT INTO `sys_movie_category` VALUES (7, '科幻');
INSERT INTO `sys_movie_category` VALUES (8, '悬疑');
INSERT INTO `sys_movie_category` VALUES (9, '惊悚');
INSERT INTO `sys_movie_category` VALUES (10, '犯罪');
INSERT INTO `sys_movie_category` VALUES (11, '冒险');
INSERT INTO `sys_movie_category` VALUES (12, '战争');
INSERT INTO `sys_movie_category` VALUES (13, '奇幻');
INSERT INTO `sys_movie_category` VALUES (14, '运动');
INSERT INTO `sys_movie_category` VALUES (15, '家庭');
INSERT INTO `sys_movie_category` VALUES (16, '古装');
INSERT INTO `sys_movie_category` VALUES (17, '武侠');
INSERT INTO `sys_movie_category` VALUES (18, '西部');
INSERT INTO `sys_movie_category` VALUES (19, '历史');
INSERT INTO `sys_movie_category` VALUES (20, '传记');
INSERT INTO `sys_movie_category` VALUES (21, '歌舞');
INSERT INTO `sys_movie_category` VALUES (22, '黑色电影');
INSERT INTO `sys_movie_category` VALUES (23, '短片');
INSERT INTO `sys_movie_category` VALUES (24, '纪录片');
INSERT INTO `sys_movie_category` VALUES (25, '其他');

-- ----------------------------
-- Table structure for sys_movie_comment
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_comment`;
CREATE TABLE `sys_movie_comment`  (
  `movie_id` bigint(20) UNSIGNED NOT NULL COMMENT '电影id',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `comment_time` datetime(0) NOT NULL COMMENT '评论时间',
  `content` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  `score` decimal(10, 0) NOT NULL COMMENT '评分',
  PRIMARY KEY (`movie_id`, `user_id`, `comment_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie_comment
-- ----------------------------
INSERT INTO `sys_movie_comment` VALUES (1, 1, '2020-12-22 11:12:07', '很想看。因为我也是一名癌症病人。我是1996年出生的女孩，在2020年2月份检查出了肠癌晚期并且已经卵巢转移，真的不敢相信，做了近9小时的手术，切除了女生所有最重要的东西，化疗了无数次，现在每天都得吃靶向药，好绝望，谈了五年的男朋友也因为我得了癌症和我分手，好几次想过自杀，一无所有，不会结婚，不会有小宝宝，这不能吃那不能吃，天天这不舒服那不舒服，我真的快坚持不下去了', 4);
INSERT INTO `sys_movie_comment` VALUES (1, 1, '2020-12-22 11:13:03', '很不错', 8);
INSERT INTO `sys_movie_comment` VALUES (1, 1, '2020-12-22 11:13:08', '太好看了', 9);
INSERT INTO `sys_movie_comment` VALUES (1, 1, '2020-12-22 11:13:11', '真的我看到抗癌两字我就忍不住想哭了，因为我妈妈就是去年得了癌症，每次我妈化疗时都会犯恶心，我看着就特别心疼，头发也都掉光了，到时候在电影院看的时候我会哭死吧，这个题材真的很棒', 10);
INSERT INTO `sys_movie_comment` VALUES (1, 1, '2020-12-22 11:13:13', '愿世人安好', 10);
INSERT INTO `sys_movie_comment` VALUES (1, 1, '2020-12-22 11:13:27', '期待演员易烊千玺 送你一朵小红花', 10);
INSERT INTO `sys_movie_comment` VALUES (1, 1, '2020-12-22 11:13:38', '满分', 10);
INSERT INTO `sys_movie_comment` VALUES (2, 1, '2020-12-22 11:12:11', '海星', 5);
INSERT INTO `sys_movie_comment` VALUES (2, 1, '2020-12-22 11:13:04', '不是很看得懂', 8);
INSERT INTO `sys_movie_comment` VALUES (2, 1, '2020-12-22 11:13:05', '一般', 7);
INSERT INTO `sys_movie_comment` VALUES (2, 1, '2020-12-22 17:12:24', '还不错哟', 7);
INSERT INTO `sys_movie_comment` VALUES (2, 1, '2020-12-22 17:13:38', '这电影也太好看了吧', 10);
INSERT INTO `sys_movie_comment` VALUES (2, 3, '2020-12-22 17:57:33', '真的好好看啊啊啊', 8);
INSERT INTO `sys_movie_comment` VALUES (2, 3, '2020-12-22 18:00:52', '还行吧，没有想象中那么好', 6);
INSERT INTO `sys_movie_comment` VALUES (3, 1, '2020-12-22 11:13:03', '好看', 9);
INSERT INTO `sys_movie_comment` VALUES (4, 1, '2020-12-22 11:12:15', '还行', 8);
INSERT INTO `sys_movie_comment` VALUES (4, 1, '2020-12-22 11:13:10', '沐浴之王yyds', 10);
INSERT INTO `sys_movie_comment` VALUES (5, 1, '2020-12-22 11:13:31', '很一般', 7);
INSERT INTO `sys_movie_comment` VALUES (6, 1, '2020-12-22 11:12:10', '太好看了吧', 10);
INSERT INTO `sys_movie_comment` VALUES (7, 1, '2020-12-22 11:12:33', '太好看了', 9);
INSERT INTO `sys_movie_comment` VALUES (7, 1, '2020-12-22 11:12:43', '好烂', 3);
INSERT INTO `sys_movie_comment` VALUES (8, 1, '2020-12-22 11:12:34', '看过前两部，这部也不差', 9);
INSERT INTO `sys_movie_comment` VALUES (9, 1, '2020-12-22 11:12:16', '一般般', 5);
INSERT INTO `sys_movie_comment` VALUES (10, 1, '2020-12-22 11:12:24', '还行吧', 7);
INSERT INTO `sys_movie_comment` VALUES (11, 1, '2020-12-22 11:13:39', '期待很久了', 10);
INSERT INTO `sys_movie_comment` VALUES (12, 1, '2020-12-22 11:13:00', '加油', 8);
INSERT INTO `sys_movie_comment` VALUES (13, 1, '2020-12-22 11:13:06', '还行吧', 7);
INSERT INTO `sys_movie_comment` VALUES (14, 1, '2020-12-22 11:13:18', '太好看了', 9);
INSERT INTO `sys_movie_comment` VALUES (15, 1, '2020-12-22 11:12:09', '泪目', 10);
INSERT INTO `sys_movie_comment` VALUES (16, 1, '2020-12-22 11:12:46', '好看', 8);
INSERT INTO `sys_movie_comment` VALUES (17, 1, '2020-12-22 11:13:04', '满分作品呀', 10);
INSERT INTO `sys_movie_comment` VALUES (18, 1, '2020-12-22 11:13:01', '一般', 6);
INSERT INTO `sys_movie_comment` VALUES (18, 1, '2020-12-23 14:34:08', '就是难看', 2);
INSERT INTO `sys_movie_comment` VALUES (19, 1, '2020-12-22 11:12:36', '还不错', 9);
INSERT INTO `sys_movie_comment` VALUES (20, 1, '2020-12-22 11:12:08', '好棒啊', 10);
INSERT INTO `sys_movie_comment` VALUES (20, 1, '2020-12-22 11:13:23', '孩子很喜欢', 9);

-- ----------------------------
-- Table structure for sys_movie_runtime
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_runtime`;
CREATE TABLE `sys_movie_runtime`  (
  `movie_runtime_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '播放时段id',
  `movie_runtime_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '播放时段名',
  `begin_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '开始时间',
  `end_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`movie_runtime_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie_runtime
-- ----------------------------
INSERT INTO `sys_movie_runtime` VALUES (1, '10点场', '10:00', '12:05');
INSERT INTO `sys_movie_runtime` VALUES (2, '10点半场', '10:30', '12:35');
INSERT INTO `sys_movie_runtime` VALUES (3, '11点场', '11:00', '13:05');
INSERT INTO `sys_movie_runtime` VALUES (4, '11点半场', '11:30', '13:35');
INSERT INTO `sys_movie_runtime` VALUES (5, '12点场', '12:00', '14:05');
INSERT INTO `sys_movie_runtime` VALUES (6, '12点半场', '12:30', '14:35');
INSERT INTO `sys_movie_runtime` VALUES (7, '下午1点场', '13:00', '15:05');
INSERT INTO `sys_movie_runtime` VALUES (8, '下午1点半场', '13:30', '15:35');
INSERT INTO `sys_movie_runtime` VALUES (9, '下午2点场', '14:00', '16:05');
INSERT INTO `sys_movie_runtime` VALUES (10, '下午2点半场', '14:30', '16:35');
INSERT INTO `sys_movie_runtime` VALUES (11, '下午3点场', '15:00', '17:05');
INSERT INTO `sys_movie_runtime` VALUES (12, '下午3点半场', '15:30', '17:35');
INSERT INTO `sys_movie_runtime` VALUES (13, '下午4点场', '16:00', '18:05');
INSERT INTO `sys_movie_runtime` VALUES (14, '下午4点半场', '16:30', '18:35');
INSERT INTO `sys_movie_runtime` VALUES (15, '下午5点场', '17:00', '19:05');
INSERT INTO `sys_movie_runtime` VALUES (16, '下午5点半场', '17:30', '19:35');
INSERT INTO `sys_movie_runtime` VALUES (17, '下午6点场', '18:00', '20:05');
INSERT INTO `sys_movie_runtime` VALUES (18, '晚上6点半场', '18:30', '20:35');
INSERT INTO `sys_movie_runtime` VALUES (19, '晚上7点场', '19:00', '21:05');
INSERT INTO `sys_movie_runtime` VALUES (20, '晚上7点半场', '19:30', '21:35');
INSERT INTO `sys_movie_runtime` VALUES (21, '晚上8点场', '20:00', '22:05');
INSERT INTO `sys_movie_runtime` VALUES (22, '晚上8点半场', '20:30', '22:35');
INSERT INTO `sys_movie_runtime` VALUES (23, '晚上9点场', '21:00', '23:05');
INSERT INTO `sys_movie_runtime` VALUES (24, '晚上9点半场', '21:30', '23:35');
INSERT INTO `sys_movie_runtime` VALUES (25, '晚上10点场', '22:00', '00:05+1');

-- ----------------------------
-- Table structure for sys_movie_to_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_to_category`;
CREATE TABLE `sys_movie_to_category`  (
  `movie_id` bigint(20) UNSIGNED NOT NULL COMMENT '电影id',
  `movie_category_id` bigint(20) UNSIGNED NOT NULL COMMENT '电影类别id',
  PRIMARY KEY (`movie_id`, `movie_category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie_to_category
-- ----------------------------
INSERT INTO `sys_movie_to_category` VALUES (1, 1);
INSERT INTO `sys_movie_to_category` VALUES (1, 2);
INSERT INTO `sys_movie_to_category` VALUES (1, 4);
INSERT INTO `sys_movie_to_category` VALUES (2, 4);
INSERT INTO `sys_movie_to_category` VALUES (2, 8);
INSERT INTO `sys_movie_to_category` VALUES (2, 9);
INSERT INTO `sys_movie_to_category` VALUES (3, 1);
INSERT INTO `sys_movie_to_category` VALUES (3, 6);
INSERT INTO `sys_movie_to_category` VALUES (4, 1);
INSERT INTO `sys_movie_to_category` VALUES (4, 3);
INSERT INTO `sys_movie_to_category` VALUES (4, 8);
INSERT INTO `sys_movie_to_category` VALUES (5, 3);
INSERT INTO `sys_movie_to_category` VALUES (5, 4);
INSERT INTO `sys_movie_to_category` VALUES (5, 13);
INSERT INTO `sys_movie_to_category` VALUES (6, 7);
INSERT INTO `sys_movie_to_category` VALUES (6, 13);
INSERT INTO `sys_movie_to_category` VALUES (6, 19);
INSERT INTO `sys_movie_to_category` VALUES (7, 11);
INSERT INTO `sys_movie_to_category` VALUES (7, 14);
INSERT INTO `sys_movie_to_category` VALUES (8, 2);
INSERT INTO `sys_movie_to_category` VALUES (8, 6);
INSERT INTO `sys_movie_to_category` VALUES (8, 10);
INSERT INTO `sys_movie_to_category` VALUES (9, 2);
INSERT INTO `sys_movie_to_category` VALUES (9, 4);
INSERT INTO `sys_movie_to_category` VALUES (10, 5);
INSERT INTO `sys_movie_to_category` VALUES (10, 6);
INSERT INTO `sys_movie_to_category` VALUES (11, 6);
INSERT INTO `sys_movie_to_category` VALUES (11, 7);
INSERT INTO `sys_movie_to_category` VALUES (12, 2);
INSERT INTO `sys_movie_to_category` VALUES (12, 15);
INSERT INTO `sys_movie_to_category` VALUES (13, 23);
INSERT INTO `sys_movie_to_category` VALUES (13, 24);
INSERT INTO `sys_movie_to_category` VALUES (14, 6);
INSERT INTO `sys_movie_to_category` VALUES (14, 10);
INSERT INTO `sys_movie_to_category` VALUES (14, 11);
INSERT INTO `sys_movie_to_category` VALUES (15, 3);
INSERT INTO `sys_movie_to_category` VALUES (15, 6);
INSERT INTO `sys_movie_to_category` VALUES (16, 2);
INSERT INTO `sys_movie_to_category` VALUES (16, 3);
INSERT INTO `sys_movie_to_category` VALUES (16, 6);
INSERT INTO `sys_movie_to_category` VALUES (16, 10);
INSERT INTO `sys_movie_to_category` VALUES (17, 3);
INSERT INTO `sys_movie_to_category` VALUES (17, 4);
INSERT INTO `sys_movie_to_category` VALUES (18, 2);
INSERT INTO `sys_movie_to_category` VALUES (18, 6);
INSERT INTO `sys_movie_to_category` VALUES (18, 7);
INSERT INTO `sys_movie_to_category` VALUES (19, 4);
INSERT INTO `sys_movie_to_category` VALUES (20, 1);
INSERT INTO `sys_movie_to_category` VALUES (20, 2);
INSERT INTO `sys_movie_to_category` VALUES (20, 3);
INSERT INTO `sys_movie_to_category` VALUES (20, 8);
INSERT INTO `sys_movie_to_category` VALUES (20, 9);
INSERT INTO `sys_movie_to_category` VALUES (20, 10);

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource`  (
  `resource_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '资源id',
  `resource_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单路径，用于保存页面地址',
  `level` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '资源权限等级,1表示该资源为最高级权限',
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '当前菜单父菜单id',
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 812 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_resource
-- ----------------------------
INSERT INTO `sys_resource` VALUES (1, '影院管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (2, '电影管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (3, '影厅管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (4, '场次管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (5, '演员管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (6, '用户管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (7, '权限管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (8, '日志管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (11, '影院信息管理', 'cinema', 2, 1);
INSERT INTO `sys_resource` VALUES (12, '影院区域管理', 'cinemaArea', 2, 1);
INSERT INTO `sys_resource` VALUES (13, '影院品牌管理', 'cinemaBrand', 2, 1);
INSERT INTO `sys_resource` VALUES (21, '电影信息管理', 'movie', 2, 2);
INSERT INTO `sys_resource` VALUES (22, '电影评论管理', 'movieComment', 2, 2);
INSERT INTO `sys_resource` VALUES (23, '电影年代管理', 'movieAge', 2, 2);
INSERT INTO `sys_resource` VALUES (24, '电影区域管理', 'movieArea', 2, 2);
INSERT INTO `sys_resource` VALUES (25, '电影类别管理', 'movieCategory', 2, 2);
INSERT INTO `sys_resource` VALUES (26, '电影播放时段管理', 'movieRuntime', 2, 2);
INSERT INTO `sys_resource` VALUES (31, '影厅信息管理', 'hall', 2, 3);
INSERT INTO `sys_resource` VALUES (32, '影厅类别管理', 'hallCategory', 2, 3);
INSERT INTO `sys_resource` VALUES (41, '场次信息管理', 'session', 2, 4);
INSERT INTO `sys_resource` VALUES (51, '演员信息管理', 'actor', 2, 5);
INSERT INTO `sys_resource` VALUES (52, '演员角色管理', 'actorRole', 2, 5);
INSERT INTO `sys_resource` VALUES (61, '用户信息管理', 'user', 2, 6);
INSERT INTO `sys_resource` VALUES (62, '订单信息管理', 'bill', 2, 6);
INSERT INTO `sys_resource` VALUES (63, '用户爱好管理', 'hobby', 2, 6);
INSERT INTO `sys_resource` VALUES (71, '角色信息管理', 'role', 2, 7);
INSERT INTO `sys_resource` VALUES (72, '资源信息管理', 'resource', 2, 7);
INSERT INTO `sys_resource` VALUES (81, '查看日志', 'log', 2, 8);
INSERT INTO `sys_resource` VALUES (111, '查询影院信息权限', '', 3, 11);
INSERT INTO `sys_resource` VALUES (112, '修改影院信息权限', '', 3, 11);
INSERT INTO `sys_resource` VALUES (121, '查询影院区域权限', '', 3, 12);
INSERT INTO `sys_resource` VALUES (122, '修改影院区域权限', '', 3, 12);
INSERT INTO `sys_resource` VALUES (131, '查询影院品牌权限', '', 3, 13);
INSERT INTO `sys_resource` VALUES (132, '修改影院品牌权限', '', 3, 13);
INSERT INTO `sys_resource` VALUES (211, '查询电影信息权限', '', 3, 21);
INSERT INTO `sys_resource` VALUES (212, '修改电影信息权限', '', 3, 21);
INSERT INTO `sys_resource` VALUES (221, '查询电影评论权限', '', 3, 22);
INSERT INTO `sys_resource` VALUES (222, '修改电影评论权限', '', 3, 22);
INSERT INTO `sys_resource` VALUES (231, '查询电影年代权限', '', 3, 23);
INSERT INTO `sys_resource` VALUES (232, '修改电影年代权限', '', 3, 23);
INSERT INTO `sys_resource` VALUES (241, '查询电影区域权限', '', 3, 24);
INSERT INTO `sys_resource` VALUES (242, '修改电影区域权限', '', 3, 24);
INSERT INTO `sys_resource` VALUES (251, '查询电影类别权限', '', 3, 25);
INSERT INTO `sys_resource` VALUES (252, '修改电影类别权限', '', 3, 25);
INSERT INTO `sys_resource` VALUES (261, '查询电影播放时段权限', '', 3, 26);
INSERT INTO `sys_resource` VALUES (262, '修改电影播放时段权限', '', 3, 26);
INSERT INTO `sys_resource` VALUES (311, '查询影厅信息权限', '', 3, 31);
INSERT INTO `sys_resource` VALUES (312, '修改影厅信息权限', '', 3, 31);
INSERT INTO `sys_resource` VALUES (321, '查询影厅类别权限', '', 3, 32);
INSERT INTO `sys_resource` VALUES (322, '修改影厅类别权限', '', 3, 32);
INSERT INTO `sys_resource` VALUES (411, '查询场次信息权限', '', 3, 41);
INSERT INTO `sys_resource` VALUES (412, '修改场次信息权限', '', 3, 41);
INSERT INTO `sys_resource` VALUES (511, '查询演员信息权限', '', 3, 51);
INSERT INTO `sys_resource` VALUES (512, '修改演员信息权限', '', 3, 51);
INSERT INTO `sys_resource` VALUES (521, '查询演员角色权限', '', 3, 52);
INSERT INTO `sys_resource` VALUES (522, '修改演员角色权限', '', 3, 52);
INSERT INTO `sys_resource` VALUES (611, '查询用户信息权限', '', 3, 61);
INSERT INTO `sys_resource` VALUES (612, '修改用户信息权限', '', 3, 61);
INSERT INTO `sys_resource` VALUES (621, '查询订单信息权限', '', 3, 62);
INSERT INTO `sys_resource` VALUES (622, '修改订单信息权限', '', 3, 62);
INSERT INTO `sys_resource` VALUES (631, '查询用户爱好权限', '', 3, 63);
INSERT INTO `sys_resource` VALUES (632, '修改用户爱好权限', '', 3, 63);
INSERT INTO `sys_resource` VALUES (711, '查询角色信息权限', '', 3, 71);
INSERT INTO `sys_resource` VALUES (712, '修改角色信息权限', '', 3, 71);
INSERT INTO `sys_resource` VALUES (721, '查询资源信息权限', '', 3, 72);
INSERT INTO `sys_resource` VALUES (722, '修改资源信息权限', '', 3, 72);
INSERT INTO `sys_resource` VALUES (811, '查询日志权限', '', 3, 81);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色描述',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '系统管理员', '管理整个影院在线售票系统');
INSERT INTO `sys_role` VALUES (2, '影院管理员', '管理其所属的影院的相关信息');
INSERT INTO `sys_role` VALUES (3, '用户', '用户，仅能使用前台浏览相关信息、下单、修改个人信息等功能');

-- ----------------------------
-- Table structure for sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource`;
CREATE TABLE `sys_role_resource`  (
  `role_id` bigint(20) UNSIGNED NOT NULL COMMENT '角色id',
  `resource_id` bigint(20) UNSIGNED NOT NULL COMMENT '资源id，只以3级权限作为权限判断的依据',
  PRIMARY KEY (`role_id`, `resource_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_resource
-- ----------------------------
INSERT INTO `sys_role_resource` VALUES (1, 111);
INSERT INTO `sys_role_resource` VALUES (1, 112);
INSERT INTO `sys_role_resource` VALUES (1, 121);
INSERT INTO `sys_role_resource` VALUES (1, 122);
INSERT INTO `sys_role_resource` VALUES (1, 131);
INSERT INTO `sys_role_resource` VALUES (1, 132);
INSERT INTO `sys_role_resource` VALUES (1, 211);
INSERT INTO `sys_role_resource` VALUES (1, 212);
INSERT INTO `sys_role_resource` VALUES (1, 221);
INSERT INTO `sys_role_resource` VALUES (1, 222);
INSERT INTO `sys_role_resource` VALUES (1, 231);
INSERT INTO `sys_role_resource` VALUES (1, 232);
INSERT INTO `sys_role_resource` VALUES (1, 241);
INSERT INTO `sys_role_resource` VALUES (1, 242);
INSERT INTO `sys_role_resource` VALUES (1, 251);
INSERT INTO `sys_role_resource` VALUES (1, 252);
INSERT INTO `sys_role_resource` VALUES (1, 261);
INSERT INTO `sys_role_resource` VALUES (1, 262);
INSERT INTO `sys_role_resource` VALUES (1, 311);
INSERT INTO `sys_role_resource` VALUES (1, 312);
INSERT INTO `sys_role_resource` VALUES (1, 321);
INSERT INTO `sys_role_resource` VALUES (1, 322);
INSERT INTO `sys_role_resource` VALUES (1, 411);
INSERT INTO `sys_role_resource` VALUES (1, 412);
INSERT INTO `sys_role_resource` VALUES (1, 511);
INSERT INTO `sys_role_resource` VALUES (1, 512);
INSERT INTO `sys_role_resource` VALUES (1, 521);
INSERT INTO `sys_role_resource` VALUES (1, 522);
INSERT INTO `sys_role_resource` VALUES (1, 611);
INSERT INTO `sys_role_resource` VALUES (1, 612);
INSERT INTO `sys_role_resource` VALUES (1, 621);
INSERT INTO `sys_role_resource` VALUES (1, 622);
INSERT INTO `sys_role_resource` VALUES (1, 631);
INSERT INTO `sys_role_resource` VALUES (1, 632);
INSERT INTO `sys_role_resource` VALUES (1, 711);
INSERT INTO `sys_role_resource` VALUES (1, 712);
INSERT INTO `sys_role_resource` VALUES (1, 721);
INSERT INTO `sys_role_resource` VALUES (1, 722);
INSERT INTO `sys_role_resource` VALUES (1, 811);
INSERT INTO `sys_role_resource` VALUES (2, 211);
INSERT INTO `sys_role_resource` VALUES (2, 221);
INSERT INTO `sys_role_resource` VALUES (2, 231);
INSERT INTO `sys_role_resource` VALUES (2, 241);
INSERT INTO `sys_role_resource` VALUES (2, 251);
INSERT INTO `sys_role_resource` VALUES (2, 261);
INSERT INTO `sys_role_resource` VALUES (2, 311);
INSERT INTO `sys_role_resource` VALUES (2, 312);
INSERT INTO `sys_role_resource` VALUES (2, 321);
INSERT INTO `sys_role_resource` VALUES (2, 411);
INSERT INTO `sys_role_resource` VALUES (2, 412);
INSERT INTO `sys_role_resource` VALUES (2, 511);
INSERT INTO `sys_role_resource` VALUES (2, 621);

-- ----------------------------
-- Table structure for sys_session
-- ----------------------------
DROP TABLE IF EXISTS `sys_session`;
CREATE TABLE `sys_session`  (
  `session_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键场次id',
  `cinema_id` bigint(20) UNSIGNED NOT NULL COMMENT '影院id',
  `hall_id` bigint(20) UNSIGNED NOT NULL COMMENT '影厅id',
  `language_version` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该场次语言版本',
  `movie_id` bigint(20) UNSIGNED NOT NULL COMMENT '电影id',
  `movie_runtime_id` bigint(20) UNSIGNED NOT NULL COMMENT '放映时段id',
  `session_date` date NOT NULL COMMENT '场次日期',
  `session_state` tinyint(3) UNSIGNED NOT NULL COMMENT '场次状态，1表示上映中，0表示已下架',
  `session_price` decimal(10, 2) NOT NULL COMMENT '票价',
  `session_tips` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '影厅提示(如是否需要戴口罩，有什么福利，显示在选座购票位置的影厅后边，格式类似：6号Barco厅-（戴口罩勿饮食）凭票领券免费停车3小时)',
  `session_seats` json NOT NULL COMMENT '场次对应座位信息，采用{key: [], key: []}存储每一个座位的状态，其中key表示排，数组(下标+1)表示几号座，存储的值为0表示可选，1表示空(无座位)，值为2表示已选择，值为3表示已售出，',
  `seat_nums` smallint(5) UNSIGNED NULL DEFAULT 0 COMMENT '该场次售出的座位的个数，用于判断电影票是否售罄',
  PRIMARY KEY (`session_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_session
-- ----------------------------
INSERT INTO `sys_session` VALUES (16, 1, 1, '国语2D', 1, 5, '2020-12-25', 1, 36.00, '(观影期间佩戴口罩禁止饮食)', '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_session` VALUES (17, 1, 4, '国语2D', 1, 1, '2020-12-25', 1, 36.00, '(观影期间佩戴口罩禁止饮食)', '{\"1\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"2\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"3\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"4\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"5\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"6\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"7\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"8\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"9\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"10\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]}', 0);
INSERT INTO `sys_session` VALUES (18, 1, 7, '国语3D', 1, 7, '2020-12-25', 1, 60.00, '(观影期间佩戴口罩禁止饮食)', '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_session` VALUES (19, 1, 1, '国语2D', 2, 13, '2020-12-25', 1, 37.90, '(免费停车 详询前台)', '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_session` VALUES (20, 1, 7, '国语2D', 2, 23, '2020-12-25', 1, 30.00, '(免费停车 详询前台)', '{\"1\": [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1], \"2\": [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], \"3\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"14\": [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], \"15\": [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1]}', 0);
INSERT INTO `sys_session` VALUES (21, 2, 1, '国语2D', 2, 2, '2020-12-27', 1, 37.00, NULL, '{\"1\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_session` VALUES (22, 2, 2, '国语2D', 5, 5, '2020-12-27', 1, 34.00, '(免费停车 详询前台)', '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"16\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"17\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"18\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_session` VALUES (23, 1, 1, '国语3D', 1, 1, '2020-12-25', 1, 34.00, '(请佩戴口罩，观影期间不要饮食)', '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_session` VALUES (24, 1, 2, '国语3D', 1, 2, '2020-12-25', 1, 40.00, '(请佩戴口罩，观影期间不要饮食)', '{\"1\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"2\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"3\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"4\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"5\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"6\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"7\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"8\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"9\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"10\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]}', 0);
INSERT INTO `sys_session` VALUES (25, 1, 1, '国语3D', 5, 1, '2020-12-26', 1, 34.00, '(请佩戴口罩)', '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_session` VALUES (26, 1, 2, '国语3D', 5, 15, '2020-12-26', 1, 34.00, '(请佩戴口罩)', '{\"1\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"2\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"3\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"4\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"5\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"6\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"7\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"8\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"9\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], \"10\": [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]}', 0);
INSERT INTO `sys_session` VALUES (27, 1, 7, '国语2D', 1, 1, '2020-12-26', 1, 60.00, '(请佩戴口罩 观影期间不要饮食)', '{\"1\": [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1], \"2\": [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], \"3\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"14\": [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], \"15\": [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1]}', 0);
INSERT INTO `sys_session` VALUES (28, 1, 1, '国语2D', 8, 4, '2020-12-26', 1, 45.00, NULL, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 1, 1, 0, 0, 0, 0]}', 0);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称(用于登录，添加时验证唯一性)',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户登录时所用的密码(密文存储)',
  `salt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '盐',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户邮箱，记录个人信息和发送通知',
  `phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户电话号码，用于注册和发送通知',
  `sex` tinyint(3) UNSIGNED NOT NULL COMMENT '用户性别，1为男性0为女性',
  `user_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `role_id` bigint(20) UNSIGNED NOT NULL DEFAULT 3 COMMENT '用户对应的角色id',
  `information` json NULL COMMENT '存储用户的基本信息，如生日、生活状态(生活状态用字符串表示)、兴趣(兴趣用id数组表示)、个性签名',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '2f6b5c3044b271f5c07545aa862cf35c', '0v#C4w&i', '17777744455@qq.com', '13111212312', 1, '[\"/images/user/2020/12/15/daec8941dad549bc95cf1b26fd796ff1.jpg\"]', 1, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (2, '李四', '51a97989bc84e6d30c323d5b7f2d6994', 'wUA)g4Nk', '123456@qq.com', '13512345678', 1, '[\"/images/user/2020/12/15/82760d557d8c4620b453a7d7c2cd6340.jpg\"]', 2, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (3, '张三', '562779e437586caeb6b0ccda5dd1b881', 'JkVgQzC@', '456@qq.com', '13512345678', 0, '[\"/images/user/2020/12/15/5765ed23e48a4626b4c8dc2c5d8ff91a.jpg\"]', 2, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (4, '赵六', 'c0e89e9d1566fa2995f6780c54c4dd72', 'rvYUBSMb', '1456@qq.com', '13512345678', 0, '[\"/images/user/2020/12/15/ba755080ab35404abd8284b6842ca77c.jpg\"]', 2, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (5, '马七', '145f410c3b3963bb57358db0a1d296c4', '0nx@bRx2', '1456@qq.com', '13512345678', 0, '[\"/images/user/2020/12/15/0b4f389d47724e3486247b64aaf4eedb.jpg\"]', 2, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (6, '王五', '2a6559de9e27517e948e9952c9719c84', 'OlXlwRI(', '123@qq.com', '13123123123', 1, '[]', 2, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (7, '周八', '79642997fd0bd57ae5fc9771b624c6c9', 'L5M9YO8@', '456@qq.com', '13511212312', 0, '[\"/images/user/2020/12/15/4c988c9f1f454064b5a26e2812ff01a3.jpg\"]', 2, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (9, '孙九', '0afa0c4f750e79da685734ca5f6d337c', 'CBHV@v8k', '12344@qq.com', '13579246802', 1, '[\"/images/user/2020/12/15/59d6862d547840e6bc86336030b72430.jpg\"]', 2, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (10, '小花', '3173ccfab7f25443b8d2019a13c1376f', 'xSC3^Qvc', '789@163.com', '13135757123', 0, '[\"/images/user/2020/12/15/4f1f61dbc5914122ae0d820ea8734a46.jpg\"]', 2, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (11, '小可', '1df866bc6ff0f25913731cb3ce972c68', 'aaJZv0mM', '147@qq.com', '13254456612', 1, '[\"/images/user/2020/12/15/2832ad8931bf4bcdb7c2dc56be794e85.jpg\"]', 2, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (12, '小新', '8c020560d20e5931156e9361cd566707', 'zIzb^aP%', '123123@12.com', '13213213212', 0, '[\"/images/user/2020/12/15/96a9cc5884f14a4db2e48ca0d434d73b.jpg\"]', 2, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (13, '电影警察', '13df2eb06de62dd0d1676fca99c7f2f7', 'ts$eJzAL', '123456@126.com', '13245612312', 1, '[\"/images/user/2020/12/15/7b39d58bfaa64c3f9d4425131ede7cc2.jpg\"]', 3, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (14, '抽烟喝酒', '9b96789b135217398f720c9df695d707', 'Y8c2ds)!', '321@qq.com', '13555555578', 1, '[\"/images/user/2020/12/15/eaa033dcf58c473d8c0d65d92f14872d.jpg\"]', 3, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (15, '阿毛仙君', 'b2ca561306cc7d95a2af02bce4ff5e89', '0jMn40DK', '65445@142.com', '15632132121', 0, '[\"/images/user/2020/12/15/1a36838e0d0b4e9e927c0ee21dc48b15.jpg\"]', 3, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (16, '_sina62152355', '8aa36b6e5a004022ca6a55d5eeb38dda', ')ddHmRBW', '87789@544.com', '15689898978', 0, '[\"/images/user/2020/12/15/2b2756c9a196478ba7f132d4210c3c86.jpg\"]', 3, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (17, '梓菱风', '005acf53993d90d436b118e1f4b4c536', 'tAIlqWE7', 'adasd1@125.com', '13555555556', 0, '[\"/images/user/2020/12/15/831e066fe440467591adfc040699673f.jpg\"]', 3, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');
INSERT INTO `sys_user` VALUES (22, '用户名', '0d6d63480b1ffd8269b746e7bb959aef', 'c$uEzAxq', '123@sss.com', '13578945455', 1, '[\"/images/user/2020/12/22/18474994d9654f178d7aa2812d9110af.jpeg\"]', 3, '{\"job\": [1, 11], \"hobbies\": [1, 6, 7, 8, 9, 10], \"birthday\": \"2020-10-11\", \"autograph\": \"爱拼才会赢\", \"condition\": \"2\"}');

-- ----------------------------
-- Table structure for sys_user_hobby
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_hobby`;
CREATE TABLE `sys_user_hobby`  (
  `user_hobby_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '个人爱好id',
  `user_hobby_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '爱好名称',
  PRIMARY KEY (`user_hobby_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_hobby
-- ----------------------------
INSERT INTO `sys_user_hobby` VALUES (1, '美食');
INSERT INTO `sys_user_hobby` VALUES (2, '动漫');
INSERT INTO `sys_user_hobby` VALUES (3, '摄影');
INSERT INTO `sys_user_hobby` VALUES (4, '电影');
INSERT INTO `sys_user_hobby` VALUES (5, '体育');
INSERT INTO `sys_user_hobby` VALUES (6, '财经');
INSERT INTO `sys_user_hobby` VALUES (7, '音乐');
INSERT INTO `sys_user_hobby` VALUES (8, '游戏');
INSERT INTO `sys_user_hobby` VALUES (9, '科技');
INSERT INTO `sys_user_hobby` VALUES (10, '旅游');
INSERT INTO `sys_user_hobby` VALUES (11, '文学');
INSERT INTO `sys_user_hobby` VALUES (12, '公益');
INSERT INTO `sys_user_hobby` VALUES (13, '汽车');
INSERT INTO `sys_user_hobby` VALUES (14, '时尚');
INSERT INTO `sys_user_hobby` VALUES (15, '宠物');

SET FOREIGN_KEY_CHECKS = 1;
