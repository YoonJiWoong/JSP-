<%@page import="bbs.bbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="User.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.bbs" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>




	
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
		
		
	}else{
		
		
		if(bbs.getBbsTitle()==null || bbs.getBbsContent()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제목 혹은 내용이 입력이 안된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");

		}else{
			bbsDAO bbsdao = new bbsDAO();
			
			
			
			int result = bbsdao.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			if(result == -1){
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			
			}else{
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");				
				script.println("</script>"); 
			
			}
		
		}
		
	}


	%>


</body>
</html>