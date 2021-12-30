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
	
	//회원가입 시 확인하는 사항
	boolean addMemberFlag = false;
	
	//양식 유효성 확인
	function fncCheckAccountForm() {
		var name = $("#memberName").val();
		var id = $("memberId").val();
		var pwd = $("#password").val();
		var checkPwd = $("#checkPassword").val();
		var phoneNum = $("#memberPhone1").val()+$("#memberPhone2").val()+$("#memberPhone3").val();
		var nickname = $("#nickname").val();
		var gender = $("#input[name=genders]:checked").val();
		var ageRange = $("#input[name=ageRanges]:checked").val();

		var pattern1 = /[0-9]/;
		var pattern2 = /[a-zA-Z]/i;

		//이름이 비었을 때
		if (name.length == 0) {
			$("#checkNameMsg").html("이름을 입력해주세요.");
			addMemberFlag = false;
		} else {
			$("#checkNameMsg").html("");
			addMemberFlag = true;
		}
		
		if (pwd.length == 0) {	//비밀번호가 비었을 때
			$("#checkPwdMsg").html("비밀번호를 입력해주세요.");
			addMemberFlag = false;
		} else if (!pattern1.test(pwd) || !pattern2.test(pwd) || pwd.length < 8 || pwd.length > 15) {
			$("#checkPwdMsg").html("비밀번호 형식에 맞춰 다시 입력해주세요.");	//비밀번호 형식 확인(알파벳 대소문자, 숫자, 특수문자)
			addMemberFlag = false;
		} else {
			$("#checkPwdMsg").html("");
			addMemberFlag = true;
		}
		
		//전화번호가 비었을 때
		if ($("#memberPhone1").val().length == 0 || $("#memberPhone2").val().length == 0 || $("#memberPhone3").val().length == 0) {
			$("#checkPhoneNumMsg").html("전화번호를 입력해주세요.");
			addMemberFlag = false;
		} else {
			$("#checkPhoneNumMsg").html("");
			addMemberFlag = true;
		}
		
		//닉네임이 비었을 때(유저만 해당)
		if (${param.memberRole == 'user'} && nickname.length == 0) {
			$("#checkNicknameMsg").html("닉네임을 입력해주세요.");
			addMemberFlag = false;
		} else {
			$("#checkNicknameMsg").html("");
			addMemberFlag = true;
		}
		
		//성별 선택 안 되었을 때
		if (${param.memberRole == 'user'} && gender.length == 0) {
			$("#checkGenderMsg").html("성별을 선택해주세요.");
			addMemberFlag = false;
		} else {
			$("#checkGenderMsg").html("");
			addMemberFlag = true;
		}
		
		//연령대 선택 안 되었을 때
		if (${param.memberRole == 'user'} && ageRange.length == 0) {
			$("#checkAgeRangeMsg").html("연령대를 선택해주세요.");
			addMemberFlag = false;
		} else {
			$("#checkAgeRangeMsg").html("");
			addMemberFlag = true;
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
						addMemberFlag = true;
					} else {
						$("#checkIdMsg").html("이미 사용 중인 아이디입니다. 다른 아이디를 입력해 주세요.");
						addMemberFlag = false;
					}
				} else {
					$("#checkIdMsg").html("이메일 형식에 맞춰 다시 입력해주세요.");
					addMemberFlag = false;
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
					addMemberFlag = true;
				} else {
					$("#checkNicknameMsg").html("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해 주세요.");
					addMemberFlag = false;
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
			addMemberFlag = false;
		} else {
			$("#checkSamePwdMsg").html("");
			addMemberFlag = true;
		}
	}

	//인증번호 전역변수 선언
	var globalVariable;

	//인증번호 일치 확인
	function certificatedNumCheckFunction() {
		var certificatedNum = globalVariable;
		var inputCertificatedNum = $("#certificatedNum").val();
		if (certificatedNum != inputCertificatedNum
				&& inputCertificatedNum.length != 6) {
			$("#checkCertificatedNumMsg").html("인증번호가 일치하지 않습니다. 다시 입력해주세요.");
			addMemberFlag = false;
		} else if(certificatedNum == inputCertificatedNum
				&& inputCertificatedNum.length == 6) {
			$("#checkCertificatedNumMsg").html("");
			addMemberFlag = true;
		}
	}
	
	//유저 회원가입 함수
	function fncAddUser() {
		var name = $("#memberName").val();
		var id = $("#memberId").val();
		var pwd = $("#password").val();
		var checkPwd = $("#checkPassword").val();
		var phoneNum = $("#memberPhone1").val()+$("#memberPhone2").val()+$("#memberPhone3").val();
		var nickname = $("#nickname").val();
		var gender = $("#input[name=genders]:checked").val();
		var ageRange = $("#input[name=ageRanges]:checked").val();
		console.log("Member : [ 이름 : "+name+", 아이디 : "+id+", 비밀번호 : "+pwd+", 전화번호 : "+phoneNum+", 닉네임 : "+nickname+", 성별 : "+gender+", 연령대 : "+ageRange+"]");
		
		if(${param.loginType == '1'} && addMemberFlag == true) {
			$("#addUser").replaceWith("<input type='button' id='addUser' class='btn btn-lg btn-primary' style='float:right' value='회원가입'></input>");
			$("#addMember-complete").attr("method","POST").attr("action","/member/addMember/user/1").submit();
		} else if(${param.loginType != '1'} && addMemberFlag == true) {
			$("#addUser").replaceWith("<input type='button' id='addUser' class='btn btn-lg btn-primary' style='float:right' value='회원가입'></input>");
			$("#addMember-complete").attr("method","POST").attr("action","/member/addMember/user/${param.loginType}").submit();
		}
	}
	
	//업주 회원가입 함수
	function fncAddOwner() {
		var name = $("#memberName").val();
		var id = $("#memberId").val();
		var pwd = $("#password").val();
		var checkPwd = $("#checkPassword").val();
		var phoneNum = $("#memberPhone1").val()+$("#memberPhone2").val()+$("#memberPhone3").val();
		var nickname = $("#nickname").val();
		console.log("Member : [ 이름 : "+name+", 아이디 : "+id+", 비밀번호 : "+pwd+", 전화번호 : "+phoneNum+"]");
		
		if(addMemberFlag == true) {
			$("#addUser").replaceWith("<input type='button' id='addOwner' class='btn btn-lg btn-primary' style='float:right' value='다음'></input>");
			$("#addMember-complete").attr("method" , "POST").attr("action" , "/member/addMember/owner/1").submit();
		}
	}

	/* function invalidCheck() {
	 
	} */

	//jQuery navigation
	$(function() {
		console.log("addMember.jsp");
		console.log("${param.memberRole}");
		
		$("input[value='회원가입']").on("click", function() {
			fncAddUser();
		})
		
		$("input[value='다음']").on("click", function() {
			fncAddOwner();
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
			location.href = "/";
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
							<form class="needs-validation" id="addMember-complete" novalidate>
								<div class="row">
									<div class="col">
										<label for="memberName">이름</label> <input type="text"
											onkeyup="fncCheckAccountForm();" name="memberName" maxlength="9"
											class="form-control" id="memberName"
											value="" required><span id="checkNameMsg"
											style="color: red; font-weight: bold"></span>
										<br/>
										<c:if test="${param.loginType == '1'}">
										<label for="password">비밀번호</label> <input type="password"
												class="form-control" id="password" name="password"
												onkeyup="fncCheckAccountForm();" minlength="8" maxlength="15"
												placeholder="8-15자 이내로 입력해주세요." required><span
												id="checkPwdMsg" style="color: red; font-weight: bold"></span>
											<!-- <h5>알파벳 대소문자, 숫자, 특수문자(~, !, @, #, $, %, ^, &, *, \, /)를
												조합하여 비밀번호를 구성하세요.</h5> -->
										</c:if>
									</div>
										<div class="col">
											<label for="memberId">아이디</label> <input type="text"
											class="form-control" id="memberId" name="memberId"
											onkeyup="fncCheckAccountForm();idCheckFunction();"
											placeholder="example@zzupzzup.com"
											required>&nbsp;<span id="checkIdMsg"
											style="color: red; font-weight: bold"></span>
											<br/>
										<c:if test="${param.loginType == '1'}">
											<label for="checkPassword">비밀번호 확인</label> <input
												type="password" class="form-control" id="checkPassword"
												onkeyup="fncCheckAccountForm();pwdCheckFunction();" minlength="8" maxlength="15"
												placeholder="비밀번호를 다시 입력해주세요." required>
											<span id="checkSamePwdMsg"
												style="color: red; font-weight: bold"></span>
										</c:if>
									</div>
								</div>
								<br/>
								<div class="row">
									<div>
										<label for="memberPhone1">전화번호</label>
									</div>
								</div>
								<div class="row">
									<div class="col">
										<input type="text" name="memberPhone1"
											class="form-control" id="memberPhone1" maxlength="3" required>
									</div>
									<div class="col">
										<input type="text" class="form-control" id="memberPhone2" name="memberPhone2"
											maxlength="4" required>
									</div>
									<div class="col">	
										<input type="text"
											onkeyup="fncCheckAccountForm();" class="form-control" name="memberPhone3"
											id="memberPhone3" maxlength="4" required>
									</div>
								</div>
								<div class="row">
									<div class="col">
										<span id="checkPhoneNumMsg" style="color: red; font-weight: bold; float:left"></span>
									</div>
									<div class="col">
										<br/>
										<input type="button" value="인증번호 전송" style="float:right"/>
									</div>
								</div>
								<div class="row">
									<div class="col">
										<label for="certificeatedNum">인증번호</label>
										<input type="text" class="form-control" id="certificatedNum"
										onkeyup="fncCheckAccountForm();certificatedNumCheckFunction();"
										required>
										<span id="checkCertificatedNumMsg"
										style="color: red; font-weight: bold"></span>
									</div>
								</div>
								<hr class="mb-4">
								<div class="row">
									<div class="col">
										<label class="form-label" for="profileImage">프로필 이미지</label>
										<input type="file" class="form-control" id="profileImage" name="profileImage"/>
									</div>
									<br/>
									<c:if test="${param.memberRole == 'user'}">
										<div class="col">
											<label for="nickname">닉네임</label> <input type="text"
												class="form-control" id="nickname" name="nickname"
												onkeyup="fncCheckAccountForm();nicknameCheckFunction();"
												placeholder="10자 이내로 입력해주세요." required>&nbsp; <span
												id="checkNicknameMsg" style="color: red; font-weight: bold"></span>
											<br/>
											<label for="stateMessage">자기소개 및 특이사항</label>
											<textarea class="form-control" id="stateMessage" name="stateMessage"
												placeholder="100자 이내로 자유롭게 기술해주세요." rows="3"></textarea>
										</div>
									</c:if>
								</div>
								<c:if test="${param.memberRole == 'user'}">
									<br/>
									<div class="row">
										<div class="col">
											<label for="stateMessage">성별</label>
												<input class="form-check-input" type="radio" name="genders" id="gender1" value="male">
												<label class="form-check-label" for="gender1">
												    남
												</label>
												<input class="form-check-input" type="radio" name="genders" id="gender2" value="female">
												<label class="form-check-label" for="gender2">
												    여
												</label>
												<span id="checkGenderMsg"
												style="color: red; font-weight: bold"></span>
										</div>
										<div class="col">
											<label for="stateMessage">연령대</label>
												<input class="form-check-input" type="radio" name="ageRanges" id="ageRange1" value="10대">
												<label class="form-check-label" for="ageRange1">
												    10대
												</label>
												<input class="form-check-input" type="radio" name="ageRanges" id="ageRange2" value="20대">
												<label class="form-check-label" for="ageRange2">
												    20대
												</label>
												<input class="form-check-input" type="radio" name="ageRanges" id="ageRange3" value="30대">
												<label class="form-check-label" for="ageRange3">
												    30대
												</label>
												<input class="form-check-input" type="radio" name="ageRanges" id="ageRange4" value="40대">
												<label class="form-check-label" for="ageRange4">
												    40대
												</label>
												<input class="form-check-input" type="radio" name="ageRanges" id="ageRange5" value="50대">
												<label class="form-check-label" for="ageRange5">
												    50대
												</label>
												<input class="form-check-input" type="radio" name="ageRanges" id="ageRange6" value="60대 이상">
												<label class="form-check-label" for="ageRange6">
												    60대 이상
												</label>
												<span id="checkAgeRangeMsg"
												style="color: red; font-weight: bold"></span>
										</div>
									</div>
									<br/>
									<div class="row">
										<div class="col">
											<label for="pushNickname">추천인 닉네임</label> <input type="text"
												class="form-control" id="pushNickname" name="pushNickname"
												placeholder="10자 이내로 입력해주세요.">
										</div>
									</div>
								</c:if>
								<!-- <hr class="mb-4">
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
								</div> -->
							</form>
							<hr class="mb-4">
							<input type="button" class="btn btn-lg btn-primary" style="float:right" value="취소"></input>
							<c:if test="${param.memberRole == 'user'}">
								<input type="button" id="addUser" class="btn btn-lg btn-primary" style="float:right" value="회원가입" disabled></input>
							</c:if>
							<c:if test="${param.memberRole == 'owner'}">
								<input type="button" id="addOwner" class="btn btn-lg btn-primary" style="float:right" value="다음" disabled></input>
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