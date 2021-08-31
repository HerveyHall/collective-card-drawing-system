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

import java.io.PrintWriter;
import java.io.StringWriter;

import proj.herveyhall.vo.Rsp;

/**
 * Provides the standard response message format.
 * 
 * @author HerveyHall
 */
public class RspUtil {

	public static <T> Rsp<T> rsp(int code, String desc, T res) {
		return new Rsp<>(code, desc, res, null);
	}

	public static <T> Rsp<T> rsp(T res) {
		return rsp(200, "success", res);
	}

	public static <T> Rsp<T> rsp(int code, Throwable throwable) {
		StringWriter stringWriter = new StringWriter();
		throwable.printStackTrace(new PrintWriter(stringWriter));
		return new Rsp<>(code, throwable.getMessage(), null, stringWriter.toString());
	}
}
