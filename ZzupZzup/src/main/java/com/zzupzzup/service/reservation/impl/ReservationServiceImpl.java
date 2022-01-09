package com.zzupzzup.service.reservation.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
import com.zzupzzup.common.util.SendMessage;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.reservation.ReservationService;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

import com.zzupzzup.service.reservation.ReservationDAO;

	@Service("reservationServiceImpl")
	public class ReservationServiceImpl implements ReservationService{
		
		///Field
		@Autowired
		@Qualifier("reservationDaoImpl")
		private ReservationDAO reservationDao;
		
		//public void setReservationDAO(ReservationDAO reservationDao) {
		//	this.reservationDao = reservationDao;
		//} 필요없으면 지우기
		
		///Constructor
		public ReservationServiceImpl() {
			System.out.println(this.getClass());
		}

		///Method
		@Override
		public int addReservation(Reservation reservation) throws Exception {
			return reservationDao.addReservation(reservation);
		}
		
		@Override
		public Reservation getReservation(int reservationNo) throws Exception {
			System.out.println("ReservationServiceImpl reservationNo" + reservationNo);
			return reservationDao.getReservation(reservationNo);
		}

		@Override
		//public Map<String , Object > listReservation(Search search, String restaurantNo) throws Exception {
		public Map<String , Object > listReservation(Search search, Member member, String restaurantNo) throws Exception {
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("search", search);
			map.put("member", member);
			map.put("restaurantNo", restaurantNo);
			
			map.put("list", reservationDao.listReservation(map));
			map.put("totalCount", reservationDao.getTotalCount(map));
			
			return map;
		}
		
		@Override
		public Map<String , Object > listMyReservation(Search search, Member member, String restaurantNo) throws Exception {
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("search", search);
			map.put("member", member);
			map.put("restaurantNo", restaurantNo);
			
			map.put("list", reservationDao.listMyReservation(map));
			map.put("totalCount", reservationDao.getTotalCount(map));
			
			return map;
		}
		
		@Override
		public int updateReservation(Reservation reservation) throws Exception {
			return reservationDao.updateReservation(reservation);
		}

		@Override
		public void sendMessage(Reservation reservation, Member toMember, Member fromMember, String reservationNumber) {
			 
			 
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
		   // map.put("reservation", reservation);
		    map.put("reservationNumber", reservationNumber);
			
			//params.put("from", "010-8256-2987");
		    
			if(fromMember.getMemberRole().equals("user")) {
				map.put("text","예약 번호"+reservation.getReservationNumber()+" "+member.getNickname()+"님이 예약을 취소하셨습니다.");
				System.out.println("ownertextMessage::");
			}
			else if  (fromMember.getMemberRole().equals("owner")){
				map.put("text", "가게 사정인 "+reservation.getReturnReservationCancelReason()+ " " +
						reservation.getReservationCancelDetail()+ " 이유로 고객님의 예약을 거절하셨습니다.");
				System.out.println("usertextMessage::");
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
