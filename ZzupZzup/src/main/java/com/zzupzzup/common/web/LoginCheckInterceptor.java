package com.zzupzzup.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.zzupzzup.service.domain.Member;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	public LoginCheckInterceptor() {
		// TODO Auto-generated constructor stub
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		System.out.println("\n[ LoginCheckInterceptor start........]");
		
		HttpSession session = request.getSession(true);
		Member member = (Member)session.getAttribute("Member");
		
		if(member != null)  {
			String uri = request.getRequestURI();
			
			if(	uri.indexOf("addUser") != -1 ||	uri.indexOf("login") != -1 		|| 
					uri.indexOf("checkDuplication") != -1 ){
				request.getRequestDispatcher("/index.jsp").forward(request, response);
				System.out.println("[ LoginCheckInterceptor end........]\n");
				return false;
			}
			
			System.out.println("[ LoginCheckInterceptor end........]\n");
			return true;
		} else {
			String uri = request.getRequestURI();
			
			if(	uri.indexOf("addUser") != -1 ||	uri.indexOf("login") != -1 || uri.indexOf("checkDuplication") != -1 ){
				System.out.println("[ LoginCheckInterceptor end........]\n");
				return true;
			}
			
			request.getRequestDispatcher("/").forward(request, response);
			System.out.println("[ LoginCheckInterceptor end........]\n");
			return false;
		}
	}

}
