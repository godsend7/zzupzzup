package com.zzupzzup.service.review;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Review;

public interface ReviewDAO {
	
	public int addReview(Review review) throws Exception;
	
	public int updateReview(Review review) throws Exception;
	
	public int deleteReview(int reviewNo) throws Exception;
	
	public Review getReview(int reviewNo) throws Exception;
	
	public List<Review> listReview(Map<String, Object> map) throws Exception;

	public List<Review> listMyReview(Map<String, Object> map) throws Exception; //해보기 
	
	public List<Review> listMyLikeReview(String memberId) throws Exception;
	
	public List<String> listHashTag(String search) throws Exception;
	
	public int deleteHashTag(int reviewNo) throws Exception;
	
	public int addLike(Map<String, Object> map) throws Exception;
	
	public int deleteLike(Map<String, Object> map) throws Exception;
	
	public int getTotalCount(Search search) throws Exception; 
	
	public void getTotalAvg() throws Exception; //필요성 생각해보기 
	
	public int getLikeCount() throws Exception; //각각의 리뷰의 count를 어떻게 할 것인지 생각해보기 

}
