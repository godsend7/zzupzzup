package com.zzupzzup.web.rating;

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

import com.zzupzzup.common.ChatMember;
import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Rating;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.rating.RatingService;

@Controller
@RequestMapping("/rating/*")

public class RatingController {

	/// Field
	@Autowired
	@Qualifier("ratingServiceImpl")
	private RatingService ratingService;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;

	public RatingController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value = "listRating")
	public String listRating(@ModelAttribute("search") Search search, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("/rating/listChat : GET / POST");
		System.out.println("rating/listRating page : " + request.getParameter("page"));

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		if (request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}

		search.setPageSize(pageSize);

		// Business logic
		Map<String, Object> map = ratingService.listRating(search);
		//System.out.println("===================================");
		//System.out.println("listChat map : " + map);
		//System.out.println("===================================");

		List<Rating> list = (List<Rating>) map.get("list");

		Member member = (Member)session.getAttribute("member");
		System.out.println("listChat member : " + member);
		
		Member toMember = new Member();
		Member FromMember = new Member();
		
		for (Rating r : list) {
			toMember = memberService.getMember(r.getRatingToId());
			FromMember = memberService.getMember(r.getRatingFromId());
			//System.out.println("================++++=================");
			//System.out.println(toMember);
			//System.out.println("==================++++===============");
			r.setRatingToId(toMember);
			r.setRatingFromId(FromMember);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println("resultPage : " + resultPage);
		
		//System.out.println("===================================");
		//System.out.println("listChat list : " + list);
		//System.out.println("===================================");
		
		model.addAttribute("list", list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		request.setAttribute("member", member);
		
		return "forward:/rating/listRating.jsp";
	}
	
	@RequestMapping(value = "listMyRating")
	public String listMyRating(@ModelAttribute("search") Search search, Model model, HttpServletRequest request,	HttpSession session) throws Exception {
		System.out.println("/rating/listMyChat : GET / POST");
		System.out.println("rating/listRating page : " + request.getParameter("page"));

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		if (request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}

		search.setPageSize(pageSize);
		
		Member member = (Member)session.getAttribute("member");
		System.out.println("listChat member : " + member);

		// Business logic
		Map<String, Object> map = ratingService.listMyRating(search, member.getMemberId());
		//System.out.println("===================================");
		//System.out.println("listChat map : " + map);
		//System.out.println("===================================");

		List<Rating> list = (List<Rating>) map.get("list");
		
		Member toMember = new Member();
		Member FromMember = new Member();
		
		for (Rating r : list) {
			toMember = memberService.getMember(r.getRatingToId());
			FromMember = memberService.getMember(r.getRatingFromId());
			//System.out.println("================++++=================");
			//System.out.println(toMember);
			//System.out.println("==================++++===============");
			r.setRatingToId(toMember);
			r.setRatingFromId(FromMember);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println("resultPage : " + resultPage);
		
		//System.out.println("===================================");
		//System.out.println("listChat list : " + list);
		//System.out.println("===================================");
		
		model.addAttribute("list", list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		request.setAttribute("member", member);
		
		return "forward:/rating/listRating.jsp";
	}

}
