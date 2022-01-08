package com.zzupzzup.web.member;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.restaurant.RestaurantService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	//*Field
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;

	//*Constructor
	public MemberController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	//*Method
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session) {
		
		System.out.println("/member/logout : GET");
		
		session.invalidate();
		
		return "redirect:/";
		
	}
	
	@RequestMapping(value="addMember/{memberRole}/{loginType}", method=RequestMethod.GET)
	public String addMember(@PathVariable String memberRole, @PathVariable String loginType) throws Exception {
		
		System.out.println("/member/addMember/"+memberRole+"/"+loginType+" : GET");
		
		return "forward:/member/addMemberView.jsp?memberRole="+memberRole+"&loginType="+loginType;
//		return "redirect:/member/addMember/"+memberRole+"/"+loginType;
		
	}
	
	@RequestMapping(value="addMember/{memberRole}/{loginType}", method=RequestMethod.POST)
	public String addMember(@PathVariable String memberRole, @PathVariable int loginType,
				@ModelAttribute("member") Member member, HttpServletRequest request,
				@RequestParam(value="fileInput", required = false) MultipartFile uploadfile) throws Exception {
		
		System.out.println("/member/addMember/"+memberRole+"/"+loginType+" : POST");
		
		String temp = request.getServletContext().getRealPath("/resources/images/uploadImages");
		String profileImage = uploadFile(uploadfile, temp, member.getProfileImage());
		
		member.setMemberRole(memberRole);
		member.setProfileImage(profileImage);
		member.setLoginType(loginType);
		memberService.addMember(member);
		
		Member pushMem = new Member();
		pushMem.setNickname(member.getPushNickname());
		Member push = memberService.getMember(pushMem);
		
		if(push != null) {
			//활동점수 추가하기
			memberService.addActivityScore(push.getMemberId(), 1, 10);
			memberService.calculateActivityScore(push.getMemberId());
		}
		
		if(member.getMemberRole().equals("owner")) {
			//member domain과 같이 음식점 등록으로 페이지 넘기기
			request.setAttribute("member", member);
			//return "redirect:/restaurant/addRestaurant?memberId="+member.getMemberId()+"&memberName="+member.getMemberName();
			
			return "forward:/restaurant/addRestaurantView.jsp";
		} else {
			return "redirect:/";
		}
		
	}
	
	@RequestMapping(value="getMember", method=RequestMethod.GET)
	public String getMember(@RequestParam("memberId") String memberId, HttpServletRequest request) throws Exception {
		
		System.out.println("/member/getMember : GET");
		
		Member memberIdSet = new Member();
		memberIdSet.setMemberId(memberId);
		Member member = memberService.getMember(memberIdSet);
		
		request.setAttribute("member", member);
		
		//owner의 경우 등록된 음식점 수 노출
		Search search = new Search();
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		
		if(request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		search.setPageSize(pageSize);
		
		Map<String, Object> myRestaurant = restaurantService.listMyRestaurant(search, member.getMemberId());
		//Page resultPage = new Page(search.getCurrentPage(), ((Integer)myRestaurant.get("totalCount")).intValue(), pageUnit, pageSize);
		
		request.setAttribute("myRestaurant", myRestaurant.get("list"));
		
		
		return "forward:/member/getMember.jsp";
	}

	@RequestMapping(value="listUser")
	public String listUser(@ModelAttribute("search") Search search, @ModelAttribute("member") Member member,
			HttpServletRequest request) throws Exception {
		
		System.out.println("/member/listUser : GET / POST");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		
		if(request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = memberService.listUser(search, member);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		request.setAttribute("listUser", map.get("listUser"));
		request.setAttribute("search", search);
		request.setAttribute("member", member);
		request.setAttribute("totalCount", map.get("totalCount"));
		request.setAttribute("resultPage", resultPage);
		
		return "forward:/member/listUser.jsp";
	}
	
	@RequestMapping(value="listOwner")
	public String listOwner(@ModelAttribute("search") Search search, @ModelAttribute("member") Member member,
			HttpServletRequest request) throws Exception {

		System.out.println("/member/listOwner : GET / POST");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		
		if(request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = memberService.listOwner(search, member);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		request.setAttribute("listOwner", map.get("listOwner"));
		request.setAttribute("search", search);
		request.setAttribute("member", member);
		request.setAttribute("totalCount", map.get("totalCount"));
		request.setAttribute("resultPage", resultPage);
		
		return "forward:/member/listOwner.jsp";
		
	}
	
	public void blacklistUser() {
		
	}
	
	@RequestMapping(value="updateMember", method=RequestMethod.GET)
	public String updateMember(@RequestParam("memberId") String memberId, HttpServletRequest request) throws Exception {
		
		System.out.println("/member/updateMember : GET");
		
		Member memberIdSet = new Member();
		memberIdSet.setMemberId(memberId);
		Member member = memberService.getMember(memberIdSet);
		
		request.setAttribute("member", member);
		
		return "forward:/member/updateMemberView.jsp";
	}
	
	@RequestMapping(value="updateMember/{memberRole}", method=RequestMethod.POST)
	public String updateMember(@PathVariable String memberRole, @ModelAttribute("member") Member member, HttpServletRequest request, HttpSession session,
			@RequestParam(value="fileInput", required = false) MultipartFile uploadfile) throws Exception {
		
		System.out.println("/member/updateMember : POST");
		
		System.out.println("1111 :: " + member);
		System.out.println("2222 :: " + uploadfile.getOriginalFilename());
		
		String temp = request.getServletContext().getRealPath("/resources/images/uploadImages");
		String profileImage = uploadFile(uploadfile, temp, member.getProfileImage());
		
		
		member.setProfileImage(profileImage);
		
		memberService.updateMember(member);
		
		String sessionId = ((Member)session.getAttribute("member")).getMemberId();
		if(sessionId.equals(member.getMemberId())){
			session.setAttribute("member", member);
			System.out.println("session value = "+session.getAttribute("member"));
		}
		
		return "redirect:/member/getMember?memberId="+member.getMemberId();
	}
	
	public void deleteMember() {
		
	}
	
	@RequestMapping(value="listMyActivityScore", method=RequestMethod.GET)
	public String listMyActivityScore(@RequestParam("memberId") String memberId, @ModelAttribute("search") Search search, @ModelAttribute("member") Member member,
			HttpServletRequest request) throws Exception {
		
		System.out.println("/member/listMyActivityScore : GET");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		
		if(request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = memberService.listActivityScore(search, memberId);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		request.setAttribute("listMyActivityScore", map.get("listMyActivityScore"));
		request.setAttribute("search", search);
		request.setAttribute("totalCount", map.get("totalCount"));
		request.setAttribute("resultPage", resultPage);
		
		System.out.println("map.get ==> "+map.get("listMyActivityScore"));
		
		return "forward:/member/listMyActivityScore.jsp";
		
	}
	
	public void calculateMannerScore() {
		
	}
	
	private String uploadFile(MultipartFile uploadfile, String temp, String originImg) throws Exception {
		
		System.out.println(":: uploadfile.getOriginalFilename() => " + uploadfile.getOriginalFilename());
		System.out.println(":: uploadfile.getSize() => " + uploadfile.getSize());
			
		String saveName = uploadfile.getOriginalFilename();
		
		System.out.println(":: saveName => " + saveName);
		
		Path copy = Paths.get(temp, File.separator + StringUtils.cleanPath(saveName));
		
		try {
			Files.copy(uploadfile.getInputStream(), copy, StandardCopyOption.REPLACE_EXISTING);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();

			if(originImg.equals("defaultImage.png")) {
				saveName = "defaultImage.png";
			} else {
				saveName = originImg;
			}
		}
		
		return saveName;
	}

}
