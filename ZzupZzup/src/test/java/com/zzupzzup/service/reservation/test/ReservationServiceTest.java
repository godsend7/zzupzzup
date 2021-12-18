package com.zzupzzup.service.reservation.test;

import java.sql.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.reservation.ReservationService;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class ReservationServiceTest {

	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService reservationService;

	@Test
	public void testAddReservation() throws Exception {
		
		Reservation reservation = new Reservation();
		Restaurant restaurant = new Restaurant();
		Chat chat = new Chat();
		Member member = new Member();
		
		restaurant.setRestaurantNo(1); //음식점 예약no
		chat.setChatNo(1); //채팅 no
		member.setMemberId("hihi@a.com"); // memberId
		
		Date date = new Date(20211213);
		reservation.setPlanDate(date);	
		reservation.setFixedDate(date);
		reservation.setMemberCount(3);
		reservation.setReservationStatus(false);
		reservation.setReservationDate(date);
				
		
		

	}
}