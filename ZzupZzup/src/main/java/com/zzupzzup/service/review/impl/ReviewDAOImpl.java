package com.zzupzzup.service.review.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.review.ReviewDAO;

@Repository("reviewDaoImpl")
public class ReviewDAOImpl implements ReviewDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public ReviewDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int addReview(Review review) throws Exception {
		// TODO Auto-generated method stub
		int result = sqlSession.insert("ReviewMapper.addReview", review);
		
		//review_no가 생성되었다면(=> review table에 insert되었다면)
		if (result == 1) {
			sqlSession.insert("ReviewMapper.addHashTag", review);
			sqlSession.insert("ReviewMapper.addImage", review);
			return 1;
		} else {
			return 0;
		}
	}
	
	@Override
	public int updateReview(Review review) throws Exception {
		// TODO Auto-generated method stub
		int result = sqlSession.update("ReviewMapper.updateReview", review);
		
		System.out.println("updateReview " + result);
		
		//review_no가 생성되었다면(=> review table에 insert되었다면)
		if (result == 1) {
			sqlSession.insert("ReviewMapper.addHashTag", review);
			sqlSession.insert("ReviewMapper.addImage", review);
			return 1;
		} else {
			return 0;
		}
	}

	@Override
	public int deleteReview(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Review getReview(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Review> listReview(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Review> listMyReview(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Review> listMyLikeReview(String memberId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> listHashTag(String search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteHashTag(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int addLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void getTotalAvg() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int getLikeCount() throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
}
