package com.zzupzzup.service.reservation.test;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;

import org.junit.Assert;

import org.aspectj.apache.bcel.generic.ReturnaddressType;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Order;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.reservation.ReservationService;
import com.zzupzzup.service.restaurant.RestaurantService;
import com.zzupzzup.service.chat.ChatService;


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
	
//	@Autowired
//	@Qualifier("restaurantServiceImpl") //restaurant 서비스 타기위해 넣어줌
//	private RestaurantService restaurantService;
	
//	@Autowired
//	@Qualifier("chatServiceImpl") //restaurant 서비스 타기위해 넣어줌
//	private ChatService chatService;

	//@Test
	public void testAddReservation() throws Exception {
		
		Reservation reservation = new Reservation();
		Restaurant restaurant = new Restaurant();
		Chat chat = new Chat();
		Member member = new Member();
		
		List<Order> order = new ArrayList<Order>();
		Order o = new Order();
		o.setMenuTitle("sersrsfdsd");
		o.setOrderCount(3);
		o.setMenuPrice(1000);
	
		order.add(o);
		order.add(o);
		
		reservation.setOrder(order);
	
		restaurant.setRestaurantNo(1); //음식점 예약no
		chat.setChatNo(1); //채팅 no
		member.setMemberId("hihi@a.com"); // memberId

		reservation.setRestaurant(restaurant);
		reservation.setChat(chat);
		reservation.setMember(member);
		
		reservation.setMemberCount(3); // 예약 인원 수
		reservation.setReservationStatus(true); // 예약 및 결제 현황
		reservation.setFixedStatus(false); // 방문 확정 여부
		reservation.setTotalPrice(10000); // 주문 메뉴 총 가격
		reservation.setPayOption(2); //결제 방법 (선결제, 방문결제)
		reservation.setPayMethod(1); // 결제 수단
		reservation.setReservationCancelReason(2); // 예약 및 결제 취소 유형
		reservation.setReservationCancelDetail("재고가 없네용~^^^^"); // 예약 및 결제 취소 상세 내용
		reservation.setRefundStatus(false); // 환불 여부
		
		reservationService.addReservation(reservation);
	}
	
//=======================================================================================
	
		 @Test 
		 public void testGetReservation() throws Exception {
		 
		 Reservation reservation = new Reservation(); 
		 Restaurant restaurant = new Restaurant(); 
		 Chat chat = new Chat(); 
		 Member member = new Member();
		 
		 reservation.setReservationNo(17);
		 System.out.println("rervation get success:::" + reservation.toString());
		 
		 reservation = reservationService.getReservation(reservation.getReservationNo());
		 //restaurant join 안하고 컨트롤러 타는법
		 System.out.println("rervation get success22222:::" + reservation);
		 
		 restaurant.setRestaurantNo(1);
		 chat.setChatNo(1);
		 
		 //restaurant = restaurantService.getRestaurant(reservation.getRestaurant().getRestaurantNo());
		 
		 //chat = chatService.getChat(reservation.getChat().getChatNo());

		// reservationService.addReservation(reservation); 
		 }
		
//========================================================================================
		 
		 
		
}