package com.zzupzzup.service.rating;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Rating;

public interface RatingService {
	
	// Insert
	public int addRating(Rating rating) throws Exception;
	
	// Select List
	public Map<String, Object> listRating(Search search) throws Exception;
}
