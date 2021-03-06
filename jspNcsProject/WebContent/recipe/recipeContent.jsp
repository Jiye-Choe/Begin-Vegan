<%@page import="jspNcsProject.dao.ScrapDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="jspNcsProject.dto.RecipeContentCommentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jspNcsProject.dao.RecipeContentCommentDAO"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dto.RecipeContentDTO"%>
<%@page import="jspNcsProject.dao.RecipeContentDAO"%>
<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 보기</title>
<link rel="stylesheet" href="../resource/team05_style.css">	
 
<style>
#greenButton {
	border:0px;
    color:white;
    padding: 8px 15px;
    cursor: pointer;
    width: auto;
    height: auto;
    background: rgb(139, 195, 74);
    border-radius: 10px;
    outline: none;
    margin: 5px auto;
}
</style>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	if(request.getParameter("num")==null){ %>
		<script> alert("잘못된 접근입니다."); history.go(-1);</script>
	<%}else{
		String memId = (String)session.getAttribute("memId");
			String pageNum = request.getParameter("pageNum");
			if(pageNum==null) pageNum="1";
			int num = Integer.parseInt(request.getParameter("num"));
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
			
			RecipeDAO recipeDAO = RecipeDAO.getInstance();
			RecipeDTO recipeBoard = new RecipeDTO();
			
			ScrapDAO scrapDAO = ScrapDAO.getInstance();
			
			recipeBoard = recipeDAO.selectRecipeBoard(num);
			int contentNum = recipeBoard.getRecipeStep();
			
			RecipeContentDTO recipeContentdto = new RecipeContentDTO();
			RecipeContentDAO recipeContentdao = RecipeContentDAO.getInstance();
			
			// recipeContentList : 레시피 조리단계  담아준 리스트 -> for문 돌려서 뽑기
			List recipeContentList = recipeContentdao.selectRecipeContent(num);
			
			for(int i = 0; i < recipeContentList.size(); i++){
				recipeContentdto = (RecipeContentDTO)recipeContentList.get(i);
			}
			
			// 조리단계 댓글 dao
			RecipeContentCommentDAO dao = null;
%>
<body>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="recipe" name="mode"/>
	</jsp:include>
	<br />
	
	<table class="nonBorder" style="max-width:1100px; min-width:1100px;">
		<tr >
			<td colspan="6" >
				<div style="min-width:40px; display:inline-block">&nbsp;</div>
				<img src="imgs/<%= recipeBoard.getThumbnail() %>" style="max-width:600px" />
				<span style="vertical-align:top; top:0px; width:40px;">
				<%if (memId != null) {  if(!memId.equals(recipeBoard.getWriter())) {%>
					<%String empty = ""; if(!scrapDAO.confirmScrap(num, memId)) { empty = "empty"; }%>
					<img src="/jnp/recipe/imgs/<%=empty %>heart.png" width="40px" style="cursor:pointer;" 
						onclick="scrap(<%=num%>,'<%=memId%>',<%=scrapDAO.confirmScrap(num, memId)%>)" />
				<%}else{%>
					<div style="min-width:40px; display:inline-block;">&nbsp;</div>
				<%} } else {%><div style="min-width:40px; display:inline-block;">&nbsp;</div><%} %>
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				 <h1><%= recipeBoard.getRecipeName() %></h1>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<%=recipeBoard.getVegiType()%><br/>
				<img src = "/jnp/recipe/imgs/<%=recipeBoard.getVegiType()%>.jpg" style="margin:0 0 30px 0"/>
			</td>
		</tr>
		<tr>
			<td style="width:20%;"></td>
			<td style="width:15%; margin:0px; padding:0px;" >
				<img src="/jnp/recipe/imgs/quantity.png" width="40"/>
			</td>
			<td style="width:15%; margin:0px; padding:0px;">
				<img src="/jnp/recipe/imgs/cookingTime.png" width="40"/>
			</td>
			<td style="width:15%; margin:0px; padding:0px;">
				<img src="/jnp/recipe/imgs/difficulty.png" width="40"/>
			</td>
			<td style="width:15%; margin:0px; padding:0px;">
				<img src="/jnp/recipe/imgs/cal.png" width="40"/>
			</td>
			<td style="width:20%;"></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<%= recipeBoard.getQuantity() %>인분
			</td>
			<td>
				<%= recipeBoard.getCookingTime() %>분
			</td>
			<td>
				<%= recipeBoard.getDifficulty() %>
			</td>
			<td>
				<%= recipeBoard.getCal() %>kcal
			</td>
			<td></td>
		</tr>
		<tr>
			<td colspan="6"></td>
		</tr>
		<tr style="border-top:2px solid #ccc;vertical-align:middle;padding:10px;">
			<td></td>
			<td style="padding:20px;margin:20px;">
				<img src="/jnp/recipe/imgs/icon_url_copy.gif" style="width:50px; height:50px; border-radius:25px;"/>
			</td>
			<td style="padding:20px;margin:20px;">
				<img src="/jnp/recipe/imgs/icon_sns_ks.png" style="width:50px; height:50px; border-radius:25px;"/>
			</td>
			<td style="padding:20px;margin:20px;">
				<img src="/jnp/recipe/imgs/icon_sns_t.png" style="width:50px; height:50px; border-radius:25px;"/>
			</td>
			<td style="padding:20px;margin:20px;">
				<img src="/jnp/recipe/imgs/icon_sns_f.png" style="width:50px; height:50px; border-radius:25px;"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td colspan="3" style="border-top:2px solid #ccc;border-right:2px solid #ccc;border-bottom:2px solid #ccc;">
				<span> 평점 : </span> 
				<%for(int i = 0; i < (int)recipeBoard.getRating() ; i++) {
					%> <img src = "/jnp/recipe/imgs/star.png" width="20px" style="margin:0px auto; vertical-align:center"/> 
				<%}%>
				<%for(int i = 0; i < 5-(int)recipeBoard.getRating() ; i++) {
					%> <img src = "/jnp/recipe/imgs/emptyStar.png" width="20px"style="margin:0px auto; vertical-align:center"/> 
				<%}%>
									
				
				<%=recipeBoard.getRating() %>
				<% if(memId != null) { 
						if(!memId.equals(recipeBoard.getWriter())) {%>
				<button class="greenButton" onclick="rating(<%=num%>)">평점 남기기</button>
				<%} }%>
			</td>
			<td colspan="3" style="border-top:2px solid #ccc;">
				<table class="nonBorder">
					<tr>
						<td> 						
							<img src="/jnp/save/<%=recipeDAO.selectImgById(recipeBoard.getWriter())%>" style="width:60px; height:60px; border-radius:30px; "/> 
						</td>
						<td><h2><%= recipeDAO.selectNameById(recipeBoard.getWriter())%></h2></td>
						<td><button class = "greenButton" onclick="window.location='recipeSearchList.jsp?writer=<%=recipeDAO.selectNameById(recipeBoard.getWriter())%>'">레시피 더 보기</button></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="6" style="padding-bottom:30px; border-bottom:2px solid #ccc" >
				<span style="text-align:left; margin:0px;" ><h1>태그</h1></span>
				<% if(recipeBoard.getTag()!=null) { %>
				<% 
					String[] tags = recipeDAO.selectTagSplit(num);
					for (int i = 0; i< tags.length; i++) { 
						if(!tags[i].equals("")){	
					%>
						<button class="lineButton"onclick="window.location='recipeSearchList.jsp?tag=<%=tags[i]%>'"><%= tags[i]%></button>
					<%}
					} 
				} else {%>
				태그 없음
				<%} %>

			</td>			
		</tr>
		<tr>
			<td colspan="6" style="border-bottom:2px solid #ccc">
				<span style="text-align:left; margin:0px;" ><h1>재료</h1></span>			
				<table class="lineTable">			
					<% 
					HashMap<String,String> ingre = recipeDAO.selectIngredients(num); 
					
					Set keySet = ingre.keySet();
					Iterator ir = keySet.iterator();
					while(ir.hasNext()) {	
						String key = (String) ir.next(); 
						String value = ingre.get(key);%>
					<tr>
						<td class="lineTable" style="width:100px; text-align:left; padding:10px;"> <%= key%> </td>
						<td class="lineTable" style="width:100px; text-align:right;padding:10px;"> <%= value%></td>
					</tr>				
					<%}%>
				</table>
			<br/><br/>
			</td>			
		</tr>
		<tr>
			<td colspan="6" style="align:left;">
				<%--추천 제품 --%>
				<jsp:include page="recipeShowProduct.jsp">
					<jsp:param value="<%=num %>" name="num"/>
				</jsp:include>
			</td>			
		</tr>
		<tr>
			<td colspan="6">
			<span style="text-align:left; margin:0px;" ><h1>조리과정</h1></span> <br/><br/>
				<jsp:include page="recipeStepComment.jsp" flush="false"/>
		<tr>
			<td colspan="6" style="border-top:2px solid #ccc;">
			<span style="text-align:left; margin:0px;" ><h1>댓글</h1></span>
				<jsp:include page="recipeComment.jsp">
					<jsp:param value="<%=num %>" name="num"/>
				</jsp:include>
			</td>			
		</tr>
	</table>
	<br /><br />
	<div align="center">
	<%
		if(session.getAttribute("memId")!= null){
			if(recipeBoard.getWriter().equals(session.getAttribute("memId")) || session.getAttribute("memId").equals("admin")){
				// 관리자거나 레시피 글쓴이면 레시피 자체에 대한 수정 삭제 뜨게 
		%>
				<button onclick="window.location='recipeModifyForm.jsp?num=<%=num %>&pageNum=<%=pageNum%>'">수정</button>
				<button onclick="window.location='recipeDeleteForm.jsp?num=<%=num %>&pageNum=<%=pageNum%>'">삭제</button>
		<%	
			} else if(!recipeBoard.getWriter().equals(session.getAttribute("memId"))){
				%> <button onclick="scrap(<%=num%>,'<%=memId%>',<%=scrapDAO.confirmScrap(num, memId)%>)">레시피 찜</button> 
					<button onclick="report('R','<%=num%>','<%=recipeBoard.getWriter()%>')">신고</button>
				<%
			}
		}
	%>	
		<button onclick="window.location='recipeList.jsp?pageNum=<%=pageNum%>'">목록</button>
	</div>
	<br/>
		<jsp:include page="../footer.jsp" flush="false"/>
</body>

<script>
	//댓글에 답댓글 달기
	function rating(num) {
		var width=150;
		var height=100;
		var wid = (window.screen.width / 2) - (width / 2);
		var hei = (window.screen.height / 2) - (height / 2);
		
		var url = "recipeRatingForm.jsp?num=" + num;
		var name = "평점 남기기";
		var option = "width=300,height=150,left="+wid+",top="+hei+",toolbar=no,menubar=no,location=no,scrollbar=no,status=no,resizable=no";
		
		window.open(url,name,option);
	}
	//레시피 찜하기
	function scrap(num, scraper,x) {
		if(x==false) {
			if(confirm("레시피를 찜하시겠습니까?")==true) {
				location.href="recipeScrap.jsp?num="+num+"&scraper="+scraper + "&pageNum=<%=pageNum%>&prePage=recipeContent";
			}
		} else {
			if(confirm("이미 찜한 레시피입니다. \n취소하시겠습니까?")==true) {
				location.href="recipeScrap.jsp?num="+num+"&scraper="+scraper+"&did=true&pageNum=<%=pageNum%>&prePage=recipeContent";
			}
		}
	}
	//신고 기능
	function report(code,commentNum,member) {
		if(confirm("이 글을 신고하시겠습니까?")==true) {
			var offenceCode = code+commentNum;
			location.href= "../member/offenceMember.jsp?offenceUrl="+offenceCode+"&member="+member;
		}		
	}
	//url 복사
	function CopyUrlToClipboard(){
		var f = document.clipboard.url;
		f.value = document.location.href;
		f.select() ;
		therange=f.createTextRange() ;
		therange.execCommand("Copy");
		alert("클립보드로 URL이 복사되었습니다.");
	}



	</script>
<%
	} %>
</html>