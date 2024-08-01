<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="test.free" %>
<%@ page import="test.freeDAO" %>
<%@ page import="freetest.freecontent" %>
<%@ page import="freetest.freecontentshowDAO" %>
<%-- <%@ page import="free.freestory" %> --%>
<%-- <%@ page import="free.freestoryDAO" %> --%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href="./css/mycontentlist.css">
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>


<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
	String userID = null;
	if (session.getAttribute("userID") != null)
	{
	    userID = (String)session.getAttribute("userID");
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
			if (userID == null) {	
		%>
		<li class="menuli"><a href="login.jsp">로그인</a></li>
		<li class="menuli"><a href="join.jsp">회원가입</a></li>
		<%
		} else{
		%>
		<li class="menuli"><a href="logoutAction.jsp">로그아웃</a></li>
		<span class="profile"><i class="fa-solid fa-circle-user fa-xl" style="color: #324b4c;"></i></span>
		<% 
		}
		%>
		</ul>
		
		
	
	</div>
	
	</header>

	

	<nav class="mycontent">
	<h1 class="mycontenth1">게시판</h1>
	
	
	
	</nav>
	<%
	int freeID=0;
	if(request.getParameter("freeID") !=null){
		freeID = Integer.parseInt(request.getParameter("freeID"));
		
	}
	int roundID=0;
	if(request.getParameter("roundID") !=null){
		roundID = Integer.parseInt(request.getParameter("roundID"));
		
	}

	free free = new freeDAO().getfree(freeID);
	freecontent freecontent =new freecontentshowDAO().getfreecontent(freeID,roundID);
	
	
%>
	<section class="mycontentsection">
		<div class="bar">
		<div class="ibtn">
		<i class="fas fa-regular fa-angle-left fa-xl" style="color: #ffffff;" onclick="location.href='board.jsp'"></i>
		</div>
		<div class="title1"><%=free.getfTitle() %></div>
		</div>

		<div class="contenttitle"><img src="book1.png">
		<span class="titlespan2"><%=free.getfTitle() %></span>
		<span class="Intospan"> <%=free.getfInto() %></span>
		</div>
	
		

	
	</section>
	
	
	<nav class="round">
	<div class="l3">
  <div class="l">
	<div class="l2">
	</div>
  
  </div>
  </div>
 
  	<div class="bardiv">
  	 <span class="circle"></span>
  	 <span class="circle2"></span>
		<span class="roundspan">작품회차() |</span>
		<div class="option">
		<span class="first"><input type="button" class="firstbutton" value="최신순">|</span>
		<span class="new"><input type="button" class="newbutton" value="1화부터"></span>
		</div>
	</div>
	
	
	</nav>

		
		
	<section class="list">

		<%	
	
			freecontentshowDAO freecontentshowDAO = new freecontentshowDAO();
	
			ArrayList<freecontent> list = freecontentshowDAO.getList(pageNumber,freeID);
			
			for ( int i= 0; i<list.size(); i++)
			{
		%>
	<ul class="listul">
		<li class="listli">
			<div class="titlediv">
			<img src="paper.png">
			<span class="roundspan2"><%=list.get(i).getRoundID() %>화.</span>
			<span class="titlespan"><strong><a class ="viewa" href="view3.jsp?freeID=<%=list.get(i).getFreeID()%>&number=<%=list.get(i).getNumber()%>"><%=list.get(i).getSubtitle()%></a></strong></span>
			<span class="infospan"><a class="suma" href="view3.jsp?freeID=<%=list.get(i).getFreeID()%>&number=<%=list.get(i).getNumber()%>&roundID=<%=list.get(i).getRoundID()%>"><%=list.get(i).getSummary() %></a></span>
			
			<hr class="listhr">
			</div>
			
			
			
			
		</li>
		
			</ul>
		
				<%
			}
		%>
	<div class="pagediv">
		
	</div>
	</section>
	

</body>
</html>