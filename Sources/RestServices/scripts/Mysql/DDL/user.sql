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
CREATE TABLE IF NOT EXISTS t_user_account (
	user_id BIGINT auto_increment NOT NULL COMMENT '用户id',
	login_name varchar(100) NOT NULL COMMENT '登录名',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_user_account_pk PRIMARY KEY (user_id),
	UNIQUE KEY `t_user_account_un` (`login_name`),
	KEY `t_user_account_login_name_idx` (`login_name`) USING BTREE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='用户账号信息表'
AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS t_user_ext_info (
	user_id BIGINT NOT NULL COMMENT '用户id',
	phone_number varchar(50) NULL COMMENT '手机号码',
	wx_open_id varchar(50) NULL COMMENT '微信openId',
	wx_union_id varchar(50) NULL COMMENT '微信unionId',
	wx_nick_name varchar(100) NULL COMMENT '微信昵称',
	wx_sex varchar(10) NULL COMMENT '微信用户性别',
	wx_province varchar(200) NULL COMMENT '微信省份',
	wx_city varchar(200) NULL COMMENT '微信城市',
	wx_country varchar(200) NULL COMMENT '微信国家编号',
	wx_headimg_url varchar(2000) NULL COMMENT '微信用户头像',
	wx_privilege LONGTEXT NULL COMMENT '微信特权信息',
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	CONSTRAINT t_user_ext_info_pk PRIMARY KEY (user_id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='用户附加信息表';
