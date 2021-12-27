package com.zzupzzup.web.community;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
		
		return "redirect:/community/getCommunity.jsp";
	}
	
	@RequestMapping(value="getCommunity", method=RequestMethod.GET)
	public String getCommunity(@RequestParam("postNo") int postNo, Model model) throws Exception {
		
		System.out.println("/community/getCommunity : GET");
		
		Community community = communityService.getCommunity(postNo);
		
		model.addAttribute("community", community);
		
		return "forward:/community/getCommunity.jsp";
	}
	
	@RequestMapping(value="updateCommunity", method=RequestMethod.POST)
	public String updateCommunity(@ModelAttribute("community") Community community) throws Exception {
		
		System.out.println("community/updateCommunity : POST");
		
		communityService.updateCommunity(community);
		
		return "redirect:/community/updateCommunity" + community.getPostNo();
	}
	
	@RequestMapping(value="listCommunity")
	public String listCommunity(@ModelAttribute("search") Search search, Model model) throws Exception {
		
		System.out.println("/community/listCommunity");
		
		if(search.getCurrentPage() == 0) {
			search.setPageSize(1);
		}
		
		search.setPageSize(0); //pageSize
		
		Map<String, Object> map = communityService.listCommunity(search);
		
		//pageUnit, pageSize
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 0, 0);
		System.out.println("RESULT PAGE : " + resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/community/listcommunity.jsp";	
	}
	
	
}
