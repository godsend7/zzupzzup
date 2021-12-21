package com.zzupzzup.service.reservation.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.reservation.ReservationDAO;


	@Repository("reservationDaoImpl")
	public class ReservationDAOImpl implements ReservationDAO{
		
		///Field
		@Autowired
		@Qualifier("sqlSessionTemplate")
		private SqlSession sqlSession;
		
		public void setSqlSession(SqlSession sqlSession) {
			this.sqlSession = sqlSession;
		}
		
		///Constructor
		public ReservationDAOImpl() {
			System.out.println(this.getClass());
		}

		///Method
		@Override
		public int addReservation(Reservation reservation) throws Exception {
			
			int result = sqlSession.insert("ReservationMapper.addReservation", reservation);
			
			System.out.println("addReservation" + result);
			//reservation_no가 생성되었다면(=> review table에 insert되었다면)
			if (result == 1) {
				sqlSession.insert("ReservationMapper.addOrder", reservation);
				return 1;
			} else {
				return 0;
			}
		}
		
		@Override
		public Reservation getReservation(int reservationNo) throws Exception {
			
			System.out.println("ReservationDAOImpl getReservation");
			
			System.out.println("reservationNo::::"+reservationNo);
			
			
			Reservation reservation = sqlSession.selectOne("ReservationMapper.getReservation", reservationNo);
			
			System.out.println(reservation);
			
			//reservation.setRestaurant(sqlSession.selectOne("ReservationMapper.getRestaurant",reservation.getRestaurant()));
			
			//reservation.setChat(sqlSession.selectOne("ReservationMapper.getChat",reservation.getChat()));
			return reservation;
		}
		
		public void updateReservation(Reservation reservation) throws Exception {
			sqlSession.update("ReservationMapper.updateReservation", reservation);
		}

		public List<Reservation> listReservation(Search search) throws Exception {
			return sqlSession.selectList("ReservationMapper.listReservation", search);
		}

		public List<Reservation> listMyReservation(Search search, String memberId) throws Exception {
			
			return sqlSession.selectList("ReservationMapper.listMyReservation", search);
		}
		
		// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
		public int getTotalCount(Search search) throws Exception {
			return sqlSession.selectOne("ReservationMapper.getTotalCount", search);
		}


}
