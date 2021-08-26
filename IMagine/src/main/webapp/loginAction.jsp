<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- JavaScript 문장 작성하기위해 임포트함. -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든데이터를 UTF-8으로 받아줌 -->
<jsp:useBean id="user" class="user.User" scope="page"/> <!-- 현재 페이지에서만 java빈즈를 사용 -->
<jsp:setProperty name="user" property="userID"/> <!-- login.jsp에 있는 userID를 그대로 받아서 한명의 사용자에서 userID넣어줌-->
<jsp:setProperty name="user" property="userPassword"/> <!-- login.jsp에 있는 userPassword를 그대로 받아서 한명의 사용자에서 userPassword넣어줌-->

<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<title>IMagine 게시판</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) { // session 확인
			userID = (String)session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되었습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		int auth = userDAO.auth(user.getUserID());
		if (result == 1 && auth == 1) {
			session.setAttribute("userID", user.getUserID()); // 세션관리 세션 : 현재접속한 회원 할당해주는 고유의 아이디
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='index1.html'"); // 일반인 회원
			script.println("</script>");
		}
		else if (result == 1 && auth == 0) {
			session.setAttribute("userID", user.getUserID()); // 세션관리 세션 : 현재접속한 회원 할당해주는 고유의 아이디
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='port.jsp'"); // 관리자 모드(GCS 회원)
			script.println("</script>");
		}
		
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호 틀립니다.')");
			script.println("history.back()"); // 이전페이지로 보내준다 (로그인페이지로)
			script.println("</script>");
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()"); // 이전페이지로 보내준다 (로그인페이지로)
			script.println("</script>");
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()"); // 이전페이지로 보내준다 (로그인페이지로)
			script.println("</script>");
		}
	%>
</body>
</html>