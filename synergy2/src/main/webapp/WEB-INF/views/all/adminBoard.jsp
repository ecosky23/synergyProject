<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/adminBoard.css">
</head>
<body>
    
    <!-- 가운데 main 내용 -->
	
    <div id="wrap">
        
        <aside class="aside">
            <div class="aside_menu">
                <ul class="aside_menu_list">
                    <li class="aside_menu_top">Admin Menu</li>
                    <li class="aside_menu_list_1">
                        <img src="../resources/image/chartIcon3.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Statistics
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 80px;"/>
                    </li>
                    <li class="aside_menu_list_2">
                        <img src="../resources/image/chartIcon4.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Management
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 50px;"/>
                    </li>
                    <li class="aside_menu_list_3">
                        <img src="../resources/image/task2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Management
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 45px;"/>
                    </li>
                    <li class="aside_menu_list_4">
                        <img src="../resources/image/map2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Location Map
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 45px;"/>
                    </li>
                </ul>
            </div>
        </aside>
        
        
        <input type="checkbox" id="menuicon">
        <label for="menuicon">
            <span></span>
            <span></span>
            <span></span>
        </label>
        <div class="sidebar">
            <ul>
                <li class="sidebar_menu">Admin Menu</li>
                <li><a class="sidebar_menu_button"><img src="../resources/image/chartIcon.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Member
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; margin-left: 30px;"/>
                </a></li>
                <li><a class="sidebar_menu_button"><img src="../resources/image/chartIcon2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Programming
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>   
                <li><a class="sidebar_menu_button"><img src="../resources/image/task.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Management
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>
                <li><a class="sidebar_menu_button"><img src="../resources/image/map.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Location Map
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>
            </ul>
        </div>
        
        <header class="header">
            <div class="header_title">Admin Board</div>
        </header>
       
        <section class="section">
        
        	<div class="searchDiv">
	           <form action="/synergy2/all/getAdminBoard" method="get">
		            <select name="searchOption" id="searchOption">
		            	<option value="username">아이디</option>
		            	<option value="nickname">닉네임</option>
		            </select>
		            <input type="text" name="keyword" id="keyword">
		            <input type="submit" id="searchBtn" value="검색">
	        	
	        	</form>
        	</div>
        
            <div class="list_wrap">
                <ul class="list">
                    <li class="list_group">
                        <div class="nickname">닉네임</div>
                        <div class="username">아이디</div>
                        <div class="created">가입일</div>
                        <div class="button">버튼</div>    
                    </li>
                    <from name="memberDeleteForm" id="memberDeleteForm" method="post" action="">
                    <c:forEach var="memberDTO" items="${list}" varStatus="status">
                    <li class="list_group_main">
                        <div class="nickname" name="nickname"><c:out value="${memberDTO.nickname }"></c:out></div>
                        <div class="username" id="username${status.count}" name="username"><c:out value="${memberDTO.username }"></c:out></div>
                        <div class="created" name="created"><c:out value="${memberDTO.created }"></c:out></div>
                        <input type="hidden" id="username" name="username" value="${memberDTO.username}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="button"><input type="button" class="withdrawalBtn" id="withdrawalBtn${status.count}" value="회원 탈퇴"></div>  
                        
                    </li>
                    </c:forEach>
 					</from>
                </ul>
            </div>
           
         	<div class="paginationDiv">
        		<ul class="pagination"> 
        			<li><a href="/synergy2/all/getAdminBoard?nowpage=0&searchOption=${searchOption}&keyword=${keyword}">&lt;&lt;</a></li> 
        		<!--현재 페이지가 0보다 작아질 경우 이전 버튼을 disabled하는 조건문 --> 
        				<c:choose> 
        					<c:when test="${nowpage <= 0}"> 
        						<li class="disabled"><a href="#">&lt;</a></li> 
        					</c:when> 
        						<c:otherwise> 
        							<li><a href="/synergy2/all/getAdminBoard?nowpage=${nowpage-1}&searchOption=${searchOption}&keyword=${keyword}">&lt;</a></li> 
        						</c:otherwise> 
        				</c:choose> 
        				<!--해당하는 페이지로 갈 수 있는 버튼 --> 
        					<c:forEach var="i" begin="0" end="${totalpage}">
  									
									 <li><a href="/synergy2/all/getAdminBoard?nowpage=${i}&searchOption=${searchOption}&keyword=${keyword}">${i+1}</a></li> 									
        						 
        					</c:forEach>
        							<%-- <li><a href="/synergy2/all/getAdminBoard?nowpage=${i}&searchOption=${searchOption}&keyword=${keyword}">${i+1}</a></li> --%>  		
        				<!--현재 페이지가 totalpage보다 커질 경우 다음 버튼을 disabled하는 조건문 --> 
        				<c:choose> 
        					<c:when test="${nowpage >= totalpage }"> 
        							<li class="disabled"><a href="#">&gt;</a></li> 
        					</c:when> 
        						<c:otherwise> 
        							<li><a href="/synergy2/all/getAdminBoard?nowpage=${nowpage+1}&searchOption=${searchOption}&keyword=${keyword}">&gt;</a></li> 
        						</c:otherwise> 
     		   			</c:choose> 
        							<li><a href="/synergy2/all/getAdminBoard?nowpage=${totalpage}&searchOption=${searchOption}&keyword=${keyword}">&gt;&gt;</a></li> 
        		</ul>

         	  </div>
        	
        	
        	
        </section>
        <footer class="main_footer"></footer>
    </div>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

 	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = document.getElementById('_csrf').content;
	
	
 	
	let a = document.querySelectorAll('input.withdrawalBtn');
	
	
	for(let i = 0; i<a.length; i++){
		
		let username = a[i].parentElement.parentElement.children[1].innerText;
		
		console.log(username);
		
	    a[i].addEventListener('click', ()=> {    
	    
		let result = confirm("정말 탈퇴 시키시겠습니까?");
	    
		if(result){
		
	    $.ajax({
			type: 'post',
			url: '/synergy2/all/memberDelete',
			data: {'username' : username},
			
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(data){
				
				a[i].parentElement.parentElement.remove();
				
				
			},
			error: function(err){
				console.log(err);
			}
		
		});
	    
		
		}
		
		
	    }
	    
	    )
	}//회원 탈퇴
	


	    	
	
</script>
</body>
</html>