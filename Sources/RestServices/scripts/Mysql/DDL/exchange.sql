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
CREATE TABLE IF NOT EXISTS t_exchange_option (
	user_id BIGINT NOT NULL COMMENT '操作用户id',
	option_timestamp BIGINT NOT NULL COMMENT '操作时间戳',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_exchange_option_pk PRIMARY KEY (user_id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='集换操作表';

CREATE TABLE IF NOT EXISTS t_exchange_record (
	id BIGINT auto_increment NOT NULL COMMENT '主键',
	user_id BIGINT NOT NULL COMMENT '操作用户id',
	deck_id BIGINT NOT NULL COMMENT '卡组id',
	deck_name varchar(50) NOT NULL COMMENT '卡组名称',
	deck_desc varchar(500) NULL COMMENT '卡组描述',
	exchange_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '兑换时间',
	card_ids longtext NOT NULL COMMENT '卡片id集合',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_exchange_option_pk PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='集换记录表'
AUTO_INCREMENT=1;