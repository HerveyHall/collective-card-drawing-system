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
package proj.herveyhall.user.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import proj.herveyhall.dao.UserAccountMapper;
import proj.herveyhall.dao.UserExtInfoMapper;
import proj.herveyhall.po.UserAccount;
import proj.herveyhall.po.UserExtInfo;
import proj.herveyhall.user.service.IUserService;

/**
 * @author HerveyHall
 */
@Service
public class UserServiceImpl implements IUserService {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);

	@Autowired
	private UserAccountMapper userAccountMapper;

	@Autowired
	private UserExtInfoMapper userExtInfoMapper;

	@Override
	public UserAccount fetchUserAccountByLoginName(String loginName) {
		Wrapper<UserAccount> wrapper = new QueryWrapper<>(new UserAccount());
		wrapper.getEntity().setLoginName(loginName);
		return userAccountMapper.selectOne(wrapper);
	}

	@Override
	public UserExtInfo loadUserExtInfo(Long userId) {
		return userExtInfoMapper.selectById(userId);
	}

	@Override
	public UserAccount createUser(String loginName) {
		try {
			createGenericUserAccount(loginName);
		} catch (DuplicateKeyException e) {
			LOGGER.error(e.getMessage(), e);
			return fetchUserAccountByLoginName(loginName);
		}
		UserAccount userAccount = fetchUserAccountByLoginName(loginName);
		createInitialUserExtInfo(userAccount.getUserId());
		return userAccount;
	}

	@Override
	public void createGenericUserAccount(String loginName) {
		UserAccount userAccount = new UserAccount();
		userAccount.setLoginName(loginName);
		userAccountMapper.insert(userAccount);
	}

	@Override
	public void createInitialUserExtInfo(Long userId) {
		UserExtInfo userExtInfo = new UserExtInfo();
		userExtInfo.setUserId(userId);
		userExtInfoMapper.insert(userExtInfo);
	}
}
