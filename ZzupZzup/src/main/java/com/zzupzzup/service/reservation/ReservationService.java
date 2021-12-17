package com.zzupzzup.service.reservation;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Reservation;

public interface ReservationService {
	
	// INSERT
	public int addReservation(Reservation reservation) throws Exception ;

	// SELECT ONE
	public Reservation getReservation(int reservationNo) throws Exception ;

	// SELECT LIST
	public Map<String, Object> listReservation(Search search) throws Exception ;
	
	// SELECT LIST
	public Map<String, Object> listMyReservation(Search search, String memberId) throws Exception ;// 일단 질문	

	// UPDATE
	public void updateReservation(Reservation reservation) throws Exception ;
			

}
