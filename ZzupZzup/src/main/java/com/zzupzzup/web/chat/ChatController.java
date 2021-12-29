package com.zzupzzup.web.chat;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.zzupzzup.common.ChatMember;
import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.chat.ChatService;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.restaurant.RestaurantService;

@Controller
@RequestMapping("/chat/*")

public class ChatController {
	
	///Field
	@Autowired
	@Qualifier("chatServiceImpl")
	private ChatService chatService;
	
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;

	public ChatController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	
	@RequestMapping(value="addChat", method=RequestMethod.GET)
	public String addChat(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("/chat/addCaht : GET");
		
		//Integer chatNo = Integer.parseInt(request.getParameter("chat_no"));
		//System.out.println("AddPurchaseView prodNo : " + chatNo);
		
		return "redirect:/chat/addChatView.jsp";
	}
	
	@RequestMapping(value="addChat", method=RequestMethod.POST)
	public String addChat(@ModelAttribute("chat") Chat chat, HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("/chat/addCaht : POST");
		
		System.out.println("chat : " + chat);
		
		//Business Logic
		chatService.addChat(chat);
		
		ChatMember chatMember = new ChatMember();
		
		chatMember.setChatNo(chat.getChatNo());
		chatMember.setMember(chat.getChatLeaderId());
		chatMember.setChatLeaderCheck(true);
		
		chatService.addChatMember(chatMember);
		
		return "forward:/chat/addChat.jsp";
		
	}
	
	@RequestMapping(value="listChat")
	public String listChat( @ModelAttribute("search") Search search, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("/chat/listChat : GET / POST");
		System.out.println("/chat/listChat page : " + request.getParameter("page"));
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		
		if(request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		search.setPageSize(pageSize);
		
		// Business logic
		Map<String, Object> map = chatService.listChat(search);
		System.out.println("===================================");
		System.out.println("listChat map : " + map);
		System.out.println("===================================");
		
		List<Chat> list = (List<Chat>)map.get("list");
		System.out.println("list : " + list);
		
		Restaurant restaurant = new Restaurant();
		
		for (Chat c : list) {
			restaurant = restaurantService.getRestaurant(c.getChatRestaurant().getRestaurantNo());
			c.setChatRestaurant(restaurant);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : " + resultPage);
		
		// Model and View
		model.addAttribute("list", list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/chat/listChat.jsp";
	}
	
	@RequestMapping(value="getChat", method=RequestMethod.GET)
	public String getChat( @RequestParam("chatNo") int chatNo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("/chat/getChat : GET");
		
		//Business Logic
		Chat chat = chatService.getChat(chatNo);
		System.out.println(chat);
		
		Restaurant restaurant = new Restaurant();
		Member member = new Member();
		
		restaurant = restaurantService.getRestaurant(chat.getChatRestaurant().getRestaurantNo());
		member = memberService.getMember(chat.getChatLeaderId());
		
		chat.setChatRestaurant(restaurant);
		chat.setChatLeaderId(member);
		
		model.addAttribute("chat", chat);
		
		return "forword:/chat/getChat.jsp";
	}
	
	@RequestMapping( value="updateChat", method=RequestMethod.GET)
	public String updateChat( @RequestParam("chatNo") int chatNo, Model model) throws Exception {
		System.out.println("chat/updateChat : GET");
		
		Restaurant restaurant = new Restaurant();
		
		//Business Logic
		Chat chat = chatService.getChat(chatNo);
		restaurant = restaurantService.getRestaurant(chat.getChatRestaurant().getRestaurantNo());
		chat.setChatRestaurant(restaurant);
		
		model.addAttribute("chat", chat);
		
		return "forward:/chat/updateChatView.jsp";
	}
	
	@RequestMapping( value="updateChat", method=RequestMethod.POST)
	public String updateChat( @ModelAttribute("chat") Chat chat, Model model, HttpSession session, HttpServletRequest request) throws Exception {
		
		System.out.println("/chat/updateChat : POST");
		System.out.println();
		
		//Business Logic
		chatService.updateChat(chat);
		
		return "forward:/chat/updateChat.jsp";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
