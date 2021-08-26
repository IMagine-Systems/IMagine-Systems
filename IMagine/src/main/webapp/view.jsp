<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.PrintWriter" %>
 <%@ page import="bbs.Bbs" %>
 <%@ page import="bbs.BbsDAO" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link href="./css/bootstrap.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">
<title>IMagine 게시판</title>
</head>
<body>
	<!-- 로그인 된 사람은 로그인 정보를 담도록 한다. -->
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>
	<!-- 네비게이션 하나의 웹사이트 전반적인 구성 보여준다.-->
	<nav class="navbar navbar-default">
		<div class="navbar-header"> <!-- header 홈페이지의 로고역할 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">IMagine 게시판</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav"> <!-- 리스트 만들때 <ul>태그 사용 -->
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a> <!-- 아이콘 -->
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>	
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
				</li>
			</ul>
			<%		
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a> <!-- 아이콘 -->
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>	
						</ul>
				</li>
			</ul>
			<% 
				}
			%>
			
		</div>
	</nav>
	<div class="container">
		<div class="raw">
			<table class="table table-striped" style="text-align: center; border; 1px solid #dddddd"> <!--글목록 홀수 짝수 서로번갈아서 색상 다르게 해줌-->
				<thead>	<!--테이블의 제목부분 각각의 속성을 알려줌 -->
					<tr>	
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">계시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if (userID != null && userID.equals(bbs.getUserID())) {
			%>
				<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>