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
package proj.herveyhall.conf;

import java.io.Serializable;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.mgt.DefaultSessionStorageEvaluator;
import org.apache.shiro.mgt.DefaultSubjectDAO;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.ShiroHttpServletRequest;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author HerveyHall
 */
@Configuration
public class ShiroConfig {

	@Value("${shiro.authToken:x-auth-token}")
	private String authTokenKey;

	@Bean
	@ConditionalOnMissingBean
	public ShiroFilterFactoryBean shiroFilterFactoryBean(
			@Qualifier("securityManager") DefaultWebSecurityManager securityManager) {
		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		shiroFilterFactoryBean.setSecurityManager(securityManager);
		return shiroFilterFactoryBean;
	}

	@Bean
	@ConditionalOnMissingBean
	public DefaultWebSecurityManager securityManager(@Qualifier("freePasswordRealm") AuthorizingRealm authRealm,
			@Qualifier("sessionManager") DefaultWebSessionManager sessionManager) {
		authRealm.setAuthenticationTokenClass(AuthenticationToken.class);
		DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
		securityManager.setRealm(authRealm);
		securityManager.setSessionManager(sessionManager);
		// In order to provide a state-less Restful Service, it is necessary to disable Shiro's Session persistence function.
		((DefaultSessionStorageEvaluator) ((DefaultSubjectDAO) securityManager.getSubjectDAO())
				.getSessionStorageEvaluator()).setSessionStorageEnabled(false);
		return securityManager;
	}

	@Bean
	@ConditionalOnMissingBean
	public DefaultWebSessionManager sessionManager() {
		DefaultWebSessionManager sessionManager = new DefaultWebSessionManager() {
			@Override
			protected Serializable getSessionId(ServletRequest request, ServletResponse response) {
				String token = WebUtils.toHttp(request).getHeader(authTokenKey);
				if (StringUtils.isNoneBlank(token)) {
					request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID_SOURCE, "url");
					request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID, token);
					request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID_IS_VALID, Boolean.TRUE);
					return token;
				}
				return null;
			}
		};
		// Shiro's session is placed in a cookie by default. Disabled.
		sessionManager.setSessionIdCookieEnabled(false);
		// Disable url rewriting, the default jsessionId is id when shiro requests.
		sessionManager.setSessionIdUrlRewritingEnabled(false);
		return sessionManager;
	}

	@Bean
	@ConditionalOnMissingBean
	public AuthorizingRealm freePasswordRealm() {
		return new AuthorizingRealm() {

			@Override
			protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
				return null;
			}

			@Override
			protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token)
					throws AuthenticationException {
				return new SimpleAuthenticationInfo(String.valueOf(token.getPrincipal()), new char[0], getName());
			}
		};
	}
}
