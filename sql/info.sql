###  中心仓数据
CREATE TABLE `wms_warehouse` (
  `wh_id` int(11) NOT NULL AUTO_INCREMENT,
  `wh_code` varchar(32) NOT NULL COMMENT '编号',
  `wh_name` varchar(32) NOT NULL DEFAULT '' COMMENT '名称',
  `wh_addr` varchar(64) NOT NULL DEFAULT '' COMMENT '地址',
  `wh_tel` varchar(16) NOT NULL DEFAULT '' COMMENT '电话',
  `wh_contact` varchar(16) NOT NULL DEFAULT '' COMMENT '联系人',
  `wh_phone` varchar(16) NOT NULL DEFAULT '' COMMENT '手机号',
  `wh_mtime` int(11) DEFAULT '0' COMMENT '修改时间',
  `wh_ctime` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`wh_id`),
  UNIQUE KEY `idx_code` (`wh_code`),
  KEY `idx_name` (`wh_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `wms_db`.`wms_warehouse` (`wh_code`, `wh_name`, `wh_addr`, `wh_tel`, `wh_contact`, `wh_phone`, `wh_mtime`, `wh_ctime`) VALUES ('C0001', '广州中心仓', '广州市天河区科韵路100号', '13975179302', '骑士', '13975179302', '1518079370', '1518079370');
