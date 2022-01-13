package com.zzupzzup.service.community.test;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.community.CommunityService;
import com.zzupzzup.service.domain.Community;
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.RestaurantTime;


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
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;

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
		
		RestaurantTime rt = new RestaurantTime();
		rt.setRestaurantDay(1);
		rt.setRestaurantOpen("11:00");
		rt.setRestaurantClose("22:00");
		rt.setRestaurantBreak("15:00");
		rt.setRestaurantLastOrder("21:30");
		rt.setRestaurantDayOff(false);
		
		List<RestaurantTime> list = new ArrayList<RestaurantTime>();
		list.add(rt);
		list.add(rt);
		
		List<String> pi = new ArrayList<String>();
		pi.add("postImage1.jpg");
		pi.add("postImage2.jpg");
		pi.add("postImage3.jpg");
		
		member.setMemberId("hihi@a.com");
		community.setMember(member);
		community.setPostTitle("쌀국수인줄 알았는데 맑은탕이였다");
		community.setPostText("쌀국수안파는맑은탕가게");
		community.setRestaurantName("할무이");
		community.setRestaurantTel("010-4444-4444");
		community.setStreetAddress("미국 뉴욕주 브루클린");
		community.setAreaAddress("미국 뉴욕주 브루클린");
		community.setRestAddress("바클레이스 센터");
		//Date postRegDate = new Date(20211218);
		//community.setPostRegDate(postRegDate);
		community.setMenuType(3);
		community.setMainMenuTitle("너구리소금맛");
		community.setMainMenuPrice(4500);
		community.setReceiptImage("test.jpg");
		community.setRestaurantTimes(list);
		community.setPostImage(pi);
		
		communityService.addCommunity(community);
		
		System.out.println("addCommunity Test : " + community);
	}
	
	
	//@Test
	public void testGetCommunity() throws Exception {
		
		Community community = communityService.getCommunity(7);

		System.out.println("GET_COMMUNITY : " + community);
		//Member member = new Member();
		
		//community = communityService.getCommunity(1);
		
//		Assert.assertEquals("hihi@a.com", community.getMember());
//		Assert.assertEquals("쌀국수인줄 알았는데 마라탕이였다", community.getPostTitle());
//		Assert.assertEquals("쌀국수안파는마라탕가게", community.getPostText());
//		Assert.assertEquals("에머이", community.getRestaurantName());
//		Assert.assertEquals("010-4444-4444", community.getRestaurantTel());
//		Assert.assertEquals("미국 뉴욕주 브루클린", community.getStreetAddress());
//		Assert.assertEquals("미국 뉴욕주 브루클린", community.getAreaAddress());
//		Assert.assertEquals(1, community.getMenuType());
//		Assert.assertEquals("진라면순한맛", community.getMainMenuTitle());
//		Assert.assertEquals(5000, community.getMainMenuPrice());
		
	}
	
	
	//@Test
	public void testUpdateCommunity() throws Exception {
		
		Community community = communityService.getCommunity(6);
		
		community.setPostTitle("쌀국수인줄 알았는데 콩국수였다");
		community.setPostText("쌀국수안파는콩국수가게");
		community.setRestaurantName("아바이");
		community.setRestaurantTel("010-7777-7777");
		community.setStreetAddress("미국 텍사스주 휴스턴");
		community.setAreaAddress("미국 텍사스주 휴스턴");
		community.setRestAddress("토요타 센터");
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
		
		Search search = new Search();
		
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String, Object> map = communityService.listCommunity(search);
		
		List<Community> list = (List<Community>) map.get("list");
		
		for(Community cn : list) {
			System.out.println(cn);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
	}
	
	
	//@Test
	public void testListMyPost() throws Exception {
		
		Search search = new Search();
		String memberId = "hihi@a.com";
		
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		// 수정 필요!!!
		Map<String, Object> map = communityService.listMyLikePost(search, null);
		
		List<Community> list = (List<Community>) map.get("list");
		
		for(Community cn : list) {
			System.out.println("LISTMYPOST : " + cn);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
	}
	
	
	//@Test
	public void testDeleteCommunity() throws Exception {
		
		Community community = new Community();
		
		community.setPostNo(5);
		
		if(communityService.deleteCommunity(community.getPostNo()) == 1) {
			System.out.println("DELETE COMPLETE");
		}
		
	}
	
	
	//@Test
	public void testAddLike() throws Exception {
		
		if(communityService.addLike("hihi@a.com", 7) == 1) {
			System.out.println("ADDLIKE OK");
		}
		
	}
	
	
	//@Test
	public void testDeleteLike() throws Exception {
			
		if(communityService.deleteLike("hihi@a.com", 7) == 1) {
			System.out.println("DELETELIKE OK");
		}
		
	}
	
	
	//@Test
	public void testListLike() throws Exception {
		
		Search search = new Search();
		
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		String memberId = "hihi@a.com";
		
//		Map<String, Object> map = communityService.listLike(search, memberId);		
//		List<Community> list = (List<Community>) map.get("list");
		
		List<Mark> map = communityService.listLike(null);	
//		List<Community> list = (List<Community>) map.get("list");
		
		System.out.println("HERE YOUR LIST");
		
//		for(Community cn : list) {
//			System.out.println(cn);
//		}
		
	}
	
	
	@Test
	public void testOfficialCommunity() throws Exception {
		
		Community community = communityService.getCommunity(10);
		
//		String od = "2021-12-24 11:11:11";
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		java.util.Date offdat = sdf.parse(od);
//		
//		community.setOfficialDate(offdat);
		
		
		communityService.officialCommunity(community);
		
		System.out.println("RESULT : " + community);
	}
	
	
}