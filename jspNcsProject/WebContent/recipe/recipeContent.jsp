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
<title>Recipe Content</title>
<link rel="stylesheet" href="../resource/team05_style.css">
 

</head>
<%
	request.setCharacterEncoding("UTF-8");
	String memName = (String)session.getAttribute("memName");
	int num = Integer.parseInt(request.getParameter("num"));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
	
	RecipeDAO recipeDAO = RecipeDAO.getInstance();
	RecipeDTO recipeBoard = new RecipeDTO();
	
	
	recipeBoard = recipeDAO.selectRecipeBoard(num);
	int contentNum = recipeBoard.getRecipeStep();
	
	RecipeContentDTO recipeContentdto = new RecipeContentDTO();
	RecipeContentDAO recipeContentdao = RecipeContentDAO.getInstance();
	
	// recipeContentList : 레시피 조리단계  담아준 리스트 -> for문 돌려서 뽑기
	List recipeContentList = recipeContentdao.selectRecipeContent(num);
	
	for(int i = 0; i < recipeContentList.size(); i++){
		recipeContentdto = (RecipeContentDTO)recipeContentList.get(i);
		System.out.println(recipeContentdto.getContent());		
	}
	
	// 조리단계 댓글 dao
	RecipeContentCommentDAO dao = null;

%>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br />
	<h1 align="center">   content </h1>
	
	<table border="1">
		<tr >
			<td colspan="4">
				<img src="../imgs/beach.jpg %>" />
			</td>
		</tr>
		<tr>
			<td colspan="4">
				 레시피 제목 : <%= recipeBoard.getRecipeName() %>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				채식주의 타입 : <%= recipeBoard.getVegiType() %>
			</td>
		</tr>
		<tr>
			<td>
				인분 : <%= recipeBoard.getQuantity() %>
			</td>
			<td>
				소요시간 : <%= recipeBoard.getCookingTime() %>
			</td>
			<td>
				난이도 : <%= recipeBoard.getDifficulty() %>
			</td>
			<td>
				칼로리 : <%= recipeBoard.getCal() %>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				평점 관련 
			</td>
			<%-- 작성자는 닉네임으로 --%>
			<td colspan="2">
				작성자 : <%= recipeDAO.selectNameById(recipeBoard.getWriter()) %>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				키워드 탭
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				재료 탭
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				추천 제품 탭
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				<jsp:include page="recipeStepComment.jsp" flush="false"/>
		<tr>
			<td colspan="4">
				댓글 탭
			</td>			
		</tr>
	</table>
	<br /><br />
	<div align="center">
	<%
		if(recipeBoard.getWriter().equals(session.getAttribute("memId")) || session.getAttribute("memId").equals("admin")){
			// 관리자거나 레시피 글쓴이면 레시피 자체에 대한 수정 삭제 뜨게 
	%>
			<button onclick="window.location='recipeModifyForm.jsp?num=<%=num %>'">수정</button>
			<button onclick="window.location='recipeDeleteForm.jsp?num=<%=num %>'">삭제</button>
	<%	
		}	
	%>	
		<button onclick="window.location='recipeList.jsp'">목록</button>
	</div>
</body>
</html>