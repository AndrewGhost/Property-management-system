package com.neu.service.office;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.neu.bean.Office3_Info;
import com.neu.dao.Office3_DAO;

public class Office3 extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	
	}

	//刷新的跳板
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("gb2312");
		
		HttpSession session = request.getSession();
		session.setAttribute("Present_Location","[办公管理]-[薪资变更记录]");
		
		int staff_num = -1;
		
		if(!session.getAttribute("staff_num").equals("")){
			staff_num = Integer.parseInt((String) session.getAttribute("staff_num")); 
		}
		
        String staff_name = (String) session.getAttribute("staff_name");
	
		
		Office3_DAO off3dao = new Office3_DAO();
		List<Office3_Info> resultList = off3dao.Office3Select(staff_num, staff_name);
		
		/*****分页处理******/
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
			 if(((Integer)session.getAttribute("currentPage")).intValue()<((Integer)session.getAttribute("pageCount")/15+((Integer)session.getAttribute("pageCount")%15!=0?1:0)))
				currentPage =((Integer)session.getAttribute("currentPage")).intValue()+1;
		}
		else if(request.getParameter("jump_type").equals("last")){
			currentPage = ((Integer)session.getAttribute("pageCount")/15+((Integer)session.getAttribute("pageCount")%15!=0?1:0));
		}
		else{
			currentPage = Integer.parseInt(request.getParameter("to_page"));
			System.out.println("page" + currentPage);
		}
		session.setAttribute("currentPage",currentPage);
		
		//查询的记录总条数
		session.setAttribute("pageCount",resultList.size());
		//查询结果的一页
		List<Office3_Info> off3 = resultList.subList((currentPage-1)*15,(currentPage*15<resultList.size()-1)?currentPage*15:resultList.size());
		request.setAttribute("off3",off3);
		
		request.getRequestDispatcher("../office/office3.jsp").forward(request,
				response);
		 
	}


}
