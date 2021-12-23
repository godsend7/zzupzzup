package com.zzupzzup.service.chat.test;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.common.ChatAge;
import com.zzupzzup.common.ChatMember;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.chat.ChatService;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.restaurant.RestaurantService;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
public class ChatServiceTest {

	@Autowired
	@Qualifier("chatServiceImpl")
	private ChatService chatService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;

	//@Test
	public void testAddChat() throws Exception {
		
		System.out.println("testAddChat");
		
		Restaurant restaurant = new Restaurant();
		Chat chat = new Chat();
		ChatMember chatMember = new ChatMember();
		Member member = new Member();
		
		restaurant.setRestaurantNo(1);
		
		chat.setChatTitle("먹으로가요");
		chat.setChatText("우리 채팅방은 먹보들~");
		chat.setChatAge("1,2,3");
		//해당 값 없으면 default로 들어간 값 들어감 chatimg.jpg
		chat.setChatImage("chatchat.jpg");
		chat.setChatGender(1);
		chat.setChatLeaderId("hihi@a.com");
		chat.setChatRestaurant(restaurant);
		
		chatService.addChat(chat);
		
		//List<ChatMember> map = chatService.addChatMember(1, member.memberId);
	}
	
	//@Test
	public void testGetMember() throws Exception {
		
		System.out.println("testGetMember");
		
		Chat chat = new Chat();
		
		chat.setChatNo(1);
		
		chat = chatService.getChat(chat.getChatNo());
		
		System.out.println("chat : " + chat);
	}
	
	//@Test
	public void testUpdateChat() throws Exception {
		
		System.out.println("testUpdateChat");
		
		Restaurant restaurant = new Restaurant();
		Chat chat = chatService.getChat(1);
		System.out.println("chat update before : " + chat);
		
		restaurant.setRestaurantNo(2);
		
		chat.setChatRestaurant(restaurant);
		chat.setChatTitle("누구 나랑 갈래?");
		chat.setChatImage("abc.jpg");
		chat.setChatText("맛있는거 먹고 싶은 사람들의 모임");
		chat.setChatGender(2);
		chat.setChatShowStatus(false);
		chat.setChatAge("6");
		
		chatService.updateChat(chat);
		
		chat = chatService.getChat(1);
		
		System.out.println("chat update after : " + chat);
		
	}
	
	@Test
	public void testListChat() throws Exception {
		
		System.out.println("testListChat");
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		String restaurantNo = null;
		
		System.out.println("search : " + search);
		
		Map<String, Object> map = chatService.listChat(search, restaurantNo);
		System.out.println("===================================");
		System.out.println("testListChat map : " + map);
		System.out.println("===================================");
		
		List<Chat> list = (List<Chat>)map.get("list");
		System.out.println("list : " + list);
		
		//Integer totalCount = (Integer)map.get("totalCount");
		//System.out.println("totalCount : " + totalCount);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}