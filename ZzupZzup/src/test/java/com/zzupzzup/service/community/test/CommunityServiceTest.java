package com.zzupzzup.service.community.test;

import java.sql.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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

	@Test
	public void testAddCommunity() throws Exception {
		
		Community community = new Community();
		Member member = new Member();
		
		
		member.setMemberId("hihi@a.com");
		community.setMember(member);
		//member.setMemberId("hihi@a.com");
		community.setPostTitle("쌀국수인줄 알았는데 라면이였다");
		community.setPostText("쌀국수안파는쌀국수가게");
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
}