<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.bbs"%>
<%@ page import="bbs.bbsDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<mata name="viewport content=" width=device-width ", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹사이트</title>
<style type="text/css">
a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>

<body>

	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
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
	
	}
		
	
	
	
	
	%>


	<nav class="navbor">

		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="js/bootstrap.js"></script>

		<nav class="navbar navbar-default">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="main.jsp">메인</a></li>
					<li class="active"><a href="bbs.jsp">게시판</a></li>
				</ul>


				<ul class="nav navbar-nav navbar-right">
					<li class="dropown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>

						</ul></li>
				</ul>

			</div>
		</nav>

		<div class="container">
			<div class="row">
				<form method="post" action="updateAction.jsp?bbsID=<%=bbsID %>">
					<table class="table table-striped"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="2"
									style="background-color: #eeeeee; text-align: center;">게시판 글 수정하기</th>
							</tr>
						</thead>
						<thead>
							<tr>
								<td><input type="text" class="form-control"
									placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle() %>">
									</td>
							</tr>
							<tr>
								<td><textarea type="text" class="form-control"
										placeholder="글 내용" name="bbsContent" maxlength="2100"
										style="height: 350px" ><%=bbs.getBbsContent() %></textarea>
										</td>								
							</tr>
						</thead>


					</table>
					<input type="submit" class="btn btn-primary pull-right" value="수정하기"></a>
				</form>
			</div>
		</div>
</body>
</html>