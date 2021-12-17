package com.zzupzzup.service.report.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.service.domain.Report;
import com.zzupzzup.service.report.ReportDAO;
import com.zzupzzup.service.report.ReportService;

@Service("reportServiceImpl")
public class ReportServiceImpl implements ReportService {

	@Autowired
	@Qualifier("reportDaoImpl")
	private ReportDAO reportDao;
	
	public ReportServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int addReport(Report report) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
