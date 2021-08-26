<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %> <!-- JavaScript 문장 작성하기위해 임포트함. -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든데이터를 UTF-8으로 받아줌 --> 
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
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		else {
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null || request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("") ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 될 사항이 있습니다.')");
				script.println("history.back()"); // 이전페이지로 보내준다 (로그인페이지로)
				script.println("</script>");
			}
			else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
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