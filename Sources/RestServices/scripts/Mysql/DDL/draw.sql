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
CREATE TABLE IF NOT EXISTS t_draw_record (
	id BIGINT auto_increment NOT NULL COMMENT '主键',
	user_id BIGINT NOT NULL COMMENT '用户id',
	card_id BIGINT NOT NULL COMMENT '卡片id',
	draw_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '抽卡时间',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_draw_record_pk PRIMARY KEY (id),
	KEY `t_draw_record_card_id_idx` (`card_id`) USING BTREE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='抽卡记录表'
AUTO_INCREMENT=1;