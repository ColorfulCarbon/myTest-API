SET NAMES UTF8;
DROP DATABASE IF EXISTS yidiandian;
CREATE DATABASE yidiandian CHARSET=UTF8;
USE yidiandian;

/*管理员*/
CREATE TABLE ydd_admin(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  aname VARCHAR(32) UNIQUE,
  apwd VARCHAR(64)
); 
INSERT INTO ydd_admin VALUES
(NULL, 'admin', PASSWORD('123456789')),
(NULL, 'boss', PASSWORD('2109387421'));

/*全局设置*/
CREATE TABLE ydd_settings(
  sid INT PRIMARY KEY AUTO_INCREMENT,
  appName VARCHAR(32),
  apiUrl VARCHAR(64),
  adminUrl VARCHAR(64),
  appUrl VARCHAR(64),
  icp VARCHAR(64),
  copyright VARCHAR(128)
);
INSERT INTO ydd_settings VALUES
(NULL, '一点点', 'http://127.0.0.1:8090', 'http://127.0.0.1:8091', 'http://127.0.0.1:8092', '京ICP备12003709号-3', 'Copyright © 北京达内金桥科技有限公司版权所有');

/*桌台表*/
CREATE TABLE ydd_table(
  tid INT PRIMARY KEY AUTO_INCREMENT,
  tname VARCHAR(32),
  type VARCHAR(32),
  status INT
);
INSERT INTO ydd_table VALUES
(1, '一点幸福', '2人桌', 1),
(2, '一点放纵', '2人桌', 1),
(3, '一点轻松', '6人桌', 3),
(5, '一点迷茫', '4人桌', 2),
(6, '一点无奈', '6人桌', 3),
(7, '一点困难', '2人桌', 1),
(8, '一点愉悦', '8人桌', 1),
(9, '一点努力', '4人桌', 3),
(10, '一点坚持', '10人桌', 2),
(11, '一点反逆', '8人桌', 1),
(12, '一点积极', '12人桌', 1),
(13, '一点乐观', '4人桌', 3),
(15, '一点大度', '2人桌',3);

/*桌台预定信息*/
CREATE TABLE ydd_reservation(
  rid INT PRIMARY KEY AUTO_INCREMENT,
  contactName VARCHAR(32),
  phone VARCHAR(16),
  contactTime BIGINT,
  dinnerTime BIGINT,
  tableId INT,
  FOREIGN KEY(tableId) REFERENCES ydd_table(tid)
);
INSERT INTO ydd_reservation VALUES
(NULL, 'didi', '13501234561', '1548311700000', '1549011000000', '1'),
(NULL, 'dada', '13501234562', '1548311710000', '1549011100000', '1'),
(NULL, 'dodo', '13501234563', '1548311720000', '1549011200000', '2'),
(NULL, 'yaya', '13501234564', '1548311730000', '1549011300000', '2'),
(NULL, 'xixi', '13501234565', '1548311740000', '1549011400000', '3'),
(NULL, 'coco', '13501234566', '1548311750000', '1549011500000', '3'),
(NULL, 'huhu', '13501234561', '1548311760000', '1549011600000', '5'),
(NULL, 'lala', '13501234562', '1548311770000', '1549011700000', '5'),
(NULL, 'qiqi', '13501234563', '1548311780000', '1549011800000', '6'),
(NULL, 'bibi', '13501234564', '1548311790000', '1549011900000', '6'),
(NULL, 'lili', '13501234565', '1548311800000', '1549011000000', '7'),


/*菜品类别*/
CREATE TABLE ydd_category(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(32)
);
INSERT INTO ydd_category VALUES
(1, '找好茶'),
(2, '找口感'),
(3, '找奶茶'),
(4, '找新鲜'),


/*菜品*/
CREATE TABLE ydd_dish(
  did INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(32),
  imgUrl VARCHAR(128),
  price DECIMAL(6,2),
  detail VARCHAR(128),
  categoryId INT,
  FOREIGN KEY(categoryId) REFERENCES ydd_category(cid)
);
INSERT INTO ydd_dish VALUES
(1, '四季春茶', 'r9470.jpg', '6', '温和甘醇的四季春茶,带有栀子花香,冷热皆宜', '1'),
(NULL, '阿萨姆红茶', 'r9017.jpg', '6', '产于印度东北部的阿萨姆邦的红茶', '1'),
(NULL, '冻顶乌龙茶', 'r4760.jpg', '7', '茶汤清爽宜人,汤色蜜绿带金黄,茶香清新典雅,喉韵回甘浓郁且持久', '1'),
(NULL, '柠檬绿', 'r9302.jpg', '6', '果味十足,口感清爽的冰茶,在炎热的夏季简直是一杯解暑神饮名奶茶品牌', '1'),
(NULL, '柠檬青', 'r9287.jpg', '7', '鲜榨柠檬汁加酸甜养乐多,味道真的好', '1'),
(NULL, '波霸奶茶', 'r9711.jpg', '11', '奶茶有绝对的口感 珍珠也不例外', '1'),
(NULL, '茉莉绿茶', 'r9470.jpg', '7', '经茉莉花香熏焙而成的绿茶', '1'),
(NULL, '波霸奶茶', 'r9017.jpg', '11', '奶茶有绝对的口感 珍珠也不例外', '2'),
(NULL, '波霸红', 'r6110.jpg', '11', '珍珠有韧性不粘牙加经典红茶', '2'),
(NULL, '珍珠奶茶', 'r7130.jpg', '10', '浓郁的风味奶茶加上香Q的珍珠,一口一口丰富的口感,调和饮品的层次感!', '2'),
(NULL, '可可芭蕾', 'r8110.jpg', '12', '法国进口巧克力粉,传递古老马雅的风味与摩登时尚,所激荡出的醇韵之作,划开巧克力的饮品传奇!', '3'),
(NULL, '红茶', 'r1238.jpg', '11', '特选香浓的锡兰红茶,一年四季人气饮品', '3'),
(NULL, '奶茶', 'r6213.jpg', '10', '纯奶加纯茶 名为奶茶', '3'),
(NULL, '红茶拿铁', 'r9913.jpg', '13', '红茶提取物与牛奶1:4混合调制而成', '3'),
(NULL, '红茶玛奇朵', 'r1313.jpg', '13', '将鲜奶油调和成绵密的香甜奶霜,加入红茶,品尝茶汤奶茶层次感', '3'),
(NULL, '冰缘', 'r7719.jpg', '6', '零添加,零替代,口味独特,多重选择', '4'),
(NULL, '柠檬汁', 'h3181.jpg', '6', '鲜榨柠檬', '4');



