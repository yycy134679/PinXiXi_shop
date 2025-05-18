/*
 Navicat Premium Dump SQL

 Source Server         : 云烟成雨
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : pinxixi_shop

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 18/05/2025 15:06:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for addresses
-- ----------------------------
DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `detail_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id_UNIQUE`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_addresses_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of addresses
-- ----------------------------
INSERT INTO `addresses` VALUES (1, 1, '广东省', '深圳市', '南山区', '科技园路123号 创新大厦A座501室', '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `addresses` VALUES (2, 3, '上海市', '上海市', '浦东新区', '世纪大道888号 国金中心二期10楼', '2025-05-18 01:13:48', '2025-05-18 01:13:48');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `price` decimal(10, 2) NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sales_volume` int NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'HUAWEI Mate 70', 'HUAWEI Mate 70鸿蒙AI 红枫原色影像 超可靠玄武架构华为鸿蒙智能手机', 5999.00, 'images/products/HUAWEI Mate 70.jpg', 1024, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (2, 'iPhone 16 Pro Max', '全新iPhone 16 Pro Max，极致体验，科技旗舰。', 8999.00, 'images/products/iPhone 16 Pro Max.jpg', 850, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (3, '三月七手办', '【崩坏星穹铁道官方】精美三月七 1/7 手办，收藏佳品。', 299.00, 'images/products/三月七手办.jpg', 920, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (4, '佳能EOS R5', '佳能EOS R5专业相机，摄影师首选。', 25999.00, 'images/products/佳能EOS R5.jpg', 780, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (5, '回力重磅短袖t恤男', '舒适百搭的回力重磅短袖t恤男，夏日必备。', 59.00, 'images/products/回力重磅短袖t恤男.jpg', 1150, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (6, '小米 su7 ultra', '自信驾驭强大 巅峰之作源自对极限性能的无限追求 年轻人的第一台Dream Car', 529999.00, 'images/products/小米 su7 ultra.jpg', 40000, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (7, '小米15Ultra', '小米15Ultra，徕卡2亿超级长焦 6000mAh小米金沙江电池。', 5999.00, 'images/products/小米15Ultra.jpg', 1080, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (8, '崩坏星穹铁道符玄手办', '【崩坏星穹铁道官方】符玄手办，动漫迷必收。', 399.00, 'images/products/崩坏星穹铁道符玄手办.jpg', 700, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (9, '机械革命耀世16Ultra', '机械革命（MECHREVO）耀世16 Ultra 酷睿Ultra 9强芯5080/5090游戏本16英寸学生设计游戏笔记本电脑。', 7999.00, 'images/products/机械革命 耀世16 Ultra.jpg', 650, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (10, '美式飞行夹克', '经典美式飞行夹克，潮流时尚。', 299.00, 'images/products/美式飞行夹克.jpg', 900, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (11, '航空母舰拼装积木', '尚韵航空母舰乐高积木玩具六一儿童节拼装军事男孩生日礼物6-8-12岁。', 199.00, 'images/products/航空母舰拼装积木.jpg', 1250, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `products` VALUES (12, '茜特菈莉手办', '【原神官方】茜特菈莉·白星黑曜Ver.1/8手办。', 299.00, 'images/products/茜特菈莉手办.jpg', 880, '2025-05-18 01:13:48', '2025-05-18 01:13:48');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatar_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username_UNIQUE`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', 'admin', 'admin@example.com', '13800138001', '男', 'images/tou_xiang/懒羊羊.jpg', '2025-05-18 01:13:48', '2025-05-18 13:33:03');
INSERT INTO `users` VALUES (2, 'testuser2', 'securepass', '爱购物的小明', 'xiaoming@example.com', '13900139002', '男', NULL, '2025-05-18 01:13:48', '2025-05-18 01:13:48');
INSERT INTO `users` VALUES (3, 'alice', 'alicepwd', 'Alice Wonderland', 'alice@example.com', '13700137003', '女', '', '2025-05-18 01:13:48', '2025-05-18 13:32:19');

SET FOREIGN_KEY_CHECKS = 1;
