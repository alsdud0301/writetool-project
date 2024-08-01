<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter"%>
    <%@ page import="magic.magic" %>
    <%@ page import="magic.magicDAO" %>
	<%@ page import="magic.magiccontent" %>
	<%@ page import="magic.magiccontentDAO" %>
	<%@ page import="magiccomment.magiccommentDAO" %>
	<%@ page import="magiccomment.cmagiccomment" %>

<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="Stylesheet"  href="./css/view.css">
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>

    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

// MS word로 다운로드/실행, filename에 저장될 파일명을 적어준다.

		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
		}
		//매개변수및 기본셋팅 처리 하는 부분
		int magicID = 0;
		//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
		//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
		if (request.getParameter("magicID") != null) {
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
	magicID = Integer.parseInt(request.getParameter("magicID"));
		}
		int number = 0;
		//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
		//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
		if (request.getParameter("number") != null) {
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
	number = Integer.parseInt(request.getParameter("number"));
		}
		//받아온 bbsID가 0이면 유효하지 않은 글이라고 넣어준다.
// 		if (freeID == 0) {
// 			PrintWriter script = response.getWriter();
// 			script.println("<script>");
// 			script.println("alert('유효하지 않은 글 입니다.')");
// 			//다시 bbs.jsp로 돌려보내주자.
// 			script.println("location.href = 'mycontentlist.jsp'");
// 			script.println("</script>");
// 			//bbsID가 존재해야지, 특정한 글을 볼 수있도록 하는 거고,
// 		}
	 	
		int pageNumber = 1; 
	 //만약에 파라미터로 pageNumber가 넘어왔다면 해당 파라미터의 값을 넣어주도록 한다.
	if (request.getParameter("pageNumber") != null)
	{
		//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
	    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	} 
	int contentNumber =1;
	if (request.getParameter("contentNumber") != null)
	{
		//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
	    contentNumber = Integer.parseInt(request.getParameter("contentNumber"));
	} 
	
		int roundID=0;
		if (request.getParameter("roundID") != null) {
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
	roundID = Integer.parseInt(request.getParameter("roundID"));
		} 
		//해당글의 구체적인 내용을 BbsDAO 내부 만들었던 getBbs함수를 실행시켜주는 부분 
		magic magic = new magicDAO().getmagic(magicID);
		magiccontent magiccontent = new magiccontentDAO().getmagiccontent(magicID,number);
%>
<header class = "menubar">

	<div class="main"><a href ="home.jsp">Epicus</a></div>
	<div class="menu">
		
		<ul class ="menuul">
		<li class= "menuli"><a href ="home.jsp" >홈</a></li>
		<li class= "menuli"><a href ="mycontent.jsp">내작품</a></li>
		<li class= "menuli"><a href ="board.jsp">게시판</a></li>
		<li class= "menuli"><a href ="contest.jsp">공모전</a></li>
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
			<%
			}
			%>
		</ul>
	
	</div>
	
	
	</header>

	

<nav class="titlenav">
		<span class="number"><%=magic.getmTitle()%> : </span><span class="freeInto"><%=magic.getmInto()%></span>
		<span class="optionbtn"></span>
		
		 
		
		<button class="option" onclick="openSetting()"><i class="fa-solid fa-ellipsis-vertical fa-xl" style="color: #324b4c;"></i></button>
	

		<div id="setting">

			<li><a href="update2.jsp?freeID=<%=magicID%>&number=<%=number%>&userID=<%=userID%>">수정하기</a></li>
			
			<li><a href="deleteAction.jsp?freeID=<%=magicID%>&number=<%=number%>">삭제하기</a></li>
	
		</div>
		<span class="Date"><%=magic.getmDate()%></span>
		<hr class="titlehr">
		
		
	</nav>
<span class="settings"><input type="button" class="nextbtn" value="스토리설정" onclick="location.href='view5.jsp?magicID=<%=magicID%>&number=<%=number%>&roundID=<%=roundID%>'"></span>
	<section class="titlesec">
	<div class="btndiv">
	<span class="btnspan">

	
	<input type="button" class="fa-solid fa-chevron-left" id="beforebtn" onclick="location.href='view2.jsp?contentNumber=<%=contentNumber-1%>&magicID=<%=magicID%>&number=<%=number%>&roundID=<%=roundID%>'">
	</span>
	
	<span class="subtitlespan"><%=magiccontent.getSub_opinion()%></span>
	<span class="spanbtn"><input type="button" class="nextbtn" value=">" onclick="location.href='view2.jsp?contentNumber=<%=contentNumber+1%>&magicID=<%=magicID%>&number=<%=number%>&roundID=<%=roundID%>'"></span>
	
	
	
	</div>
	<script>
	function openSetting(){
	    if(document.getElementById('setting').style.display==='block'){
	        document.getElementById('setting').style.display='none';
	    }else{
	        document.getElementById('setting').style.display='block';
	    }
	}
	</script>
	<div class="summarydiv">
		<div class="summary">
			<h3 class="summaryh3">사건요약 (줄거리)</h3>
		</div>
		<div class="summarydiv2"><%=magiccontent.getStory_opinion()%></div>
	</div>
	<div class="storydiv" style ="overflow:auto;"><%=magiccontent.getMain_opinion()%></div>
	
	<div class="btn">
	<input type="button" class="before" value="< 이전화">
	<input type="button" class="list" value="목록" onclick="location.href='mycontentlist2.jsp?magicID=<%=magicID%>'">
	<input type="button" class="next" value="다음화 >">
	</div>
	</section>
	
	<section class="commentsec">
	<h3 class="commenth3">댓글</h3>
	</section>
	<section class="commentsec2">
	
	<%
		magiccommentDAO magiccommentDAO = new magiccommentDAO();
			
			ArrayList<magiccomment.cmagiccomment> list = magiccommentDAO.getList(pageNumber,magicID,number);
			
			for ( int i= 0; i<list.size(); i++)
			{
		%>
	<div class="commentdiv">
	<span class="userspan"><%=list.get(i).getUserID() %></span>
	
	<span class="commentdate"><%=list.get(i).getCommentDate() %></span><br><br>
	<span class="comment"><%=list.get(i).getCommentText() %></span>
	
	</div>
	<hr class="commenthr">
	
				<%
			}
		%>
	</section>
	
	
	<footer class="listfooter">
	
		</footer>
</body>
</html>