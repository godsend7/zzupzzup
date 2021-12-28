<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-addMember</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">

	function parseURI() {
		
		var url = window.location.href;
		var result = null;
		
		console.log(url);
		
		if(url.indexOf("owner")) {
			result = "owner";
		} else {
			result = "user";
		}
		
		return result;
	}

	function fncAddMember() {
		
		let name = $("input[id=memberName]").val();
		let id = $("input[id=memberId]").val();
		let pwd = $("input[id=password]").val();
		
		var memberRole = parseURI();
		
		$("#addMember").attr("method" , "POST").attr("action" , "/member/addMember").submit();
	}

	$(function() {
		console.log("addMember.jsp");
		console.log(parseURI());
		
		console.log('${param.memberRole}');
		
		$("input[value='회원가입']").on("click", function() {
			fncAddMember();
		})
		
		$("input[value='취소']").on("click", function() {
			location.href = "/main.jsp";
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
				<%-- <jsp:include page="/layout/header.jsp" /> --%>
				<header id="header">
					<strong>쩝쩝듀스101 회원가입</strong>
				</header>

				<section id="addMember">
					<div class="container">
						<div>
							<form class="needs-validation" id="addMember" novalidate>
								<div>
									<label for="memberName">이름</label>
									<input type="text" class="col-sm-offset-1 col-sm-3 control-label" id="memberName" value="" required>
									<div class="invalid-feedback">이름은 반드시 입력해야 합니다.</div>
								</div>
								<br/>
								<div>
									<label for="email">아이디</label>
									<input type="email" class="form-control" id="email" placeholder="example@zzupzzup.com" style="width:300px" required>&nbsp;
									<input type="button" value="중복확인"/>
									<div class="invalid-feedback">아이디는 반드시 입력해야 합니다.</div>
								</div>
								<br/>
								<div>
									<label for="password">비밀번호</label>
									<input type="password" class="form-control" id="password" placeholder="8-15자 이내로 입력해주세요." style="width:250px" required>
									<div class="invalid-feedback">비밀번호는 반드시 입력해야 합니다.</div>
								</div>
								<br/>
								<div>
									<label for="checkPassword">비밀번호 확인</label>
									<input type="password" class="form-control" id="checkPassword" placeholder="비밀번호를 다시 입력해주세요." style="width:250px" required>
									<div class="invalid-feedback">비밀번호는 반드시 입력해야 합니다.</div>
								</div>
								<br/>
								<div>
									<label for="memberPhone1">전화번호</label>
									<input type="text" class="form-control" id="memberPhone1" required>&nbsp;-&nbsp;
									<input type="text" class="form-control" id="memberPhone2" required>&nbsp;-&nbsp;
									<input type="text" class="form-control" id="memberPhone3" required>&nbsp;
									<input type="button" value="인증번호 전송"/>
									<div class="invalid-feedback">전화번호는 반드시 입력해야 합니다.</div>
									
									<label for="certificeatedNum">인증번호</label>
									<input type="text" class="form-control" id="certificeatedNum" required>&nbsp;
									<input type="button" value="확인"/>
									<div class="invalid-feedback">인증번호는 반드시 입력해야 합니다.</div>
								</div>
								<br/>
								<div>
									<label for="profileImage">프로필 이미지</label>
									<input type="text" class="form-control" id="profileImage">
								</div>
								<br/>
								<c:if test="${param.memberRole == 'user'}">
								<div>
									<label for="nickname">닉네임</label>
									<input type="text" class="form-control" id="nickname" placeholder="10자 이내로 입력해주세요." required>&nbsp;
									<input type="button" value="중복확인"/>
									<div class="invalid-feedback">닉네임은 반드시 입력해야 합니다.</div>
								</div>
								<br/>
								<div>
									<label for="stateMessage">자기소개 및 특이사항</label>
									<textarea class="form-control" id="stateMessage" placeholder="100자 이내로 자유롭게 기술해주세요." rows="3"></textarea>
								</div>
								<br/>
								<div>
									<label for="pushNickname">추천인 닉네임</label>
									<input type="text" class="form-control" id="pushNickname" placeholder="10자 이내로 입력해주세요.">
								</div>
								</c:if>
								<hr class="mb-4">
								<div class="custom-control custom-checkbox">
									<input type="checkbox" class="custom-control-input"
										id="same-address"> <label
										class="custom-control-label" for="same-address">Shipping
										address is the same as my billing address</label>
								</div>
								<div class="custom-control custom-checkbox">
									<input type="checkbox" class="custom-control-input"
										id="save-info"> <label class="custom-control-label"
										for="save-info">Save this information for next time</label>
								</div>
							</form>
							<hr class="mb-4">
							<input type="button" class="btn btn-lg btn-primary" value="취소"></input>
							<c:if test="${param.memberRole == 'user'}">
								<input type="button" class="btn btn-lg btn-primary" value="회원가입"></input>
							</c:if>
							<c:if test="${param.memberRole == 'owner'}">
								<input type="button" class="btn btn-lg btn-primary" value="다음"></input>
							</c:if>
						</div>
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