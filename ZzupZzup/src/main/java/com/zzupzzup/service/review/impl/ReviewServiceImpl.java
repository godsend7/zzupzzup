package com.zzupzzup.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.HashTag;
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.review.ReviewDAO;
import com.zzupzzup.service.review.ReviewService;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	@Qualifier("reviewDaoImpl")
	private ReviewDAO reviewDao;
	
	public ReviewServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int addReview(Review review) throws Exception {
		// TODO Auto-generated method stub
		return reviewDao.addReview(review);
	}

	@Override
	public int updateReview(Review review) throws Exception {
		// TODO Auto-generated method stub
		return reviewDao.updateReview(review);
	}

	@Override
	public int deleteReview(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return reviewDao.deleteReview(reviewNo);
	}

	@Override
	public Review getReview(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return reviewDao.getReview(reviewNo);
	}

	@Override
	public Map<String, Object> listReview(Search search, String restaurantNo, String memberId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("restaurantNo", restaurantNo);
		map.put("memberId", memberId);
		
		System.out.println("listReview의 search 확인 :: " + search);
		System.out.println("listReview의 search 확인2 :: " + search.getStartRowNum());
		System.out.println("listReview의 search 확인2 :: " + search.getPageSize());
		
		map.put("list", reviewDao.listReview(map));
		map.put("totalCount", reviewDao.getTotalCount(map));
		
		if (restaurantNo != null) {
			map.put("avgTotalScope", reviewDao.getTotalAvg(restaurantNo));
		}

		return map;
	}

	@Override
	public Map<String, Object> listMyLikeReview(Search search, String memberId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("memberId", memberId);
		
		map.put("list", reviewDao.listMyLikeReview(map));
		map.put("totalCount", reviewDao.getTotalCount(map));
		
		return map;
	}

	@Override
	public List<HashTag> listHashTag(String search) throws Exception {
		// TODO Auto-generated method stub
		return reviewDao.listHashTag(search);
	}
	
	@Override
	public List<Mark> listLike(String memberId) throws Exception {
		// TODO Auto-generated method stub
		return reviewDao.listLike(memberId);
	}

	@Override
	public int addLike(String memberId, int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("reviewNo", reviewNo);
		
		return reviewDao.addLike(map);
	}

	@Override
	public int deleteLike(String memberId, int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("reviewNo", reviewNo);
		
		return reviewDao.deleteLike(map);
	}
}
