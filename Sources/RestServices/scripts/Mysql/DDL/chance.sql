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
CREATE TABLE IF NOT EXISTS t_chance_info (
	user_id BIGINT NOT NULL COMMENT '用户id',
	times_number INT NOT NULL COMMENT '抽卡次数',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_chance_info_pk PRIMARY KEY (user_id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='抽卡机会表';

CREATE TABLE IF NOT EXISTS t_chance_increase_log (
	id BIGINT auto_increment NOT NULL COMMENT '主键',
	user_id BIGINT NOT NULL COMMENT '用户id',
	operate varchar(100) NOT NULL COMMENT '操作类型',
	increase_number INT NOT NULL COMMENT '新增抽卡次数',
	increase_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_chance_increase_log_pk PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='抽卡次数新增日志表'
AUTO_INCREMENT=1;