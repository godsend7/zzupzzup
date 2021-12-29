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
	
	//양식 유효성 확인
	function fncCheckAccountForm() {
		var name = $("#memberName").val();
		var id = $("memberId").val();
		var pwd = $("#password").val();
		var checkPwd = $("#checkPassword").val();
		var phoneNum = $("#memberPhone1").val()+$("#memberPhone2").val()+$("#memberPhone3").val();
		var nickname = $("#nickname").val();

		var pattern1 = /[0-9]/;
		var pattern2 = /[a-zA-Z]/i;

		//이름이 비었을 때
		if (name.length == 0) {
			$("#checkNameMsg").html("이름을 입력해주세요.");
		} else {
			$("#checkNameMsg").html("");
		}
		
		if (pwd.length == 0) {	//비밀번호가 비었을 때
			$("#checkPwdMsg").html("비밀번호를 입력해주세요.");
		} else if (!pattern1.test(pwd) || !pattern2.test(pwd) || pwd.length < 8 || pwd.length > 15) {
			$("#checkPwdMsg").html("비밀번호 형식에 맞춰 다시 입력해주세요.");	//비밀번호 형식 확인(알파벳 대소문자, 숫자, 특수문자)
		} else {
			$("#checkPwdMsg").html("");
		}
		
		//전화번호가 비었을 때
		if ($("#memberPhone1").val().length == 0 || $("#memberPhone2").val().length == 0 || $("#memberPhone3").val().length == 0) {
			$("#checkPhoneNumMsg").html("전화번호를 입력해주세요.");
		} else {
			$("#checkPhoneNumMsg").html("");
		}
		
		//닉네임이 비었을 때(유저만 해당)
		if (${param.memberRole == 'user'} && nickname == 0) {
			$("#checkNicknameMsg").html("닉네임을 입력해주세요.");
		} else {
			$("#checkNicknameMsg").html("");
		}

	}

	//이메일 정규식 전역변수 선언
	var emailForm = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	
	//아이디 중복 및 유효성 확인
	function idCheckFunction() {
		var memberId = $("#memberId").val();
		$.ajax({
			type : "POST",
			url : "/member/json/checkIdDuplication",
			data : {
				"memberId" : memberId
			},
			success : function(result) {
				if(emailForm.test(memberId)) {
					if (result) {
						$("#checkIdMsg").html("사용할 수 있는 아이디입니다.");	
					} else {
						$("#checkIdMsg").html("이미 사용 중인 아이디입니다. 다른 아이디를 입력해 주세요.");
					}
				} else {
					$("#checkIdMsg").html("이메일 형식에 맞춰 다시 입력해주세요.");
				}
			}
		})
	}

	//닉네임 중복확인
	function nicknameCheckFunction() {
		var nickname = $("#nickname").val();
		$.ajax({
			type : "POST",
			url : "/member/json/checkNicknameDuplication",
			data : {
				"nickname" : nickname
			},
			success : function(result) {
				if (result) {
					$("#checkNicknameMsg").html("사용할 수 있는 닉네임입니다.");
				} else {
					$("#checkNicknameMsg").html("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해 주세요.");
				}
			}
		})
	}

	//비밀번호 일치 확인
	function pwdCheckFunction() {
		var pwd = $("#password").val();
		var checkPwd = $("#checkPassword").val();
		if (pwd != checkPwd) {
			$("#checkSamePwdMsg").html("비밀번호가 일치하지 않습니다.");
		} else {
			$("#checkSamePwdMsg").html("");
		}
	}

	//인증번호 전역변수 선언
	var globalVariable;

	//인증번호 일치 확인
	function certificatedNumCheckFunction() {
		var certificatedNum = globalVariable;
		var inputCertificatedNum = $("#certificatedNum").val();
		console.log(inputCertificatedNum);
		if (certificatedNum != inputCertificatedNum
				&& inputCertificatedNum.length != 6) {
			$("#checkCertificatedNumMsg").html("인증번호가 일치하지 않습니다. 다시 입력해주세요.");
		} else {
			$("#checkCertificatedNumMsg").html("");
		}
	}

	/* function invalidCheck() {
	 
	} */

	//jQuery navigation
	$(function() {
		console.log("addMember.jsp");
		console.log("${param.memberRole}");

		$("input:button[1]").on("click", function() {
			
			var name = $("#memberName").val();
			var id = $("memberId").val();
			var pwd = $("#password").val();
			var checkPwd = $("#checkPassword").val();
			var phoneNum = $("#memberPhone1").val()+$("#memberPhone2").val()+$("#memberPhone3").val();
			var nickname = $("#nickname").val();
			
			if(name.length != 0 && id.length != 0 && pwd.length != 0 && checkPwd.length != 0 && phoneNum.length != 0 && nickname.length != 0) {
				$("#addMember").attr("method" , "POST").attr("action" , "/member/addMember/user").submit();	
			}
			
		})

		$("input:button[2]").on("click", function() {
			
			var name = $("#memberName").val();
			var id = $("memberId").val();
			var pwd = $("#password").val();
			var checkPwd = $("#checkPassword").val();
			var phoneNum = $("#memberPhone1").val()+$("#memberPhone2").val()+$("#memberPhone3").val();
			
			if(name.length != 0 && id.length != 0 && pwd.length != 0 && checkPwd.length != 0 && phoneNum.length != 0) {
				$("#addMember").attr("method" , "POST").attr("action" , "/member/addMember/owner").submit();	
			}
		})

		$("input[value='인증번호 전송']").on(
				"click",
				function() {

					var phoneNum = $("#memberPhone1").val()+$("#memberPhone2").val()+$("#memberPhone3").val();
					$.ajax({
						type : "GET",
						url : "/member/json/sendCertificatedNum",
						data : {
							"phoneNum" : phoneNum
						},
						success : function(result) {
							alert("인증번호가 발송되었습니다.");
							globalVariable = result;
						}
					})

				});

		$("input[value='파일첨부']").on("click", function() {

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
									<label for="memberName">이름</label> <input type="text"
										onkeyup="fncCheckAccountForm();"
										class="col-sm-offset-1 col-sm-3 control-label" id="memberName"
										value="" required><span id="checkNameMsg"
										style="color: red; font-weight: bold"></span>
								</div>
								<br />
								<div>
									<label for="memberId">아이디</label> <input type="text"
										class="form-control" id="memberId"
										onkeyup="fncCheckAccountForm();idCheckFunction();"
										placeholder="example@zzupzzup.com" style="width: 300px"
										required>&nbsp;<span id="checkIdMsg"
										style="color: red; font-weight: bold"></span>
								</div>
								<br />
								<div>
									<label for="password">비밀번호</label> <input type="password"
										class="form-control" id="password"
										onkeyup="fncCheckAccountForm();"
										placeholder="8-15자 이내로 입력해주세요." style="width: 250px" required><span
										id="checkPwdMsg" style="color: red; font-weight: bold"></span>
									<h5>알파벳 대소문자, 숫자, 특수문자(~, !, @, #, $, %, ^, &, *, \, /)를
										조합하여 비밀번호를 구성하세요.</h5>
								</div>
								<br />
								<div>
									<label for="checkPassword">비밀번호 확인</label> <input
										type="password" class="form-control" id="checkPassword"
										onkeyup="fncCheckAccountForm();pwdCheckFunction();"
										placeholder="비밀번호를 다시 입력해주세요." style="width: 250px" required>
									<span id="checkSamePwdMsg"
										style="color: red; font-weight: bold"></span>
								</div>
								<br />
								<div>
									<label for="memberPhone1">전화번호</label> <input type="text"
										class="form-control" id="memberPhone1" required>&nbsp;-&nbsp;
									<input type="text" class="form-control" id="memberPhone2"
										required>&nbsp;-&nbsp; <input type="text"
										onkeyup="fncCheckAccountForm();" class="form-control"
										id="memberPhone3" required>&nbsp; <span
										id="checkPhoneNumMsg" style="color: red; font-weight: bold"></span>
									<input type="button" value="인증번호 전송" /> <label
										for="certificeatedNum">인증번호</label> <input type="text"
										class="form-control" id="certificatedNum"
										onkeyup="fncCheckAccountForm();certificatedNumCheckFunction();"
										required><span id="checkCertificatedNumMsg"
										style="color: red; font-weight: bold"></span>
								</div>
								<br />
								<div>
									<label for="profileImage">프로필 이미지</label> <input type="text"
										class="form-control" id="profileImage">&nbsp; <input
										type="button" value="파일첨부" />
								</div>
								<br />
								<c:if test="${param.memberRole == 'user'}">
									<div>
										<label for="nickname">닉네임</label> <input type="text"
											class="form-control" id="nickname"
											onkeyup="fncCheckAccountForm();nicknameCheckFunction();"
											placeholder="10자 이내로 입력해주세요." required>&nbsp; <span
											id="checkNicknameMsg" style="color: red; font-weight: bold"></span>
										<div class="invalid-feedback">닉네임은 반드시 입력해야 합니다.</div>
									</div>
									<br />
									<div>
										<label for="stateMessage">자기소개 및 특이사항</label>
										<textarea class="form-control" id="stateMessage"
											placeholder="100자 이내로 자유롭게 기술해주세요." rows="3"></textarea>
									</div>
									<br />
									<div>
										<label for="pushNickname">추천인 닉네임</label> <input type="text"
											class="form-control" id="pushNickname"
											placeholder="10자 이내로 입력해주세요.">
									</div>
								</c:if>
								<hr class="mb-4">
								<div class="custom-control custom-checkbox">
									<input type="checkbox" class="custom-control-input"
										id="same-address"> <label class="custom-control-label"
										for="same-address">Shipping address is the same as my
										billing address</label>
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