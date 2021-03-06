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
	
	//flag
	//*addMember global field flag
	var checkNameFlag;
	var checkIdFlag;
	var checkPwdFlag;
	var checkSamePwdFlag;
	var checkPhoneFlag;
	var checkNicknameFlag;
	var checkCertificatedNumFlag;
	//인증번호 전역변수 선언
	var certificatedNumG;
	
	//changed image preview function
	function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
		
        reader.onload = function (e) {
                $("#profileImage").attr("src", e.target.result);
            }

		reader.readAsDataURL(input.files[0]);
		console.log(input.files[0].name);
		
        }
    }

	//jQuery navigation
	$(function() {
		console.log("addMember.jsp");
		console.log("${param.memberRole}");
		
		//이름 유효성 체크
		$("#memberName").keyup(function() {
			var name = $("#memberName").val();
			
			if (name == "" || name.length < 2) {
				$("#checkNameMsg").text("이름을 입력해주세요.");
				checkNameFlag = false;
			} else {
				$("#checkNameMsg").text("");
				checkNameFlag = true;
			}
		});
		
		//아이디 중복 및 유효성 체크
		$("#memberId").keyup(function() {
			var memberId = $("#memberId").val();
			var emailForm = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			
			$.ajax({
				type : "POST",
				url : "/member/json/checkIdDuplication",
				data : {
					"memberId" : memberId
				},
				success : function(result) {
					if(memberId.length > 0) {
						if(emailForm.test(memberId)) {
							if (result) {
								$("#checkIdMsg").text("사용할 수 있는 아이디입니다.");	
								checkIdFlag = true;
							} else {
								$("#checkIdMsg").text("이미 사용 중인 아이디입니다. 다른 아이디를 입력해 주세요.");
								checkIdFlag = false;
							}
						} else {
							$("#checkIdMsg").text("이메일 형식에 맞춰 다시 입력해주세요.");
							checkIdFlag = false;
						}	
					} else {
						$("#checkIdMsg").text("아이디를 입력해주세요.");
						checkIdFlag = false;
					}
					
				}
			})
		});
		
		//비밀번호 유효성 체크
		$("#password").keyup(function() {
			var pwd = $("#password").val();

			var pattern1 = /[0-9]/;
			var pattern2 = /[a-zA-Z]/i;
			
			if (pwd == "" || pwd == null) {	//비밀번호가 비었을 때
				$("#checkPwdMsg").text("비밀번호를 입력해주세요.");
				checkPwdFlag = false;
			} else {
				if ( ! pattern1.test(pwd) || ! pattern2.test(pwd) || pwd.length < 8) {
					$("#checkPwdMsg").text("비밀번호 형식에 맞춰 다시 입력해주세요.");	//비밀번호 형식 확인(알파벳 대소문자, 숫자, 특수문자)
					checkPwdFlag = false;
				} else {
					$("#checkPwdMsg").text("");
					checkPwdFlag = true;
				}
			}
		});
		
		//비밀번호 일치 여부 체크
		$("#checkPassword").keyup(function() {
			var pwd = $("#password").val();
			var checkPwd = $("#checkPassword").val();

			if (pwd != checkPwd) {
				$("#checkSamePwdMsg").text("비밀번호가 일치하지 않습니다.");
				checkSamePwdFlag = false;
			} else {
				$("#checkSamePwdMsg").text("");
				checkSamePwdFlag = true;
			}
		});
		
		//전화번호 유효성 체크
		$("#memberPhone1, #memberPhone2, #memberPhone3").keyup(function() {
			var phoneNum = $("#memberPhone1").val()+"-"+$("#memberPhone2").val()+"-"+$("#memberPhone3").val();
			var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
			
			if ($("#memberPhone1").val() != "" && $("#memberPhone2").val() == "" && $("#memberPhone3").val() == "") {
				$("#checkPhoneNumMsg").text("전화번호를 입력해주세요.");
				checkPhoneFlag = false;
			} else if (!regPhone.test(phoneNum)) {
				$("#checkPhoneNumMsg").text("전화번호 형식에 맞춰 다시 입력해주세요.");	//전화번호 형식 확인
				checkPhoneFlag = false;
			} else {
				$("#checkPhoneNumMsg").text("");
				checkPhoneFlag = true;
			}
		});
		
		//인증번호 일치 여부 체크
		$("#certificatedNum").keyup(function() {
			console.log(certificatedNumG);
			var certificatedNum = certificatedNumG;
			var inputCertificatedNum = $("#certificatedNum").val();
			
			if (certificatedNum != inputCertificatedNum
					&& inputCertificatedNum.length != 6) {
				$("#checkCertificatedNumMsg").text("인증번호가 일치하지 않습니다. 다시 입력해주세요.");
				checkCertificatedNumFlag = false;
			} else if(certificatedNum == inputCertificatedNum
					&& inputCertificatedNum.length == 6) {
				$("#checkCertificatedNumMsg").text("");
				checkCertificatedNumFlag = true;
			}
		});
		
		//닉네임 중복 여부 체크
		$("#nickname").keyup(function() {
			var nickname = $("#nickname").val();
			$.ajax({
				type : "POST",
				url : "/member/json/checkNicknameDuplication",
				data : {
					"nickname" : nickname
				},
				success : function(result) {
					if (nickname.length > 0) {
						if (result) {
							$("#checkNicknameMsg").text("사용할 수 있는 닉네임입니다.");
							checkNicknameFlag = true;
						} else {
							$("#checkNicknameMsg").text("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해 주세요.");
							checkNicknameFlag = false;
						}
					} else if(${param.memberRole == 'owner'} && nickname.length == 0) { 
						$("#checkNicknameMsg").text("");
						checkNicknameFlag = true;
					} else {
						$("#checkNicknameMsg").text("닉네임을 입력해주세요.");
						checkNicknameFlag = false;
					}
				}
			})
		});
		
		$("a[href='#']").on("click", function() {
			$("#form-reset").reset();
		})
		
		$("input[value='회원가입']").on("click", function() {
			//이미 값이 불러와진 경우(SNS 로그인 때) 필요한 variable
			var memberId = $("#memberId").val();
			
			var checkAddMember = confirm("회원가입을 진행하시겠습니까?");
			
			if(checkAddMember) {
				if("${param.memberRole}" == "user") {
					if("${param.loginType}" == "1" && (checkNameFlag && checkIdFlag && checkPwdFlag && checkSamePwdFlag && checkPhoneFlag && checkNicknameFlag && checkCertificatedNumFlag)) {	//일반 회원가입
						$("#addMember-complete").attr("method","POST").attr("action","/member/addMember/user/${param.loginType}").submit();
					} else if("${param.loginType}" != "1" && (checkNameFlag && (checkIdFlag || memberId != "") && checkPhoneFlag && checkNicknameFlag && checkCertificatedNumFlag)) {	//SNS(카카오) 회원가입
						$("#addMember-complete").attr("method","POST").attr("action","/member/addMember/user/${param.loginType}").submit();
					} else {
						alert("누락된 항목 확인 후 다시 진행해주세요.");
						//alert("name : "+checkNameFlag+", "+"id : "+checkIdFlag+", "+"pwd : "+checkPwdFlag+", "+"same pwd : "+checkSamePwdFlag+", "+"phone : "+checkPhoneFlag+", "+"nickname : "+checkNicknameFlag+", "+"certificatedNum : "+checkCertificatedNumFlag);
					}
				} else {
					if("${param.loginType}" == "1" && (checkNameFlag && checkIdFlag && checkPwdFlag && checkSamePwdFlag && checkPhoneFlag && checkCertificatedNumFlag)) {
						var regRestaurant = confirm("음식점 등록을 진행하시겠습니까?");
						
						if(regRestaurant) {
							$("#addMember-hidden").html("<input type='hidden' name='regRestaurant' value='"+regRestaurant+"'/>");
							$("#addMember-complete").attr("method" , "POST").attr("action" , "/member/addMember/owner/${param.loginType}").submit();
						} else {
							$("#addMember-hidden").html("<input type='hidden' name='regRestaurant' value='"+regRestaurant+"'/>");
							alert("로그인 후 음식점을 등록해주세요.");
							$("#addMember-complete").attr("method" , "POST").attr("action" , "/member/addMember/owner/${param.loginType}").submit();
						}
					} else {
						alert("누락된 항목 확인 후 다시 진행해주세요.");
					}
				}
			}
		})

		$("input[value='인증번호 전송']").on("click", function() {
			var phoneNum = $("#memberPhone1").val()+$("#memberPhone2").val()+$("#memberPhone3").val();
			alert("인증번호를 발송합니다.");
			if(checkPhoneFlag) {
				$.ajax({
					type : "GET",
					url : "/member/json/sendCertificatedNum",
					data : {
						"phoneNum" : phoneNum
					},
					success : function(result) {
						alert("인증번호 발송이 완료되었습니다.");
						certificatedNumG = result;
					}
				});
			} else {
				alert("전화번호를 입력해주세요.");
			}

		});

		$("input[value='이전']").on("click", function() {
			location.href = "/";
		})
		
		//changed image preview
		 $("#fileInput").on("change", function(){
            readURL(this);
        });
		
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
				<!-- <header id="header">
					<strong>쩝쩝듀스101 회원가입</strong>
				</header> -->

				<section id="addMember">
					<div class="container">
						<div>
							<form class="needs-validation" id="addMember-complete" enctype="multipart/form-data">
							<a href="#"><input type="hidden" id="form-reset"/></a><!-- refresh 경우 form reset tag 추가 -->
								<input type="hidden" name="memberRole" value="${param.memberRole}"/>
								<input type="hidden" name="loginType" value="${param.loginType}"/>
								<div id="addMember-contents">
									<div class="row">
										<div class="col">
											<label for="memberName">이름</label> <input type="text" name="memberName" maxlength="9"
												class="form-control" id="memberName" required>
											<span id="checkNameMsg" style="color: red; font-weight: bold"></span>
											<br/>
											<label for="memberId">아이디</label> <input type="text" class="form-control" id="memberId" name="memberId"
												placeholder="example@zzupzzup.com" value="${sessionScope.snsMember.memberId != null ? snsMember.memberId : '' }"
												required>&nbsp;<span id="checkIdMsg"
												style="color: red; font-weight: bold"></span>
												<br/>
										</div>
										<div class="col">
											<c:if test="${param.loginType == '1'}">
												<label for="password">비밀번호</label> <input type="password" class="form-control" id="password" name="password"
														minlength="8" maxlength="15" placeholder="비밀번호는 8-15자 이내의 영문 대소문자와 숫자의 조합으로 구성해주세요.">
												<span id="checkPwdMsg" style="color: red; font-weight: bold"></span>
												<br/>
													<!-- <h5>알파벳 대소문자, 숫자, 특수문자(~, !, @, #, $, %, ^, &, *, \, /)를
														조합하여 비밀번호를 구성하세요.</h5> -->
												<label for="checkPassword">비밀번호 확인</label> <input
													type="password" class="form-control" id="checkPassword" maxlength="15"
													placeholder="비밀번호를 다시 입력해주세요.">
												<span id="checkSamePwdMsg" style="color: red; font-weight: bold"></span>
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
											<input type="text" class="form-control" name="memberPhone3"
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
											<input type="text" class="form-control" id="certificatedNum" maxlength="6" required>
											<span id="checkCertificatedNumMsg" style="color: red; font-weight: bold"></span>
										</div>
									</div>
									<hr class="mb-4">
									<div class="row">
										<div class="col">
											<div class="file-view mt-4" align="center">
												<c:if test="${member.profileImage == 'defaultImage.png' || member.profileImage == null}">
													<!-- <img id="profileImage" src="/resources/images/defaultImage.png" class="rounded-circle" width="150" height="150"/> -->
													<img id="profileImage" src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/common/defaultImage.png" class="rounded-circle" width="150" height="150"/>
													<input type="hidden" name="profileImage" value="defaultImage.png" />
												</c:if>
												<c:if test="${member.profileImage != 'defaultImage.png' && member.profileImage != null}">
													<%-- <img id="profileImage" src="/resources/images/uploadImages/${member.profileImage}" class="rounded-circle" width="150" height="150"/> --%>
													<img id="profileImage" src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/member/${member.profileImage}" class="rounded-circle" width="150" height="150"/>
												</c:if>
											</div>
											<div style="margin-top:10px;margin-left:5px;" align="center">
												<span class="file-drag-btn">이미지 변경</span>
												<input class="file-drag-input" type="file" id="fileInput" name="fileInput" value="${member.profileImage}">
											</div>
										</div>
										<br/>
										<c:if test="${param.memberRole == 'user'}">
											<div class="col">
												<label for="nickname">닉네임</label> <input type="text"
													class="form-control" id="nickname" name="nickname"
													placeholder="10자 이내로 입력해주세요." required>&nbsp; <span
													id="checkNicknameMsg" style="color: red; font-weight: bold"></span>
												<br/>
												<label for="stateMessage">자기소개 및 특이사항</label>
												<textarea class="form-control" id="statusMessage" name="statusMessage"
													placeholder="100자 이내로 자유롭게 기술해주세요." style="resize: none;" rows="3"></textarea>
											</div>
										</c:if>
									</div>
									<c:if test="${param.memberRole == 'user'}">
										<br/>
										<div class="row">
											<div class="col">
												<label for="gender">성별</label>
												<c:if test="${snsMember.gender == 'male' || snsMember == null}">
													<input class="form-check-input" type="radio" name="gender" id="gender1" value="male" checked>
													<label class="form-check-label" for="gender1">
													    남
													</label>
													<input class="form-check-input" type="radio" name="gender" id="gender2" value="female">
													<label class="form-check-label" for="gender2">
													    여
													</label>
												</c:if>
												<c:if test="${snsMember.gender == 'female'}">
													<input class="form-check-input" type="radio" name="gender" id="gender1" value="male">
													<label class="form-check-label" for="gender1">
													    남
													</label>
													<input class="form-check-input" type="radio" name="gender" id="gender2" value="female" checked>
													<label class="form-check-label" for="gender2">
													    여
													</label>
												</c:if>
											</div>
											<div class="col">
												<label for="ageRange">연령대</label>
												<c:if test="${snsMember.ageRange == '10대' || snsMember == null}">
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange1" value="10대" checked>
													<label class="form-check-label" for="ageRange1">
													    10대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange2" value="20대">
													<label class="form-check-label" for="ageRange2">
													    20대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange3" value="30대">
													<label class="form-check-label" for="ageRange3">
													    30대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange4" value="40대">
													<label class="form-check-label" for="ageRange4">
													    40대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange5" value="50대">
													<label class="form-check-label" for="ageRange5">
													    50대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange6" value="60대 이상">
													<label class="form-check-label" for="ageRange6">
													    60대 이상
													</label>
												</c:if>
												<c:if test="${snsMember.ageRange == '20대'}">
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange1" value="10대">
													<label class="form-check-label" for="ageRange1">
													    10대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange2" value="20대" checked>
													<label class="form-check-label" for="ageRange2">
													    20대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange3" value="30대">
													<label class="form-check-label" for="ageRange3">
													    30대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange4" value="40대">
													<label class="form-check-label" for="ageRange4">
													    40대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange5" value="50대">
													<label class="form-check-label" for="ageRange5">
													    50대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange6" value="60대 이상">
													<label class="form-check-label" for="ageRange6">
													    60대 이상
													</label>
												</c:if>
												<c:if test="${snsMember.ageRange == '30대'}">
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange1" value="10대">
													<label class="form-check-label" for="ageRange1">
													    10대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange2" value="20대">
													<label class="form-check-label" for="ageRange2">
													    20대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange3" value="30대" checked>
													<label class="form-check-label" for="ageRange3">
													    30대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange4" value="40대">
													<label class="form-check-label" for="ageRange4">
													    40대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange5" value="50대">
													<label class="form-check-label" for="ageRange5">
													    50대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange6" value="60대 이상">
													<label class="form-check-label" for="ageRange6">
													    60대 이상
													</label>
												</c:if>
												<c:if test="${snsMember.ageRange == '40대'}">
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange1" value="10대">
													<label class="form-check-label" for="ageRange1">
													    10대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange2" value="20대">
													<label class="form-check-label" for="ageRange2">
													    20대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange3" value="30대">
													<label class="form-check-label" for="ageRange3">
													    30대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange4" value="40대" checked>
													<label class="form-check-label" for="ageRange4">
													    40대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange5" value="50대">
													<label class="form-check-label" for="ageRange5">
													    50대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange6" value="60대 이상">
													<label class="form-check-label" for="ageRange6">
													    60대 이상
													</label>
												</c:if>
												<c:if test="${snsMember.ageRange == '50대'}">
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange1" value="10대">
													<label class="form-check-label" for="ageRange1">
													    10대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange2" value="20대">
													<label class="form-check-label" for="ageRange2">
													    20대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange3" value="30대">
													<label class="form-check-label" for="ageRange3">
													    30대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange4" value="40대">
													<label class="form-check-label" for="ageRange4">
													    40대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange5" value="50대" checked>
													<label class="form-check-label" for="ageRange5">
													    50대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange6" value="60대 이상">
													<label class="form-check-label" for="ageRange6">
													    60대 이상
													</label>
												</c:if>
												<c:if test="${snsMember.ageRange == '60대 이상'}">
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange1" value="10대">
													<label class="form-check-label" for="ageRange1">
													    10대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange2" value="20대">
													<label class="form-check-label" for="ageRange2">
													    20대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange3" value="30대">
													<label class="form-check-label" for="ageRange3">
													    30대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange4" value="40대">
													<label class="form-check-label" for="ageRange4">
													    40대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange5" value="50대">
													<label class="form-check-label" for="ageRange5">
													    50대
													</label>
													<input class="form-check-input" type="radio" name="ageRange" id="ageRange6" value="60대 이상" checked>
													<label class="form-check-label" for="ageRange6">
													    60대 이상
													</label>
												</c:if>
											</div>
										</div>
										<br/>
										<div class="row">
											<div class="col">
												<label for="pushNickname">추천인 닉네임</label> <input type="text"
													class="form-control" id="pushNickname" name="pushNickname"
													placeholder="10자 이내로 입력해주세요." maxlength="9">
											</div>
										</div>
									</c:if>
								</div>
								<div id="addMember-hidden"></div>
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
							<div align="center">
								<input type="button" class="btn btn-lg button secondary" value="이전"></input>
								<c:if test="${param.memberRole == 'user'}">
									<input type="button" id="addMember" class="btn btn-lg button primary" value="회원가입"/>
								</c:if>
								<c:if test="${param.memberRole == 'owner'}">
									<input type="button" id="addMember" class="btn btn-lg button primary" value="회원가입"/>
								</c:if>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
		<!-- E:Main -->

		<!-- Sidebar -->
		<jsp:include page="/layout/sidebar.jsp" />
	</div>
	<!-- E:Wrapper -->
</body>
</html>