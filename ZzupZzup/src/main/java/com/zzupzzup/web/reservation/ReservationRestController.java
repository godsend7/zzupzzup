package com.zzupzzup.web.reservation;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.zzupzzup.service.reservation.ReservationService;

@RestController
@RequestMapping("/reservation/*")

public class ReservationRestController {
	
	//Field
	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService reservationService;
	
	public ReservationRestController() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
