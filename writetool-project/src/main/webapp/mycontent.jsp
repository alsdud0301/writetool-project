<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="test.free" %>
<%@ page import="test.freeDAO" %>
 <%@ page import="java.util.ArrayList" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/mycontent.css">

<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<title>내 작품</title>

</head>
<body style="overflow-x: hidden;">

<%
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
	
	<nav class="mycontentnav">
		<div class="mycontentdiv">내작품 > 자유</div>
	 <hr class="mycontenthr">
	
		
	</nav>

	<section class="contentsection">
		<span class="freebtn"><input type="button" class="free" value="자유"></span>
		<span class="wizardbtn"><input type="button" class="wizard" value="마법사" onclick="location.href='mycontentmagic.jsp'"></span>
		<form class="search" method="post" action="mycontent2.jsp">
		<div class="searchdiv">
		
		<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="fTitle">제목</option>
							
						</select></td>
		<input type="text" class="searchbox" name="searchText">
		
		<button type="submit" class="searchbtn"><i class="fa-solid fa-magnifying-glass fa-xl" style="color: #324b4c;"></i></button>
		
		
		</div>
		</form>
	</section>
	<hr class="contenthr2">
	<section class="contentsection2">
	
		<%	
		
// 		ArrayList<free> list = freeDAO.getSearch(request.getParameter("searchField"),
// 				request.getParameter("searchText"));
// 		if (list.size() == 0) {
// 			PrintWriter script = response.getWriter();
// 			script.println("<script>");
// 			script.println("alert('검색결과가 없습니다.')");
// 			script.println("history.back()");
// 			script.println("</script>");
// 		}
// 		for (int i = 0; i < list.size(); i++) {
			freeDAO freeDAO = new freeDAO();
			ArrayList<free> list = freeDAO.getList(pageNumber,userID);
			
			for ( int i= 0; i<list.size(); i++)
			{
				
		%>
		<%
						
					%>

	<ul class="ullist">
		<li class="content1">
		<div class="image"><a href="mycontentlist.jsp?freeID=<%=list.get(i).getFreeID() %>"><img src="rabbit.png"></a></div>
		<div class="contentdiv"><%=list.get(i).getfTitle() %></div>
		
		</li>
		
		
	</ul>
	
	
	<%
			}
		%>
	
			<div class="btndiv">
		<span class="createbtn"><input type="button" class="pluscreate" value="+작품생성" onclick="location.href='createcontent2.jsp'"></span>
		
		<span class="deletebtn"><input type="button" class="delete" value="작품삭제"></span>
		</div>
		</section>
	
		<footer class="contentfooter">
	
		<% 
	 if(pageNumber != 1) {
            %>
            	<!--페이지넘버가 1이 아니면 전부다 2페이지 이상이기 때문에 pageN에서 1을뺀값을 넣어서 게시판
            	 메인화면으로 이동하게 한다. class내부 에는 화살표모양으로 버튼이 생기게 하는 소스작성 아마 부트스트랩 기능인듯.-->
			<input type="button" class="beforea" value="이전" onclick="location.href=mycontent.jsp?pageNumber=<%=pageNumber -1 %>">
                
            <%
            	//BbsDAO에서 만들었던 함수를 이용해서, 다음페이지가 존재 할 경우
                } if (freeDAO.nextPage(pageNumber + 1)) {
            %>
            	<!-- a태그를 이용해서 다음페이지로 넘어 갈 수있는 버튼을 만들어 준다. -->
            	
            	<input type="button" class="nexta" value=">" onclick="location.href=mycontent.jsp?pageNumber=<%=pageNumber + 1 %>">
                
            <%
                }
            %>
          
		
	
		
		</footer>
	
	
	

</body>
</html>