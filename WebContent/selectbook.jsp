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
<h2>도서 정보 목록</h2>
<% PreparedStatement pstmt = null;
	ResultSet rs = null;
	int cnt =0;
	
	try{
		String sql1="select count(*) from bookinfo1229";
		pstmt = conn.prepareStatement(sql1);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			cnt = rs.getInt(1);
		%>	
<div id="num">총 <%=cnt %>권의 도서정보가 있습니다.</div>
<table border=1 id="tab1">
<tr>
<th>no</th>
<th>도서코드</th>
<th>저자</th>
<th>도서명</th>
<th>관리</th>
</tr>
<%
	int no = 0;
	try{	
		String sql2 = "select * from bookinfo1229";
		pstmt = conn.prepareStatement(sql2);
		rs = pstmt.executeQuery();
		while(rs.next()){
			no++;
			String bookno = rs.getString("bookno");
			String author = rs.getString("author");
			String bookname = rs.getString("bookname");
			%>
<tr>
<td><%=no %></td>
<td><a href="updatebook.jsp?bookno=<%=bookno%>"><%=bookno %></a></td>
<td><%=author %></td>
<td><%=bookname %></td>
<td><a href="bookDelete.jsp?bookno=<%=bookno %>" onclick="if(!confirm('정말로 삭제하시겠습니까?')) return false;">삭제</a></td>
</tr>
			<%
		}
	}catch(SQLException e){
		System.out.println("데이터 연결 실패");
	}
	}
	}catch(SQLException e){
		System.out.println("데이터 연결 실패");
	}
	%>
</table>
<br><br>
<input id="button1" type="button" value="도서 정보 추가" onclick="location.href='insertbook.jsp'">
</section>
<%@ include file="footer.jsp" %>
</body>
</html>