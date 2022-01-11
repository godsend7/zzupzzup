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
	$(function() {
		console.log("setPassword.jsp");
		
		var id = "${param.memberId}";
		var pwd = $("#pwd").val();
		var checkPwd = $("#checkPwd").val();
		
		$("input[type=button]").on("click", function() {
			alert("id : "+id+", pwd : "+pwd+", checkPwd : "+checkPwd);
			if(pwd != null && checkPwd != null && pwd === checkPwd) {
				$("#set-password").attr("method", "POST").attr("action", "/member/setPassword").submit();
			}
		})
		
	});
	
	//비밀번호 일치 확인
	function pwdCheckFunction() {
		var pwd = $("#pwd").val();
		var checkPwd = $("#checkPwd").val();

		var pattern1 = /[0-9]/;
		var pattern2 = /[a-zA-Z]/i;
		
		if (pwd == "") {	//비밀번호가 비었을 때
			$("#checkPwdMsg").text("비밀번호를 입력해주세요.");
		} else {
			if ( ! pattern1.test(pwd) || ! pattern2.test(pwd) || pwd.length < 8) {
				$("#checkPwdMsg").text("비밀번호 형식에 맞춰 다시 입력해주세요.");	//비밀번호 형식 확인(알파벳 대소문자, 숫자, 특수문자)
			} else {
				if (pwd != checkPwd) {
					$("#checkSamePwdMsg").text("비밀번호가 일치하지 않습니다.");
				} else {
					$("#checkSamePwdMsg").text("");
				}
			}
		}
	}
</script>
</head>

<body class="is-preload">

	<!-- S:Wrapper -->
	<div id="wrapper">

		<!-- S:Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<%-- <jsp:include page="/layout/header.jsp" /> --%>
				<header id="header">
					<a href="/" class="logo">
						<strong><svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="currentColor" class="bi bi-piggy-bank" viewBox="0 0 16 16">
				  		<path d="M5 6.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0zm1.138-1.496A6.613 6.613 0 0 1 7.964 4.5c.666 0 1.303.097 1.893.273a.5.5 0 0 0 .286-.958A7.602 7.602 0 0 0 7.964 3.5c-.734 0-1.441.103-2.102.292a.5.5 0 1 0 .276.962z"/>
				  		<path fill-rule="evenodd" d="M7.964 1.527c-2.977 0-5.571 1.704-6.32 4.125h-.55A1 1 0 0 0 .11 6.824l.254 1.46a1.5 1.5 0 0 0 1.478 1.243h.263c.3.513.688.978 1.145 1.382l-.729 2.477a.5.5 0 0 0 .48.641h2a.5.5 0 0 0 .471-.332l.482-1.351c.635.173 1.31.267 2.011.267.707 0 1.388-.095 2.028-.272l.543 1.372a.5.5 0 0 0 .465.316h2a.5.5 0 0 0 .478-.645l-.761-2.506C13.81 9.895 14.5 8.559 14.5 7.069c0-.145-.007-.29-.02-.431.261-.11.508-.266.705-.444.315.306.815.306.815-.417 0 .223-.5.223-.461-.026a.95.95 0 0 0 .09-.255.7.7 0 0 0-.202-.645.58.58 0 0 0-.707-.098.735.735 0 0 0-.375.562c-.024.243.082.48.32.654a2.112 2.112 0 0 1-.259.153c-.534-2.664-3.284-4.595-6.442-4.595zM2.516 6.26c.455-2.066 2.667-3.733 5.448-3.733 3.146 0 5.536 2.114 5.536 4.542 0 1.254-.624 2.41-1.67 3.248a.5.5 0 0 0-.165.535l.66 2.175h-.985l-.59-1.487a.5.5 0 0 0-.629-.288c-.661.23-1.39.359-2.157.359a6.558 6.558 0 0 1-2.157-.359.5.5 0 0 0-.635.304l-.525 1.471h-.979l.633-2.15a.5.5 0 0 0-.17-.534 4.649 4.649 0 0 1-1.284-1.541.5.5 0 0 0-.446-.275h-.56a.5.5 0 0 1-.492-.414l-.254-1.46h.933a.5.5 0 0 0 .488-.393zm12.621-.857a.565.565 0 0 1-.098.21.704.704 0 0 1-.044-.025c-.146-.09-.157-.175-.152-.223a.236.236 0 0 1 .117-.173c.049-.027.08-.021.113.012a.202.202 0 0 1 .064.199z"/>
						</svg> ZZUPZZUPDUCE_101</strong>
					</a>
				</header>
				
				<section id="set-password-jsp">
					<div class="container">
						
						<form id="set-password" class="col-md-12">
							<input type="hidden" name="memberId" value="${param.memberId}"/>
							<h2>비밀번호 재설정</h2><hr/>
							<br/><br/><br/>
							<div class="col-md-12 form-row">
								<label for="password" class="col-md-2">새로운 비밀번호</label>
								<input type="password" id="pwd" name="password" class="col-md-5" maxlength="15"/>
								<span id="checkPwdMsg" style="color: red; font-weight: bold"></span>
							</div>
							<br/><br/>
							<div class="col-md-12 form-row">
								<label for="checkPwd" class="col-md-2">비밀번호 확인</label>
								<input type="password" id="checkPwd" class="col-md-5" maxlength="15"/>
							</div>
							<br/><br/>
							<div class="col-md-12">
								<input type="button" value="비밀번호 변경" style="float:right;">
								<span id="checkSamePwdMsg" style="color: red; font-weight: bold"></span>
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