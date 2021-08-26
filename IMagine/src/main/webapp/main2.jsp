<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link href="./css/bootstrap.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">

<title>IMagine.fly</title>
</head>
<body>
	<!-- GCS화면 -->
	<!-- 로그인 된 사람은 로그인 정보를 담도록 한다. -->
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
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
			<a class="navbar-brand" href="main.jsp">IMagine.fly</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav"> <!-- 리스트 만들때 <ul>태그 사용 -->
				<li class="active"><a href="main.jsp">GCS</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
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
		<div class="jumbotron">
			<div class="container">
				<h1>IMagine.fly</h1>
				<p>모두가 '언젠가'라며 미루어 왔던 상상속의 미래를 '지금부터'라는 사명감으로 상상을 현실로 만들어갑니다..</p>
				<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
			</div>
		</div>
	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li> <!-- active 맨 처음 이미지 -->
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/car.jpg">
				</div>
				<div class="item">
					<img src="images/car2.jpg">
				</div>
				<div class="item">
					<img src="images/car3.PNG">
				</div>
			</div> 
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>