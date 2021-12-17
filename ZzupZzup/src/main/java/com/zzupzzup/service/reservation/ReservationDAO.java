package com.zzupzzup.service.reservation;

import java.util.List;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Reservation;

//==> 예약/결제에서 CRUD 추상화/캡슐화한 DAO Interface Definition
public interface ReservationDAO {
	
	// INSERT
	public int addReservation(Reservation reservation) throws Exception ;

	// SELECT ONE
	public Reservation getReservation(int reservationNo) throws Exception ;

	// SELECT LIST
	public List<Reservation> listReservation(Search search) throws Exception ;// 내일 질문
	
	// SELECT LIST
	public List<Reservation> listMyReservation(Search search, String memberId) throws Exception ;


	// UPDATE
	public void updateReservation(Reservation reservation) throws Exception ;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
}
