package com.zzupzzup.service.reservation.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;
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
		
		@Override
		public int updateReservation(Reservation reservation) throws Exception {

			return sqlSession.update("ReservationMapper.updateReservation", reservation);
		}
		
		@Override
		public List<Reservation> listReservation(Map<String, Object> map) throws Exception {
			
			List<Reservation> list = sqlSession.selectList("ReservationMapper.listReservation",map);
			
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> newMap = new HashMap<String, Object>();
				newMap.put("member", map.get("member"));
				newMap.put("reservationNo", list.get(i).getReservationNo());
				list.get(i).setReviewNo(reviewCheck(newMap));
			}
			
			return list;
		}
			
		@Override
		public List<Reservation> listMyReservation(Map<String, Object> map) throws Exception {
			
			List<Reservation> list = sqlSession.selectList("ReservationMapper.listMyReservation", map);
			return list;
		}
		
		// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
		public int getTotalCount(Map<String, Object> map) throws Exception {
			return sqlSession.selectOne("ReservationMapper.getTotalCount", map);
		}

		//review 작성 check를 위한 dao
		@Override
		public String reviewCheck(Map<String, Object> map) throws Exception {
			// TODO Auto-generated method stub
			return sqlSession.selectOne("ReservationMapper.listReviewCheck", map);
		}


}
