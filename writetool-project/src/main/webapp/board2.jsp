<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.free" %>
<%@ page import="test.freeshowDAO" %>
<%@ page import="test.freeopenDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="freetest.freecontentDAO" %>
   <%@ page import="freetest.freecontent" %>
 <%@ page import="java.util.ArrayList" %>
  <%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>    
<jsp:useBean id="freetest" class="freetest.freecontent" scope="page" />
<jsp:setProperty name="freetest" property="freeID"/>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/board.css">
</head>
<body style ="overflow-x:hidden;">
	<%
	String searchField=request.getParameter("searchField");
	String searchText=request.getParameter("searchText");
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String userID = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	}
	 int pageNumber = 1; 
	 //만약에 파라미터로 pageNumber가 넘어왔다면 해당 파라미터의 값을 넣어주도록 한다.
	if (request.getParameter("pageNumber") != null)
	{
		//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
	    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	} 

	%>
<header class = "menubar">
	<div class="main"><a href ="home.jsp">Epicus</a></div>
	<div class="menu">
		
		<ul class ="menuul">
		<li class= "menuli"><a href ="home.jsp" >홈</a></li>
		<li class= "menuli"><a href ="mycontent.jsp">내작품</a></li>
		<li class= "menuli"><a href ="board.jsp">게시판</a></li>
		<li class= "menuli"><a href ="contest.jsp">공모전</a></li>
		<li class="menuli"><a href="#">마이페이지</a></li>
		<%
				// 접속하기는 로그인이 되어있지 않은 경우만 나오게한다.
			if (userID == null) {
			%>
			<li class="menuli"><a href="login.jsp">로그인</a></li>
			<li class="menuli"><a href="join.jsp">회원가입</a></li>
	
	<%
				// 로그인이 되어있는 사람만 볼수 있는 화면
			} else {
			%>
			<li class="menuli"><a href="logoutAction.jsp">로그아웃</a></li>
			<span class="profile"><i class="fa-solid fa-circle-user fa-xl" style="color: #324b4c;"></i></span>
			<%} %>
		</ul>
	
	</div>
	
	
	</header>
	<nav class="boardnav">
		<h1 class="boardh1">게시판 > 전체</h1>

		<span class="arraybtn">
<!-- 		<input type="button" class= "pbtn" value="인기순"> -->
<!-- 		<input type="button" class="lbtn" value="최신순"> -->
		</span>
		
		<div class="searchdiv">
		<form method="post" name="search" action="board2.jsp">
		
		<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="fTitle">제목</option>
								<option value="userID">작가명</option>
						</select></td>
		<input type="text" class="search" name="searchText">
		<input type="submit" class="searchbtn" value="검색">
		</form>
		</div>
		
		<hr class="boardhr">
		
		
		
	</nav>
	<nav class="menunav">
	<div class="uldiv">
		<ul class="ulmenu">
		  <li class="limenu"><a class="active" href="board.jsp">전체</a></li>
		  <li class="limenu"><a class="active" href="#">추리</a></li>
		  <li class="limenu"><a class="active" href="#">무협</a></li>
		  <li class="limenu"><a class="active" href="#">일기</a></li>
		  <li class="limenu"><a class="active" href="#">사극</a></li>
		  <li class="limenu"><a class="active" href="#">스릴러</a></li>
		  <li class="limenu"><a class="active" href="#">게임</a></li>
		  <li class="limenu"><a class="active" href="#">우화</a></li>
		  <li class="limenu"><a class="active" href="#">공포</a></li>
		  <li class="limenu"><a class="active" href="#">로맨스</a></li>
		  <li class="limenu"><a class="active" href="#">모험</a></li>
		  <li class="limenu"><a class="active" href="#">과학(SF)</a></li>
		  <li class="limenu"><a class="active" href="#">자서전</a></li>
		  <li class="limenu"><a class="active" href="#">역사</a></li>
		  <li class="limenu"><a class="active" href="#">판타지</a></li>
		  <li class="limenu"><a class="active" href="#">전기</a></li>
		  <li class="limenu"><a class="active" href="#">라이트노벨</a></li>
		  
		</ul>
	</div>
	<div class="contestbanner">
	<img class="contestimg" src="contestbanner.png" onclick="location.href='contest.jsp'">
	</div>	
	<%-- <%=searchText %>
	<%	
	
		
			freeopenDAO freeopenDAO = new freeopenDAO();
			ArrayList<free> list = freeopenDAO.getList(pageNumber);
			
			for ( int i= 0; i<list.size(); i++)
			{
		%>
	<div class="boarduldiv">
	<div class="boardbar"></div>
	<span class="image"><a href="showcontent.jsp?freeID=<%=list.get(i).getFreeID() %>"><img src="rabbit.png"></a></span>
	<span class="title"><%=list.get(i).getfTitle() %></span>
	<span class="user"><%=list.get(i).getUserID() %></span>
	<span class="Into"><%=list.get(i).getfInto() %></span>

	<hr class="contenthr">
	</div>
	<%
			}
		%> --%>

		<% 
		freeopenDAO freeopenDAO = new freeopenDAO();
		ArrayList<free> list1 = freeopenDAO.getSearch(request.getParameter("searchField"),request.getParameter("searchText"));
		if (list1.size() == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('검색결과가 없습니다.')");
		
			script.println("</script>");
		}
		for (int i = 0; i < list1.size(); i++) {
		%>
		<div class="boarduldiv">
	<div class="boardbar"></div>
	<span class="image"><a href="showcontent.jsp?freeID=<%=list1.get(i).getFreeID() %>"><img src="rabbit.png"></a></span>
	<span class="title"><%=list1.get(i).getfTitle() %></span>
	<span class="user"><%=list1.get(i).getUserID() %></span>
	<span class="Into"><%=list1.get(i).getfInto() %></span>

	<hr class="contenthr">
	</div>
	<%
	}
	%>
			</nav>
	

</body>
</html>