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
package proj.herveyhall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.web.servlet.HandlerInterceptor;

import proj.herveyhall.auth.dto.UserDto;
import proj.herveyhall.util.AuthUtil;

/**
 * @author HerveyHall
 */
public class AuthInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Session session = SecurityUtils.getSubject().getSession();
		AuthUtil.putUser((UserDto) session.getAttribute(session.getId()));
		// TODO Block users who are not logged in.
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
