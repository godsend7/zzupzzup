package com.zzupzzup.service.alarm.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.service.alarm.AlarmDAO;

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
	public void addAlarm() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void listAlarm() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateAlarm() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteAlarm() throws Exception {
		// TODO Auto-generated method stub
		
	}

}
