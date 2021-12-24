package com.zzupzzup.web.reservation;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.reservation.ReservationService;

@Controller
@RequestMapping("/reservation/*")

public class ReservationController {
	
	//Field
	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService reservationService;
	
	public ReservationController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize; // 미니프로젝트보고 따라한것.
	
	
	@RequestMapping( value="addReservation", method=RequestMethod.GET )
	public String addReservation() throws Exception{
	
		System.out.println("/reservation/addReservation : GET");
		
		return "forward:/reservation/addReservationView.jsp";
	}
	
	@RequestMapping( value="addReservation", method=RequestMethod.POST )
	public String addReservation ( @ModelAttribute("reservation") Reservation reservation ) throws Exception {

		System.out.println("/reservation/addReservation : POST");
		//Business Logic
		reservationService.addReservation(reservation);
		
		return "foward:/reservation/addReservation.jsp";
	}
	
	
	
	
	
	
	
	

	   @RequestMapping(value="sendPhoneMessage", method=RequestMethod.POST)
	   public void sendMessage(@RequestBody String phone, String text) throws Exception{
	      
	     // Random rand  = new Random();
	        
	      //  String numStr = "";
	        
	     //   for(int i=0; i<4; i++) {
	           
	      //      String num = Integer.toString(rand.nextInt(10));
	            
	      //      numStr += num;
	      //  }     
	        
	       // session.setAttribute(phone, numStr);
	        
	        reservationService.sendMessage(phone, text);
	   }

}
