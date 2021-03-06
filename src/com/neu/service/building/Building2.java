package com.neu.service.building;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.neu.bean.Building2_Info;
import com.neu.bean.Building5_Info;
import com.neu.dao.Building1_DAO;
import com.neu.dao.Building2_DAO;

public class Building2 extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
	
		this.doPost(request, response);
	
	}
	
	//刷新的跳板
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
	
		request.setCharacterEncoding("gb2312");
		
		HttpSession session = request.getSession();
	
		//初始化查询条件
		if(request.getParameter("init")!= null){
	
			 session.setAttribute("com_name","0");
             session.setAttribute("build_num","0");
             session.setAttribute("period","0");       	
		}
		
		
		//从session获取查询条件
		String com_name = (String) session.getAttribute("com_name");
		String build_num = (String) session.getAttribute("build_num");
		String period = (String) session.getAttribute("period");
		
		Building2_DAO b2_dao = new Building2_DAO();
		List<Building2_Info> resultList = b2_dao.select(com_name,build_num,period);
		
		
		/*******************************************分页处理(固定代码)*******************************************/
		//设置要查询的页号
		int currentPage = (Integer)session.getAttribute("currentPage");
		if(request.getParameter("jump_type").equals("first")){
			currentPage = 1;
		}
		else if(request.getParameter("jump_type").equals("back")){
			if(((Integer)session.getAttribute("currentPage")).intValue()>=2)
				currentPage = ((Integer)session.getAttribute("currentPage")).intValue()-1;
		}
		else if(request.getParameter("jump_type").equals("next")){
			 if(((Integer)session.getAttribute("currentPage")).intValue()<((Integer)session.getAttribute("pageCount")))
				currentPage =((Integer)session.getAttribute("currentPage")).intValue()+1;
		}
		else if(request.getParameter("jump_type").equals("last")){
			currentPage = (Integer)session.getAttribute("pageCount");
		}
		else{
			currentPage = Integer.parseInt(request.getParameter("to_page"));
		}
		session.setAttribute("currentPage",currentPage);
		
		/*******************************************分页处理(固定代码)*******************************************/
		
		//查询的记录总条数
		session.setAttribute("recordCount",resultList.size());
		//记录的页数(15条/页)
		session.setAttribute("pageCount",resultList.size()/15+ (resultList.size()%15!=0?1:0));
		//查询结果的一页
		List<Building2_Info> list = null;
		if(resultList.size()!=0)
			 list = resultList.subList((currentPage-1)*15,(currentPage*15<=resultList.size()-1)?currentPage*15:resultList.size());
		
		//查询结果的一页
		request.setAttribute("list",list);

		request.getRequestDispatcher("../building/building2.jsp").forward(request,
				response);
 
	}

}
