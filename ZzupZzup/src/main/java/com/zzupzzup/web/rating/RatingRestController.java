package com.zzupzzup.web.rating;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Rating;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.rating.RatingService;

@RestController
@RequestMapping("/rating/*")
public class RatingRestController {

	/// Field
	@Autowired
	@Qualifier("ratingServiceImpl")
	private RatingService ratingService;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;


	public RatingRestController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@ResponseBody
	@RequestMapping(value="json/addRating", method=RequestMethod.POST)
	public int addRating(@RequestBody  Map<String, Object> ratingData, HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("/rating/json/addRating : POST");
		System.out.println(ratingData);
		
		// json으로 받은 데이터 String으로 형변환
		String jsonData = ratingData.get("ratingArrObj").toString();
		// Object로 형변환
		Object ratingObj = JSONValue.parse(jsonData);
		// JSONArrat로 형변환
		JSONArray ratingObjArr = (JSONArray)ratingObj;
		  
		//System.out.println("1::::"+jsonData);
		//System.out.println("5:::"+ratingObjArr.size());
		//System.out.println("6:::"+ratingObjArr);
		
		// List로 형변환
		List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
		resultMap = (List<Map<String, Object>>) ratingObj;
		
		//System.out.println(resultMap);
		//System.out.println(resultMap.size());
		
		for(int i=0; i<ratingObjArr.size(); i++) {
			
			Rating rating = new Rating();
			Member toMember = new Member();
			Member fromMember = new Member();
			
			System.out.println(ratingObjArr.get(i));
			JSONObject obj = (JSONObject)ratingObjArr.get(i);
			System.out.println(obj.get("ratingToId"));
			int ratingType = Integer.parseInt(obj.get("ratingType").toString());
			int ratingScore = 0;
			toMember.setMemberId(obj.get("ratingToId").toString());
			fromMember.setMemberId(obj.get("ratingFromId").toString());
			rating.setChatNo(Integer.parseInt((String) obj.get("chatNo")));
			rating.setRatingFromId(fromMember);
			rating.setRatingToId(toMember);
			rating.setRatingType(ratingType);
			
			if(ratingType == 1) {
				ratingScore = -1;
			}else if(ratingType == 2) {
				ratingScore = 1;
			}else if(ratingType == 3) {
				ratingScore = 2;
			}
			
			rating.setRatingScore(ratingScore);
			  
			ratingService.addRating(rating);
			//MemberService.calculateMannerScore(toMember.getMemberId(), ratingScore);
		  }
		
		return 1;
	}


}
