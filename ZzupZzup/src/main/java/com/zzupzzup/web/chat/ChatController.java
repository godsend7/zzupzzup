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

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.chat.ChatService;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.ChatMember;
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
		
		//????????? ?????? ????????? null??? ???????????? default ????????? ???????????? ???
		if(chat.getChatImage().equals("") || chat.getChatImage() == "") {
			chat.setChatImage(null);
		}
		
		//Business Logic
		chatService.addChat(chat);
		
		ChatMember chatMember = new ChatMember();
		
		chatMember.setChatNo(chat.getChatNo());
		chatMember.setMember(chat.getChatLeaderId());
		chatMember.setChatLeaderCheck(true);
		chatMember.setReadyCheck(true);
		
		chatService.addChatMember(chatMember);
		
		return "redirect:/chat/getChatEntrance?chatNo="+chat.getChatNo();
		
	}
	
	@RequestMapping(value="listChat")
	public String listChat( @ModelAttribute("search") Search search, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("/chat/listChat : GET / POST");
		System.out.println("/chat/listChat page : " + request.getParameter("page"));
		System.out.println("/chat/listChat searchSort : " + search.getSearchSort());
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		
		if(search.getSearchSort() == null || search.getSearchSort() == "") {
			search.setSearchSort("latest");
		}
		
		if(request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		search.setPageSize(pageSize);
		
		Member member = (Member)session.getAttribute("member");
		
		
		
		// Business logic
		Map<String, Object> map = chatService.listChat(search, member.getMemberId());
		System.out.println("===================================");
		System.out.println(member.getMemberId());
		System.out.println("listChat map : " + map);
		System.out.println("===================================");
		
		List<Chat> list = (List<Chat>)map.get("list");
		//System.out.println("list : " + list);
		
		Restaurant restaurant = new Restaurant();
		
		for (Chat c : list) {
			restaurant = restaurantService.getRestaurant(c.getChatRestaurant().getRestaurantNo());
			c.setChatRestaurant(restaurant);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		//System.out.println("resultPage : " + resultPage);
		
		
		//System.out.println("listChat member : " + member);
		
		// Model and View
		model.addAttribute("list", list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		request.setAttribute("member", member);
		
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
		
		return "forward:/chat/getChat.jsp";
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
		System.out.println("chat : " + chat);
		
		//????????? ?????? ????????? null??? ???????????? default ????????? ???????????? ???
		if(chat.getChatImage().equals("") || chat.getChatImage() == "") {
			chat.setChatImage(null);
		}
		Restaurant restaurant = new Restaurant();
		
		//Business Logic
		chatService.updateChat(chat);
		
		chat = chatService.getChat(chat.getChatNo());
		restaurant = restaurantService.getRestaurant(chat.getChatRestaurant().getRestaurantNo());
		chat.setChatRestaurant(restaurant);
		model.addAttribute("chat", chat);
		
		return "forward:/chat/updateChat.jsp";
	}
	
	@RequestMapping(value="getChatEntrance", method=RequestMethod.GET)
	public String getChatEntrance( HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("/chat/getChatEntrance : GET");
		
		Integer chatNo = Integer.parseInt(request.getParameter("chatNo"));
		System.out.println("getChatEntrance chatNo : " + chatNo);
		
		//Business Logic
		Chat chat = chatService.getChat(chatNo);
		System.out.println("getChatEntrance chat : " + chat);
		
		Restaurant restaurant = new Restaurant();		
		restaurant = restaurantService.getRestaurant(chat.getChatRestaurant().getRestaurantNo());
		chat.setChatRestaurant(restaurant);
		
		Member member = (Member)session.getAttribute("member");
		System.out.println("getChatEntrance member : " + member);
		
		
		
		ChatMember chatMember = new ChatMember();
		ChatMember chatMember2 = new ChatMember();
		
		//???????????? ????????? ??????????????? ??????????????? ??????
		String chatLeaderId = chat.getChatLeaderId().getMemberId();
		String memberId = member.getMemberId();
		
		//System.out.println("chatLeaderId : " + chatLeaderId + "memberId : " + memberId);
		if(chatLeaderId.equals(memberId)) {
			//???????????? ???????????? ???
			//System.out.println("????????????");
			chat.setChatLeaderId(member);
		}else {
			//???????????? ???????????? ???
			//System.out.println("????????????");
			//Business Logic
			chatMember = chatService.getChatMember(chat.getChatNo(), memberId);
			System.out.println("chatMember : " + chatMember);
			
			//???????????? chat_member ???????????? ????????? ??????
			if(chatMember == null) {
				chatMember2.setChatNo(chat.getChatNo());
				chatMember2.setMember(member);
				chatService.addChatMember(chatMember2);
				
				//?????? ??? ?????? ?????? chatMember??? ??????
				chatMember = chatService.getChatMember(chat.getChatNo(), memberId);
			}else {
				//????????? ??? ???????????? ?????? ??????????????? ?????????
				if(chatMember.isInOutCheck() == false) {
					System.out.println("????????? ???????????? ????????????.");
					chatMember2.setChatNo(chat.getChatNo());
					chatMember2.setMember(member);
					chatMember2.setInOutCheck(true);
					chatService.updateChatMember(chatMember2);
					
					//?????? ??? ?????? ?????? chatMember??? ??????
					chatMember = chatService.getChatMember(chat.getChatNo(), memberId);
				}
			}
		}
		
		// Business logic
		Map<String, Object> map = chatService.listReadyCheckMember(chat.getChatNo());
		
		List<ChatMember> chatMemberList = (List<ChatMember>)map.get("list");
		
		request.setAttribute("chat", chat);
		request.setAttribute("member", member);
		request.setAttribute("chatMember", chatMember);
		request.setAttribute("chatMemberList", chatMemberList);
		
		return "forward:/chat/getChatEntrance.jsp";
	}
	
	
	@RequestMapping(value="getChatReservation", method=RequestMethod.GET)
	public String getChatReservation( HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("/chat/getChatReservation : GET");
		
		Integer chatNo = Integer.parseInt(request.getParameter("chatNo"));
		System.out.println("getChatReservation chatNo : " + chatNo);
		
		//Business Logic
		//?????? ????????? ??? ?????? ?????? ?????????????????? ????????????
		//chatService.updateChatState(chatNo, 2);
		
		Chat chat = chatService.getChat(chatNo);
		
		Map<String, Object> map = chatService.listReadyCheckMember(chat.getChatNo());
		
		List<ChatMember> chatMemberList = (List<ChatMember>)map.get("list");
		
		request.setAttribute("chatMemberList", chatMemberList);
	
		return "forward:/reservation/addReservation?chatNo="+chatNo;
	}
	
	@RequestMapping(value="deleteChatMember", method=RequestMethod.GET)
	public String deleteChat( HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("chat/deleteChatMember : GET");
		
		Integer chatNo = Integer.parseInt(request.getParameter("chatNo"));
		System.out.println("deleteChatMember chatNo : " + chatNo);
		
		//Business Logic
		Chat chat = chatService.getChat(chatNo);
		System.out.println("getChatEntrance chat : " + chat);
		
		Member member = (Member)session.getAttribute("member");
		System.out.println("getChatEntrance member : " + member);
		
		//???????????? ????????? ??????????????? ??????????????? ??????
		String chatLeaderId = chat.getChatLeaderId().getMemberId();
		String memberId = member.getMemberId();
		
		ChatMember chatMember = new ChatMember();
		
		if(chatLeaderId.equals(memberId)) {
			//???????????? ???????????? ???
			//????????? ?????? ?????? ??????
			System.out.println("????????????");
			chatMember.setChatNo(chatNo);
			chatMember.setInOutCheck(false);
			
			chatService.deleteAllChatMember(chatMember);
			
			chatService.updateChatState(chatNo, 5);
		}else {
			//???????????? ???????????? ???
			//??????????????? ??????
			System.out.println("????????????");
			System.out.println(memberId);
			chatMember.setChatNo(chatNo);
			chatMember.setMember(member);
			chatMember.setInOutCheck(false);
			
			chatService.deleteChatMember(chatMember);
			
		}
		
		return "redirect:/chat/listChat";
	}
	
	@RequestMapping(value="getChatRecord", method=RequestMethod.GET)
	public String getChatRecord( HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("/chat/getChatEntrance : GET");
		
		Integer chatNo = Integer.parseInt(request.getParameter("chatNo"));
		System.out.println("getChatRecord chatNo : " + chatNo);
		
		//Business Logic
		Chat chat = chatService.getChat(chatNo);
		System.out.println("getChatEntrance chat : " + chat);
		
		Member member = (Member)session.getAttribute("member");
		System.out.println("getChatEntrance member : " + member);
		
		request.setAttribute("chat", chat);
		request.setAttribute("member", member);
		
		return "forward:/chat/getChatRecord.jsp";
	}
	
	@RequestMapping(value="deleteForbiddenMember", method=RequestMethod.GET)
	public String deleteForbiddenMember( HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("chat/deleteForbiddenMember : GET");
		
		Integer chatNo = Integer.parseInt(request.getParameter("chatNo"));
		System.out.println("deleteChatMember chatNo : " + chatNo);
		
		//Business Logic
		Chat chat = chatService.getChat(chatNo);
		System.out.println("getChatEntrance chat : " + chat);
		
		Member member = (Member)session.getAttribute("member");
		System.out.println("getChatEntrance member : " + member);
		
		//???????????? ????????? ??????????????? ??????????????? ??????
		String chatLeaderId = chat.getChatLeaderId().getMemberId();
		String memberId = member.getMemberId();
		
		ChatMember chatMember = new ChatMember();
		
		if(chatLeaderId.equals(memberId)) {
			//???????????? ???????????? ???
			//????????? ?????? ?????? ??????
			System.out.println("????????????");
			chatMember.setChatNo(chatNo);
			chatMember.setInOutCheck(false);
			
			chatService.deleteAllChatMember(chatMember);
			
			chatService.updateChatState(chatNo, 5);
		}else {
			//???????????? ???????????? ???
			//??????????????? ??????
			System.out.println("????????????");
			System.out.println(memberId);
			chatMember.setChatNo(chatNo);
			chatMember.setMember(member);
			chatMember.setInOutCheck(false);
			
			chatService.deleteChatMember(chatMember);
			
		}
		
		return "redirect:/chat/listChat";
	}
	
	
	
}
