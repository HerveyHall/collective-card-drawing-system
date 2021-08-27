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
CREATE TABLE IF NOT EXISTS t_deck_info (
	deck_id BIGINT auto_increment NOT NULL COMMENT '卡组id',
	deck_name varchar(50) NOT NULL COMMENT '卡组名称',
	deck_desc varchar(500) NULL COMMENT '卡组描述',
	valid_mark INT NOT NULL DEFAULT 1 COMMENT '有效标志(0无效;1有效)',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_deck_info_pk PRIMARY KEY (deck_id),
	KEY `t_deck_info_valid_mark_idx` (`valid_mark`) USING BTREE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='卡组表'
AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS t_deck_cards (
	deck_id BIGINT NOT NULL COMMENT '卡组id',
	card_id BIGINT NOT NULL COMMENT '卡片id',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_deck_cards_pk PRIMARY KEY (deck_id,card_id),
	KEY `t_deck_cards_deck_id_idx` (`deck_id`) USING BTREE,
	KEY `t_deck_cards_card_id_idx` (`card_id`) USING BTREE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='卡组卡片关系表';
