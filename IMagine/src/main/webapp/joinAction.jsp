<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- JavaScript 문장 작성하기위해 임포트함. -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든데이터를 UTF-8으로 받아줌 -->
<jsp:useBean id="user" class="user.User" scope="page"/> <!-- 현재 페이지에서만 java빈즈를 사용 -->
<jsp:setProperty name="user" property="userID"/> <!-- login.jsp에 있는 userID를 그대로 받아서 한명의 사용자에서 userID넣어줌-->
<jsp:setProperty name="user" property="userPassword"/> <!-- login.jsp에 있는 userPassword를 그대로 받아서 한명의 사용자에서 userPassword넣어줌-->
<jsp:setProperty name="user" property="userGender"/> <!-- login.jsp에 있는 userGender를 그대로 받아서 한명의 사용자에서 userGender넣어줌-->
<jsp:setProperty name="user" property="userEmail"/> <!-- login.jsp에 있는 userEmail를 그대로 받아서 한명의 사용자에서 userEmail넣어줌-->
<jsp:setProperty name="user" property="userName"/> <!-- login.jsp에 있는 userName를 그대로 받아서 한명의 사용자에서 userName넣어줌-->
<jsp:setProperty name="user" property="userAuth"/> <!-- login.jsp에 있는 userAuth를 그대로 받아서 한명의 사용자에서 userAuth넣어줌-->

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
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserEmail() == null || user.getUserAuth() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 될 사항이 있습니다.')");
			script.println("history.back()"); // 이전페이지로 보내준다 (로그인페이지로)
			script.println("</script>");
		}
		else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()"); // 이전페이지로 보내준다
				script.println("</script>");
			}
			
			else { // 회원가입 성공
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	
	%>
</body>
</html>