package com.zzupzzup.web.community;

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

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.community.CommunityService;
import com.zzupzzup.service.domain.Community;

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
	public String addCommunity(@ModelAttribute("community") Community community) throws Exception {
		
		System.out.println("/community/addCommunity : POST");
		
		System.out.println(community);
		
		communityService.addCommunity(community);
		
		return "redirect:/community/listCommunity";
	}
	
	@RequestMapping(value="getCommunity", method=RequestMethod.GET)
	public String getCommunity(@RequestParam("postNo") int postNo, Model model) throws Exception {
		
		System.out.println("/community/getCommunity : GET");
		
		System.out.println("test section 1 : " + postNo);
		
		Community community = communityService.getCommunity(postNo);
		
		System.out.println("test section 2 : " + postNo);
		
		model.addAttribute("community", community);
		
		System.out.println("test section 3 : " + community);
		
		return "forward:/community/getCommunity.jsp";
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
	
	
}
