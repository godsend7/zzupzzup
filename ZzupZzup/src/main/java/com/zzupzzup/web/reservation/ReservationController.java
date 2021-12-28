package com.zzupzzup.web.reservation;

import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
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
		System.out.println("/reservation/addReservation22222 : POST");
		return "foward:/reservation/addReservation.jsp";
	}
	
//==================================================================================================
	//질문
	@RequestMapping( value="getReservation", method=RequestMethod.GET )
	public String getReservation( @RequestParam("reservationNo") int reservationNo , Model model ) throws Exception {
		
		System.out.println("/reservation/getReseration : GET");
		//Business Logic
		Reservation reservation = reservationService.getReservation(reservationNo);
		// Model 과 View 연결
		model.addAttribute("reservation", reservation);
		
		return "foward:/reservation/getReservation.jsp";
	}
	
	
	
//==================================================================================================	
	//질문
	@RequestMapping( value="updateReservation", method=RequestMethod.GET )
	public String updateUser( @RequestParam("reservationNo") int  reservationNo , Model model ) throws Exception{

		System.out.println("/reservation/updateReseration : GET");
		//Business Logic
		Reservation reservation = reservationService.getReservation(reservationNo);
		// Model 과 View 연결
		model.addAttribute("reservation", reservation);
		
		return "foward:/reservation/updateReservation.jsp";
	}

//==================================================================================================	
	
	@RequestMapping(value="listReservation")
	public String listReservation(@ModelAttribute("search") Search search, Model model) throws Exception {
		
		System.out.println("/reservation/listReservation");
		
		if(search.getCurrentPage() == 0) {
			search.setPageSize(1);
		}
		
		search.setPageSize(0); //pageSize
		
		Map<String, Object> map = reservationService.listReservation(search);
		
		//pageUnit, pageSize
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 0, 0);
		System.out.println("RESULT PAGE : " + resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/reservation/listReservation.jsp";	
	}
//==================================================================================================
	
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
