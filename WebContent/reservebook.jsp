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
<h2>도서 대출 정보 등록 화면</h2>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String bookno1;
	int seq=0;
	try{
		String sql="select reserve_seq.nextval from dual";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			seq = rs.getInt(1);
		}
	}catch(SQLException e){
		System.out.println("데이터 연결 실패");
	}
	
	String bookno = request.getParameter("bookno");
	String custname = request.getParameter("custname");
	String indate = request.getParameter("indate");
	String outdate = request.getParameter("outdate");
	String lentno = request.getParameter("lentno");
	String t_bookno="", t_bookname="", t_lentno="";
	int sel=0;
	
	if(bookno==null){
		bookno="";
		custname="";
		indate="";
		outdate="";
	}else{
	try{
		String sql2="select a.bookno, a.bookname, b.lentno from bookinfo1229 a, reservation1229 b where bookno=? and a.bookno=b.bookno";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, bookno);
		rs = pstmt.executeQuery();
				
		if(rs.next()){
			t_bookno = rs.getString(1);
			t_bookname = rs.getString(2);
			t_lentno = rs.getString(3);
		}else{
			%>
			<script>
			alert("등록되지 않은 도서코드입니다.");
			</script>
			<%
		}
	}catch(SQLException e){
		System.out.println("bookinfo 테이블 오류");
		e.printStackTrace();
	}}
%>
		
<form name="form" method="post" action="reservebook.jsp">
<table border=1>
<tr>
<th>대출번호</th>
<td><input type="text" name="lentno" value="<%=seq%>" onchange="changesubmit();" <%if(lentno==""||lentno==null){lentno="";}else{lentno=t_lentno;} %>></td>
<th>고객성명</th>
<td><input type="text" name="custname" value="<%=custname%>"></td>
</tr>
<tr>
<th>도서코드</th>
<td><input type="text" name="bookno" onchange="changesubmit();" value="<%=t_bookno%>"></td>

<th>도서이름</th>
<td><input type="text" name="bookname" value="<%=t_bookname%>"></td>
</tr>
<tr>
<th>대출일자</th>
<td><input type="text" name="outdate" value="<%=outdate%>"></td>
<th>반납일자</th>
<td><input type="text" name="indate" value="<%=indate %>" onchange="changesubmit();" 
	<%if(indate==""||indate==null){sel=1;}else{sel=0;} %>></td>
</tr>
<tr>
<th>대출상태</th>
<td><input type="radio" name="status" value="1" <%if(sel==1){%>checked<%} %>>대출
	<input type="radio" name="status" value="2" <%if(sel==0){%>checked<%} %>>반납</td>
<th>등급</th>
<td><select name="class">
	<option value=""> </option>
	<option value="S">S</option>
	<option value="A">A</option>
	<option value="B">B</option>
	<option value="C">C</option></select>
	</td>
</tr>
<tr>
<td colspan=4 align=center>
	<input type="submit" value="저장" onclick="check()">
	<input type="reset" value="취소">
	</td>
</tr>


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
		alert('등록이 완료되었습니다!');
		form.action="reserveProcess.jsp";
	}
}

function changesubmit(){
	document.form.submit();
}
</script>
</html>