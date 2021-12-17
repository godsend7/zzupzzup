package com.zzupzzup.service.report;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Report;

public interface ReportService {
	
	public int addReport(Report report) throws Exception;
	
	public int checkReport(boolean check) throws Exception; //신고 확인
	
	public List<Report> listReport(int category) throws Exception; //카테고리별 list 출력
	
	public List<Report> listMyReport(int category, String memberId) throws Exception; //카테고리별 mylist 출력
	
	public int getTotalCount(Search search) throws Exception;
}
