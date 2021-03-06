package com.zzupzzup.service.domain;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;


public class Order {
	
	//Field
	private int orderNo;
	private String menuTitle;
	private int orderCount;
	private int menuPrice;
	
	//Constructor
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public String getMenuTitle() {
		return menuTitle;
	}
	public void setMenuTitle(String menuTitle) {
		this.menuTitle = menuTitle;
	}
	public int getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}
	public int getMenuPrice() {
		return menuPrice;
	}
	public void setMenuPrice(int menuPrice) {
		this.menuPrice = menuPrice;
	}
	
	
	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", menuTitle=" + menuTitle + ", orderCount=" + orderCount + ", menuPrice="
				+ menuPrice + "]";
	}
	
	
	
	//Method
	
	

}
