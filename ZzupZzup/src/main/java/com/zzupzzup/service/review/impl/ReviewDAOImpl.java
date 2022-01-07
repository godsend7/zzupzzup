package com.zzupzzup.service.review.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.HashTag;
import com.zzupzzup.service.domain.Mark;
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
		
		//review_no가 업데이트 되었다면
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
		return sqlSession.delete("ReviewMapper.deleteReview", reviewNo);
	}

	@Override
	public Review getReview(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		Review review = sqlSession.selectOne("ReviewMapper.getReview", reviewNo);
		
		review.setLikeCount(getLikeCount(review.getReviewNo()));
				
		return review;
	}

	@Override
	public List<Review> listReview(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Review> list = sqlSession.selectList("ReviewMapper.listReview", map);
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setLikeCount(getLikeCount(list.get(i).getReviewNo()));
		}
		
		return list;
	}

	@Override
	public List<Review> listMyLikeReview(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Review> list = sqlSession.selectList("ReviewMapper.listMyLikeReview", map);
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setLikeCount(getLikeCount(list.get(i).getReviewNo()));
		}
		
		return list;
	}

	@Override
	public List<HashTag> listHashTag(String search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ReviewMapper.listHashTag", search);
	}
	
	@Override
	public List<Mark> listLike(String memberId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ReviewMapper.listLike", memberId);
	}

	@Override
	public int addLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("ReviewMapper.addLike", map);
	}

	@Override
	public int deleteLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("ReviewMapper.deleteLike", map);
	}

	@Override
	public int getTotalCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ReviewMapper.getTotalCount", map);
	}

	@Override
	public double getTotalAvg(String restaurantNo) throws Exception {
		return sqlSession.selectOne("ReviewMapper.getTotalAvg", restaurantNo);
		
	}

	@Override
	public int getLikeCount(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ReviewMapper.getLikeCount", reviewNo);
	}
}
