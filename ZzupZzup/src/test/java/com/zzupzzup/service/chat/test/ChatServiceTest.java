package com.zzupzzup.service.chat.test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.common.ChatAge;
import com.zzupzzup.common.ChatMember;
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
	
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;

	@Test
	public void testAddChat() throws Exception {
		
		Restaurant restaurant = new Restaurant();
		Chat chat = new Chat();
		ChatMember chatMember = new ChatMember();
		Member member = new Member();
		
		List<Integer> chatAge = new ArrayList<Integer>();
		
		chatAge.add(1);
		chatAge.add(2);
		
		restaurant.setRestaurantNo(1);
		
		chat.setChatTitle("먹으로가요");
		chat.setChatText("우리 채팅방은 먹보들~");
		chat.setChatAge(chatAge);
		chat.setChatGender(1);
		chat.setChatLeaderId("hihi@a.com");
		chat.setChatRestaurant(restaurant);
		
		//List<ChatMember> map = chatService.addChatMember(1, member.memberId);
		
	}
}