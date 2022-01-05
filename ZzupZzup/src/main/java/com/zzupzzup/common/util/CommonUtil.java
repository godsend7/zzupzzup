package com.zzupzzup.common.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.Locale;

import org.apache.commons.io.FilenameUtils;


public class CommonUtil {
	
	///Field
	private static final String AGE_TEN = "10대";
	private static final String AGE_TWENTY = "20대";
	private static final String AGE_THIRTY = "30대";
	private static final String AGE_FOURTY = "40대";
	private static final String AGE_FIFTY = "50대";
	private static final String AGE_ELDER = "60대 이상";
	
	private static final String MEMEBER_RANK_1 = "쩝린이";
	private static final String MEMEBER_RANK_2 = "쩝쩝학사";
	private static final String MEMEBER_RANK_3 = "쩝쩝석사";
	private static final String MEMEBER_RANK_4 = "쩝쩝박사";
	
	private static final String DELETE_TYPE_1 = "더 이상 이 서비스를 이용하고 싶지 않아서";
	private static final String DELETE_TYPE_2 = "기존의 타 사이트를 이용하고 있어서";
	private static final String DELETE_TYPE_3 = "탈퇴 후 재가입을 위해서";
	
	public static final String IMAGE_PATH = "/resources/images/uploadImages";
	
	public static String returnAgeRange(String ageRange) {
		
		int parseAge = Integer.parseInt(ageRange.substring(0, 1));
		String age = null;
		
		switch (parseAge) {
		case 1:
			age = AGE_TEN;
			break;
		case 2:
			age = AGE_TWENTY;
			break;
		case 3:
			age = AGE_THIRTY;
			break;
		case 4:
			age = AGE_FOURTY;
			break;
		case 5:
			age = AGE_FIFTY;
			break;
		case 6:
		case 7:
		case 8:
		case 9:
		case 10:
			age = AGE_ELDER;
			break;
		default:
			break;
		}
		
		return age;
	
	}
	
	public static String returnGender(String gender) {
		
		String genderData = null;
		
		if(gender.startsWith("F") || gender.startsWith("f")) {
			genderData = "female";
		} else {
			genderData = "male";
		}
		
		
		return genderData;
	}
	
	public static String returnMemberRank(int activityScore) {
		
		if (activityScore <= 100) {
			return MEMEBER_RANK_1;	
		} else if (activityScore > 100 && activityScore < 250) {
			return MEMEBER_RANK_2;	
		} else if (activityScore >= 250 && activityScore < 500) {
			return MEMEBER_RANK_3;	
		} else if (activityScore >= 500) {
			return MEMEBER_RANK_4;	
		} else {
			return null;
		}
		
	}
	
	public static String returnDeleteData(int deleteType) {
		if (deleteType == 1) {
			return DELETE_TYPE_1;
		} else if (deleteType == 2) {
			return DELETE_TYPE_2;
		} else if (deleteType == 3) {
			return DELETE_TYPE_3;
		} else {
			return null;
		}
	}
	
	public static String returnTelNum(String num1, String num2, String num3) {
		return num1+"-"+num2+"-"+num3;
	}
	
	public static String intToStringMenuType(int menuType) {
		
		String typeName = "";
		
		if(menuType == 1) {
			typeName = "한식";
			
			return typeName;
			
		} else if(menuType == 2) {
			typeName = "중식";
			
			return typeName;
			
		} else if(menuType == 3) {
			typeName = "일식";
			
			return typeName;
			
		} else if(menuType == 4) {
			typeName = "양식";
			
			return typeName;
		
		} else if(menuType == 5) {
			typeName = "카페";
			
			return typeName;
		
		} else {
			
			return "YOU CAN NOT TRANSFORMATION";
		}
		
	}
	
	public static String reservationStatus(int reservationStatus) {
		
		String typeName = "";
		
		if(reservationStatus == 0) {
			typeName = "결제완료";
			
			return typeName;
			
		} else if(reservationStatus == 1) {
			typeName = "방문완료";
			
			return typeName;
			
		} else if(reservationStatus == 2) {
			typeName = "미방문";
			
			return typeName;
			
		} else if(reservationStatus == 3) {
			typeName = "예약 취소";
			
			return typeName;
		
		} else if(reservationStatus == 4) {
			typeName = "예약 거절";
			
			return typeName;
		
		} else {
			
			return null;
		}
		
	}
	
	public static String payOption(int payOption) {
		
		String typeName = "";
		
		if(payOption == 1) {
			typeName = "방문결제";
			
			return typeName;
			
		} else if(payOption == 2) {
			typeName = "선결제";
			
			return typeName;
		
		} else {
			
			return null;
		}
		
	}
	
	public static String returnReportData(int reportCategory, int reportType) {
		
		String data = "";
		
		if (reportCategory == 1) {
			switch (reportType) {
				case 1:
					data = "허위 광고성 채팅방 입니다.";
					break;
				case 2:
					data = "부적절한 언행을 사용하였습니다.";
					break;
			}
		} else if(reportCategory == 2) {
			switch (reportType) {
				case 1:
					data = "돈을 지불하지 않았습니다.";
					break;
				case 2:
					data = "부적절한 언행을 사용하였습니다.";
					break;
				case 3:
					data = "약속에 불참하였습니다.";
					break;
			}
		} else if(reportCategory == 3) {
			switch (reportType) {
				case 1:
					data = "허위 광고성 리뷰입니다.";
					break;
				case 2:
					data = "부적절한 언어를 사용하였습니다.";
					break;
				case 3:
					data = "해당음식점과 일치하지 않는 내용입니다.";
					break;
			}
		} else if(reportCategory == 4) {
			switch (reportType) {
				case 1:
					data = "허위 광고성 게시물입니다.";
					break;
				case 2:
					data = "부적절한 언어를 사용하였습니다.";
					break;
				case 3:
					data = "해당 음식점과 일치하는 영수증이 아닙니다.";
					break;
			}
		} else if(reportCategory == 5) {
			switch (reportType) {
				case 1:
					data = "일치하지 않는 정보를 제공하고 있습니다.";
					break;
				case 2:
					data = "영업시간이 다릅니다.";
					break;
				case 3:
					data = "폐점된 가게입니다.";
					break;
			}
		}
		return data;
	}
	
	
	public static String getTimeStamp(String pattern, String fileName) {

        String newFileName = new SimpleDateFormat(pattern).format(new Date());  //현재시간
        //System.out.println("변형된 파일 이름 출력 => " + newFileName);
        
        //확장자 제외한 이름 출력
        String originName = FilenameUtils.getBaseName(fileName);
        //변경한 파일명_원본 파일명  
        newFileName = newFileName + "_" + originName;
        
        if (newFileName.length() > 50) {
			newFileName = null2str(newFileName.substring(0,46));
		}
       
        //newFileName + 확장자 출력
        newFileName = newFileName(FilenameUtils.getExtension(fileName), newFileName);
        //System.out.println("newFileName.확장자 출력 => " + newFileName);
        
        //System.out.println("최종 :: " + newFileName);
        
        return newFileName;
    }
	
	//======================================================================================================================
	
	///Method
	public static String newFileName(String ext, String fileName) {
		if (ext == null || ext.trim().length() == 0) 
			return fileName;
		else 
			return fileName+"."+ext;
	}
	
	public static String getDate(Timestamp regDate) {
		if (regDate == null || regDate.toString().trim().length() == 0) {
			return "";
		} else {
			return regDate.toString().split(" ")[0];
		}
	}
	
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
