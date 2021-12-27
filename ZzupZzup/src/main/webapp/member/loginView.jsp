<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/layout/toolbar.jsp" />
<script>
    
    
    $(function(){
    	
    	$("#login").on("click", function(){
    		
    		let memberId = $("input[type=email]").val();
        	let password = $("input[type=password]").val();
        	
        	console.log("memberId:" + memberId);
        	console.log("password:" + password);
        	
        	$.ajax({
        	    url: "/member/json/login",
        	    method: "POST",
        	    dataType: "json",
        	    data: {
        	    	"memberId":memberId, 
        	    	"password":password
        	    },
        	    success : function(data){
        	      self.location("/main.jsp");
        	    },
        	    error : function(){
        	      alert("아이디 또는 비밀번호가 잘못 입력되었습니다. 다시 확인하여 주세요.");		
        	    }
        	});
    	});
    });
    
	</script>

<div class="container">
	<!-- 여기 안에 작성해주세요``~~~ -->

	<!-- Button trigger modal -->
	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#loginModal">로그인</button>

	<!-- Modal -->
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
							type="password" id="password" name="password"
							class="form-control" placeholder="비밀번호를 입력해주세요." required>
						<div class="checkbox mb-6">
							<label> <input type="checkbox" value="remember-me" /> 로그인
								유지
							</label>
						</div>
						<input class="btn btn-lg btn-primary btn-block" id="login"
							type="button" value="login" />
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

</div>

<%-- <jsp:include page="/layout/sidebar.jsp" /> --%>