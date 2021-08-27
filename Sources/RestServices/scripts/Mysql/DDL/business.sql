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
CREATE TABLE IF NOT EXISTS t_business_form (
	id BIGINT auto_increment NOT NULL COMMENT '主键',
	user_id BIGINT NOT NULL COMMENT '用户id',
	content LONGTEXT NOT NULL COMMENT '表单内容',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_business_form_pk PRIMARY KEY (id),
	KEY `t_business_form_user_id_idx` (`user_id`) USING BTREE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='表单表'
AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS t_business_sharing (
	share_user_id BIGINT NOT NULL COMMENT '分享用户id',
	target_user_id BIGINT NOT NULL COMMENT '被分享用户id',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_business_sharing_pk PRIMARY KEY (share_user_id,target_user_id),
	KEY `t_business_sharing_share_user_id_idx` (`share_user_id`) USING BTREE,
	KEY `t_business_sharing_target_user_id_idx` (`target_user_id`) USING BTREE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='分享表';
