package com.zzupzzup.service.community.test;

import java.sql.Date;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.community.CommunityService;
import com.zzupzzup.service.domain.Community;
import com.zzupzzup.service.domain.Member;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class CommunityServiceTest {

	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;

	//@Test
	public void testAddCommunity() throws Exception {
		
		Community community = new Community();
		Member member = new Member();
		
//		member.setMemberId("hihi@a.com");
//		community.setMember(member);
//		//member.setMemberId("hihi@a.com");
//		community.setPostTitle("쌀국수인줄 알았는데 라면이였다");
//		community.setPostText("쌀국수안파는쌀국수가게");
//		community.setRestaurantName("에머이");
//		community.setRestaurantTel("010-4444-4444");
//		community.setStreetAddress("미국 뉴욕주 브루클린");
//		community.setAreaAddress("미국 뉴욕주 브루클린");
//		//community.setRestAddress("바클레이스 센터");
//		//Date postRegDate = new Date(20211218);
//		//community.setPostRegDate(postRegDate);
//		community.setMenuType(1);
//		community.setMainMenuTitle("진라면순한맛");
//		community.setMainMenuPrice(5000);
//		//community.setReceiptImage("test.jpg");
		
		member.setMemberId("hihi@a.com");
		community.setMember(member);
		//member.setMemberId("hihi@a.com");
		community.setPostTitle("쌀국수인줄 알았는데 마라탕이였다");
		community.setPostText("쌀국수안파는마라탕가게");
		community.setRestaurantName("에머이");
		community.setRestaurantTel("010-4444-4444");
		community.setStreetAddress("미국 뉴욕주 브루클린");
		community.setAreaAddress("미국 뉴욕주 브루클린");
		//community.setRestAddress("바클레이스 센터");
		//Date postRegDate = new Date(20211218);
		//community.setPostRegDate(postRegDate);
		community.setMenuType(1);
		community.setMainMenuTitle("진라면순한맛");
		community.setMainMenuPrice(5000);
		//community.setReceiptImage("test.jpg");
		
		communityService.addCommunity(community);
		
		System.out.println("addCommunity Test : " + community);
	}
	
	
	//@Test
	public void testGetCommunity() throws Exception {
		
		Community community = communityService.getCommunity(3);
		//Member member = new Member();
		
		//community = communityService.getCommunity(1);
		
		//Assert.assertEquals("hihi@a.com", community.getMember());
		Assert.assertEquals("쌀국수인줄 알았는데 마라탕이였다", community.getPostTitle());
		Assert.assertEquals("쌀국수안파는마라탕가게", community.getPostText());
		Assert.assertEquals("에머이", community.getRestaurantName());
		Assert.assertEquals("010-4444-4444", community.getRestaurantTel());
		Assert.assertEquals("미국 뉴욕주 브루클린", community.getStreetAddress());
		Assert.assertEquals("미국 뉴욕주 브루클린", community.getAreaAddress());
		Assert.assertEquals(1, community.getMenuType());
		Assert.assertEquals("진라면순한맛", community.getMainMenuTitle());
		Assert.assertEquals(5000, community.getMainMenuPrice());
		
	}
	
	
	@Test
	public void testUpdateCommunity() throws Exception {
		
		Community community = communityService.getCommunity(3);
		
		community.setPostTitle("라면인줄 알았는데 파스타였다");
		community.setPostText("쌀국수안파는파스타가게");
		community.setRestaurantName("어머이");
		community.setRestaurantTel("010-5555-5555");
		community.setStreetAddress("미국 텍사스주 오스틴");
		community.setAreaAddress("미국 텍사스주 오스틴");
		//community.setRestAddress("바클레이스 센터");
		//Date postRegDate = new Date(20211218);
		//community.setPostRegDate(postRegDate);
		community.setMenuType(2);
		community.setMainMenuTitle("진라면매운맛");
		community.setMainMenuPrice(5500);
		//community.setReceiptImage("test.jpg");
		
		communityService.updateCommunity(community);
		
		System.out.println("updateCommunity Test : " + community);
		
	}
	
	
	//@Test
	public void testListCommunity() throws Exception {
		
		
				
	}
	
	
	
	
}