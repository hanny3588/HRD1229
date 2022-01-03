<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="DBConn.jsp"%>

<%	
	String lentno = request.getParameter("lentno");
	String custname = request.getParameter("custname");
 	String bookno = request.getParameter("bookno");
 	String outdate = request.getParameter("outdate");
 	String indate = request.getParameter("indate");
	String status = request.getParameter("status");
	String class1 = request.getParameter("class");
	
	PreparedStatement pstmt = null;
	
	try{
		String sql ="insert into reservation1229 values(?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, lentno);
		pstmt.setString(2, custname);
		pstmt.setString(3, bookno);
		pstmt.setString(4, outdate);
		pstmt.setString(5, indate);
		pstmt.setString(6, status);
		pstmt.setString(7, class1);
		pstmt.executeUpdate();
		%>
		<script>
		alert('저장이 완료되었습니다.');
		location.href="selectreserve.jsp"
		</script>
		<% 
	}catch(SQLException e){
		System.out.println("데이터 저장 실패");
	}

%>
