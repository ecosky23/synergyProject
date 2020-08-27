<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyPage</title>
    <link rel="stylesheet" href="../resources/css/myPage.css">
</head>
<body>

<div id=body_wrapper>
        <div id="loginBar_wrapper">
            <div id="loginBar" class="container">
                <a href="#">회원가입</a>
                <a href="#">로그인</a>
            </div>
        </div>
        <div id=header_wrapper>
			<header id="header" class="container">
                <!-- 로고 -->
				<div id="logo">
					<a href="#"><img alt="" style="width:155px;height:55px;" src="../resources/image/logo.png"/></a>
                </div>
                <!-- nav -->
				<nav id="nav">
					<ul>
						<li class="welcome" style="white-space: nowrap;">
							<a href="#">Welcome</a>
						</li>
						<li class="matching" style="white-space: nowrap;">
							<a href="#">스터디 매칭</a>
						</li>
						<li class="menu1" style="white-space: nowrap;">
							<a href="#">스터디 모집</a>
						</li>
						<li class="menu2" style="white-space: nowrap;">
							<a href="#">메뉴</a>
						</li>
						<li class="menu3" style="white-space: nowrap;">
							<a href="#" >문의</a>
						</li>
					</ul>
				</nav>
			</header>
        </div>
        <!-- 가운데 main 내용 -->
        <div id="content_wrapper">
			<header class="content_header">
                <div class="header_label">개인정보 관리</div>
            </header>
			<aside class="content_aside"></aside>
            <section class="content_section">
                <table>
                    <tbody>
                        <tr>
                            <th class="table_left">아이디</th>
                            <td class="id_label">${memberDTO.username}</td>
                        </tr>
                        <tr>
                            <th class="table_left">비밀번호</th>
                            	<form name="reviseForm" id="reviseForm" method="post" action="/synergy2/member/revise">
                            <td class="table_right">
                            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            	<input type="hidden" id="username" name="username" value="${memberDTO.username}">
                                <input type="password" name="password" id="password" placeholder="비밀번호 입력">
                                
                                <div id="pwdDiv"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_left">비밀번호 재입력</th>
                            <td class="table_right">
                                <input type="password" name="repwd" id="repwd" placeholder="한번 더 입력해 주세요">
                            </td>
                        </tr>
                        <tr>
                            <th class="table_left_bottom"><span class="nickName_star">*  </span>닉네임</th>
                            <td class="table_right_bottom">
                                <input type="text" name="nickname" id="nickname" value="${memberDTO.nickname}">
                                <span class="nickName_re">닉네임을 입력하세요</span>
                                <div id="nicknameDiv"></div>
                            </td>
                        </tr>
                            </form>
                        
                    </tbody>
                </table>
                <div class="buttonDiv">
                    <input type="button" id="reviseBtn" value="수정">
                    <input type="reset" id="resetBtn" value="취소"> 
                </div>
                <div class="withdrawDiv">
                    
                    <div class="withdrawDiv_label">
                    	<form name="withdrawalForm" id="withdrawalForm" method="post" action="/synergy2/member/withdrawal">
                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                      	<input type="hidden" id="username" name="username" value="${memberDTO.username}">
                      	</form>
                        <div class="withdrawBtn"><input type="button" value="회원 탈퇴" id="withdrawBtn">  
                        </div>    
                    </div>
                </div>
            </section>
            <article class="content_article"></article>
			<footer class="content_footer"></footer>
		</div>
	</div>
<form method="post" action="/synergy2/logout" >
	<button name="logout" id="logout" value="logout">logout</button>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

$('#reviseBtn').click(function(){

$('#pwdDiv').empty();	
$('#nicknameDiv').empty();
	
let pwd = $('#password').val();
let repwd = $('#repwd').val();
let nickname = $('#nickname').val();

	
	if(pwd != repwd){
		
		$('#pwdDiv').text("비밀번호를 동일하게 입력해 주세요").css("color", "red").css("font-size", "8pt").css("font-weight", "bold");	
		
	}else if(nickname == null || nickname == ""){
	
		$('#nicknameDiv').text("닉네임을 입력해 주세요").css("color", "red").css("font-size", "8pt").css("font-weight", "bold");
	
	}else{
		document.forms[0].submit();	
	}
	
});

$('#withdrawBtn').click(function(){
	
let withdrawal = confirm("정말 회원을 탈퇴 하시겠습니까?");

	if(withdrawal){
		document.forms[1].submit()
	}
});


</script>
</body>
</html>