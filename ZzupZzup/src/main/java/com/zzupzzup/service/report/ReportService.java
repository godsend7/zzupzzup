package com.zzupzzup.service.report;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Report;

public interface ReportService {
	
	public int addReport(Report report) throws Exception;
	
	public int checkReport(int reportNo) throws Exception; //신고 확인
	
	public Map<String, Object> listReport(Search search, int category, Member member) throws Exception; //카테고리별 list 출력
	
	//public int getReportCount(String report, int category) throws Exception;
}
