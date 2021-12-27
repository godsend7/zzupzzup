package com.zzupzzup.service.rating;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Rating;

public interface RatingDAO {
	
	// Insert
	public int addRating(Rating rating) throws Exception;
	
	// Select List
	public List<Rating> listRating(Map<String, Object> map) throws Exception;
	
	// Page Row(totalCount) return
	public int getTotalCount(Search search) throws Exception;
	
	// Select List
	public List<Rating> listMyRating(Map<String, Object> map) throws Exception;
	
	
}
