package com.zzupzzup.common.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;


public class CommonUtil {
	
	///Field
	private static final String AGE_TEN = "10대";
	private static final String AGE_TWENTY = "20대";
	private static final String AGE_THIRTY = "30대";
	private static final String AGE_FOURTY = "40대";
	private static final String AGE_FIFTY = "50대";
	private static final String AGE_ELDER = "60대 이상";
	
	private static final String GRADE_1 = "쩝린이";
	private static final String GRADE_2 = "쩝쩝학사";
	private static final String GRADE_3 = "쩝쩝석사";
	private static final String GRADE_4 = "쩝쩝박사";
	
	///Constructor
	
	
	
	public static String test(int activityScore) {
		
		if (activityScore >= 0 && activityScore <= 100) {
			return GRADE_1;	
		} else if (activityScore > 100 && activityScore < 100) {
			return GRADE_2;	
		} else if (activityScore > 0 && activityScore < 100) {
			return GRADE_3;	
		} else if (activityScore >= 500) {
			return GRADE_4;	
		} else {
			return null;
		}
		
	}
	
	
	///Method
	public static String null2str(String org, String converted) {
		if (org == null || org.trim().length() == 0)
			return converted;
		else
			return org.trim();
	}

	public static String null2str(String org) {
		return CommonUtil.null2str(org, "");
	}

	public static String null2str(Object org) {
		if (org != null && org instanceof java.math.BigDecimal) {
			return CommonUtil.null2str((java.math.BigDecimal) org, "");
		} else {
			return CommonUtil.null2str((String) org, "");
		}
	}

	public static String null2str(java.math.BigDecimal org, String converted) {
		if (org == null)
			return converted;
		else
			return org.toString();
	}

	public static String null2str(java.math.BigDecimal org) {
		return CommonUtil.null2str(org, "");
	}

	public static String toDateStr(String dateStr) {
		if (dateStr == null)
			return "";
		else if (dateStr.length() != 8)
			return dateStr;
		else
			return dateStr.substring(0, 4) + "/" + dateStr.substring(4, 6)
					+ "/" + dateStr.substring(6, 8);
	}

	public static String toDateStr(Timestamp date) {
		if (date == null)
			return "";
		else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			return sdf.format(new Date(date.getTime()));
		}
	}

	public static String toSsnStr(String ssnStr) {
		if (ssnStr == null)
			return "";
		else if (ssnStr.length() != 13)
			return ssnStr;
		else
			return ssnStr.substring(0, 6) + "-" + ssnStr.substring(6, 13);
	}

	public static String toAmountStr(String amountStr) {
		String returnValue = "";
		if (amountStr == null)
			return returnValue;
		else {
			int strLength = amountStr.length();

			if (strLength <= 3)
				return amountStr;
			else {
				String s1 = "";
				String s2 = "";
				for (int i = strLength - 1; i >= 0; i--)
					s1 += amountStr.charAt(i);

				for (int i = strLength - 1; i >= 0; i--) {
					s2 += s1.charAt(i);
					if (i % 3 == 0 && i != 0)
						s2 += ",";
				}

				return s2;
			}
		}
	}

	public static String toAmountStr(java.math.BigDecimal amount) {
		if (amount == null) {
			return "";
		} else {
			return toAmountStr(amount.toString());
		}
	}
}
