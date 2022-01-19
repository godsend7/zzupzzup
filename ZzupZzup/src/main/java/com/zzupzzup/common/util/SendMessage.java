package com.zzupzzup.common.util;

import java.util.HashMap;

import org.json.simple.JSONObject;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class SendMessage {
	
	public void sendMessage() {}
	
	 public void sendMessage( Reservation reservation, String text, Member toMember, Member fromMember, String reservationNo, String memberId, String restaurantNo) {
		 
		 
		 	//업주 경우 받는 업주 핸드폰번호 : 해당유저가 예약번호/닉네임 님이 예약을 취소하셨습니다.
		 	//유저 경우 받는 유저 핸드폰번호 : 업주가 (가게사유 reservationCanceltype+reservationCancelReason)으로 고객님의 예약을 거절하셨습니다.
		    
		 	String api_key = "NCSNKY0LCPXFSTX8";
		    String api_secret = "JRFMP2VNN1JPWKAQS7XQSILZ1NI6TKAR";
		    Message coolsms = new Message(api_key, api_secret);
		    Member member = new Member();
		
		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> map = new HashMap<String, String>();
		    map.put("to", toMember.getMemberPhone());        
		    map.put("from", fromMember.getMemberPhone());
			map.put("restaurantNo", restaurantNo);
			map.put("reservationNo", reservationNo);
			map.put("memberId", memberId);
			//params.put("from", "010-8256-2987");
		    
			if(toMember.getMemberRole().equals("user")) {
				map.put("text", reservation.getReservationCancelDetail()+reservation.getReservationCancelReason()+
						"이유로 고객님의 예약을 거절하셨습니다.");
				System.out.println("usertextMessage::");
			}
			else if  (toMember.getMemberRole().equals("owner")){
				map.put("text","예약 번호"+reservation.getReservationNumber()+" "+member.getNickname()+"님이 예약을 취소하셨습니다.");
				System.out.println("ownertextMessage::");
			}
			map.put("type", "SMS");
			//map.put("text", "");
			map.put("app_version", "test app 1.2"); // application name and version

		    try {
		      JSONObject obj = (JSONObject) coolsms.send(map);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
		  }
		

}
