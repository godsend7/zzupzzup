package com.zzupzzup.service.alarm.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.service.alarm.AlarmDAO;
import com.zzupzzup.service.alarm.AlarmService;
import com.zzupzzup.service.domain.Alarm;

@Service("alarmServiceImpl")
public class AlarmServiceImpl implements AlarmService{

	//*Field
	@Autowired
	@Qualifier("alarmDaoImpl")
	private AlarmDAO alarmDao;
	
	//*Constructor
	public AlarmServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	//*Method
	@Override
	public int addAlarm(Alarm alarm) throws Exception {
		// TODO Auto-generated method stub
		alarmDao.addAlarm(alarm);
		return 1;
	}

	@Override
	public Map<String, Object> listAlarm(String memberId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listAlarm", alarmDao.listAlarm(memberId));
		
		return map;
	}

	@Override
	public Map<String, Object> updateAlarm(String memberId, int alarmNo) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("updateAlarm", alarmDao.updateAlarm(memberId, alarmNo));
		
		return map;
	}

}
