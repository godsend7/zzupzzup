package com.zzupzzup.web.restaurant;

import java.io.File;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.common.Search;
import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.restaurant.RestaurantService;

@RestController
@RequestMapping("/restaurant/*")
public class RestaurantRestController {
	
	///Field
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;
	
	
	///Constructor
	public RestaurantRestController() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping(value="json/addRestaurant/searchKeyword={searchKeyword}", method=RequestMethod.GET)
	public Map<String, Object> addRestaurant(@ModelAttribute("search") Search search, 
			HttpServletRequest request) throws Exception {
		
		System.out.println("/restaurant/json/addRestaurant : GET");
		System.out.println("REQUEST KEYWORD : " + search.getSearchKeyword());
		
		String searchK2yword = search.getSearchKeyword();
		
		search.setSearchKeyword(null);
		
		String decodeText = URLDecoder.decode(searchK2yword, "UTF-8");
		System.out.println("decodeText : " + decodeText);
		search.setSearchKeyword(decodeText);
		
		Map<String, Object> map = restaurantService.listRestaurantName(search);
		
		Restaurant restaurant = new Restaurant();
		
		map.put("restaurant", restaurant);
		
		return map;
		
	}
	
	@RequestMapping(value="json/addDragFile", method=RequestMethod.POST)
	public List<String> addDragFile(MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/restaurant/json/addDragFile : POST");
		
		List<MultipartFile> fileList = multipartRequest.getFiles("uploadFile");
		System.out.println("FILE LIST TO UPLOAD : " + fileList);
		
		List<String> resImg = new ArrayList<String>();
		String filePath = request.getServletContext().getRealPath(CommonUtil.IMAGE_PATH);
		System.out.println("FILE_PATH : " + filePath);
		
		for(MultipartFile mf : fileList) {
			
			if(!mf.getOriginalFilename().equals("")) {
				System.out.println(":: 파일 이름 => " + mf.getOriginalFilename());
				System.out.println(":: 파일 사이즈 => " + mf.getSize());
				
				try {
					String fileName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mf.getOriginalFilename());
					
					File file = new File(filePath + "/" + fileName);
					mf.transferTo(file);
					
					System.out.println(":: 저장할 이름 => " + fileName);
					resImg.add(fileName);
					
					System.out.println("::: IMAGE UPLOAD SUCCESS :::");
					
				} catch (Exception e) {
					System.out.println("::: IMAGE UPLOAD FAIL :::");
					e.printStackTrace();
				}
				
			}
			
		}
		
		return resImg;
		
	}
	
	@RequestMapping(value = "json/checkCallDibs/{restaurantNo}", method = RequestMethod.GET)
	public Restaurant checkCallDibs(@PathVariable("restaurantNo") int restaurantNo, HttpSession session) throws Exception {
		
		System.out.println("/restaurant/json/checkCallDibs : GET");
		
		Member member = (Member)session.getAttribute("member");
		System.out.println("MEMBER INFOMATION : " + member);
		
		if(member != null) {
			restaurantService.checkCallDibs(member.getMemberId(), restaurantNo);
		}
		
		return restaurantService.getRestaurant(restaurantNo);
		
	}
	
	@RequestMapping(value = "json/cancelCallDibs/{restaurantNo}", method = RequestMethod.GET)
	public Restaurant cancelCallDibs(@PathVariable("restaurantNo") int restaurantNo, HttpSession session) throws Exception {
		
		System.out.println("/restaurant/json/cancelCallDibs : GET");
		
		Member member = (Member)session.getAttribute("member");
		System.out.println("MEMBER INFOMATION : " + member);
		
		if(member != null) {
			restaurantService.cancelCallDibs(member.getMemberId(), restaurantNo);
		}
		
		return restaurantService.getRestaurant(restaurantNo);
		
	}

}
