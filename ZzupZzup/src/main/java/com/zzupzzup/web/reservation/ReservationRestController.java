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
		
		Reservation reservation = new Reservation();
		
		reservation.setMember(member);
		reservation.setReservationNo(reservationNo);
		reservation.setReservationStatus(reservationStatus);
		//reservation.setReservationCancelReason(reservationCancelReason);
		
		System.out.println("getReservation reservation : " + reservation);
		
		return reservationService.updateReservation(reservation);
	}
	
	@RequestMapping(value = "json/reservationCancel", method = RequestMethod.POST)
	public int reservationCancel(@RequestBody Reservation reservation, HttpServletRequest httpServletRequest, HttpSession session) throws Exception {
		
		System.out.println("/reservation/json/reservationCancel : GET");
		
		Member member = (Member) session.getAttribute("member");
		reservation.setMember(member);
		
		return reservationService.updateReservation(reservation);
	}	
	
	@RequestMapping( value="json/addReservation", method=RequestMethod.POST )
	public int addReservation ( @RequestBody Reservation reservation, HttpServletRequest httpServletRequest) throws Exception {

		System.out.println("/reservation/addReservation : POST");
		//Business Logic
		//reservationService.addReservation(reservation);
		//reservation.setReservationNo(Integer.parseInt(httpServletRequest.getParameter("reservationNo")));
		
		System.out.println("/reservation/addReservation22222 : POST");
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
		
		@RequestMapping(value = "/json/payRefund/{reservationNo}/{payMethod}", method = RequestMethod.GET)
		public Map payRefund(@PathVariable int reservationNo ,@PathVariable String payMethod ) throws Exception {
		// 이미 취소된 거래 imp_uid
		System.out.println("testCancelPaymentByImpUid --- Start!---");
		
		Reservation reservation = new Reservation();
		
		reservation.setReservationNo(reservationNo);
		reservation.setPayMethod(payMethod);
		
		Map<String, Object> map =  new HashMap<String,Object>();
		
		setup();
		testGetToken();
		setup();
		//Order order = orderService.getFlightOrder(orderId);
		
		CancelData cancel = new CancelData(payMethod, true);
		System.out.println("imp_uid : " + payMethod);
		IamportResponse<Payment> cancelpayment = client.cancelPaymentByImpUid(cancel);
		System.out.println(cancelpayment.getMessage());
		System.out.println("testCancelPaymentByImpUid --- End!---");
		
		return map;
		}
		
		///////////////////////////////환불 끝///////////////////////////////////////////////
		//==================================================================================================
		
		   @RequestMapping(value="json/sendPhoneMessage", method=RequestMethod.POST)
		   public void sendMessage(HttpServletRequest httpServletRequest, HttpSession session) throws Exception{
		      
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
				   System.out.println("restraurantNo222::"+restaurant);
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
			   
			   System.out.println("toMember 확인 :: " + toMember);
			   System.out.println("fromMember 확인 :: " + fromMember);
			   System.out.println("reservation 확인 :: " + reservation.getReservationNumber());
			  
		       reservationService.sendMessage(reservation, toMember,fromMember, reservationNumber);
		   }
		   /////////////////////////////////무한 스크롤////////////////////////////////////////
		   
		   @RequestMapping("json/listReservation")
			public Map<String, Object> listReservation(HttpServletRequest request, @RequestParam  Map<String, Object> map, HttpSession session) throws Exception {
				
				System.out.println("review/json/listReservation : Service");
				
				String restaurantNo = request.getParameter("restaurantNo");
				System.out.println("json/listReservation :: " + restaurantNo);
				Member member = (Member) session.getAttribute("member");
				
				System.out.println(restaurantNo);
				System.out.println(member);
				
				Search search = new Search();
				search.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
				search.setPageSize(pageSize);
				
				System.out.println(search.getCurrentPage() + ":: currentPage");
				
				map.put("search", search);	
				
				Map<String, Object> resultMap = reservationService.listReservation(search, member, restaurantNo);
				
				List<Reservation> reservation = (List<Reservation>) resultMap.get("list");
				
				for (Reservation r : reservation ) {
					System.out.println(r);
				}
				
				Page resultPage = new Page(search.getCurrentPage(), ((Integer)resultMap.get("totalCount")).intValue(), pageUnit, pageSize);
				
				resultMap.put("resultPage", resultPage);
				resultMap.put("search", search);
				
				return resultMap;
			}
	
}
