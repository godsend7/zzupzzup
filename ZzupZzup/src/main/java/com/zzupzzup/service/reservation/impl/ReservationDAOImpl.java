package com.zzupzzup.service.reservation.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.reservation.ReservationDAO;


	@Repository("reservationDAOImpl")
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
		public int addReservation(Reservation reservation) throws Exception {
			return sqlSession.insert("ReservationMapper.addReservation", reservation);
		}

		public Reservation getReservation(int reservationNo) throws Exception {
			return sqlSession.selectOne("ReservationMapper.getReservation", reservationNo);
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
