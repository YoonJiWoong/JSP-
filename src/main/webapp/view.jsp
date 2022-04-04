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
	int bbsID=0;
	if(request.getParameter("bbsID")!=null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
		
	}
	if(bbsID==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
		
	}
	bbs bbs = new bbsDAO().getbbs(bbsID);
	
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

				<%
				if (userID == null) {
					
				%>



				<ul class="nav navbar-nav navbar-right">
					<li class="dropown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul></li>
				</ul>


				<%
				} else {
				%>

				<ul class="nav navbar-nav navbar-right">
					<li class="dropown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>

						</ul></li>
				</ul>

				<%
				}
				%>
			</div>
		</nav>

		<div class="container">
			<div class="row">
				
					<table class="table table-striped"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan=32"
									style="background-color: #eeeeee; text-align: center;">게시판
									게시판 글 보기</th>
							</tr>
						</thead>
						<thead>
							<tr>
								<td style="width: 20%;">글제목</td>
								<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>;") %></td>
							</tr>
							<tr>								
								<td>작성자</td>
								<td colspan="2"><%=bbs.getUserID().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>;")%></td>																
							</tr>
							<tr>								
								<td>작성일자</td>
								<td colspan="2"><%=bbs.getBbsDate().substring(0,11)+bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14,16)+"분"%></td>																
							</tr>
							<tr>								
								<td>내용</td>
								<td colspan="2" style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>;")%></td>																
							</tr>
							
							
							
							 
						</thead>


					</table>
					<a href="bbs.jsp" class="btn btn-primary">목록</a>
					<%
						if(userID !=null && userID.equals(bbs.getUserID())){
							%>
								<a href="update.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">수정</a>
								<a href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">삭제</a>
							<%
						}
					%>
					
					
					<input type="submit" class="btn btn-primary pull-right" value="글쓰기"></a>
				
			</div>
		</div>
</body>
</html>