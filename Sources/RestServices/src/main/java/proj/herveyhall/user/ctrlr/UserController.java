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
package proj.herveyhall.user.ctrlr;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import proj.herveyhall.auth.dto.UserDto;
import proj.herveyhall.auth.shiro.token.FreePasswordToken;
import proj.herveyhall.po.UserAccount;
import proj.herveyhall.user.service.IUserService;
import proj.herveyhall.util.AuthUtil;
import proj.herveyhall.vo.Rsp;

import static proj.herveyhall.util.RspUtil.rsp;

/**
 * @author HerveyHall
 */
@RestController("user")
public class UserController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private IUserService userService;

	@PostMapping("/auth/{loginName}")
	public Rsp<UserDto> auth(@PathVariable("loginName") String loginName) {
		Subject userSubject = SecurityUtils.getSubject();
		boolean doLogin = !userSubject.isAuthenticated();
		Session session;
		UserAccount userAccount = null;
		if (doLogin) {
			userAccount = userService.fetchUserAccountByLoginName(loginName);
			if (null == userAccount) {
				userAccount = userService.createUser(loginName);
				LOGGER.info("User \"{}\" registered!", loginName);
			}
			userSubject.login(new FreePasswordToken(loginName, null));
			LOGGER.info("User \"{}\" logged in!", loginName);
		}
		session = userSubject.getSession();
		if (doLogin) {
			session.setAttribute(session.getId(), new UserDto(session.getId().toString(), userAccount,
					userService.loadUserExtInfo(userAccount.getUserId())));
		}
		return rsp((UserDto) session.getAttribute(session.getId()));
	}

	@GetMapping("/currentUser")
	public Rsp<UserDto> currentUser() {
		return rsp(AuthUtil.currentUser());
	}
}
