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
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.reservation.ReservationService;

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
	
}
