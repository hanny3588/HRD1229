<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<%@ include file="DBConn.jsp" %>
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<section>
<%
	String bookno = request.getParameter("bookno");

PreparedStatement pstmt = null;
ResultSet rs = null;

try{
	String sql ="select * from bookinfo1229 where bookno=?";
	pstmt= conn.prepareStatement(sql);
	pstmt.setString(1, bookno);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
	String author= rs.getString("author");
	String bookname= rs.getString("bookname");
	
	%>
	
<h2>도서 정보 수정 화면</h2>
<form name="form" method="post" action="updatebookProcess.jsp">
<table border=1>
<tr>
<th>도서코드</th>
<td><input type="text" name="bookno" value="<%=bookno %>"></td>
</tr>
<tr>
<th>저자</th>
<td><input type="text" name="author" value="<%=author %>"></td>
</tr>
<tr>
<th>도서이름</th>
<td><input type="text" name="bookname" value="<%=bookname %>"></td>
</tr>
<tr>
<td colspan=2 align=center>
	<input type="submit" value="수정" onclick="check()">
	<input type="reset" value="취소">
	</td>
</tr>
<%
}}catch(SQLException e){
	System.out.println("데이터 연결 실패");
}

%>
</table>
</form>
</section>
<%@ include file="footer.jsp" %>
</body>
<script>
function check(){
	if(document.form.bookno.value==""){
		alert('도서코드가 입력되지 않았습니다.');
		document.form.bookno.focus();
	}else if(document.form.author.value==""){
		alert('작가가 입력되지 않았습니다.');
		document.form.author.focus();
	}else if(document.form.bookname.value==""){
		alert('도서이름이 입력되지 않았습니다.');
		document.form.bookname.focus();
	}else{
		alert('수정이 완료되었습니다!');
		document.form.submit();
	}
}
</script>
</html>