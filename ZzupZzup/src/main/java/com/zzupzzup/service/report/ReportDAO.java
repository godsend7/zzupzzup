package com.zzupzzup.service.report;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Report;

public interface ReportDAO {
	
	public int addReport(Report report) throws Exception;
	
	public int checkReport(int reportNo) throws Exception; //신고 확인
	
	public List<Report> listReport(Map<String, Object> map) throws Exception; //카테고리별 list 출력
		
	public int getTotalCount(int category) throws Exception;
	
	//public int getReportCount(Map<String, Object> map) throws Exception; //카테고리별 mylist 출력
}
