package com.zhao.utils;

import java.util.UUID;

public class OtherUtils {

	/**
	 * 获取UUID
	 * @return
	 */
	public String getUUId() {
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		return uuid;
	}
	
}
