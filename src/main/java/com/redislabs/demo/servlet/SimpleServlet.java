package com.redislabs.demo.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * A servlet which updates the session with the content of the request parameters and forwards
 * to the SessionContents.jsp which displays the contents of the session
 */
public class SimpleServlet extends HttpServlet {

	private static final long serialVersionUID = 2118777857574858437L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(true);
		
		String action = request.getParameter("dataaction");
		String dataName = request.getParameter("dataname");
		String dataValue = request.getParameter("datavalue");

		if(isStringNotEmpty(action) && "Remove".equals(action) && isStringNotEmpty(dataName)) {
			session.removeAttribute(dataName);
		}
		else if(isStringNotEmpty(dataName) && isStringNotEmpty(dataValue)) {
			session.setAttribute(dataName, dataValue);
		}

		request.getRequestDispatcher("/SessionContents.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private boolean isStringNotEmpty(String str) {
		return (str != null && str.trim().length() > 0);
	}

}