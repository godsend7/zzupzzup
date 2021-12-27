package com.zzupzzup.service.rating.test;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.common.ChatMember;
import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.chat.ChatService;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Rating;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.rating.RatingService;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
public class RatingServiceTest {

	@Autowired
	@Qualifier("ratingServiceImpl")
	private RatingService ratingService;
	
	@Autowired
	@Qualifier("chatServiceImpl")
	private ChatService chatService;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;

	//@Test
	public void testAddRating() throws Exception {
		System.out.println("testAddRating");
		
		Rating rating = new Rating();
		Chat chat  = new Chat();
		ChatMember chatMember = new ChatMember();
		/*
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		Map<String, Object> map = chatService.listReadyCheckMember(search, 10);
		List<ChatMember> list = (List<ChatMember>)map.get("list");
		System.out.println("list : " + list);
		
		for(ChatMember c : list) {
			String toId = c.getMember().getMemberId();
			if(toId.equals("hihi@a.com")) {
				continue;
			}
			System.out.println(toId);
			rating.setChatNo(10);
			rating.setRatingFromId("hihi@a.com");
			rating.setRatingToId(toId);
			rating.setRatingScore(-1);
			rating.setRatingType(1);
			
			ratingService.addRating(rating);
		}
		*/
		
		rating.setChatNo(10);
		rating.setRatingFromId("hihi@a.com");
		rating.setRatingToId("user01@zzupzzup.com");
		rating.setRatingScore(1);
		rating.setRatingType(1);
		
		ratingService.addRating(rating);
		
		memberService.calculateMannerScore(rating.getRatingToId(), rating.getRatingScore());
	}
	
	//@Test
	public void testListRating() throws Exception {
		
		System.out.println("testListRating");
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		System.out.println("search : " + search);
		
		Map<String, Object> map = ratingService.listRating(search);
		System.out.println("===================================");
		System.out.println("testListChat map : " + map);
		System.out.println("===================================");
		
		List<Rating> list = (List<Rating>)map.get("list");
		System.out.println("list : " + list);
		
		for (Rating r : list) {
			System.out.println(r.getRatingNo());
			System.out.println(r);
		}
		
		//Integer totalCount = (Integer)map.get("totalCount");
		//System.out.println("totalCount : " + totalCount);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		 System.out.println(resultPage);
	}
	
	@Test
	public void testListMyRating() throws Exception {
		
		System.out.println("testListRating");
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		System.out.println("search : " + search);
		
		Map<String, Object> map = ratingService.listMyRating(search, "user01@zzupzzup.com");
		System.out.println("===================================");
		System.out.println("testListChat map : " + map);
		System.out.println("===================================");
		
		List<Rating> list = (List<Rating>)map.get("list");
		System.out.println("list : " + list);
		
		for (Rating r : list) {
			System.out.println(r.getRatingNo());
			System.out.println(r);
		}
		
		//Integer totalCount = (Integer)map.get("totalCount");
		//System.out.println("totalCount : " + totalCount);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		 System.out.println(resultPage);
	}
}