package com.zzupzzup.web.reservation;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.http.HttpRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.service.chat.ChatService;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.reservation.ReservationService;
import com.zzupzzup.service.restaurant.RestaurantService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/reservation/*")

public class ReservationRestController {
	
	//Field
	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService reservationService;
	
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;
	
	@Autowired
	@Qualifier("chatServiceImpl")
	private ChatService chatService;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;
	
	public ReservationRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "json/updateReservation/{reservationNo}/{reservationStatus}", method = RequestMethod.GET)
	public int updateReservation(@PathVariable("reservationNo") int reservationNo, @PathVariable("reservationStatus") int reservationStatus, HttpSession session) throws Exception {
		
		System.out.println("/reservation/json/getReservation : GET");
		
		Member member = (Member) session.getAttribute("member");
		
		Reservation reservation = reservationService.getReservation(reservationNo);
		
		reservation.setMember(member);
		reservation.setReservationNo(reservationNo);
		reservation.setReservationStatus(reservationStatus);
		
		System.out.println("updateReservation reservation : " + reservation);
		
		  /////////////////////////////////////////////////////////////////////
	      // 예약상태 변경시 채팅방 상태 변경
	      if(reservationStatus == 1) {
	         chatService.updateChatState(reservation.getChat().getChatNo(), 4);
	      }else if(reservationStatus == 2 || reservationStatus == 3 || reservationStatus == 4) {
	         chatService.updateChatState(reservation.getChat().getChatNo(), 1);
	      }
	      ////////////////////////////////////////////////////////////////////
	      

		
		return reservationService.updateReservation(reservation);
	}
	
	@RequestMapping(value = "json/reservationCancel", method = RequestMethod.POST)
	public int reservationCancel(@RequestBody Reservation reservation, HttpServletRequest httpServletRequest, HttpSession session) throws Exception {
		
		System.out.println("/reservation/json/reservationCancel : GET");
		
		Member member = (Member) session.getAttribute("member");
		reservation.setMember(member);
		
		 //////////////////////////////////////////////////////////////////
	      // 예약 취소시 채팅방 상태 모임중 변경
	      Reservation reservationn = reservationService.getReservation(reservation.getReservationNo());
	      chatService.updateChatState(reservationn.getChat().getChatNo(), 1);
	      /////////////////////////////////////////////////////////////////

		
		return reservationService.updateReservation(reservation);
	}	
	
	@RequestMapping( value="json/addReservation", method=RequestMethod.POST )
	public int addReservation ( @RequestBody Reservation reservation, HttpServletRequest httpServletRequest) throws Exception {

		System.out.println("/reservation/addReservation : POST");
		//Business Logic
		return reservationService.addReservation(reservation);
	
	}
	
		///////////////////////////////////환불////////////////////////////////////////
		
		IamportClient client;
		
		public void setup() throws Exception {
		String api_key = "1022196707048541";
		String api_secret = "244054838c37987389b0bfc481e1281b3a67bb77a3102c1a21c6c8494a3e9c330ae9d261d8571a97";
		
		client = new IamportClient(api_key, api_secret);
		}
		
		public void testGetToken() throws Exception {
		String token = String.valueOf(client.getAuth());
		System.out.println("token : " + token);
		}
		
		@RequestMapping(value = "/json/payRefund/{reservationNo}/{payMethod}/{refundStatus}", method = RequestMethod.GET)
		public int payRefund(@PathVariable int reservationNo ,@PathVariable String payMethod ,@PathVariable boolean refundStatus, HttpSession session) throws Exception {
			// 이미 취소된 거래 imp_uid
			System.out.println("testCancelPaymentByImpUid --- Start!---");
			
			Member member = (Member) session.getAttribute("member");
			
			Reservation reservation = reservationService.getReservation(reservationNo);
			
			reservation.setReservationNo(reservationNo);
			reservation.setPayMethod(payMethod);
			reservation.setRefundStatus(true);
			reservation.setMember(member);
		
			Map<String, Object> map =  new HashMap<String,Object>();
			
			setup();
			testGetToken();
			setup();
			
			System.out.println("updateReservation reservation : " + reservation);
			
			CancelData cancel = new CancelData(payMethod, true);
			System.out.println("imp_uid : " + payMethod);
			IamportResponse<Payment> cancelpayment = client.cancelPaymentByImpUid(cancel);
			System.out.println(cancelpayment.getMessage());
			System.out.println("testCancelPaymentByImpUid --- End!---");
			
			return reservationService.updateReservation(reservation);
		}
		
		///////////////////////////////환불 끝///////////////////////////////////////////////
		//==================================================================================================
		
		   @RequestMapping(value="json/sendPhoneMessage", method=RequestMethod.POST)
		   public boolean sendMessage(HttpServletRequest httpServletRequest, HttpSession session) throws Exception{
		      
			   System.out.println("/reservation/sendPhoneMessage : POST");
			   Member fromMember = (Member) session.getAttribute("member");//보내는 사람
			   Member toMember = new Member();
			   Reservation reservation = new Reservation();
			   String reservationNumber = "";
			   Restaurant restaurant = new Restaurant();
			   
			   System.out.println("reservation number::: "+httpServletRequest.getParameter("reservationNumber"));
			   System.out.println("sendPhone::: "+httpServletRequest.getParameter("toMemberPhone"));
			   System.out.println("nickname::: "+httpServletRequest.getParameter("toNickName"));
			   System.out.println("nickname::: "+httpServletRequest.getParameter("reservationCancelDetail"));
			   System.out.println("nickname::: "+httpServletRequest.getParameter("reservationCancelReason"));
			   System.out.println("restaurantNo::: "+httpServletRequest.getParameter("restaurantNo"));
			   System.out.println("restaurantNo::: "+httpServletRequest.getParameter("fromMemberPhone"));
			   
			   
			   //from 세션이라고 생각. from은 폰번호만 필요 from에 저장된 세션 내가 로그인한 사람. 내가 업주인지 유저인지 감 from.setmemberrole해서 멤버면 이렇게 유저면 이렇게 실행해라 기재
			   //to가 보내는 것이라 생각.
			   if(fromMember.getMemberRole().equals("user")) {
				   restaurant = restaurantService.getRestaurant(Integer.parseInt(httpServletRequest.getParameter("restaurantNo")));
				   restaurant.getMember().getMemberId();
				
				   Member member = new Member();
				   member.setMemberId(restaurant.getMember().getMemberId());
				   toMember = memberService.getMember(member);
				   reservation.setReservationNumber(httpServletRequest.getParameter("reservationNumber"));
				   System.out.println("유저가 예약 취소 진행");
			   }
			   else if (fromMember.getMemberRole().equals("owner")) {
				   toMember.setMemberPhone(httpServletRequest.getParameter("toMemberPhone"));
				   toMember.setNickname(httpServletRequest.getParameter("toNickName"));
				   
				   reservation.setReservationCancelDetail(httpServletRequest.getParameter("reservationCancelDetail"));
				   reservation.setReservationCancelReason(Integer.parseInt(httpServletRequest.getParameter("reservationCancelReason")));
			        System.out.println("nickname::: "+reservation.getReturnReservationCancelReason());
			        
			        System.out.println("업주가 예약 취소 진행");
			   }
			   
			   System.out.println("reservation 확인 :: " + reservation.getReservationNumber());
			  
		      return reservationService.sendMessage(reservation, toMember,fromMember, reservationNumber);
		   }
		   /////////////////////////////////무한 스크롤////////////////////////////////////////
		   
		   @RequestMapping("json/listReservation")
			public Map<String, Object> listReservation(@ModelAttribute("search") Search search, HttpServletRequest request, @RequestParam  Map<String, Object> map, HttpSession session) throws Exception {
				
				System.out.println("review/json/listReservation : Service");
				
				String restaurantNo = request.getParameter("restaurantNo");
				Member member = (Member) session.getAttribute("member");
				
				search.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
				///
				if(search.getCurrentPage() == 0 ){
					search.setCurrentPage(1);
				}
				
				if(search.getSearchSort() == null || search.getSearchSort() == "") {
					search.setSearchSort("latest");
				}
				///
				search.setPageSize(pageSize);
				
				System.out.println(search.getCurrentPage() + ":: currentPage");
				
				map.put("search", search);	
				
				Map<String, Object> resultMap = reservationService.listReservation(search, member, restaurantNo);
				
				List<Reservation> list = (List<Reservation>) resultMap.get("list");
				
				Restaurant restaurant = new Restaurant();
				Chat chat = new Chat();
				Member memberChat = new Member();
				
				for (Reservation r : list ) {
					restaurant = restaurantService.getRestaurant(r.getRestaurant().getRestaurantNo());
					memberChat = memberService.getMember(r.getMember());
					member = memberService.getMember(member);//member 못불러와서 추가
					chat = chatService.getChat(r.getChat().getChatNo());
					chat.setChatLeaderId(memberChat);
					r.setMember(member);
					r.setRestaurant(restaurant);
					r.setChat(chat);//무한스크롤에 업주Id 안나와서 추가
				}
				
				Page resultPage = new Page(search.getCurrentPage(), ((Integer)resultMap.get("totalCount")).intValue(), pageUnit, pageSize);
				
				resultMap.put("resultPage", resultPage);
				resultMap.put("search", search);
				
				return resultMap;
			}
	
}
