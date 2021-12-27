package com.zzupzzup.service.rating.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Rating;
import com.zzupzzup.service.rating.RatingDAO;

@Repository("ratingDaoImpl")
public class RatingDAOImpl implements RatingDAO {
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public RatingDAOImpl() {
		System.out.println(this.getClass());
	}
	
	//Method
	@Override
	public int addRating(Rating rating) throws Exception {
		int result = sqlSession.insert("RatingMapper.addRating", rating);
		
		if(result == 1) {
			return 1;
		}else {
			return 0;
		}
		
	}
	
	@Override
	public List<Rating> listRating(Map<String, Object> map) throws Exception {
		System.out.println("ratingDaoImpl listRating map : " + map);
		
		List<Rating> list = sqlSession.selectList("RatingMapper.listRating", map);
		
		return list;
	}
	
	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("RatingMapper.getTotalCount", search);
	}

	@Override
	public List<Rating> listMyRating(Map<String, Object> map) throws Exception {
		System.out.println("ratingDaoImpl listMyRating map : " + map);
		
		List<Rating> list = sqlSession.selectList("RatingMapper.listMyRating", map);
		
		return list;
	}

}
