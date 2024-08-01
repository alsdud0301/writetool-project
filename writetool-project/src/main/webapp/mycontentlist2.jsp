<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="magic.magic" %>
<%@ page import="magic.magicDAO" %>
<%@ page import="magic.magiccontent" %>
<%@ page import="magic.magiccontentDAO" %>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>


<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
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
		<span class="profile"><i class="fa-solid fa-user" style="color: #324b4c;"></i></span>
		<% 
		}
		%>
		</ul>
		
		
	
	</div>
	
	</header>

	

	<nav class="mycontent">
	<h1 class="mycontenth1">내 작품</h1>
	
	
	
	</nav>
	<%
	int magicID=0;
	if(request.getParameter("magicID") !=null){
		magicID = Integer.parseInt(request.getParameter("magicID"));
		
	}
	int roundID=0;
	if(request.getParameter("roundID") !=null){
		roundID = Integer.parseInt(request.getParameter("roundID"));
		
	}
	int number=0;
	if(request.getParameter("number") !=null){
		roundID = Integer.parseInt(request.getParameter("number"));
		
	}

	magic magic = new magicDAO().getmagic(magicID);
	magiccontent magiccontent =new magiccontentDAO().getmagiccontent(magicID,number);
	
	
%>
	<section class="mycontentsection">
		<div class="bar">
		<span class="ibtn">
		<i class="fas fa-regular fa-angle-left" style="color: #ffffff;"></i>
<!-- 		<i class="fa-light fa-angle-left" style="color: #ffffff;" onclick="location.href='mycontent.jsp'"></i> -->
		</span>
		<div class="title"><%=magic.getmTitle() %></div>
		</div>

	
		<div class="contenttitle"><img src="free.png" style="width :200px; height : 200px; background-color : white;">
		<div class="v"></div>
		<span class="titlespan2"><%=magic.getmTitle() %></span>
		<span class="Intospan"><%=magic.getmInto() %></span>
		
		<span class="btnspan"><input type="button" class="revisebtn" value="퇴고하기" onclick="location.href='finishboard2.jsp?userID=<%=userID%>&magicID=<%=magicID%>'"></span>
		
		<span class="plusspan"><input type="button" class="pluswrite" value="+ 글쓰기" onclick="location.href='magiccontent.jsp?magicID=<%=magicID%>'"></span>
		<button type="button" class="closespan"  onclick="location.href='closeAction.jsp?magicID=<%=magicID %>'"><img src="lock.png"></button>
		</div>
		
		
		
		

	
	</section>
	
	
	<nav class="round">
	
	 <script type="text/javascript">
  function showPopup() { window.open("popup.jsp?magicID=<%=magicID%>", "a", "width=200, height=300, left=500, top=500"); }
  </script>
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
	
			magiccontentDAO magiccontentDAO = new magiccontentDAO();
	
			ArrayList<magiccontent> list = magiccontentDAO.getList(pageNumber,magicID,userID);
			
			for ( int i= 0; i<list.size(); i++)
			{
		%>
	
		<li class="listli">
			<div class="titlediv">
			<img src="paper.png">
			<span class="roundspan2"><%=list.get(i).getRoundID() %>화.</span>
			<span class="titlespan"><strong><a class ="viewa" href="view4.jsp?magicID=<%=list.get(i).getMagicID()%>&number=<%=list.get(i).getNumber()%>"><%=list.get(i).getSub_opinion()%></a></strong></span>
			<span class="infospan"><a class="suma" href="view2.jsp?magicID=<%=list.get(i).getMagicID()%>&number=<%=list.get(i).getNumber()%>&roundID=<%=list.get(i).getRoundID()%>"><%=list.get(i).getStory_opinion() %></a></span>
			<input type="button" class="downloada" value ="word파일다운" onclick="location.href='http://localhost:8888/testtest/word.jsp?magicID=<%=magicID%>&number=<%=list.get(i).getNumber()%>'">
			<hr class="listhr">
			</div>
			
			
			
			
		</li>
		
			
		
				<%
			}
		%>
	<div class="pagediv">
		
	</div>
	</section>
		
		<footer>
				<% 
	 if(pageNumber != 1) {
            %>
            	<!--페이지넘버가 1이 아니면 전부다 2페이지 이상이기 때문에 pageN에서 1을뺀값을 넣어서 게시판
            	 메인화면으로 이동하게 한다. class내부 에는 화살표모양으로 버튼이 생기게 하는 소스작성 아마 부트스트랩 기능인듯.-->
			<a href="mycontentlist.jsp?pageNumber=<%=pageNumber - 1 %>&magicID=<%=magicID %>" >이전</a>
                
            <%
            	//BbsDAO에서 만들었던 함수를 이용해서, 다음페이지가 존재 할 경우
                } if (magiccontentDAO.nextPage(pageNumber + 1)) {
            %>
            	<!-- a태그를 이용해서 다음페이지로 넘어 갈 수있는 버튼을 만들어 준다. -->
                <a href="mycontentlist.jsp?pageNumber=<%=pageNumber + 1 %>&magicID=<%=magicID %>" >다음</a>
            <%
                }
            %>
		</footer>
	

</body>
</html>