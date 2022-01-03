<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="DBConn.jsp"%>

<%
	String bookno = request.getParameter("bookno");

	PreparedStatement pstmt =null;
	
try{
	String sql="delete from bookinfo1229 where bookno=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, bookno);
	pstmt.executeUpdate();
	%>
	<script>
	alert('삭제되었습니다.');
	location.href='selectbook.jsp'
	</script>
	<%
}catch(SQLException e){
	System.out.println("데이터 연결 실패");
}
%>