package com.zzupzzup.service.report.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.service.domain.Report;
import com.zzupzzup.service.report.ReportDAO;

@Repository("reportDaoImpl")
public class ReportDAOImpl implements ReportDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public ReportDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int addReport(Report report) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
}
