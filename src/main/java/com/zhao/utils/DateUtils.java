package com.zhao.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils {
	
	private static final long day = 60 * 60 * 24 * 1000;
	/**
	 * 取得今天的开始时间（毫秒）
	 *
	 * @return
	 */
	public static long getTodayBeginningTime() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, cal.getMinimum(Calendar.HOUR_OF_DAY));
		cal.set(Calendar.MINUTE, cal.getMinimum(Calendar.MINUTE));
		cal.set(Calendar.SECOND, cal.getMinimum(Calendar.SECOND));
		cal.set(Calendar.MILLISECOND, cal.getMinimum(Calendar.MILLISECOND));
		return cal.getTimeInMillis();
	}

	/**
	 * 今天的开始时间
	 * @return
	 */
	public static Date todayBeginAt() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	/**
	 * 今天的结束时间
	 * @return
	 */
	public static Date todayEndAt() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 23);
		cal.set(Calendar.MINUTE, 59);
		cal.set(Calendar.SECOND, 59);
		cal.set(Calendar.MILLISECOND, 999);
		return cal.getTime();
	}

	/**
	 * 获取指定时间，指定天数前 开始时间
	 * @return
	 */
	public static Date beginTime(Date date, int dayNum) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, -dayNum);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		return cal.getTime();
	}
	
	/**
	 *  获取指定天数前 结束时间
	 * @param dayNum
	 * @return
	 */
	public static Date endTime(int dayNum) {
		Date todayBeginAt = todayEndAt();
		long time = todayBeginAt.getTime();
		long yesterDay = time - day * dayNum;
		return new Date(yesterDay);
	}
	
	/**
	 * 返回指定时间当天的开始时间
	 * @param input
	 * @return
	 */

	public static Date dailyMinTimeOfDate(Date input) {
		Calendar c = Calendar.getInstance();
		c.setTime(input);
		c.set(Calendar.HOUR_OF_DAY, c.getMinimum(Calendar.HOUR_OF_DAY));
		c.set(Calendar.MINUTE, c.getMinimum(Calendar.MINUTE));
		c.set(Calendar.SECOND, c.getMinimum(Calendar.SECOND));
		c.set(Calendar.MILLISECOND, c.getMinimum(Calendar.MILLISECOND));
		return c.getTime();
	}
	
	/**
	 * yyyy-MM-dd HH:mm:ss 格式转换成date类型
	 * @param strTime
	 * @return
	 */
	public static Date getDate(String strTime) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = null;
		;
		try {
			date = sdf.parse(strTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

}
