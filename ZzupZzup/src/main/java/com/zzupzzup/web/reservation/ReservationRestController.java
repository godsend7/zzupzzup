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
import org.springframework.web.bind.annotation.RestController;

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
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "json/getReservation/reservation={reservationNo}&reservationStatus={reservationStaus}", method = RequestMethod.GET)
	public Reservation getReservation(@RequestParam("reservationNo") int reservationNo, @RequestParam("reservationStatus") int reservationStatus ,HttpSession session) throws Exception {
		
		System.out.println("/reservation/json/getReservation : GET");
		
		Member member = (Member) session.getAttribute("member");
		
		Reservation reservation = new Reservation();
		
		reservation.setReservationNo(reservationNo);
		reservation.setReservationStatus(reservationStatus);
		
		System.out.println("getReservation reservation : " + reservation);
		
		reservationService.getReservation(reservationNo);
		
		Map map = new HashMap();
		map.put("reservation", reservation);
		
		return map;
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
}
