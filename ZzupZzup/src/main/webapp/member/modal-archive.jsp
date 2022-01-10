<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- kakao login api cdn -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script type="text/javascript">

	Kakao.init('e2b092b99c10982f7e28b410d1b6a8f4');							// initialize Kakao SDK
	console.log("Is Kakao SDK inintailized? :: "+Kakao.isInitialized());	// check Kakao SDK initailized

	$(function() {
		console.log("loginView.jsp");

		//login type == 1
		$("#login").on("click", function() {

			let memberId = $("input[type=email]").val();
			let password = $("input[type=password]").val();

			console.log("memberId:" + memberId);
			console.log("password:" + password);

			$.ajax({
				url : "/member/json/login",
				method : "POST",
				contentType : 'application/json',
				dataType : "json",
				data : JSON.stringify({
					"memberId" : memberId,
					"password" : password
				}),
				success : function(data) {
					if (data != null) {
						//main.jsp로 이동
						location.href = "/";
					}
				},
				error : function() {
					alert("아이디 또는 비밀번호가 잘못 입력되었습니다. 다시 확인하여 주세요.");
				}
			});
		});
		
		//login type == 2
		$("#kakaoLogin").on("click", function() {

			// 로그인 시도
		    Kakao.Auth.loginForm({
		        success: function(authObj) {
		          console.log(JSON.stringify(authObj));
		          console.log(Kakao.Auth.getAccessToken());
		          
		          var accessToken = authObj.access_token;
	              var refreshToken = authObj.refresh_token;
		        
		          // 로그인 성공 시 API 호출
		          Kakao.API.request({
		            url: '/v2/user/me',
		            success: function(result) {
		              alert(JSON.stringify("[result] clientId : "+result.id+", memberId : "+result.kakao_account.email+", gender : "+result.kakao_account.gender+", age_range : "+result.kakao_account.age_range+", access_token : "+accessToken+", refresh_token : "+refreshToken));
		              
		              var clientId = result.id;
		              var memberId = result.kakao_account.email;
		              var gender = result.kakao_account.gender;
		              var age = result.kakao_account.age_range;
		              
		              $.ajax({
		                  url : "/member/json/checkIdDuplication?memberId="+memberId,
		                  method : "POST",
		                  headers : {
		                      "Accept" : "application/json",
		                      "Content-Type" : "application/json"
		                    },
		                  data : {
		                	  "memberId" : memberId
		                	},
		                  success : function(checkId){
		                      
		                      if(checkId) { //DB에 아이디가 없을 경우 => 회원가입
		                          console.log("DB 정보 없음");
		                          $("#login-view").after("<form id='kakao-login-value'>"
		              									+"<input type='hidden' name='memberId' value='"+memberId+"'>"
		              									+"<input type='hidden' name='gender' value='"+gender+"'>"
		              									+"<input type='hidden' name='age' value='"+age+"'>"
		                  								+"</form>");
		                          $("#kakao-login-value").attr("method","GET").attr("action","/member/addMember/user/2").submit();
		                          
		                      } else { //DB에 아이디가 존재할 경우 => 로그인
		                          console.log("DB 정보 있음");
		                          $.ajax({
		              				url : "/member/json/kakaoLogin",
	                				method : "POST",
	                				contentType : 'application/json',		                				
	                				dataType : "json",
		                			data : JSON.stringify({
		                				"memberId" : memberId
		                			}),
		                			success : function(data) {
		               					if (data != null) {
		               						//main.jsp로 이동
		               						location.href = "/";
		               					}
		               				}
		               			});
		                      }
		                  }
		              })
		            },
		            fail: function(error) {
		              alert(JSON.stringify(error));
		            }
		          });
		                  
		        },
		        fail: function(err) {
		          alert(JSON.stringify(err));
		        }
		      });
			
		});
		
		//logout
		$("#logout").on("click", function() {
			if(${member.loginType == 1}){
				$(self.location).attr("href", "/member/logout");
			} else if(${member.loginType == 2}) {
				logoutFromKakao();
				$(self.location).attr("href", "/member/logout");
			}
			
		});
		
		//계정 찾기 클릭 시 로그인 모달 닫기
		$("#findAccountModal-nav").on("click", function() {
			$("#loginModal").modal("hide");
		})
		
	});
	
	//*logout kakao  
	function logoutFromKakao() {
		
	    if (Kakao.Auth.getAccessToken()) {
	      Kakao.Auth.logout(function() {})
	    } else {
	    	alert("로그인 상태가 아닙니다.");
	    	return;
	    }
	  }  
	
	//*unlink kakao  
	function unlinkKakao() {
		Kakao.API.request({
		  url: '/v1/user/unlink',
		  success: function(response) {
		    console.log(response);
		  },
		  fail: function(error) {
		    console.log(error);
		  },
		});
	  }
	
	function fncPageNavigation(category) {
		
	    if (category == null) {
			category = ${category};
		}
	   
	    $("#report").attr("action","/report/listReport?reportCategory="+category).attr("method", "POST").submit();
	}
</script>



<!-- login modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
	aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title" id="loginModalLabel">회원 로그인</h2>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form class="form-signin" id="login-view">
					<!-- <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
					<h6 class="h6 mb-6 font-weight-normal">로그인 후 이용하여 주십시오.</h6>
					<label for="memberId" class="sr-only">Email address</label> <input
						type="email" id="memberId" name="memberId" class="form-control"
						placeholder="example@zzupzzup.com" required autofocus> <label
						for="password" class="sr-only">Password</label> <input
						type="password" id="password" name="password" class="form-control"
						placeholder="비밀번호를 입력해주세요." required>
					<br/>
					<input class="btn btn-lg btn-primary btn-block" id="login"
						type="button" value="login" /> 
					<a id="kakaoLogin" href="#">
					  <img
					    src="/resources/images/common/kakao_login_medium_wide.png"
					    width="250"
					    alt="카카오 로그인 버튼"
					  />
					</a>
					<!-- <input
						class="btn btn-lg btn-primary btn-block" id="kakaoLogin"
						type="button" value="카카오 로그인 (구현 예정)" /> -->
					<input
						class="btn btn-lg btn-primary btn-block" id="naverLogin"
						type="button" value="네이버 로그인 (구현 예정)" /><br/><br/>
					<div align="right">
						회원이 아니신가요? > 
						<a href="/member/addMember/user/1">유저</a>&nbsp;/
						<a href="/member/addMember/owner/1">업주</a>
					</div>
					<div align="right">
						<a id="findAccountModal-nav" data-dismiss="#loginModal" data-toggle="modal" data-target="#findAccountModal" href="#findAccount">아이디/비밀번호 찾기 ></a>
					</div>
					<!-- <p class="mt-5 mb-3 text-muted">&copy; 2017-2021</p> -->
				</form>
			</div>
		</div>
	</div>
</div>

<!-- ID, PWD 찾기 modal -->
<div class="modal fade" id="findAccountModal" tabindex="-1" role="dialog"
	aria-labelledby="findAccountModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title" id="findAccountModalLabel">계정 찾기</h2>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" align="center">
				<form id="findAccount">
					<ul class="nav nav-tabs findAccount-top-tabs">
					  	<li class="nav-item">
					    	<a class="nav-link" href="javascript:fncPageNavigation(1)">아이디 찾기</a>
					  	</li>
					  	<li class="nav-item">
					    	<a class="nav-link" href="javascript:fncPageNavigation(2)">비밀번호 찾기</a>
					  	</li>
					</ul>
					
				</form>
			</div>
			<!-- <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary"></button>
		    </div> -->
		</div>
	</div>
</div>
