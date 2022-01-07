package com.zzupzzup.web.restaurant;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.RestaurantMenu;
import com.zzupzzup.service.domain.RestaurantTime;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.restaurant.RestaurantService;

@Controller
@RequestMapping("/restaurant/*")
public class RestaurantController {
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	///Field
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	
	///Constructor
	public RestaurantController() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping(value="addRestaurant", method=RequestMethod.GET)
	public String addRestaurant() throws Exception {
		
		System.out.println("/restaurant/addRestaurant : GET");
		//System.out.println("memberId : "+memberId);
		
		return "forward:/restaurant/addRestaurantView.jsp";
	}
	
	@RequestMapping(value="addRestaurant", method=RequestMethod.POST)
	public String addRestaurant(@ModelAttribute("restaurant") Restaurant restaurant, 
			@ModelAttribute("restaurantMenus") Restaurant restaurantMenus,
			@ModelAttribute("restaurantTimes") Restaurant restaurantTimes,
			/*@ModelAttribute("restaurantImage") Restaurant restaurantImage*/
			@RequestParam(value="file", required = false) MultipartFile uploadOwnerFile,
			MultipartHttpServletRequest uploadFile,
			HttpServletRequest request) throws Exception {
			
		System.out.println("/restaurant/addRestaurant : POST");
		
		String empty = request.getServletContext().getRealPath("/resources/images/uploadImages");
		uploadFilePath(uploadFile, empty, restaurant);
		
		//System.out.println("debugging point1 : " + uploadOwnerFile);
		
		String vacant = request.getServletContext().getRealPath("/resources/images/uploadImages/owner");
		String ownerImage = uploadOwnerImg(uploadOwnerFile, vacant);
		
		restaurant.setOwnerImage(ownerImage);
		
		if(restaurantService.addRestaurant(restaurant) == 1) {
			System.out.println("INSERT RESTAURANT SUCCESS");
			
			System.out.println("Uploaded by : " + restaurant.getMember().getMemberId());
			//memberService.addActivityScore(restaurant.getMember().getMemberId(), 3, 10);
		}
		
		for(RestaurantMenu rm : restaurantMenus.getRestaurantMenus()) {
			System.out.println(rm);
		}
		
		for(RestaurantTime rt : restaurantTimes.getRestaurantTimes()) {
			System.out.println(rt);
		}
		
		/*
		 * for(String ri : restaurantImage.getRestaurantImage()) {
		 * System.out.println(ri); }
		 */
		
		//System.out.println("Restaurant Menu : " + restaurant.getRestaurantMenus());
		
		return "forward:/restaurant/addRestaurant.jsp";
	}
	
	@RequestMapping(value="getRestaurant", method=RequestMethod.GET)
	public String getRestaurant(@RequestParam("restaurantNo") int restaurantNo, Model model) throws Exception {
		
		System.out.println("/restaurant/getRestaurant : GET");
		
		Restaurant restaurant = restaurantService.getRestaurant(restaurantNo);
		
		model.addAttribute("restaurant", restaurant);
		
		return "forward:/restaurant/getRestaurant.jsp";
	}
	
	@RequestMapping(value="getRequestRestaurant", method=RequestMethod.GET)
	public String getRequestRestaurant(@RequestParam("restaurantNo") int restaurantNo, Model model) throws Exception {
		
		System.out.println("/restaurant/getRequestRestaurant : GET");
		
		Restaurant restaurant = restaurantService.getRestaurant(restaurantNo);
		
		model.addAttribute("restaurant", restaurant);
		
		return "forward:/restaurant/getRequestRestaurant.jsp";
	}
	
	@RequestMapping(value="updateRestaurant", method=RequestMethod.GET)
	public String updateRestaurant(@RequestParam("restaurantNo") int restaurantNo, HttpSession session) throws Exception {
		
		System.out.println("/restaurant/updateRestaurant : GET");
		
		Restaurant restaurant = restaurantService.getRestaurant(restaurantNo);
		
		session.setAttribute("restaurant", restaurant);
		
		return "forward:/restaurant/updateRestaurant.jsp";
	}
	
