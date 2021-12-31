package com.zzupzzup.web.community;

import java.io.File;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.service.community.CommunityService;
import com.zzupzzup.service.domain.Community;
import com.zzupzzup.service.domain.RestaurantTime;
import com.zzupzzup.service.member.MemberService;

@Controller
@RequestMapping("/community/*")
public class CommunityController {
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	///Field
	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	
	///Constructor
	public CommunityController() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping(value="addCommunity", method=RequestMethod.GET)
	public String addCommunity() throws Exception {
		
		System.out.println("/community/addCommunityView : GET");
		
		return "forward:/community/addCommunityView.jsp";
	}
	
	@RequestMapping(value="addCommunity", method=RequestMethod.POST)
	public String addCommunity(@ModelAttribute("community") Community community, 
			@ModelAttribute("restaurantTimes") Community restaurantTimes, 
			MultipartHttpServletRequest uploadFile, 
			HttpServletRequest request) throws Exception {
		
		System.out.println("/community/addCommunity : POST");
		
		String empty = request.getServletContext().getRealPath("/resources/images/uploadImages");
		
		uploadFilePath(uploadFile, empty, community);
		
		if(communityService.addCommunity(community) == 1) {
			System.out.println("POST UPLOAD SUCCESS");
			
			System.out.println("write by : " + community.getMember());
			memberService.addActivityScore(community.getMember().getMemberId(), 3, 10);
		}
		
		for(RestaurantTime rt : restaurantTimes.getRestaurantTimes()) {
			System.out.println(rt);
		}
		
		System.out.println(community);
		
		return "redirect:/community/listCommunity";
	}
	
	@RequestMapping(value="getCommunity", method=RequestMethod.GET)
	public String getCommunity(@RequestParam("postNo") int postNo, Model model) throws Exception {
		
		System.out.println("/community/getCommunity : GET");
		
//		System.out.println("test section 1 : " + postNo);
		
		Community community = communityService.getCommunity(postNo);
		
//		System.out.println("test section 2 : " + postNo);
		
		model.addAttribute("community", community);
		
//		System.out.println("test section 3 : " + community);
		
		return "forward:/community/getCommunity.jsp";
	}
	
	@RequestMapping(value="updateCommunity", method=RequestMethod.GET)
	public String updateCommunity(@RequestParam("postNo") int postNo, HttpSession session) throws Exception {
		
		System.out.println("community/updateCommunity : GET");
		
		Community community = communityService.getCommunity(postNo);
		
		session.setAttribute("community", community);
		
		return "forward:/community/updateCommunity.jsp";
	}
	
	
	@RequestMapping(value="updateCommunity", method=RequestMethod.POST)
	public String updateCommunity(@ModelAttribute("community") Community community, HttpSession session) throws Exception {
		
		System.out.println("community/updateCommunity : POST");
		
		communityService.updateCommunity(community);
		
		int sessionNo = community.getPostNo();
		String sessinNum = Integer.toString(sessionNo);
		
		if(sessinNum.equals(community.getPostNo())) {
			session.setAttribute("community", community);
		}
		
		return "redirect:/community/updateCommunity" + community.getPostNo();
	}
	
	@RequestMapping(value="listCommunity")
	public String listCommunity(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
		
		System.out.println("/community/listCommunity : SERVICE");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		/*
		 * if(request.getParameter("page") != null) {
		 * search.setCurrentPage(Integer.parseInt(request.getParameter("page"))); }
		 */
		
		System.out.println(search);
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = communityService.listCommunity(search);
		
		//pageUnit, pageSize
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("RESULT PAGE : " + resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/community/listCommunity.jsp";	
	}
	
	@RequestMapping(value="deleteCommunity", method=RequestMethod.POST)
	public String deleteCommunity(@RequestParam("postNo") int postNo) throws Exception {
		
		System.out.println("/community/deleteCommunity : POST");
		
		System.out.println("THE POST YOU ARE GOING TO DELETE : " + postNo);
		
		communityService.deleteCommunity(postNo);
		
		System.out.println("POST DELETE SUCCESS");
		
		return "redirect:/community/listCommunity";
	}
	
	private void uploadFilePath(MultipartHttpServletRequest uploadFile, String empty, Community community) {
		
		List<MultipartFile> fileList = uploadFile.getFiles("file");
		
		List<String> cnImg = new ArrayList<String>();
		
		for(MultipartFile mpf : fileList) {
			if(!mpf.getOriginalFilename().equals("")) {
				
				try {
					String fileName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mpf.getOriginalFilename());
					
					File file = new File(empty + "/" + fileName);
					
					mpf.transferTo(file);
					
					cnImg.add(fileName);
					community.setPostImage(cnImg);
					
					System.out.println("IMAGES UPLOAD SUCCESS");
					
				} catch (Exception e) {
					System.out.println("YOU CAN NOT UPLOAD IMAGES");
					e.printStackTrace();
				}
				
			}
		}
		
	}
	
	
}
