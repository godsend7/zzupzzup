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
import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.chat.ChatService;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.member.MemberService;
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
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;

	//@Test
	public void testAddChat() throws Exception {
		
		System.out.println("testAddChat");
		
		Chat chat = new Chat();
		Restaurant restaurant = new Restaurant();
		Member member = new Member();
		member.setMemberId("hihi@a.com");
		
		//restaurant = restaurantService.getRestaurant(1);
		restaurant.setRestaurantNo(1);
		
		System.out.println("sdsqwwq"+restaurant);
		member = memberService.getMember(member);
		
		
		chat.setChatTitle("먹으로가요");
		chat.setChatText("우리 채팅방은 먹보들~");
		chat.setChatAge("1,2,3");
		//해당 값 없으면 default로 들어간 값 들어감 chatimg.jpg
		chat.setChatImage("chatchat.jpg");
		chat.setChatGender(1);
		chat.setChatLeaderId(member);
		chat.setChatRestaurant(restaurant);
		
		chatService.addChat(chat);
		
		//채팅방 개설시 개설자가 리더가 되어 chat_member 테이블에 추가된다.
		if(chatService.addChat(chat) == 1) {
			System.out.println("chat insert success");
			testAddChatMember(chat.getChatNo(), member, true);
		}
	}
	
	//@Test
	public void testGetChat() throws Exception {
		
		System.out.println("testGetChat");
		
		Chat chat = new Chat();
		Restaurant restaurant = new Restaurant();
		Member member = new Member();
		
		chat.setChatNo(1);
		chat = chatService.getChat(chat.getChatNo());
		
		//restaurant = restaurantService.getRestaurant(chat.getChatRestaurant().getRestaurantNo());
		restaurant.setRestaurantNo(chat.getChatRestaurant().getRestaurantNo());
		member = memberService.getMember(chat.getChatLeaderId());
		
		chat.setChatRestaurant(restaurant);
		chat.setChatLeaderId(member);
		
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
		chat.setChatAge("6");
		//유저일때도 히든으로 값을 false로 보내고 admin 일때는 체크 할 수 있게
		chat.setChatShowStatus(false);
		
		chatService.updateChat(chat);		
		chat = chatService.getChat(1);
		
		System.out.println("chat update after : " + chat);
	}
	
	//@Test
	public void testListChat() throws Exception {
		
		System.out.println("testListChat");
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		System.out.println("search : " + search);
		
		Map<String, Object> map = chatService.listChat(search);
		System.out.println("===================================");
		System.out.println("testListChat map : " + map);
		System.out.println("===================================");
		
		List<Chat> list = (List<Chat>)map.get("list");
		System.out.println("list : " + list);
		
		for (Chat c : list) {
			System.out.println(c.getChatNo());
			System.out.println(c.getChatRestaurant().getRestaurantNo());
			System.out.println(c);
		}
		
		//Integer totalCount = (Integer)map.get("totalCount");
		//System.out.println("totalCount : " + totalCount);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		 System.out.println(resultPage);
	}
	
	//@Test
	public void testGetChatEntrance() throws Exception {
		
		System.out.println("testGetChatEntrance");
		
		Chat chat = new Chat();
		Restaurant restaurant = new Restaurant();
		Member member = new Member();
		
		chat.setChatNo(1);
		chat = chatService.getChatEntrance(chat.getChatNo());
		
		//restaurant = restaurantService.getRestaurant(chat.getChatRestaurant().getRestaurantNo());
		restaurant.setRestaurantNo(chat.getChatRestaurant().getRestaurantNo());
		member = memberService.getMember(chat.getChatLeaderId());
		
		chat.setChatRestaurant(restaurant);
		chat.setChatLeaderId(member);
		
		System.out.println("chat : " + chat);
		
	}
	
	//@Test
	public void testDeleteChat() throws Exception {
		
		System.out.println("testDeleteChat");
		
		Chat chat = chatService.getChat(2);		
		chat.setChatShowStatus(false);		
		chatService.deleteChat(chat);
		
		chat = chatService.getChat(1);		
		System.out.println("chat update after : " + chat);
	}
	
	//@Test
	public void testUpdateChatState() throws Exception {
		
		System.out.println("testUpdateChatState");
		
		Chat chat = chatService.getChat(1);
		System.out.println("chat update state before : " + chat);
		chat.setChatState(4);
		chatService.updateChatState(chat.getChatNo(), 2);
		
		chat = chatService.getChat(1);
		System.out.println("chat update state after : " + chat);
	}
	
	//@Test
	public void testAddChatMember() throws Exception {
		
		System.out.println("testAddChatMember");
		
		ChatMember chatMember = new ChatMember();
		Member member = new Member();
		member.setMemberId("owner01@zzupzzup.com");
		
		chatMember.setChatNo(10);
		chatMember.setMember(member);
		
		chatService.addChatMember(chatMember);
	}
	
	//@Test
	public void testAddChatMember(int chatNo, Member member) throws Exception {
		
		ChatMember chatMember = new ChatMember();
		
		chatMember.setChatNo(chatNo);
		chatMember.setMember(member);
		
		chatService.addChatMember(chatMember);
	}
	
	//@Test
	public void testAddChatMember(int chatNo, Member member, Boolean chatLeaderCheck) throws Exception {
		
		ChatMember chatMember = new ChatMember();
		
		chatMember.setChatNo(chatNo);
		chatMember.setMember(member);
		chatMember.setChatLeaderCheck(true);
		
		chatService.addChatMember(chatMember);
	}
	
	//@Test
	public void testListChatMember() throws Exception {
		
		System.out.println("testListChatMember");
		
		ChatMember chatMember = new ChatMember();
		chatMember.setChatNo(1);
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		
		
		System.out.println("search : " + search);
		
		Map<String, Object> map = chatService.listChatMember(search, chatMember.getChatNo());
		System.out.println("===================================");
		System.out.println("testListChat map : " + map);
		System.out.println("===================================");
		
		List<ChatMember> list = (List<ChatMember>)map.get("list");
		System.out.println("list : " + list);
		
		for (ChatMember c : list) {
			System.out.println(c.getChatNo());
			System.out.println(c);
		}
	}
	
	// 예약에 기록이 되어야 해서 채팅방 멤버 지우는건 없음...
	// 레디 체크 안한사람은 나갈 수 있음
	// 레디 체크한 사람은 나갈 수 없음
	//@Test
	public void testDeleteChatMember() throws Exception {
		
		System.out.println("testDeleteChatMember");
		
		ChatMember chatMember = new ChatMember();
		Member member = new Member();
		
		member.setMemberId("hihi@a.com");
		
		chatMember.setChatNo(1);
		chatMember.setMember(member);
		
		chatService.deleteChatMember(chatMember);
		
	}
	
	//@Test
	public void testUpdateReadyCheck() throws Exception {
		
		System.out.println("testUpdateReadyCheck");
		
		ChatMember chatMember = new ChatMember();
		Member member = new Member();
		
		member.setMemberId("user02@zzupzzup.com");
		
		chatMember.setChatNo(10);
		chatMember.setMember(member);
		chatMember.setReadyCheck(true);
		
		chatService.updateReadyCheck(chatMember);
	}
	
	@Test
	public void testListReadyCheckMember() throws Exception {
		
		System.out.println("testListReadyCheckMember");
		
		ChatMember chatMember = new ChatMember();
		chatMember.setChatNo(10);
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);		
		
		System.out.println("search : " + search);
		
		Map<String, Object> map = chatService.listReadyCheckMember(search, chatMember.getChatNo());
		System.out.println("===================================");
		System.out.println("testListChat map : " + map);
		System.out.println("===================================");
		
		List<ChatMember> list = (List<ChatMember>)map.get("list");
		System.out.println("list : " + list);
		
		for (ChatMember c : list) {
			System.out.println(c.getChatNo());
			System.out.println(c);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}