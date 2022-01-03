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
<h2>도서 예약정보 조회</h2>
<% PreparedStatement pstmt = null;
	ResultSet rs = null;
	int cnt =0;
	
	try{
		String sql1="select count(*) from reservation1229";
		pstmt = conn.prepareStatement(sql1);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			cnt = rs.getInt(1);
		%>	
<div id="num">총 <%=cnt %>권의 도서 예약 정보가 있습니다.</div>
<table border=1 id="tab1">
<tr>
<th>no</th>
<th>대출번호</th>
<th>고객성명</th>
<th>도서코드</th>
<th>도서명</th>
<th>대출일자</th>
<th>반납일자</th>
<th>대출상태</th>
<th>등급</th>
<th>관리</th>
</tr>
<%
	int no = 0;
	try{	
		String sql2 = "select a.lentno, a.custname, a.bookno, b.bookname, to_char(a.outdate,'yyyy-mm-dd'), to_char(a.indate,'yyyy-mm-dd'), a.status, a.class from reservation1229 a, bookinfo1229 b where a.bookno=b.bookno";
		pstmt = conn.prepareStatement(sql2);
		rs = pstmt.executeQuery();
		while(rs.next()){
			no++;
			String lentno = rs.getString(1);
			String custname = rs.getString(2);
		 	String bookno = rs.getString(3);
		 	String bookname = rs.getString(4);
		 	String outdate = rs.getString(5);
		 	String indate = rs.getString(6);
			String status = rs.getString(7);
			String class1 = rs.getString(8);
			
			%>
<tr>
<td><%=no %></td>
<td><a href="reserveUpdate.jsp?lentno=<%=lentno%>"><%=lentno %></a></td>
<td><%=custname %></td>
<td><%=bookno %></td>
<td><%=bookname %></td>
<td><%=outdate %></td>
<td><%=indate %></td>
<td><%=status %></td>
<td><%=class1 %></td>
<td><a href="reserveDelete.jsp?bookno=<%=bookno%>" onclick="if(!confirm('정말로 삭제하시겠습니까?')) return false;">삭제</a></td>
</tr>
			<%
		}
	}catch(SQLException e){
		System.out.println("데이터 연결 실패");
		e.printStackTrace();
	}
	}
	}catch(SQLException e){
		System.out.println("데이터 연결 실패");
		e.printStackTrace();
	}
	%>
</table>
<br><br>
<input id="button1" type="button" value="도서 정보 추가" onclick="location.href='insertbook.jsp'">
</section>
<%@ include file="footer.jsp" %>
</body>
</html>