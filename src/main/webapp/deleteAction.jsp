<%@page import="bbs.bbs"%>
<%@page import="bbs.bbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="User.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>



	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<mata name="viewport content=" width=device-width ", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
	
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	

	
	if(userID == null){
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		
		
	}
	int bbsID = 0;
	if(request.getParameter("bbsID")!=null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
		
	}if(bbsID==0){
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않는 글입니다.')");
		script.println("location.href = 'bbs.jsp'");			
		script.println("</script>"); 
	
	}
	bbs bbs = new bbsDAO().getbbs(bbsID);
	if(userID.equals(bbs.getUserID())==false){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp'");			
		script.println("</script>"); 
	
	} else{
		
		bbsDAO bbsdao = new bbsDAO();

		int result = bbsdao.delete(bbsID);
		if(result == -1){
				
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글삭제에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
			
		}else{
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제되었습니다')");
			script.println("location.href = 'bbs.jsp'");				
			script.println("</script>"); 
			
			}
		
		}
		
	


	%>


</body>
</html>