<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- JavaScript 문장 작성하기위해 임포트함. -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든데이터를 UTF-8으로 받아줌 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/> <!-- 현재 페이지에서만 java빈즈를 사용 -->
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/> 
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
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		else {
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 될 사항이 있습니다.')");
				script.println("history.back()"); // 이전페이지로 보내준다 (로그인페이지로)
				script.println("</script>");
			}
			else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()"); // 이전페이지로 보내준다
					script.println("</script>");
				}
				
				else { 
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