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

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.common.util.SendMessage;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Order;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.Review;
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
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;

	@Test
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
		member.setMemberId("owner01@zzupzzup.com"); // memberId

		reservation.setRestaurant(restaurant);
		reservation.setChat(chat);
		reservation.setMember(member);
		
		//reservation.setPlanDate(2021-20-12); // 예약 시간
		reservation.setPlanTime("12:12"); // 예약 시간
		reservation.setMemberCount(3); // 예약 인원 수
		reservation.setReservationStatus(1); // 예약 및 결제 현황
		reservation.setFixedStatus(false); // 방문 확정 여부
		reservation.setTotalPrice(10000); // 주문 메뉴 총 가격
		reservation.setPayOption(2); //결제 방법 (선결제, 방문결제)
		reservation.setPayMethod("아임포트~~"); // 결제 수단
		reservation.setReservationCancelReason(2); // 예약 및 결제 취소 유형
		reservation.setReservationCancelDetail("재고가 없네용~^^^^"); // 예약 및 결제 취소 상세 내용
		reservation.setRefundStatus(false); // 환불 여부
		
		reservationService.addReservation(reservation);
	}
	
//=======================================================================================
	
		 //@Test 
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
		 
		//@Test
		public void testListReservation() throws Exception {
			Search search = new Search();
			
			search.setCurrentPage(3);		
			search.setPageSize(pageSize);
			
			//해당 음식점의 리뷰 출력
			String restaurantNo = "1";
			//내가 작성한 리뷰 출력 
			String memberId = "hihi@a.com";
			
			
			Map<String, Object> map = reservationService.listReservation(search, restaurantNo);
			
			List<Reservation> list = (List<Reservation>) map.get("list");
			
			System.out.println("reservation list success");
			
			for (Reservation r : list) {
				System.out.println(r.getReservationNo());
			}
			
			 Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			 System.out.println(resultPage);
		}

//========================================================================================
 
		//@Test
		public void testListMyReservation() throws Exception {
			Search search = new Search();
			
			Member member = new Member();
			member.setMemberId("hihi@a.com");
			member.setMemberRole("user");
			
			//String memberId = "user";
			String restaurantNo = null;
				
			Map<String, Object> map = reservationService.listMyReservation(search, member, restaurantNo);
				
			List<Reservation> list = (List<Reservation>) map.get("list");
				
			System.out.println("reservation mylist success");
				
			for (Reservation r : list) {
				System.out.println(r);
			}
		}	
	
//========================================================================================
		
		//@Test
		public void testUpdateReservation() throws Exception {
			
			Reservation reservation = new Reservation();
			
			reservation.setReservationNo(15);
			//reservation.setFixedDate(null); now()여서 없는지 확인
			reservation.setReservationStatus(1);
			//reservation.setReservationCancelDate(null);
			reservation.setFixedStatus(false);
			reservation.setReservationCancelReason(1);
			reservation.setReservationCancelDetail("1605는 떠납니다.~~");
		
			//reservationService.updateReservation(reservation);
			
			if(reservationService.updateReservation(reservation) == 1) {
				System.out.println("review update success");
			}
		
		}
		
//========================================================================================	
		
		//@Test
		public void testSendMessage() throws Exception {
	
			SendMessage sendMessage = new SendMessage();
			
			sendMessage.sendMessage("010-3023-5823","유희주 coolsms 명의 내놔~~~~~~~~");
			//for문을 돌리는 member.getMemerphone 위에값을 list에 넣어서 넣기
		
		}
}