package com.zzupzzup.service.review;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.HashTag;
import com.zzupzzup.service.domain.Review;

public interface ReviewDAO {
	
	public int addReview(Review review) throws Exception;
	
	public int updateReview(Review review) throws Exception;
	
	public int deleteReview(int reviewNo) throws Exception;
	
	public Review getReview(int reviewNo) throws Exception;
	
	public List<Review> listReview(Map<String, Object> map) throws Exception;
	
	public List<Review> listMyLikeReview(Map<String, Object> map) throws Exception;
	
	public List<HashTag> listHashTag(String search) throws Exception;
	
	public int addLike(Map<String, Object> map) throws Exception;
	
	public int deleteLike(Map<String, Object> map) throws Exception;
	
	public int getTotalCount(Search search) throws Exception; 
	
	public double getTotalAvg() throws Exception;
	
	public int getLikeCount(int reviewNo) throws Exception;

}
