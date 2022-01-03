<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="DBConn.jsp"%>
<%
	String bookno = request.getParameter("bookno");
	String author = request.getParameter("author");
	String bookname = request.getParameter("bookname");
	
	PreparedStatement pstmt = null;
	
	try{
		String sql ="update bookinfo1229 set author=?, bookname=? where bookno=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(3, bookno);
		pstmt.setString(1, author);
		pstmt.setString(2, bookname);
		pstmt.executeUpdate();
		
		%>
		<script>
		location.href='selectbook.jsp';
		</script>
		<%
	}catch(SQLException e){
		System.out.println("데이터 수정 실패");
		e.printStackTrace();
	}

%>
