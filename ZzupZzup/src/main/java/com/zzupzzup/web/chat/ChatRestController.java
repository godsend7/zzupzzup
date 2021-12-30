package com.zzupzzup.web.chat;

import java.net.URLDecoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.chat.ChatService;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.restaurant.RestaurantService;

@RestController
@RequestMapping("/chat/*")
public class ChatRestController {

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
	
	public ChatRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value="json/getChat/{chatNo}", method=RequestMethod.GET)
	public Chat getChat(@PathVariable int chatNo) throws Exception {
		
		System.out.println("/chat/json/getProduct : GET");
		System.out.println("chatNo : " + chatNo);
		
		//Business Logic
		Chat chat = chatService.getChat(chatNo);
		
		Restaurant restaurant = new Restaurant();
		Member member = new Member();
		
		restaurant = restaurantService.getRestaurant(chat.getChatRestaurant().getRestaurantNo());
		member = memberService.getMember(chat.getChatLeaderId());
		
		chat.setChatRestaurant(restaurant);
		chat.setChatLeaderId(member);

		System.out.println(chat);

		// Business Logic
		return chat;
	}
	
	@RequestMapping(value="json/listRestaurantAutocomplete/searchKeyword={searchKeyword}", method=RequestMethod.GET)
	public Map listRestaurantAutocomplete(@ModelAttribute("search") Search search, HttpServletRequest requeste) throws Exception {
		
		System.out.println("/chat/json/listRestaurantAutocomplete : GET");
		System.out.println("listRestaurantAutocomplete request menu : " + search.getSearchKeyword());
		
		String searchKeyword2 = search.getSearchKeyword();
		
		search.setSearchKeyword(null);
		
		String decText= URLDecoder.decode(searchKeyword2,"UTF-8");
		System.out.println("decText : " + decText);
		search.setSearchKeyword(decText);
		
		//Business Logic
		Map<String, Object> map = chatService.listRestaurantName(search);
		
		Restaurant restaurant = new Restaurant();
		
		//System.out.println(map);
		
		map.put("restaurant", restaurant);

		// Business Logic
		return map;
	}

}
