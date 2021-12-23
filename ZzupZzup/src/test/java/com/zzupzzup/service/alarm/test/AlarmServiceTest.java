package com.zzupzzup.service.alarm.test;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.service.alarm.AlarmService;
import com.zzupzzup.service.domain.Alarm;
import com.zzupzzup.service.domain.Community;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class AlarmServiceTest {

	@Autowired
	@Qualifier("alarmServiceImpl")
	private AlarmService alarmService;

	//@Test
	public void testAddAlarm() throws Exception {
		Alarm alarm = new Alarm();
		
		alarm.setAlarmType(4);
		alarm.setAlarmContents("예약 취소가 완료되었습니다.");
		
		Member member = new Member();
		member.setMemberId("hihi@a.com");
		alarm.setMember(member);
		
		Reservation reservation = new Reservation();
		reservation.setReservationNo(1);
		alarm.setReservation(reservation);
		
		alarmService.addAlarm(alarm);
		
	}
	
	//@Test
	public void testListAlarm() throws Exception {
		
		String memberId = "hihi@a.com";
		Map<String, Object> map = alarmService.listAlarm(memberId);
		List<Alarm> list = (List<Alarm>)map.get("listAlarm");
		
		for (Alarm alarm : list) {
			System.out.println(alarm);
		}
		
	}
	
	@Test
	public void testUpdateAlarm() throws Exception {
		
		String memberId = "hihi@a.com";
		int alarmNo = 2;
		alarmService.updateAlarm(memberId, alarmNo);
		
		
	}
}