package com.zzupzzup.service.reservation;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;

public interface ReservationService {
	
	// INSERT
	public int addReservation(Reservation reservation) throws Exception ;

	// SELECT ONE
	public Reservation getReservation(int reservationNo) throws Exception ; //reservationNo를 넣게되면 거기서부터 get/ list에 restaurantNo를 넣어준건 내가 레스토랑이 몇개가있는지 보려고

	// SELECT LIST
	public Map<String, Object> listReservation(Search search, String restaurantNo) throws Exception ;//관리자가 보는 목록
	
	// SELECT LIST
	public Map<String, Object> listMyReservation(Search search, Member memberId, String restaurantNo) throws Exception ;//업주, 유저가 보는 목록. 업주는 레스토랑이 여러개 있을 수있어서 레스토랑no값을 넣어줌	

	// UPDATE
	public int updateReservation(Reservation reservation) throws Exception ;
	
	
	public void sendMessage(String phone, String text) throws Exception ;
			

}
