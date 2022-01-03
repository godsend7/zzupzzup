package com.zzupzzup.service.restaurant.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.RestaurantMenu;
import com.zzupzzup.service.domain.RestaurantTime;
import com.zzupzzup.service.restaurant.RestaurantDAO;

@Repository("restaurantDaoImpl")
public class RestaurantDAOImpl implements RestaurantDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	///Constructor
	public RestaurantDAOImpl() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@Override
	public int addRestaurant(Restaurant restaurant) throws Exception {
		int result = sqlSession.insert("RestaurantMapper.addRestaurant", restaurant);
		
		if(result == 1) {
			sqlSession.insert("RestaurantMapper.addRestaurantMenu", restaurant);
			sqlSession.insert("RestaurantMapper.addRestaurantTime", restaurant);
			sqlSession.insert("RestaurantMapper.addImage", restaurant);
			
			return 1;
			
		} else {
			return 0;
		}
		
	}
	
	@Override
	public Restaurant getRestaurant(int restaurantNo) throws Exception {
		return sqlSession.selectOne("RestaurantMapper.getRestaurant", restaurantNo);
	}
	
	@Override
	public RestaurantMenu getRestaurantMenu(RestaurantMenu restaurantMenu) throws Exception {
		return restaurantMenu;
	}

	@Override
	public RestaurantTime getRestaurantTime(RestaurantTime restaurantTime) throws Exception {
		return restaurantTime;		
	}

	@Override
	public List<Restaurant> listRestaurant(Search search) throws Exception {
		return sqlSession.selectList("RestaurantMapper.listRestaurant", search);
	}
	
	@Override
	public List<Restaurant> listMyRestaurant(Map<String, Object> map) throws Exception {
		
		List<Restaurant> list = sqlSession.selectList("RestaurantMapper.listMyRestaurant", map);

		return list;
	}

	@Override
	public int updateRestaurant(Restaurant restaurant) throws Exception {
		int result = sqlSession.update("RestaurantMapper.updateRestaurant", restaurant);
		
		if(result == 1) {
			sqlSession.insert("RestaurantMapper.addRestaurantMenu", restaurant);
			sqlSession.insert("RestaurantMapper.addRestaurantTime", restaurant);
			sqlSession.insert("RestaurantMapper.addImage", restaurant);
			
			return 1;
			
		} else {
			return 0;
		}
		
	}
	
	@Override
	public int deleteRestaurant(int restaurantNo) throws Exception {
		return sqlSession.delete("RestaurantMapper.deleteRestaurant", restaurantNo);
	}
	
	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("RestaurantMapper.getTotalCount", search);		
	}
	
	@Override
	public List<Restaurant> listCallDibs(Map<String, Object> map) throws Exception {
		
		List<Restaurant> list = sqlSession.selectList("RestaurantMapper.listCallDibs", map);
		
		return list;
	}
	
	@Override
	public int checkCallDibs(Map<String, Object> map) throws Exception {
		return sqlSession.insert("RestaurantMapper.checkCallDibs", map);
	}

	@Override
	public int cancelCallDibs(Map<String, Object> map) throws Exception {
		return sqlSession.delete("RestaurantMapper.cancelCallDibs", map);
	}


	@Override
	public List<Restaurant> listRestaurantName(Map<String, Object> map) {
		System.out.println("restaurantDaoImpl listRestaurantName map : " + map);
	      
	      List<Restaurant> list = sqlSession.selectList("RestaurantMapper.listRestaurantName", map);
	      
	      return list;
	}


	@Override
	public List<Restaurant> listMainRestaurant() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("RestaurantMapper.listMainRestaurant");
	}
}
