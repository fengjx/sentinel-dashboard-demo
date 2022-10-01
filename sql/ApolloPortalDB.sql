
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

# Create Database
# ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS ApolloPortalDB DEFAULT CHARACTER SET = utf8mb4;

Use ApolloPortalDB;

-- ----------------------------
-- Table structure for App
-- ----------------------------
DROP TABLE IF EXISTS `App`;
CREATE TABLE `App` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_AppId_DeletedAt` (`AppId`,`DeletedAt`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_Name` (`Name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='应用表';

-- ----------------------------
-- Records of App
-- ----------------------------
BEGIN;
INSERT INTO `App` (`Id`, `AppId`, `Name`, `OrgId`, `OrgName`, `OwnerName`, `OwnerEmail`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (1, 'SampleApp', 'Sample App', 'TEST1', '样例部门1', 'apollo', 'apollo@acme.com', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `App` (`Id`, `AppId`, `Name`, `OrgId`, `OrgName`, `OwnerName`, `OwnerEmail`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (2, 'sentinel-demo-server', 'sentinel-demo-server', 'TEST1', '样例部门1', 'apollo', 'apollo@acme.com', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
COMMIT;

-- ----------------------------
-- Table structure for AppNamespace
-- ----------------------------
DROP TABLE IF EXISTS `AppNamespace`;
CREATE TABLE `AppNamespace` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Name` varchar(32) NOT NULL DEFAULT '' COMMENT 'namespace名字，注意，需要全局唯一',
  `AppId` varchar(64) NOT NULL DEFAULT '' COMMENT 'app id',
  `Format` varchar(32) NOT NULL DEFAULT 'properties' COMMENT 'namespace的format类型',
  `IsPublic` bit(1) NOT NULL DEFAULT b'0' COMMENT 'namespace是否为公共',
  `Comment` varchar(64) NOT NULL DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_AppId_Name_DeletedAt` (`AppId`,`Name`,`DeletedAt`),
  KEY `Name_AppId` (`Name`,`AppId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='应用namespace定义';

-- ----------------------------
-- Records of AppNamespace
-- ----------------------------
BEGIN;
INSERT INTO `AppNamespace` (`Id`, `Name`, `AppId`, `Format`, `IsPublic`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (1, 'application', 'SampleApp', 'properties', b'0', 'default app namespace', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `AppNamespace` (`Id`, `Name`, `AppId`, `Format`, `IsPublic`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (2, 'application', 'sentinel-demo-server', 'properties', b'0', 'default app namespace', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `AppNamespace` (`Id`, `Name`, `AppId`, `Format`, `IsPublic`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (3, 'sentinel-rule', 'sentinel-demo-server', 'properties', b'0', 'sentinel 规则配置', b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
COMMIT;

-- ----------------------------
-- Table structure for Authorities
-- ----------------------------
DROP TABLE IF EXISTS `Authorities`;
CREATE TABLE `Authorities` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) NOT NULL,
  `Authority` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of Authorities
-- ----------------------------
BEGIN;
INSERT INTO `Authorities` (`Id`, `Username`, `Authority`) VALUES (1, 'apollo', 'ROLE_user');
COMMIT;

-- ----------------------------
-- Table structure for Consumer
-- ----------------------------
DROP TABLE IF EXISTS `Consumer`;
CREATE TABLE `Consumer` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_AppId_DeletedAt` (`AppId`,`DeletedAt`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='开放API消费者';

-- ----------------------------
-- Records of Consumer
-- ----------------------------
BEGIN;
INSERT INTO `Consumer` (`Id`, `AppId`, `Name`, `OrgId`, `OrgName`, `OwnerName`, `OwnerEmail`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (1, 'sentinel-dashboard-apollo', 'sentinel-dashboard-apollo', 'TEST1', '样例部门1', 'apollo', 'apollo@acme.com', b'0', 0, 'apollo', '2022-09-30 19:31:30', 'apollo', '2022-09-30 19:31:30');
COMMIT;

-- ----------------------------
-- Table structure for ConsumerAudit
-- ----------------------------
DROP TABLE IF EXISTS `ConsumerAudit`;
CREATE TABLE `ConsumerAudit` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'Consumer Id',
  `Uri` varchar(1024) NOT NULL DEFAULT '' COMMENT '访问的Uri',
  `Method` varchar(16) NOT NULL DEFAULT '' COMMENT '访问的Method',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_ConsumerId` (`ConsumerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='consumer审计表';

-- ----------------------------
-- Records of ConsumerAudit
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ConsumerRole
-- ----------------------------
DROP TABLE IF EXISTS `ConsumerRole`;
CREATE TABLE `ConsumerRole` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'Consumer Id',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_ConsumerId_RoleId_DeletedAt` (`ConsumerId`,`RoleId`,`DeletedAt`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='consumer和role的绑定表';

-- ----------------------------
-- Records of ConsumerRole
-- ----------------------------
BEGIN;
INSERT INTO `ConsumerRole` (`Id`, `ConsumerId`, `RoleId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (1, 1, 13, b'0', 0, 'apollo', '2022-09-30 19:32:23', 'apollo', '2022-09-30 19:32:23');
INSERT INTO `ConsumerRole` (`Id`, `ConsumerId`, `RoleId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (2, 1, 14, b'0', 0, 'apollo', '2022-09-30 19:32:23', 'apollo', '2022-09-30 19:32:23');
COMMIT;

-- ----------------------------
-- Table structure for ConsumerToken
-- ----------------------------
DROP TABLE IF EXISTS `ConsumerToken`;
CREATE TABLE `ConsumerToken` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'ConsumerId',
  `Token` varchar(128) NOT NULL DEFAULT '' COMMENT 'token',
  `Expires` datetime NOT NULL DEFAULT '2099-01-01 00:00:00' COMMENT 'token失效时间',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_Token_DeletedAt` (`Token`,`DeletedAt`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='consumer token表';

-- ----------------------------
-- Records of ConsumerToken
-- ----------------------------
BEGIN;
INSERT INTO `ConsumerToken` (`Id`, `ConsumerId`, `Token`, `Expires`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (1, 1, '183d39a00a46656063ab286830f71e023d24c454', '2099-01-01 00:00:00', b'0', 0, 'apollo', '2022-09-30 19:31:30', 'apollo', '2022-09-30 19:31:30');
COMMIT;

-- ----------------------------
-- Table structure for Favorite
-- ----------------------------
DROP TABLE IF EXISTS `Favorite`;
CREATE TABLE `Favorite` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UserId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '收藏的用户',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Position` int(32) NOT NULL DEFAULT '10000' COMMENT '收藏顺序',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_UserId_AppId_DeletedAt` (`UserId`,`AppId`,`DeletedAt`),
  KEY `AppId` (`AppId`(191)),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='应用收藏表';

-- ----------------------------
-- Records of Favorite
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for Permission
-- ----------------------------
DROP TABLE IF EXISTS `Permission`;
CREATE TABLE `Permission` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `PermissionType` varchar(32) NOT NULL DEFAULT '' COMMENT '权限类型',
  `TargetId` varchar(256) NOT NULL DEFAULT '' COMMENT '权限对象类型',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_TargetId_PermissionType_DeletedAt` (`TargetId`,`PermissionType`,`DeletedAt`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='permission表';

-- ----------------------------
-- Records of Permission
-- ----------------------------
BEGIN;
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (1, 'CreateCluster', 'SampleApp', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (2, 'CreateNamespace', 'SampleApp', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (3, 'AssignRole', 'SampleApp', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (4, 'ModifyNamespace', 'SampleApp+application', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (5, 'ReleaseNamespace', 'SampleApp+application', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (6, 'CreateApplication', 'SystemRole', b'0', 0, 'apollo', '2022-09-30 19:26:52', 'apollo', '2022-09-30 19:26:52');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (7, 'AssignRole', 'sentinel-demo-server', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (8, 'CreateNamespace', 'sentinel-demo-server', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (9, 'CreateCluster', 'sentinel-demo-server', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (10, 'ManageAppMaster', 'sentinel-demo-server', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (11, 'ModifyNamespace', 'sentinel-demo-server+application', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (12, 'ReleaseNamespace', 'sentinel-demo-server+application', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (13, 'ModifyNamespace', 'sentinel-demo-server+application+DEV', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (14, 'ReleaseNamespace', 'sentinel-demo-server+application+DEV', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (15, 'ModifyNamespace', 'sentinel-demo-server+sentinel-rule', b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (16, 'ReleaseNamespace', 'sentinel-demo-server+sentinel-rule', b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (17, 'ModifyNamespace', 'sentinel-demo-server+sentinel-rule+DEV', b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
INSERT INTO `Permission` (`Id`, `PermissionType`, `TargetId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (18, 'ReleaseNamespace', 'sentinel-demo-server+sentinel-rule+DEV', b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
COMMIT;

-- ----------------------------
-- Table structure for Role
-- ----------------------------
DROP TABLE IF EXISTS `Role`;
CREATE TABLE `Role` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleName` varchar(256) NOT NULL DEFAULT '' COMMENT 'Role name',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_RoleName_DeletedAt` (`RoleName`,`DeletedAt`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- ----------------------------
-- Records of Role
-- ----------------------------
BEGIN;
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (1, 'Master+SampleApp', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (2, 'ModifyNamespace+SampleApp+application', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (3, 'ReleaseNamespace+SampleApp+application', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (4, 'CreateApplication+SystemRole', b'0', 0, 'apollo', '2022-09-30 19:26:52', 'apollo', '2022-09-30 19:26:52');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (5, 'Master+sentinel-demo-server', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (6, 'ManageAppMaster+sentinel-demo-server', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (7, 'ModifyNamespace+sentinel-demo-server+application', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (8, 'ReleaseNamespace+sentinel-demo-server+application', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (9, 'ModifyNamespace+sentinel-demo-server+application+DEV', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (10, 'ReleaseNamespace+sentinel-demo-server+application+DEV', b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (11, 'ModifyNamespace+sentinel-demo-server+sentinel-rule', b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (12, 'ReleaseNamespace+sentinel-demo-server+sentinel-rule', b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (13, 'ModifyNamespace+sentinel-demo-server+sentinel-rule+DEV', b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
INSERT INTO `Role` (`Id`, `RoleName`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (14, 'ReleaseNamespace+sentinel-demo-server+sentinel-rule+DEV', b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
COMMIT;

-- ----------------------------
-- Table structure for RolePermission
-- ----------------------------
DROP TABLE IF EXISTS `RolePermission`;
CREATE TABLE `RolePermission` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `PermissionId` int(10) unsigned DEFAULT NULL COMMENT 'Permission Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_RoleId_PermissionId_DeletedAt` (`RoleId`,`PermissionId`,`DeletedAt`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_PermissionId` (`PermissionId`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='角色和权限的绑定表';

-- ----------------------------
-- Records of RolePermission
-- ----------------------------
BEGIN;
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (1, 1, 1, b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (2, 1, 2, b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (3, 1, 3, b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (4, 2, 4, b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (5, 3, 5, b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (6, 4, 6, b'0', 0, 'apollo', '2022-09-30 19:26:52', 'apollo', '2022-09-30 19:26:52');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (7, 5, 7, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (8, 5, 8, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (9, 5, 9, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (10, 6, 10, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (11, 7, 11, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (12, 8, 12, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (13, 9, 13, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (14, 10, 14, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (15, 11, 15, b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (16, 12, 16, b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (17, 13, 17, b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
INSERT INTO `RolePermission` (`Id`, `RoleId`, `PermissionId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (18, 14, 18, b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
COMMIT;

-- ----------------------------
-- Table structure for SPRING_SESSION
-- ----------------------------
DROP TABLE IF EXISTS `SPRING_SESSION`;
CREATE TABLE `SPRING_SESSION` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint(20) NOT NULL,
  `LAST_ACCESS_TIME` bigint(20) NOT NULL,
  `MAX_INACTIVE_INTERVAL` int(11) NOT NULL,
  `EXPIRY_TIME` bigint(20) NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of SPRING_SESSION
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for SPRING_SESSION_ATTRIBUTES
-- ----------------------------
DROP TABLE IF EXISTS `SPRING_SESSION_ATTRIBUTES`;
CREATE TABLE `SPRING_SESSION_ATTRIBUTES` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `SPRING_SESSION` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of SPRING_SESSION_ATTRIBUTES
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ServerConfig
-- ----------------------------
DROP TABLE IF EXISTS `ServerConfig`;
CREATE TABLE `ServerConfig` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Key` varchar(64) NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `Value` varchar(2048) NOT NULL DEFAULT 'default' COMMENT '配置项值',
  `Comment` varchar(1024) DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_Key_DeletedAt` (`Key`,`DeletedAt`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='配置服务自身配置';

-- ----------------------------
-- Records of ServerConfig
-- ----------------------------
BEGIN;
INSERT INTO `ServerConfig` (`Id`, `Key`, `Value`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (1, 'apollo.portal.envs', 'dev', '可支持的环境列表', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `ServerConfig` (`Id`, `Key`, `Value`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (2, 'organizations', '[{\"orgId\":\"TEST1\",\"orgName\":\"样例部门1\"},{\"orgId\":\"TEST2\",\"orgName\":\"样例部门2\"}]', '部门列表', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `ServerConfig` (`Id`, `Key`, `Value`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (3, 'superAdmin', 'apollo', 'Portal超级管理员', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `ServerConfig` (`Id`, `Key`, `Value`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (4, 'api.readTimeout', '10000', 'http接口read timeout', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `ServerConfig` (`Id`, `Key`, `Value`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (5, 'consumer.token.salt', 'someSalt', 'consumer token salt', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `ServerConfig` (`Id`, `Key`, `Value`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (6, 'admin.createPrivateNamespace.switch', 'true', '是否允许项目管理员创建私有namespace', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `ServerConfig` (`Id`, `Key`, `Value`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (7, 'configView.memberOnly.envs', 'dev', '只对项目成员显示配置信息的环境列表，多个env以英文逗号分隔', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `ServerConfig` (`Id`, `Key`, `Value`, `Comment`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (8, 'apollo.portal.meta.servers', '{}', '各环境Meta Service列表', b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
COMMIT;

-- ----------------------------
-- Table structure for UserRole
-- ----------------------------
DROP TABLE IF EXISTS `UserRole`;
CREATE TABLE `UserRole` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `UserId` varchar(128) DEFAULT '' COMMENT '用户身份标识',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_UserId_RoleId_DeletedAt` (`UserId`,`RoleId`,`DeletedAt`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='用户和role的绑定表';

-- ----------------------------
-- Records of UserRole
-- ----------------------------
BEGIN;
INSERT INTO `UserRole` (`Id`, `UserId`, `RoleId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (1, 'apollo', 1, b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `UserRole` (`Id`, `UserId`, `RoleId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (2, 'apollo', 2, b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `UserRole` (`Id`, `UserId`, `RoleId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (3, 'apollo', 3, b'0', 0, 'default', '2022-09-30 19:26:09', '', '2022-09-30 19:26:09');
INSERT INTO `UserRole` (`Id`, `UserId`, `RoleId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (4, 'apollo', 5, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `UserRole` (`Id`, `UserId`, `RoleId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (5, 'apollo', 7, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `UserRole` (`Id`, `UserId`, `RoleId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (6, 'apollo', 8, b'0', 0, 'apollo', '2022-09-30 19:29:25', 'apollo', '2022-09-30 19:29:25');
INSERT INTO `UserRole` (`Id`, `UserId`, `RoleId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (7, 'apollo', 11, b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
INSERT INTO `UserRole` (`Id`, `UserId`, `RoleId`, `IsDeleted`, `DeletedAt`, `DataChange_CreatedBy`, `DataChange_CreatedTime`, `DataChange_LastModifiedBy`, `DataChange_LastTime`) VALUES (8, 'apollo', 12, b'0', 0, 'apollo', '2022-09-30 19:30:30', 'apollo', '2022-09-30 19:30:30');
COMMIT;

-- ----------------------------
-- Table structure for Users
-- ----------------------------
DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) NOT NULL DEFAULT 'default' COMMENT '用户登录账户',
  `Password` varchar(512) NOT NULL DEFAULT 'default' COMMENT '密码',
  `UserDisplayName` varchar(512) NOT NULL DEFAULT 'default' COMMENT '用户名称',
  `Email` varchar(64) NOT NULL DEFAULT 'default' COMMENT '邮箱地址',
  `Enabled` tinyint(4) DEFAULT NULL COMMENT '是否有效',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- Records of Users
-- ----------------------------
BEGIN;
INSERT INTO `Users` (`Id`, `Username`, `Password`, `UserDisplayName`, `Email`, `Enabled`) VALUES (1, 'apollo', '$2a$10$7r20uS.BQ9uBpf3Baj3uQOZvMVvB1RN3PYoKE94gtz2.WAOuiiwXS', 'apollo', 'apollo@acme.com', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
