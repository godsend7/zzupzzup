package com.zzupzzup.common.web;

import java.io.PrintWriter;

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
		
		System.out.println("Logon Check :: " + member);
		
		if(member == null)  {
			
			String uri = request.getRequestURI();
			
			if (uri.indexOf("favicon") != -1 || uri.indexOf("webjars") != -1 || uri.indexOf("resources") != -1 || uri.indexOf("member") != -1 || uri.indexOf("map") != -1 
					|| uri.indexOf("getRestaurant") != -1 || uri.indexOf("listReview") != -1 || uri.indexOf("listReview") != -1) {
				System.out.println("비회원 접근 가능 uri :: " + uri);
				return true;
			}
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>alert('로그인이 필요합니다!'); location.href='/'; </script>");
			out.flush();
			out.close();
			System.out.println("LoginCheck :: " + uri);
			System.out.println("[ LoginCheckInterceptor end........]\n");
			
//			if(	uri.indexOf("listChat") != -1 || uri.indexOf("listCommunity") != -1 || uri.indexOf("listNotice") != -1 ){
//				response.setContentType("text/html; charset=utf-8");
//				PrintWriter out = response.getWriter();
//				out.print("<script>alert('로그인이 필요합니다!'); location.href='/'; </script>");
//				out.flush();
//				out.close();
//				System.out.println("LoginCheck :: " + uri);
//				System.out.println("[ LoginCheckInterceptor end........]\n");
//				return false;
//			}
//			
//			System.out.println("[ LoginCheckInterceptor end........]\n");
			return false;
		}
		
		return true;
	}

}
