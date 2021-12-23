package com.zzupzzup.service.alarm.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.service.alarm.AlarmDAO;
import com.zzupzzup.service.domain.Alarm;

@Repository("alarmDaoImpl")
public class AlarmDAOImpl implements AlarmDAO {
	
	//*Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	//*Constructor
	public AlarmDAOImpl() {
		// TODO Auto-generated constructor stub
	}
	
	//*Method
	@Override
	public int addAlarm(Alarm alarm) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("AlarmMapper.addAlarm", alarm);
		return 1;
	}

	@Override
	public List<Alarm> listAlarm(String memberId) throws Exception {
		// TODO Auto-generated method stub
		List<Alarm> list = sqlSession.selectList("AlarmMapper.listAlarm", memberId);
		
		return list;
	}

	@Override
	public int updateAlarm(String memberId, int alarmNo) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("alarmNo", alarmNo);
		
		sqlSession.update("AlarmMapper.updateAlarm", map);
		return 1;
	}

}
