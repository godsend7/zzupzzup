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
		
		String temDir = request.getServletContext().getRealPath(CommonUtil.IMAGE_PATH);
		
		uploadFilePath(uploadfile, temDir, review);
		
		System.out.println(review);
		
		if(reviewService.addReview(review) == 1) {
			System.out.println("review insert success");
			//리뷰 작성 성공 시 활동점수 추가 
			memberService.addActivityScore(review.getMember().getMemberId(), 2, 5); //리뷰 작성 시 5
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
	public String updateReview(@ModelAttribute("review") Review review, MultipartHttpServletRequest uploadfile, Model model, HttpServletRequest request) throws Exception {
		
		System.out.println("review/updateReview : POST");
		
		String temDir = request.getServletContext().getRealPath(CommonUtil.IMAGE_PATH);
		
		uploadFilePath(uploadfile, temDir, review);
		
		reviewService.updateReview(review);
		
		return "redirect:/review/listReview";
	}
	
	@RequestMapping("listReview")
	public String listReview(HttpServletRequest request, @ModelAttribute Search search, Model model, HttpSession session) throws Exception {
		
		System.out.println("review/listReview : Service");
		
		String restaurantNo = request.getParameter("restaurantNo");
		Member member = (Member) session.getAttribute("member");
		
		List<Mark> listLike = null;
		
		String memberId = null;
		
		if (member != null && member.getMemberRole().equals("user")) {
			memberId = member.getMemberId();
			listLike = reviewService.listLike(memberId);
		}
		
		
		System.out.println(restaurantNo);
		System.out.println(member);
		
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		System.out.println(search.getCurrentPage() + ":: currentPage");
		
		search.setPageSize(pageSize);
		
		
		Map<String, Object> map = reviewService.listReview(search, restaurantNo, memberId);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
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
		
		//file의 name을 가지고 있는 input tag 가져오기
		List<MultipartFile> fileList = uploadfile.getFiles("file");
		
		List<String> reviewImage = new ArrayList<String>();
		
		for (MultipartFile mf : fileList) {
			//image가 존재한다면(image의 name이 공백이 아닐경우)
			if (!mf.getOriginalFilename().equals("")) {
//				System.out.println(":: 파일 이름 => " + mf.getOriginalFilename());
//				System.out.println(":: 파일 사이즈 => " + mf.getSize());
	
				try {
					String saveName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mf.getOriginalFilename());
					
					File file = new File(temDir + "/" + saveName);
					mf.transferTo(file);
									
					//System.out.println(":: 저장할 이름 => " + saveName);
					 
					reviewImage.add(saveName);
					review.setReviewImage(reviewImage);
				
					System.out.println("업로드 성공");
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println("업로드 없음");
					e.printStackTrace();
					//saveName = "notFile.png";
				}
			}
		}
	}
}