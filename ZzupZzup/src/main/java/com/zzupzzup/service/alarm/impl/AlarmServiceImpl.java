package com.zzupzzup.service.alarm.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.zzupzzup.service.alarm.AlarmDAO;
import com.zzupzzup.service.alarm.AlarmService;


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
