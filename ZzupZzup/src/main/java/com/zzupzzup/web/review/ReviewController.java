package com.zzupzzup.web.review;

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
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.reservation.ReservationService;
import com.zzupzzup.service.restaurant.RestaurantService;
import com.zzupzzup.service.review.ReviewService;


@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	///Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	///Field
	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService reservationService;
	
	///Field
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;
	
	///Field
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;
	
	
	///Constructor
	public ReviewController() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping(value="addReview", method=RequestMethod.GET)
	public String addReview(@RequestParam("reservationNo") int reservationNo, Model model) throws Exception {
		
		System.out.println("review/addReview : GET");
		
		Review review = new Review();
		review.setReservation(reservationService.getReservation(reservationNo));
		review.setRestaurant(restaurantService.getRestaurant(review.getReservation().getRestaurant().getRestaurantNo()));
		
		System.out.println(review);
		model.addAttribute("review", review);
		
		return "forward:/review/addReviewView.jsp";
	}
	
	@RequestMapping(value="addReview", method=RequestMethod.POST)
	public String addReview(@ModelAttribute("review") Review review, MultipartHttpServletRequest uploadfile, Model model, HttpServletRequest request) throws Exception {
				
		System.out.println("review/addReview : POST");
		
		String temDir = request.getServletContext().getRealPath(CommonUtil.IMAGE_PATH+"review");
		
		uploadFilePath(uploadfile, temDir, review);
		
		System.out.println("????????? ?????? :: " + review);
		
		if(reviewService.addReview(review) == 1) {
			System.out.println("review insert success");
			//?????? ?????? ?????? ??? ???????????? ?????? 
			memberService.addActivityScore(review.getMember().getMemberId(), 2, 5); //?????? ?????? ??? 5
			memberService.calculateActivityScore(review.getMember().getMemberId());
		}
		
		return "redirect:/review/listReview";
	}
	
	@RequestMapping(value="updateReview", method=RequestMethod.GET)
	public String updateReview(@RequestParam("reviewNo") int reviewNo, Model model) throws Exception {
		
		System.out.println("review/updateReview : GET");
		
		Review review = reviewService.getReview(reviewNo);
		
		model.addAttribute("review", review);
		
		return "forward:/review/updateReviewView.jsp";
	}
	
	@RequestMapping(value="updateReview", method=RequestMethod.POST)
	public String updateReview(@ModelAttribute("review") Review review, MultipartHttpServletRequest uploadfile, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("review/updateReview : POST");
		
		String temDir = request.getServletContext().getRealPath(CommonUtil.IMAGE_PATH);
		
		uploadFilePath(uploadfile, temDir, review);
		
		Member member = (Member) session.getAttribute("member");
		review.setMember(member);
		
		reviewService.updateReview(review);
		
		return "redirect:/review/listReview";
	}
	
	@RequestMapping("listReview")
	public String listReview(HttpServletRequest request, @ModelAttribute Search search, Model model, HttpSession session) throws Exception {
		
		System.out.println("review/listReview : Service");
		
		String restaurantNo = request.getParameter("restaurantNo");
		Member member = (Member) session.getAttribute("member");
		
		List<Mark> listLike = null;
		
		if (member != null && member.getMemberRole().equals("user")) {
			restaurantNo = null;
			listLike = reviewService.listLike(member.getMemberId());
		}
		
		System.out.println(restaurantNo);
		System.out.println(member);
		
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		System.out.println(search.getCurrentPage() + ":: currentPage");
		
		search.setPageSize(pageSize);
		
		
		Map<String, Object> map = reviewService.listReview(search, restaurantNo, member);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("listLike", listLike);
		model.addAttribute("search", search);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("avgTotalScope", map.get("avgTotalScope"));
		model.addAttribute("resultPage", resultPage);
		
		return "forward:/review/listReview.jsp";
	}
	
	@RequestMapping("listMyLikeReview")
	public String listMyLikeReview(@ModelAttribute Search search, Model model, HttpSession session) throws Exception {
		
		System.out.println("review/listMyLikeReview : Service");
		
		Member member = (Member) session.getAttribute("member");
		
		List<Mark> listLike = null;
		
		if (member != null && member.getMemberRole().equals("user")) {
			listLike = reviewService.listLike(member.getMemberId());
		}
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		System.out.println(search.getCurrentPage() + ":: currentPage");
		
		search.setPageSize(pageSize);
		
		
		Map<String, Object> map = reviewService.listMyLikeReview(search, member);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		List<Review> list = (List<Review>) map.get("list");
		
		for (Review r : list) {
			System.out.println(r);
		}
		
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("listLike", listLike);
		model.addAttribute("search", search);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("avgTotalScope", map.get("avgTotalScope"));
		model.addAttribute("resultPage", resultPage);
		
		return "forward:/review/listReview.jsp";
	}
	
	@RequestMapping(value="deleteReview", method=RequestMethod.GET)
	public String deleteReview(@RequestParam("reviewNo") int reviewNo) throws Exception {
		
		reviewService.deleteReview(reviewNo);
		
		return "redirect:/review/listReview";
	}
	
	private void uploadFilePath(MultipartHttpServletRequest uploadfile, String temDir, Review review) {
		
		//file??? name??? ????????? ?????? input tag ????????????
		List<MultipartFile> fileList = uploadfile.getFiles("uploadFile");
		
		System.out.println(fileList);
		
		List<String> reviewImage = new ArrayList<String>();
		
		for (MultipartFile mf : fileList) {
			//image??? ???????????????(image??? name??? ????????? ????????????)
			if (!mf.getOriginalFilename().equals("")) {
				System.out.println(":: ?????? ?????? => " + mf.getOriginalFilename());
				System.out.println(":: ?????? ????????? => " + mf.getSize());
	
				try {
					String saveName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mf.getOriginalFilename());
					
					File file = new File(temDir + "/" + saveName);
					mf.transferTo(file);
									
					System.out.println(":: ????????? ?????? => " + saveName);
					 
					reviewImage.add(saveName);
					review.setReviewImage(reviewImage);
				
					System.out.println("????????? ??????");
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println("????????? ??????");
					e.printStackTrace();
					//saveName = "notFile.png";
				}
			}
		}
	}
}