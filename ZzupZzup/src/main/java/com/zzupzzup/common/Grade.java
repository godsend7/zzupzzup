package com.zzupzzup.common;

public class Grade {

	//*Field
	private String grade;		//등급
	private int gradeScoreMin;	//최소 활동점수
	private int gradeScoreMax;	//최대 활동점수
	
	//*Constructor
	public Grade() {
		// TODO Auto-generated constructor stub
	}

	//*Method
	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getGradeScoreMin() {
		return gradeScoreMin;
	}

	public void setGradeScoreMin(int gradeScoreMin) {
		this.gradeScoreMin = gradeScoreMin;
	}

	public int getGradeScoreMax() {
		return gradeScoreMax;
	}

	public void setGradeScoreMax(int gradeScoreMax) {
		this.gradeScoreMax = gradeScoreMax;
	}
	
}
