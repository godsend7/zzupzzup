package com.zzupzzup.service.alarm;

import java.util.Map;

import com.zzupzzup.service.domain.Alarm;

public interface AlarmService {
	
	public int addAlarm(Alarm alarm) throws Exception;
	
	public Map<String, Object> listAlarm(String memberId) throws Exception;
	
	public Map<String, Object> updateAlarm(String memberId, int alarmNo) throws Exception;

}
