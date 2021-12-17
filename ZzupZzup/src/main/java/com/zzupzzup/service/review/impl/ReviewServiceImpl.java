package com.zzupzzup.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
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
	public Map<String, Object> listReview(Search search) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", reviewDao.listReview(search));
		map.put("totalCount", reviewDao.getTotalCount(search));
		map.put("likeCount", reviewDao.getLikeCount());
		
		return map;
	}

	@Override
	public Map<String, Object> listMyReview(Search search, String memberId) throws Exception { //map으로??? like)
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("memberId", memberId);
		
		map.put("list", reviewDao.listMyReview(map));
		map.put("totalCount", reviewDao.getTotalCount(search));
		map.put("likeCount", reviewDao.getLikeCount());
		
		return map;
	}

	@Override
	public Map<String, Object> listMyLikeReview(String memberId) throws Exception {
		// TODO Auto-generated method stub
		
		
		return null;
	}

	@Override
	public List<String> listHashTag(String search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int addLike(String memberId, int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteLike(String memeberId, int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