	@RequestMapping(value="updateRestaurant", method=RequestMethod.POST)
	public String updateRestaurant(@ModelAttribute("restaurant") Restaurant restaurant, MultipartHttpServletRequest uploadFile, @RequestParam(value="file", required = false) MultipartFile uploadOwnerFile, HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("/restaurant/updateRestaurant : POST");
		
		String empty = request.getServletContext().getRealPath(CommonUtil.IMAGE_PATH);
		uploadFilePath(uploadFile, empty, restaurant);
		
		String vacant = request.getServletContext().getRealPath("/resources/images/uploadImages/owner");
		String ownerImage = uploadOwnerImg(uploadOwnerFile, vacant);
		
		restaurant.setOwnerImage(ownerImage);
		
		restaurantService.updateRestaurant(restaurant);
		
		int sessionNo = restaurant.getRestaurantNo();
		String sessionNum = Integer.toString(sessionNo);
		
		if(sessionNum.equals(restaurant.getRestaurantNo())) {
			session.setAttribute("restaurant", restaurant);
		}
		
		Restaurant res = (Restaurant) session.getAttribute("restaurant");
		
		System.out.println("CHECK POINT : " + res);
		
		if(res.getJudgeDate() != null) {
			return "redirect:/restaurant/getRestaurant?restaurantNo=" + restaurant.getRestaurantNo();
		} else {
			return "forward:/restaurant/addRestaurant?restaurantNo=" + restaurant.getRestaurantNo();
		}
		
	}
	
	@RequestMapping(value="listRestaurant")
	public String listRestaurant(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
		
		System.out.println("/restaurant/listRestaurant : SERVICE");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		
		if(request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = restaurantService.listRestaurant(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("resultPage", resultPage);
		
		return "forward:/restaurant/listRestaurant.jsp";
		
	}
	
	@RequestMapping(value="listRequestRestaurant")
	public String listRequestRestaurant(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
		
		System.out.println("/restaurant/listRequestRestaurant : SERVICE");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		
		if(request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = restaurantService.listRestaurant(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("resultPage", resultPage);
		
		return "forward:/restaurant/listRequestRestaurant.jsp";
		
	}
	
	@RequestMapping(value="judgeRestaurant")
	public String judgeRestaurant(@ModelAttribute Restaurant restaurant) throws Exception {
		
		System.out.println("/restaurant/judgeRestaurant : POST");
		
		System.out.println("CHECK POINT : " + restaurant);
		
		restaurantService.judgeRestaurant(restaurant);
		
		return "redirect:/";
		
	}
	
	@RequestMapping(value="deleteRestaurant", method=RequestMethod.GET)
	public String deleteRestaurant(@RequestParam("restaurantNo") int restaurantNo) throws Exception {
		
		System.out.println("/restaurant/listRestaurant : GET");
		
		System.out.println("DELETE TO : " + restaurantNo);
		
		restaurantService.deleteRestaurant(restaurantNo);
		
		System.out.println("SUCCESS OF DELETE RESTAURANT");
		
		return "redirect:/restaurant/listRestaurant";
	}
	
	private void uploadFilePath(MultipartHttpServletRequest uploadFile, String empty, Restaurant restaurant) {
		
		List<MultipartFile> fileList = uploadFile.getFiles("multiFile");
		
		List<String> resImg = new ArrayList<String>();
		
		for(MultipartFile mpf : fileList) {
			if(!mpf.getOriginalFilename().equals("")) {
				
				try {
					String fileName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mpf.getOriginalFilename());
					
					File file = new File(empty + "/" + fileName);
					
					mpf.transferTo(file);
					
					resImg.add(fileName);
					restaurant.setRestaurantImage(resImg);
					
					System.out.println("IMAGES UPLOAD SUCCESS");
					
				} catch (Exception e) {
					System.out.println("YOU CAN NOT UPLOAD IMAGES");
					e.printStackTrace();
				}
			}
		}	
	}
	
	private String uploadOwnerImg(MultipartFile uploadOwnerFile, String vacant) {
		
		//System.out.println("CHECK POINT 1 : " + uploadOwnerFile.getOriginalFilename());
		
		String ownerInfo = uploadOwnerFile.getOriginalFilename();
		
		//System.out.println("ownerInfo : " + ownerInfo);
		
		Path checkpoint = Paths.get(vacant, File.separator + StringUtils.cleanPath(ownerInfo));
		
		try {
			Files.copy(uploadOwnerFile.getInputStream(), checkpoint, StandardCopyOption.REPLACE_EXISTING);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return ownerInfo;
	}
	
	
}
