package com.zzupzzup.service.alarm;

import java.util.List;

import com.zzupzzup.service.domain.Alarm;

public interface AlarmDAO {
	
	public int addAlarm(Alarm alarm) throws Exception;
	
	public List<Alarm> listAlarm(String memberId) throws Exception;
	
	public int updateAlarm(String memberId, int alarmNo) throws Exception;
	
}
