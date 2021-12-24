package com.zzupzzup.service.reservation.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
import com.zzupzzup.common.util.SendMessage;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.reservation.ReservationService;
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
		public Map<String , Object > listReservation(Search search) throws Exception {
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("search", search);
			
			
			map.put("list", reservationDao.listReservation(map));
			map.put("totalCount", reservationDao.getTotalCount(search));
			
			return map;
		}
		
		@Override
		public Map<String , Object > listMyReservation(Search search, String memberId, String restaurantNo) throws Exception {
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("search", search);
			map.put("memberId", memberId);
			map.put("restaurantNo", restaurantNo);
			
			map.put("list", reservationDao.listMyReservation(map));
			map.put("totalCount", reservationDao.getTotalCount(search));
			
			return map;
		}
		
		@Override
		public int updateReservation(Reservation reservation) throws Exception {
			return reservationDao.updateReservation(reservation);
		}

		@Override
		public void sendMessage(String phone, String text) throws Exception {
			text = null;
			SendMessage sendMessage = new SendMessage();
			sendMessage.sendMessage(phone, text);
				
			
		}
		
	

		
}
