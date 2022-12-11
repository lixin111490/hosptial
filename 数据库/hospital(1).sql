/*
Navicat MySQL Data Transfer

Source Server         : localhost_33063
Source Server Version : 80029
Source Host           : localhost:3306
Source Database       : hospital

Target Server Type    : MYSQL
Target Server Version : 80029
File Encoding         : 65001

Date: 2022-12-09 14:27:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '管理员编号',
  `username` varchar(256) DEFAULT NULL COMMENT '姓名',
  `user_account` varchar(256) NOT NULL COMMENT '登陆账号',
  `user_password` varchar(512) NOT NULL COMMENT '登陆密码',
  `admin_gender` varchar(10) DEFAULT NULL COMMENT '管理员性别',
  `admin_age` int DEFAULT NULL COMMENT '管理员年龄',
  `phone` varchar(256) DEFAULT NULL COMMENT '手机号',
  `user_role` tinyint NOT NULL DEFAULT '0' COMMENT '用户身份，对应着不同的权限：0 - 管理员，1 - 医生，2 - 护士',
  `avatar_url` varchar(1024) DEFAULT NULL COMMENT '用户头像',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除（逻辑删除）： 0 - 未删除 1 - 已删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_admin_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='管理员表';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', '孙洋', 'admin', 'eeb9bad681184779aa6570e402d6ef6c', 'nan', '22', '123456786', '0', '', '2022-12-08 20:28:21', '2022-12-08 20:28:21', '0');
INSERT INTO `admin` VALUES ('2', '谁', 'sy123', '1327167796', '男', '23', '123458578', '0', null, '2022-12-08 20:49:24', '2022-12-08 20:49:24', '0');

-- ----------------------------
-- Table structure for bed
-- ----------------------------
DROP TABLE IF EXISTS `bed`;
CREATE TABLE `bed` (
  `bed_id` int NOT NULL AUTO_INCREMENT COMMENT '病床编号',
  `department_id` int DEFAULT NULL COMMENT '所属科室编号',
  `available` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可用：1 -- 可用，0 -- 不可用',
  `allocated` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已被分配：1 -- 已分配，0 -- 未分配',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除：0 -- 未删除，1 -- 已删除',
  PRIMARY KEY (`bed_id`),
  UNIQUE KEY `bed_bed_id_uindex` (`bed_id`),
  KEY `bed_department_department_id_fk` (`department_id`),
  CONSTRAINT `bed_department_department_id_fk` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COMMENT='病床表';

-- ----------------------------
-- Records of bed
-- ----------------------------
INSERT INTO `bed` VALUES ('1', '2', '1', '0', '2022-12-08 22:00:13', '2022-12-08 22:00:13', '0');
INSERT INTO `bed` VALUES ('2', '2', '1', '0', '2022-12-08 22:00:13', '2022-12-08 22:00:13', '0');
INSERT INTO `bed` VALUES ('3', '2', '1', '0', '2022-12-08 22:00:13', '2022-12-08 22:00:13', '0');
INSERT INTO `bed` VALUES ('4', '2', '1', '0', '2022-12-08 22:00:13', '2022-12-08 22:00:13', '0');
INSERT INTO `bed` VALUES ('5', '2', '1', '0', '2022-12-08 22:00:13', '2022-12-08 22:00:13', '0');
INSERT INTO `bed` VALUES ('6', '2', '1', '0', '2022-12-08 22:00:13', '2022-12-08 22:00:13', '0');
INSERT INTO `bed` VALUES ('7', '2', '1', '0', '2022-12-08 22:00:13', '2022-12-08 22:00:13', '0');
INSERT INTO `bed` VALUES ('8', '2', '1', '0', '2022-12-08 22:00:13', '2022-12-08 22:00:13', '0');
INSERT INTO `bed` VALUES ('9', '2', '1', '0', '2022-12-08 22:00:13', '2022-12-08 22:00:13', '0');
INSERT INTO `bed` VALUES ('10', '2', '1', '0', '2022-12-08 22:00:13', '2022-12-08 22:00:13', '0');

-- ----------------------------
-- Table structure for bed_allocate
-- ----------------------------
DROP TABLE IF EXISTS `bed_allocate`;
CREATE TABLE `bed_allocate` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '申请编号',
  `apply_id` int NOT NULL COMMENT '发送申请用户的 id（只有医生能申请病床）',
  `apply_name` varchar(256) DEFAULT NULL COMMENT '申请者姓名',
  `patient_id` int DEFAULT NULL COMMENT '病人编号',
  `patient_name` varchar(256) DEFAULT NULL COMMENT '病人姓名',
  `bed_id` int DEFAULT NULL COMMENT '病床编号',
  `department_name` varchar(256) DEFAULT NULL COMMENT '科室名称',
  `approve_status` tinyint NOT NULL DEFAULT '2' COMMENT '审核状态：0 - 审核未通过  1 - 审核通过  2 - 未审核',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  UNIQUE KEY `bed_apply_apply_id_uindex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='病床分配表';

-- ----------------------------
-- Records of bed_allocate
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT COMMENT '科室编号',
  `department_name` varchar(256) NOT NULL COMMENT '科室名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_id_uindex` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='科室表';

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '脑科', '2022-12-08 21:20:23', '2022-12-08 21:20:23', '0');
INSERT INTO `department` VALUES ('2', '呼吸内科', '2022-12-08 22:00:08', '2022-12-08 22:00:08', '0');

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '医生编号',
  `username` varchar(256) DEFAULT NULL COMMENT '医生姓名',
  `user_account` varchar(256) DEFAULT NULL COMMENT '登陆账号',
  `user_password` varchar(256) DEFAULT NULL COMMENT '登陆密码',
  `doctor_gender` varchar(10) DEFAULT NULL COMMENT '医生性别',
  `doctor_age` int DEFAULT NULL COMMENT '医生年龄',
  `phone` varchar(256) DEFAULT NULL COMMENT '手机号',
  `avatar_url` varchar(1024) DEFAULT 'https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/2433/头像2.jpg' COMMENT '用户头像',
  `department_id` int DEFAULT NULL COMMENT '所属科室编号',
  `user_role` tinyint NOT NULL DEFAULT '1' COMMENT '用户身份，对应着不同的权限：0 - 管理员，1 - 医生，2 - 护士',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint DEFAULT '0' COMMENT '是否删除（逻辑删除）： 0 - 未删除 1 - 已删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctor_doctor_id_uindex` (`id`),
  KEY `doctor_department_department_id_fk` (`department_id`),
  CONSTRAINT `doctor_department_department_id_fk` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='医生表';

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES ('1', '孙洋', 'woshisunyang', 'eeb9bad681184779aa6570e402d6ef6c', '男', '22', '13206471952', 'https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/2433/头像2.jpg', '1', '1', '2022-12-08 21:20:40', '2022-12-08 21:20:40', '0');

-- ----------------------------
-- Table structure for health_info
-- ----------------------------
DROP TABLE IF EXISTS `health_info`;
CREATE TABLE `health_info` (
  `patient_id` int NOT NULL AUTO_INCREMENT COMMENT '病人编号',
  `patient_name` varchar(256) DEFAULT NULL COMMENT '病人姓名',
  `heart_rate` int DEFAULT NULL COMMENT '心率（单位：次/分）',
  `pulse` int DEFAULT NULL COMMENT '脉搏（单位：次/分）',
  `temperature` float DEFAULT NULL COMMENT '体温（单位：℃）',
  `blood_pressure` float DEFAULT NULL COMMENT '血压（单位：kPa）',
  `breathe` int DEFAULT NULL COMMENT '呼吸（单位：次/分）',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_delete` int DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `health_info_patient_id_uindex` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='病人健康状况表';

-- ----------------------------
-- Records of health_info
-- ----------------------------
INSERT INTO `health_info` VALUES ('1', '小a', '82', '86', '36.9', '15', '16', '2022-12-08 21:53:06', '2022-12-08 21:53:06', '0');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '消息编号',
  `send_id` int DEFAULT NULL COMMENT '发送者的编号',
  `send_name` varchar(256) DEFAULT NULL COMMENT '发送者姓名',
  `receive_id` int DEFAULT NULL COMMENT '接收者的编号',
  `receive_role` tinyint DEFAULT NULL COMMENT '接收消息者的身份：1 -- 医生，2 -- 护士，3 -- 所有人',
  `avatar` varchar(1024) DEFAULT NULL COMMENT '消息图标',
  `title` varchar(256) DEFAULT NULL COMMENT '消息标题',
  `content` text COMMENT '消息内容',
  `is_read` tinyint DEFAULT '0' COMMENT '状态：0 -- 未读，1 -- 已读',
  `data_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间：默认为当前时间',
  `type` varchar(32) DEFAULT NULL COMMENT '消息类型：notification -- 通知，message -- 消息',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除：0 -- 未删除，1 -- 已删除',
  PRIMARY KEY (`notice_id`),
  UNIQUE KEY `message_message_id_uindex` (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='消息表';

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES ('1', '1', '孙洋', '1', '1', '', '病人分配通知', '孙洋给您分配了一位病人，请前往查看', '0', '2022-12-08 21:53:06', 'message', '2022-12-08 21:53:06', '2022-12-08 21:53:06', '0');
INSERT INTO `notice` VALUES ('2', '1', '孙洋', '1', '2', '', '病人分配通知', '孙洋给您分配了一位病人，请前往查看', '0', '2022-12-08 21:53:07', 'message', '2022-12-08 21:53:07', '2022-12-08 21:53:07', '0');
INSERT INTO `notice` VALUES ('3', '1', '孙洋', null, '1', '', '病人分配通知', '孙洋给您分配了一位病人，请前往查看', '0', '2022-12-08 21:53:12', 'message', '2022-12-08 21:53:12', '2022-12-08 21:53:12', '0');
INSERT INTO `notice` VALUES ('4', '1', '孙洋', null, '2', '', '病人分配通知', '孙洋给您分配了一位病人，请前往查看', '0', '2022-12-08 21:53:12', 'message', '2022-12-08 21:53:12', '2022-12-08 21:53:12', '0');
INSERT INTO `notice` VALUES ('5', '1', '孙洋', '1', '3', 'https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/2433/ThXAXghbEsBCCSDihZxY.png', '住院管理啊 ', '大家好', '0', '2022-12-08 21:53:55', 'notification', '2022-12-08 21:53:55', '2022-12-08 21:53:55', '0');
INSERT INTO `notice` VALUES ('6', '1', '孙洋', '1', '3', 'https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/2433/ThXAXghbEsBCCSDihZxY.png', '住院管理啊 ', '大家好', '0', '2022-12-08 21:53:55', 'notification', '2022-12-08 21:53:55', '2022-12-08 21:53:55', '0');

-- ----------------------------
-- Table structure for nurse
-- ----------------------------
DROP TABLE IF EXISTS `nurse`;
CREATE TABLE `nurse` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '护士编号',
  `username` varchar(256) DEFAULT NULL COMMENT '护士姓名',
  `user_account` varchar(256) DEFAULT NULL COMMENT '登陆账号',
  `user_password` varchar(256) DEFAULT NULL COMMENT '登陆密码',
  `nurse_gender` varchar(10) DEFAULT NULL COMMENT '护士性别',
  `nurse_age` int DEFAULT NULL COMMENT '护士年龄',
  `phone` varchar(256) DEFAULT NULL COMMENT '手机号',
  `avatar_url` varchar(1024) DEFAULT 'https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/2433/头像7.jpg' COMMENT '用户头像',
  `user_role` tinyint NOT NULL DEFAULT '2' COMMENT '用户身份，对应着不同的权限：0 - 管理员，1 - 医生，2 - 护士',
  `department_id` int DEFAULT NULL COMMENT '所属科室编号',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint DEFAULT '0' COMMENT '是否删除（逻辑删除）： 0 - 未删除 1 - 已删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nurse_nurse_id_uindex` (`id`),
  KEY `nurse_department_department_id_fk` (`department_id`),
  CONSTRAINT `nurse_department_department_id_fk` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='护士表';

-- ----------------------------
-- Records of nurse
-- ----------------------------
INSERT INTO `nurse` VALUES ('1', '谁', 'woshisheiovo', 'eeb9bad681184779aa6570e402d6ef6c', null, null, null, 'https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/2433/头像7.jpg', '2', '1', '2022-12-08 21:26:34', '2022-12-08 21:26:34', '0');

-- ----------------------------
-- Table structure for patient
-- ----------------------------
DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient` (
  `patient_id` int NOT NULL AUTO_INCREMENT COMMENT '病人编号',
  `patient_name` varchar(256) NOT NULL COMMENT '病人姓名',
  `patient_gender` varchar(10) DEFAULT NULL COMMENT '病人性别',
  `patient_age` tinyint DEFAULT NULL COMMENT '病人年龄',
  `bed_id` int DEFAULT NULL COMMENT '病人病床号',
  `doctor_id` int DEFAULT NULL COMMENT '病人的主治医生编号',
  `nurse_id` int DEFAULT NULL COMMENT '病人的责任护士编号',
  `is_discharged` int NOT NULL DEFAULT '0' COMMENT '病人是否出院:0 - 未出院 1 - 已出院',
  `admission_date` date DEFAULT NULL COMMENT '病人入院日期',
  `discharged_date` date DEFAULT NULL COMMENT '病人出院日期',
  `condition_description` text COMMENT '病情描述',
  `department_id` int DEFAULT NULL COMMENT '所属科室编号',
  `department_name` varchar(256) DEFAULT NULL COMMENT '科室名称',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `patient_patient_id_uindex` (`patient_id`),
  UNIQUE KEY `patient_bed_number_uindex` (`bed_id`),
  KEY `patient_department_department_id_fk` (`department_id`),
  KEY `patient_doctor_doctor_id_fk` (`doctor_id`),
  KEY `patient_nurse_nurse_id_fk` (`nurse_id`),
  CONSTRAINT `patient_bed_bed_id_fk` FOREIGN KEY (`bed_id`) REFERENCES `bed` (`bed_id`),
  CONSTRAINT `patient_department_department_id_fk` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
  CONSTRAINT `patient_doctor_doctor_id_fk` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`),
  CONSTRAINT `patient_nurse_nurse_id_fk` FOREIGN KEY (`nurse_id`) REFERENCES `nurse` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='病人表';

-- ----------------------------
-- Records of patient
-- ----------------------------
INSERT INTO `patient` VALUES ('1', '小a', '男', '70', null, '1', '1', '0', '2022-12-08', null, '.', '1', '脑科', '2022-12-08 21:53:06', '2022-12-08 21:53:06', '0');
