package com.zzupzzup.service.rating.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.chat.ChatDAO;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Rating;
import com.zzupzzup.service.rating.RatingDAO;
import com.zzupzzup.service.rating.RatingService;

@Service("ratingServiceImpl")
public class RatingServiceImpl implements RatingService {
	
	///Field
	@Autowired
	@Qualifier("ratingDaoImpl")
	private RatingDAO ratingDao;

	///Constructor
	public RatingServiceImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public int addRating(Rating rating) throws Exception {
		return ratingDao.addRating(rating);
	}

	@Override
	public Map<String, Object> listRating(Search search) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("list", ratingDao.listRating(map));
		map.put("totalCount", ratingDao.getTotalCount(search));
		
		return map;
	}

	@Override
	public Map<String, Object> listMyRating(Search search, String memberId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("memberId", memberId);
		
		map.put("list", ratingDao.listMyRating(map));
		map.put("totalCount", ratingDao.getMyTotalCount(memberId));
		
		return map;
	}

}
