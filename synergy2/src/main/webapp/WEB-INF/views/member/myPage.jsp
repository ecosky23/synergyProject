<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>    
    <title>MyPage</title>
    <link rel="stylesheet" href="../resources/css/myPage.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.2/dist/sweetalert2.all.min.js"></script>
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
                    	
                    	
                      	<input type="hidden" id="username" name="username" value="${memberDTO.username}">
                      	
                        <div class="withdrawBtn"><button id="withdrawBtn">회원 탈퇴</button>  
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

var btn = document.getElementById("withdrawBtn");

btn.onclick = async function(){


	var csrfHeaderName = document.getElementById('_csrf_header').content;
	var csrfTokenValue = document.getElementById('_csrf').content;

	await Swal.fire({
		  title: '회원을 탈퇴 하시겠습니까?',
		  text: "모든 개인 정보가 삭제됩니다. ",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  cancelButtonText: '취 소',
		  confirmButtonText: '회원 탈퇴'
		}).then((result) => {
		  if (result.value) {
			  
			  const { value: password } = Swal.fire({
				  title: '비밀번호를 입력해 주세요',
				  input: 'password',
				  inputPlaceholder: '비밀번호를 입력해 주세요',
				  inputAttributes: {
				    maxlength: 10,
				    autocapitalize: 'off',
				    autocorrect: 'off'
				  }
				}).then((res)=>{
					//비번 입력 후 ok
					if	(res.isConfirmed) {
						let username = document.getElementById('username').value;
						
						$.ajax({
							type: 'post',
							url: '/synergy2/member/withdrawal',
							data: {'username' : username,
									'password' : res.value},
							beforeSend:function(xhr){
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},
							success: function(data){
								
							//alert(data);	
								
							if(data == 'equal'){

								Swal.fire({
									  icon: 'success',
									  title: '회원 탈퇴 성공',
									  text: '지금까지 이용해 주셔서 감사합니다.',
								}).then((result) => {
									
									location.href="/synergy2/all/loginForm";
								
								})

								
							}else{
								
								Swal.fire({
									  icon: 'error',
									  title: '비번이 틀렸습니다.',
									  text: '다시 입력해 주세요',
								})
								
								
							}
							
								
							},
							error: function(err){
								console.log(err);
							}		
									
						});
						
						
						
					//비번 입력 중단
					}else {
						Swal.fire('취소', '입력을 취소하셨습니다', 'error');
					}
				});
			 
				
		  }
		})
	
	
	
}


</script>
<script type="text/javascript">

$('#reviseBtn').click(function(){

	var csrfHeaderName = document.getElementById('_csrf_header').content;
	var csrfTokenValue = document.getElementById('_csrf').content;	
	
	
$('#pwdDiv').empty();	
$('#nicknameDiv').empty();
	
let password = $('#password').val();
let repwd = $('#repwd').val();
let nickname = $('#nickname').val();
let username = document.getElementById('username').value;
	
	if(password != repwd){
		
		$('#pwdDiv').text("비밀번호를 동일하게 입력해 주세요").css("color", "red").css("font-size", "8pt").css("font-weight", "bold");	
		
	}else if(nickname == null || nickname == ""){
	
		$('#nicknameDiv').text("닉네임을 입력해 주세요").css("color", "red").css("font-size", "8pt").css("font-weight", "bold");
	
	}else{
		
		
		$.ajax({
			
			type: 'post',
			url: '/synergy2/member/revise',
			data: {'username':username,
					'password':password,
					'nickname':nickname },
			beforeSend:function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(data){

				if(data =='onlyNickname'){
					
					Swal.fire({
						  icon: 'success',
						  title: '닉네임 변경 완료',
						  text: '닉네임이 변경 되었습니다.',
					}).then((result) => {
						
						location.href="/synergy2/member/welcome";
					
					})
					
				}else if(data =='fail'){
					
					Swal.fire({
						  icon: 'error',
						  title: '닉네임 중복',
						  text: '닉네임이 중복 됩니다.',
					})
					
				}else if(data =='onlyPassword'){
					Swal.fire({
						  icon: 'success',
						  title: '비밀번호 변경 완료',
						  text: '닉네임 중복 : 변경을 원하시면 다시 확인해 주세요.',
					}).then((result) => {
						
						location.href="/synergy2/member/welcome";
					
					})
					
				}else if(data == 'dualSuccess'){
					Swal.fire({
						  icon: 'success',
						  title: '비밀번호 닉네임 변경 완료',
						  text: '비밀번호와 닉네임이 변경 되었습니다.',
					}).then((result) => {
						
						location.href="/synergy2/member/welcome";
					
					})
				}
				
			},
			error: function(err){
				console.log(err);
			}
					
		});
		
		
	}
	
});

</script>
</body>
</html>