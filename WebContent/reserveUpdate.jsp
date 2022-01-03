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
<h2>도서 대출 정보 수정 화면</h2>
<%
	String lentno = request.getParameter("lentno");

	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
		String sql="select a.*, b.bookname from reservation1229 a, bookinfo1229 b where lentno=? and a.bookno=b.bookno";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, lentno);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			String custname = rs.getString("custname");
		 	String bookno = rs.getString("bookno");
		 	String outdate = rs.getString("outdate");
		 	String indate = rs.getString("indate");
			String status = rs.getString("status");
			String class1 = rs.getString("class");
			String bookname = rs.getString("bookname");
			if(class1==null){
				class1="";
			}
	%>
		
<form name="form" method="post" action="reserveupdateProcess.jsp">
<table border=1>
<tr>
<th>대출번호</th>
<td><input type="text" name="lentno" value="<%=lentno%>"></td>
<th>고객성명</th>
<td><input type="text" name="custname" value="<%=custname%>"></td>
</tr>
<tr>
<th>도서코드</th>
<td><input type="text" name="bookno" value="<%=bookno%>"></td>

<th>도서이름</th>
<td><input type="text" name="bookname" value="<%=bookname%>"></td>
</tr>
<tr>
<th>대출일자</th>
<td><input type="text" name="outdate" value="<%=outdate%>"></td>
<th>반납일자</th>
<td><input type="text" name="indate" value="<%=indate %>"></td>
</tr>
<tr>
<th>대출상태</th>
<td><input type="radio" name="status" value="1"<%= status.equals("1") ? "checked" : ""%>>대출
	<input type="radio" name="status" value="2"<%= status.equals("2") ? "checked" : ""%>>반납</td>
<th>등급</th>
<td><select name="class">
	<option value="" <%if(class1.equals(null)){%>selected<%} %>> </option>
	<option value="S" <%if(class1.equals("S")){%>selected<%} %>>S</option>
	<option value="A" <%if(class1.equals("A")){%>selected<%} %>>A</option>
	<option value="B" <%if(class1.equals("B")){%>selected<%} %>>B</option>
	<option value="C" <%if(class1.equals("C")){%>selected<%} %>>C</option></select>
	</td>
</tr>
<tr>
<td colspan=4 align=center>
	<input type="button" value="저장" onclick="check()">
	<input type="reset" value="취소">
	</td>
</tr>
	<%}
	}catch(SQLException e){
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
	if(document.form.lentno.value==""){
		alert('대출번호가 입력되지 않았습니다.');
		document.form.lentno.focus();
	}else if(document.form.custname.value==""){
		alert('고객성명이 입력되지 않았습니다.');
		document.form.custname.focus();
	}else if(document.form.bookno.value==""){
		alert('도서코드가 입력되지 않았습니다.');
		document.form.bookno.focus();
	}else if(document.form.outdate.value==""){
		alert('대출일자가 입력되지 않았습니다.');
		document.form.outdate.focus();
	}else{
		alert('수정이 완료되었습니다!');
		document.form.submit();
	}
}

</script>
</html>