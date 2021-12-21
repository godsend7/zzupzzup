package com.zzupzzup.service.restaurant.test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.RestaurantMenu;
import com.zzupzzup.service.domain.RestaurantTime;
import com.zzupzzup.service.restaurant.RestaurantService;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class RestaurantServiceTest {

	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;

	//@Test
	public void testAddRestaurant() throws Exception {
	
		Restaurant restaurant = new Restaurant();
		Member member = new Member();
		
		RestaurantMenu menu = new RestaurantMenu();
		menu.setMenuTitle("a");
		menu.setMenuPrice(100);
		menu.setMainMenuStatus(false);
		
		List<RestaurantMenu> list = new ArrayList<RestaurantMenu>();
		list.add(menu);
		list.add(menu);
		
		RestaurantTime rt = new RestaurantTime();
		rt.setRestaurantDay(1);
		rt.setRestaurantOpen("09:00");
		rt.setRestaurantClose("20:00");
		rt.setRestaurantBreak("15:00");
		rt.setRestaurantLastOrder("19:00");
		rt.setRestaurantDayOff(false);
		
		List<RestaurantTime> list2 = new ArrayList<RestaurantTime>();
		list2.add(rt);
		list2.add(rt);
		
		List<String> rm = new ArrayList<String>();
		rm.add("first.jpg");
		rm.add("second.jpg");
		rm.add("third.jpg");
		
		
		member.setMemberId("user01@zzupzzup.com");
		member.setMemberName("홍진호");
		restaurant.setMember(member);
		//restaurant.setOwnerName("홍진호");
		restaurant.setOwnerImage("image.jpg");
		restaurant.setRestaurantName("거구장");
		restaurant.setRestaurantText("짜파게티보다 맛있는 집");
		restaurant.setRestaurantTel("02-734-2485");
		restaurant.setStreetAddress("서울 종로구 인사동3길 29");
		restaurant.setAreaAddress("서울 종로구 인사동 215-1");
		restaurant.setMenuType(1);
		restaurant.setRestaurantMenus(list);
		restaurant.setRestaurantTimes(list2);
		restaurant.setRestaurantImage(rm);
		
		restaurantService.addRestaurant(restaurant);
		
		System.out.println("addRestaurant Test : " + restaurant.toString());
		
	}
	
	
	@Test
	public void testGetRestaurant() throws Exception {
		
		Restaurant restaurant = restaurantService.getRestaurant(17);
		
		System.out.println(restaurant);
		
		//Assert.assertEquals("image.jpg", restaurant.getOwnerImage());
		//Assert.assertEquals("거구장", restaurant.getRestaurantName());
		//Assert.assertEquals("짜파게티보다 맛있는 집", restaurant.getRestaurantText());
		//Assert.assertEquals("02-734-2485", restaurant.getRestaurantTel());
		//Assert.assertEquals("서울 종로구 인사동3길 29", restaurant.getStreetAddress());
		//Assert.assertEquals("서울 종로구 인사동 215-1", restaurant.getAreaAddress());
		//Assert.assertEquals(1, restaurant.getMenuType());
		
	}
	
	
	//@Test
	public void testUpdateRestaurant() throws Exception {
		
		Restaurant restaurant = restaurantService.getRestaurant(3);
		
		restaurant.setOwnerImage("updateTest.jpg");
		restaurant.setRestaurantName("거구장 종각점");
		restaurant.setRestaurantText("짜짜로니보다 맛있는 집");
		restaurant.setRestaurantTel("02-734-2486");
		restaurant.setStreetAddress("서울 종로구 인사동3길 29");
		restaurant.setAreaAddress("서울 종로구 인사동 215-1");
		restaurant.setMenuType(2);
		
		//System.out.println(restaurant.toString());
		
		restaurantService.updateRestaurant(restaurant);
		
	}
	
	
}