package com.zzupzzup.service.reservation.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.reservation.ReservationService;
import com.zzupzzup.service.reservation.ReservationDAO;

	@Service("reservationServiceImpl")
	public class ReservationServiceImpl implements ReservationService{
		
		///Field
		@Autowired
		@Qualifier("reservationDaoImpl")
		private ReservationDAO reservationDao;
		public void setReservationDAO(ReservationDAO reservationDao) {
			this.reservationDao = reservationDao;
		}
		
		///Constructor
		public ReservationServiceImpl() {
			System.out.println(this.getClass());
		}

		///Method
		public int addReservation(Reservation reservation) throws Exception {
			return reservationDao.addReservation(reservation);
		}

		public Reservation getReservation(int reservationNo) throws Exception {
			return reservationDao.getReservation(reservationNo);
		}

		public Map<String , Object > listReservation(Search search) throws Exception {
			List<Reservation> list= reservationDao.listReservation(search);
			int totalCount = reservationDao.getTotalCount(search);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list );
			map.put("totalCount", new Integer(totalCount));
			
			return map;
		}
		
		public Map<String , Object > listMyReservation(Search search, String memberId) throws Exception {
			List<Reservation> list= reservationDao.listReservation(search);
			int totalCount = reservationDao.getTotalCount(search);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list );
			map.put("totalCount", new Integer(totalCount));
			
			return map;
		}

		public void updateReservation(Reservation reservation) throws Exception {
			reservationDao.updateReservation(reservation);
		}

}
