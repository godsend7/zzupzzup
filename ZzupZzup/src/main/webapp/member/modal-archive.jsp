<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- kakao login api cdn -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script type="text/javascript">
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
		
		//login type == 1
		$("#kakaoLogin").on("click", function() {

			let memberId = $("input[type=email]").val();
			let password = $("input[type=password]").val();

			console.log("memberId:" + memberId);
			console.log("password:" + password);

			$.ajax({
				url : "/member/json/kakaoLogin",
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
		
		//logout
		$("#logout").on("click", function() {
			$(self.location).attr("href", "/member/logout");
		});
		
	});
	
	//login type == 2 (kakao)
	Kakao.init('e2b092b99c10982f7e28b410d1b6a8f4'); // set kakao app javascript key
	console.log(Kakao.isInitialized()); // check sdk initialized
	
	//*login kakao
	function kakaoLogin() {
	    Kakao.Auth.login({
	      success: function (response) {
	        Kakao.API.request({
	          url: '/v2/user/me',
	          success: function (response) {
	        	  console.log(response)
	          },
	          fail: function (error) {
	            console.log(error)
	          },
	        })
	      },
	      fail: function (error) {
	        console.log(error)
	      },
	    })
	  }
	
	//*logout kakao  
	function kakaoLogout() {
	    if (Kakao.Auth.getAccessToken()) {
	      Kakao.API.request({
	        url: '/v1/user/unlink',
	        success: function (response) {
	        	console.log(response)
	        },
	        fail: function (error) {
	          console.log(error)
	        },
	      })
	      Kakao.Auth.setAccessToken(undefined)
	    }
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
				<form class="form-signin">
					<!-- <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
					<h6 class="h6 mb-6 font-weight-normal">로그인 후 이용하여 주십시오.</h6>
					<label for="memberId" class="sr-only">Email address</label> <input
						type="email" id="memberId" name="memberId" class="form-control"
						placeholder="example@zzupzzup.com" required autofocus> <label
						for="password" class="sr-only">Password</label> <input
						type="password" id="password" name="password" class="form-control"
						placeholder="비밀번호를 입력해주세요." required>
						<br/>
					<div class="checkbox mb-6">
						<input type="checkbox" class="custom-control-input" id="persistLogin" value="" /> 
						<label for="persistLogin">로그인 유지(구현 예정)</label>
					</div>
					<br/>
					<input class="btn btn-lg btn-primary btn-block" id="login"
						type="button" value="login" /> <input
						class="btn btn-lg btn-primary btn-block" id="kakaoLogin"
						type="button" value="카카오 로그인 (구현 예정)" /> <input
						class="btn btn-lg btn-primary btn-block" id="naverLogin"
						type="button" value="네이버 로그인 (구현 예정)" /><br/><br/>
						회원이 아니신가요? > 
						<a href="/member/addMember/user/1">유저</a>&nbsp;/
						<a href="/member/addMember/owner/1">업주</a>
					<p class="mt-5 mb-3 text-muted">&copy; 2017-2021</p>
				</form>
			</div>
			<!-- <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary"></button>
		    </div> -->
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
			<div class="modal-body">
				<form class="form-signin">
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
						type="button" value="login" /> <input
						class="btn btn-lg btn-primary btn-block" id="kakaoLogin"
						type="button" value="카카오 로그인 (구현 예정)" /> <input
						class="btn btn-lg btn-primary btn-block" id="naverLogin"
						type="button" value="네이버 로그인 (구현 예정)" /><br/><br/>
						회원이 아니신가요? > 
						<a href="/member/addMember/user/1">유저</a>&nbsp;/
						<a href="/member/addMember/owner/1">업주</a>
					<p class="mt-5 mb-3 text-muted">&copy; 2017-2021</p>
				</form>
			</div>
			<!-- <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary"></button>
		    </div> -->
		</div>
	</div>
</div>