/*订单*/
CREATE TABLE ydd_order(
  oid INT PRIMARY KEY AUTO_INCREMENT,
  startTime BIGINT,
  endTime BIGINT,
  customerCount INT,
  tableId INT,
  FOREIGN KEY(tableId) REFERENCES xfn_table(tid)
);
INSERT INTO ydd_order VALUES
(100000, '1547800000000', '1547814918000', '2', '1'),
(NULL, '1547801000000', '1547824918000', '4', '2'),
(NULL, '1547802000000', '1547834918000', '3', '3'),
(NULL, '1547803000000', '1547844918000', '5', '5'),
(NULL, '1547804000000', '1547854918000', '8', '6'),
(NULL, '1547805000000', '1547864918000', '2', '7'),
(NULL, '1547806000000', '1547874918000', '1', '8'),
(NULL, '1547807000000', '1547884918000', '2', '9'),
(NULL, '1547808000000', '1547894918000', '6', '10'),
(NULL, '1547809000000', '1547804918000', '3', '11'),
(NULL, '1547800000000', '1547814918000', '10', '12'),
(NULL, '1547801000000', '1547824918000', '2', '13'),
(NULL, '1547802000000', '1547834918000', '4', '15'),
(NULL, '1547800000000', '1547814918000', '2', '1'),
(NULL, '1547801000000', '1547824918000', '4', '2'),
(NULL, '1547802000000', '1547834918000', '3', '3'),
(NULL, '1547803000000', '', '5', '5'),
(NULL, '1547804000000', '1547854918000', '8', '6'),
(NULL, '1547805000000', '', '2', '7'),
(NULL, '1547806000000', '1547874918000', '1', '8'),
(NULL, '1547807000000', '1547884918000', '2', '9'),
(NULL, '1547808000000', '', '6', '10'),
(NULL, '1547809000000', '1547804918000', '3', '11'),
(NULL, '1547800000000', '', '10', '12'),
(NULL, '1547801000000', '1547824918000', '2', '13'),
(NULL, '1547802000000', '', '4', '15');

/*订单详情*/
CREATE TABLE ydd_order_detail(
  oid INT PRIMARY KEY AUTO_INCREMENT,
  dishId INT,       /*菜品编号*/
  dishCount INT,    /*份数*/
  customerName VARCHAR(32),    /*顾客名称*/
  orderId INT,      /*订单编号*/
  FOREIGN KEY(dishId) REFERENCES ydd_dish(did),
  FOREIGN KEY(orderId) REFERENCES ydd_order(oid)
);
INSERT INTO ydd_order_detail VALUES
(NULL, '5', '2', '皖皖', '100000'),
(NULL, '4', '2', '鹏鹏', '100001'),
(NULL, '7', '1', '大翔', '100002'),
(NULL, '8', '3', '狗卓', '100003'),
(NULL, '2', '1', '屁为', '100004'),
(NULL, '11', '2', '刘狗蛋', '100005'),
(NULL, '6', '1', '曹帅逼', '100006'),
(NULL, '1', '2', '二傻子', '100007'),
(NULL, '3', '2', '伊利丹', '100008'),
(NULL, '1', '2', '图拉杨', '100000'),
(NULL, '4', '2', '洛萨', '100001'),
(NULL, '7', '1', '帕拉丁', '100002'),
(NULL, '8', '3', '乌瑟尔', '100003'),
(NULL, '4', '1', '瓦莉拉', '100004'),
(NULL, '1', '2', '瓦里安', '100005'),
(NULL, '6', '1', '安度因', '100006'),
(NULL, '1', '2', '提尔', '100007'),
(NULL, '3', '2', '世界萨', '100008'),
(NULL, '5', '2', '阿强', '100009'),
(NULL, '4', '1', '凯子', '100010'),

