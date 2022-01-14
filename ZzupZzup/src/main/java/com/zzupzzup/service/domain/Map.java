package com.zzupzzup.service.domain;

public class Map {

	private String thisLat;
	private String thisLong;
	
	private String startLat;
	private String startLong;
	
	private String goalLat;
	private String goalLong;
	
	public Map() {
		// TODO Auto-generated constructor stub
	}
	

	public String getThisLat() {
		return thisLat;
	}

	public void setThisLat(String thisLat) {
		this.thisLat = thisLat;
	}

	public String getThisLong() {
		return thisLong;
	}

	public void setThisLong(String thisLong) {
		this.thisLong = thisLong;
	}


	
	public String getStartLat() {
		return startLat;
	}

	public void setStartLat(String startLat) {
		this.startLat = startLat;
	}


	public String getStartLong() {
		return startLong;
	}

	public void setStartLong(String startLong) {
		this.startLong = startLong;
	}



	public String getGoalLat() {
		return goalLat;
	}

	public void setGoalLat(String goalLat) {
		this.goalLat = goalLat;
	}

	public String getGoalLong() {
		return goalLong;
	}

	public void setGoalLong(String goalLong) {
		this.goalLong = goalLong;
	}



	@Override
	public String toString() {
		return "Map [thisLat=" + thisLat + ", thisLong=" + thisLong + ", startLat=" + startLat + ", startLong="
				+ startLong + ", goalLat=" + goalLat + ", goalLong=" + goalLong + "]";
	}
}
