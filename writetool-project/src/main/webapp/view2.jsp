<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter"%>
    <%@ page import="test.free" %>
    <%@ page import="test.freeDAO" %>

<%@ page import="freetest.freecontent" %>

<%@ page import="freetest.freecontentDAO" %>
<%@ page import="ccomment.Comment" %>
<%@ page import="ccomment.CommentDAO" %>

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
		int commentID = 0;
		//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
		//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
		if (request.getParameter("commentID") != null) {
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
	commentID = Integer.parseInt(request.getParameter("freeID"));
		}
		//매개변수및 기본셋팅 처리 하는 부분
		int freeID = 0;
		//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
		//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
		if (request.getParameter("freeID") != null) {
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
	freeID = Integer.parseInt(request.getParameter("freeID"));
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
		free free = new freeDAO().getfree(freeID);
		freecontent freetest = new freecontentDAO().getfreecontent(freeID,number);
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
			<%
			}
			%>
		</ul>
	
	</div>
	
	
	</header>

	



	<nav class="titlenav">
		<span class="number"><%=free.getfTitle()%> : </span><span class="freeInto"><%=free.getfInto() %></span>
		<span class="optionbtn"></span>
		
		 
		
		<button class="option" onclick="openSetting()"><i class="fa-solid fa-ellipsis-vertical fa-xl" style="color: #324b4c;"></i></button>
	

		<%-- <div id="setting">

			<li><a href="update2.jsp?freeID=<%=freeID %>&number=<%=number %>&userID=<%=userID%>">수정하기</a></li>
			
			<li><a href="deleteAction.jsp?freeID=<%=freeID %>&number=<%=number %>">삭제하기</a></li>
	
		</div> --%>
		<span class="Date"><%=free.getfDate() %></span>
		<hr class="titlehr">
		
		
	</nav>
	<section class="titlesec">
	<div class="btndiv">
	<%-- <span class="btnspan">

	
	<input type="button" class="fa-solid fa-chevron-left" id="beforebtn" onclick="location.href='view2.jsp?contentNumber=<%=contentNumber-1 %>&freeID=<%=freeID %>&number=<%=number %>&roundID=<%=roundID %>'">
	</span> --%>
	
	<span class="subtitlespan"><%=freetest.getSubtitle() %></span>
	<%-- <span class="spanbtn"><input type="button" class="nextbtn" value=">" onclick="location.href='view2.jsp?contentNumber=<%=contentNumber+1 %>&freeID=<%=freeID %>&number=<%=number %>&roundID=<%=roundID %>'"></span> --%>
	
	
	
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
		<div class="summarydiv2"><%=freetest.getSummary()%></div>
	</div>
	<div class="storydiv" style ="overflow:auto;"><%=freetest.getStory() %></div>
	
	<div class="btn">
	<input type="button" class="before" value="< 이전화">
	<input type="button" class="list" value="목록" onclick="location.href='mycontentlist.jsp?freeID=<%=freeID%>'">
	<input type="button" class="next" value="다음화 >">
	</div>
	</section>
	<%-- <section class="roundsection">
	<span class="number"><%=free.getfTitle()%></span>
	<hr class="titlehr">
	<div class="titlebox">
	<input type="button" class="last" value="<">
	<span class="scene"><%=freetest.getRoundID()%>화 <%=freetest.getSubtitle()%></span>
	<input type="button" class="next" value=">" onclick="location.href=view.jsp?roundID">
	</div>
	</section>
	<section class="storysec">
	<div class="summary"><%=freetest.getSummary()%></div>
	<div class="story"><%=freetest.getStory()%></div>

	</section> --%>
	<section class="commentsec">
	<% if(commentID==0){
		%>
		<% 
	}else{
		%>
		
	<h3 class="commenth3">댓글</h3>
	
	
	<%} %>
	</section>
	<section class="commentsec2">
	<%
	CommentDAO CommentDAO = new CommentDAO();
			
			ArrayList<Comment> list = CommentDAO.getList(pageNumber,freeID,number);
			
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