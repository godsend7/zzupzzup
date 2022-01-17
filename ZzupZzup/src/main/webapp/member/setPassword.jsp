<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-setPassword</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	var checkPwdFlag;
	var checkSamePwdFlag;
	
	$(function() {
		console.log("setPassword.jsp");
		
		var id = "${param.memberId}";
		var pwd = $("#pwd").val();
		var checkPwd = $("#checkPwd").val();
		
		//비밀번호 유효성 체크
		$("#pwd").keyup(function() {
			var pattern1 = /[0-9]/;
			var pattern2 = /[a-zA-Z]/i;
			
			if (pwd == "" || pwd == null) {	//비밀번호가 비었을 때
				$("#checkPwdMsg").text("비밀번호를 입력해주세요.");
				checkPwdFlag = false;
			} else {
				if ( ! pattern1.test(pwd) || ! pattern2.test(pwd) || pwd.length < 8) {
					console.log("형식 이거 안 타나?");
					$("#checkPwdMsg").text("비밀번호 형식에 맞춰 다시 입력해주세요.");	//비밀번호 형식 확인(알파벳 대소문자, 숫자, 특수문자)
					checkPwdFlag = false;
				} else {
					console.log("너도 안 되니?");
					$("#checkPwdMsg").text("");
					checkPwdFlag = true;
				}
			}
		});
		
		//비밀번호 일치 여부 체크
		$("#checkPwd").keyup(function() {
			if (pwd != checkPwd) {
				$("#checkSamePwdMsg").text("비밀번호가 일치하지 않습니다.");
				checkSamePwdFlag = false;
			} else {
				$("#checkSamePwdMsg").text("");
				checkSamePwdFlag = true;
			}
		});
		
		$("input[type=button]").on("click", function() {
			//alert("id : "+id+", pwd : "+pwd+", checkPwd : "+checkPwd);
			if(checkPwdFlag && checkSamePwdFlag) {
				$("#set-password").attr("method", "POST").attr("action", "/member/setPassword").submit();
			}
		})
		
	});
	
</script>
</head>

<body class="is-preload">

	<!-- S:Wrapper -->
	<div id="wrapper">

		<!-- S:Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<jsp:include page="/layout/header.jsp" />
				
				<section id="set-password-jsp">
					<div class="container">
						
						<form id="set-password" class="col-md-12">
							<input type="hidden" name="memberId" value="${param.memberId}"/>
							<h2>비밀번호 재설정</h2><hr/>
							<br/><br/><br/>
							<div class="col-md-12 form-row" align="center">
								<label for="password" class="col-md-2">새로운 비밀번호</label>
								<input type="password" id="pwd" name="password" class="col-md-5" maxlength="15"/>
								<span id="checkPwdMsg" class="col-md-12" style="color: red; font-weight: bold"></span>
							</div>
							<br/><br/>
							<div class="col-md-12 form-row" align="center">
								<label for="checkPwd" class="col-md-2">비밀번호 확인</label>
								<input type="password" id="checkPwd" class="col-md-5" maxlength="15"/>
								<span id="checkSamePwdMsg" class="col-md-12" style="color: red; font-weight: bold"></span>
							</div>
							<br/><br/>
							<div class="col-md-12" align="center">
								<input type="button" class="button primary" value="비밀번호 변경" style="float:right;">
							</div>
						</form>
						
					</div>
				</section>
			</div>
		</div>
		<!-- E:Main -->
		
		<!-- Sidebar -->
		<%-- <jsp:include page="/layout/sidebar.jsp" /> --%>
	</div>
	<!-- E:Wrapper -->
</body>
</html>