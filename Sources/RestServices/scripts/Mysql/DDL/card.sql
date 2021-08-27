/*
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */
CREATE TABLE IF NOT EXISTS t_card_info (
	card_id BIGINT auto_increment NOT NULL COMMENT '卡片id',
	card_name varchar(50) NOT NULL COMMENT '卡片名称',
	card_level varchar(20) NULL COMMENT '卡片等级',
	card_desc varchar(500) NULL COMMENT '卡片描述',
	card_probability decimal(8,6) NOT NULL DEFAULT 0 COMMENT '抽卡概率',
	valid_mark INT NOT NULL DEFAULT 1 COMMENT '有效标志(0无效;1有效)',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_card_info_pk PRIMARY KEY (card_id),
	KEY `t_user_card_pools_card_level_idx` (`card_level`) USING BTREE,
	KEY `t_card_info_valid_mark_idx` (`valid_mark`) USING BTREE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='卡片信息表'
AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS t_card_storage (
	card_id BIGINT NOT NULL COMMENT '卡片id',
	storage_count INT NOT NULL COMMENT '库存数量',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_card_storage_pk PRIMARY KEY (card_id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='卡片库存表';