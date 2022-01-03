<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="DBConn.jsp"%>

<%
 	String bookno = request.getParameter("bookno");
	String author = request.getParameter("author");
	String bookname = request.getParameter("bookname");
	
	PreparedStatement pstmt = null;
	
	try{
		String sql ="insert into bookinfo1229 values(?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, bookno);
		pstmt.setString(2, author);
		pstmt.setString(3, bookname);
		pstmt.executeUpdate();
		%>
		<script>
		location.href="selectbook.jsp"
		</script>
		<% 
	}catch(SQLException e){
		System.out.println("데이터 저장 실패");
	}

%>
