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
package proj.herveyhall.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import proj.herveyhall.auth.dto.UserDto;

/**
 * Use ThreadLocal to manage current users.
 * 
 * @author HerveyHall
 */
public class AuthUtil {

	public static final Logger LOGGER = LoggerFactory.getLogger(AuthUtil.class);

    private static volatile InheritableThreadLocal<UserDto> localUser = new InheritableThreadLocal<>();

    public static UserDto currentUser() {
    	logThreadId();
		return localUser.get();
    }

    public static void putUser(UserDto user) {
    	logThreadId();
    	localUser.set(user);
    }

    private static void logThreadId() {
    	LOGGER.info(String.format("Current thread id is %d", Thread.currentThread().getId()));
    }
}
