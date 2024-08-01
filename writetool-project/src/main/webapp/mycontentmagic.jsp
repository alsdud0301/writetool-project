<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="magic.magic" %>
<%@ page import="magic.magicDAO" %>
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
<body>

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
		<div class="mycontentdiv">내작품 > 마법사</div>
	 <hr class="mycontenthr">
	
		
	</nav>


	<section class="contentsection">
	<span class="freebtn"><input type="button" class="free" value="자유" onclick="location.href='mycontent.jsp'"></span>
		<span class="wizardbtn"><input type="button" class="wizard" value="마법사" onclick="location.href='mycontentmagic.jsp'"></span>
		<div class="searchdiv">
		<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="fTitle">제목</option>
								<option value="userID">작성자</option>
						</select></td>
		<textarea class="searchbox" cols="60" rows="1"></textarea>
		
		<button type="submit" class="searchbtn"><i class="fa-solid fa-magnifying-glass fa-xl" style="color: #324b4c;"></i></button>
		
		</div>
		</section>
		<hr class="contenthr2">
		<section class="contentsection2">
		<%	
			magicDAO magicDAO = new magicDAO();
			ArrayList<magic> list = magicDAO.getList(pageNumber,userID);
			
			for ( int i= 0; i<list.size(); i++)
			{
		%>

	<ul class="ullist">
		<li class="content1">
		<div class="image"><a href="mycontentlist2.jsp?magicID=<%=list.get(i).getMagicID() %>"><img src="rabbit.png"></a></div>
		<div class="contentdiv"><%=list.get(i).getmTitle() %></div>
		</li>
		
	</ul>
	<%
			}
		%>
		<div class="btndiv">
		<span class="createbtn"><input type="button" class="pluscreate" value="+작품생성" onclick="location.href='magiccreatecontent.jsp'"></span>
		
		<span class="deletebtn"><input type="button" class="delete" value="작품삭제"></span>
		</div>
		</section>
		
		<footer class="contentfooter">
		
		
	
		
		</footer>
	
	
	

</body>
</html>