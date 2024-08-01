<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="test.free" %>
<%@ page import="test.freeDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="freetest.freecontent" %>
<%@ page import="freetest.freecontentDAO" %>
<jsp:useBean id="freetest" class="freetest.freecontent" scope="page" />
<jsp:setProperty name="freetest" property="freeID"/>
<jsp:setProperty name="freetest" property="number"/>
<jsp:setProperty name="freetest" property="roundID"/>
<jsp:setProperty name="freetest" property="subtitle" />
<jsp:setProperty name="freetest" property="summary" />
<jsp:setProperty name="freetest" property="story" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/write.css">
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="./smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "ss", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "./smarteditor/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,         
              fOnBeforeUnload : function(){
                   
              }
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["ss"].exec("PASTE_HTML", [""]);
          },
          fCreator: "createSEditor2"
      });
      
      //저장버튼 클릭시 form 전송
      $("#save").click(function(){
          oEditors.getById["ss"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm").submit();
      });    
});
 
 
 
</script>
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
	int freeID=0;
	if(request.getParameter("freeID") !=null){
		freeID = Integer.parseInt(request.getParameter("freeID"));
		
	}
	int number = 0;
	//view페이지에서 넘겨준 bbsID를 들고오는 소스 코드
	if (request.getParameter("number") != null) {
		//받은 bbsID를 정수형으로 반환해서 bbsID 인스턴스에 저장
		number= Integer.parseInt(request.getParameter("number"));
	}
	int roundID=0;
	if(request.getParameter("roundID") !=null){
		roundID = Integer.parseInt(request.getParameter("roundID"));
	}
	//현재 작성한 글이 작성자가 일치하는지 확인해주는 소스코드 작성
	//만약 userID와 뷰페이지에서 넘겨받은 bbsID값을 가지고 해당 글을 가져온 후
	freecontent freecontent = new freecontentDAO().getfreecontent(freeID,number);
	//실제로 이 글의 작성자가 일치하는지 비교해준다. userID는 세션에 있는 값이고, bbs.getUserID는 이글을 작성한 사람의 값이다.
	if (!userID.equals(freecontent.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		//동일하지 않다면 오류를 출력해 돌려보내준다.
		script.println("location.href = 'mycontent.jsp'");
		script.println("</script>");				
	}
	free free = new freeDAO().getfree(freeID);
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
	<form method="post" id="frm" accept-charset="utf-8" action="updateAction.jsp?freeID=<%=freeID%>&number=<%=number%>&userID=<%=userID%>">
	<nav class="titlenav">
		<span class="titlespan"><%=free.getfTitle() %></span>
		<span class="inputspan"><span class="roundspan">화</span><input type="text" class="roundbox" name="roundID" value="<%=freecontent.getRoundID()%>"></span>
		<hr class="navhr">
	</nav>
	<section class="createsec">
		<div class="creatediv">대표 삽화</div>
		<input type="file" class="image">
		<div class="imagediv"></div>
		<div class="subdiv">부제목</div>
		<textarea class="sub" name="subtitle" cols=146 rows=4><%=freecontent.getSubtitle() %></textarea>
		<div class="sum">사건 요약(줄거리)</div>
		<textarea class="summary" name="summary" cols=146 rows=20><%=freecontent.getSummary() %></textarea>
		<div class="storybox">내용</div>
		<div class="box">
		<textarea name="story" id="ss" cols=144 rows=100><%=freecontent.getStory() %></textarea>
		</div>
	</section>
	<footer class="createfooter">
	<input type="button" class="list" value="목록으로" onclick="location.href='mycontentlist.jsp?freeID=<%=freeID%>'">
	<input type="submit" id ="save" class="create" value="생성" onclick="location.href='mycontentlist.jsp?freeID=<%=freeID %>'">
	</footer>
	</form>


</body>
</html>