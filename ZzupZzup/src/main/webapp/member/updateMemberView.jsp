<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-updateMember</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	//flag
	//*updateMember global field flag
	var checkPwdFlag;
	var checkSamePwdFlag;
	var checkPhoneFlag;
	var checkCertificatedNumFlag;
	//인증번호 전역변수 선언
	var certificatedNumG;
	
	$(function() {
		console.log("updateMemberView.jsp");
		
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
		
		$("#updateMember-submit").on("click", function() {
			//location.href = "/member/updateMember";
			var password = $("#password").val();
			var checkPwd = $("#checkPassword").val();
			var phoneNum = $("#memberPhone1").val()+$("#memberPhone2").val()+$("#memberPhone3").val();
			var certificatedNum = $("#certificatedNum").val();
			
			console.log(password+", "+checkPwd+", "+phoneNum+", "+certificatedNum);
			
			if("${sessionScope.member.memberRole}" != "admin") {
				if("${sessionScope.member.loginType}" == 1) {
					if(checkPwdFlag && checkSamePwdFlag && (checkPhoneFlag || phoneNum != "") && checkCertificatedNumFlag) {
						$("#updateMember-complete").attr("method","POST").attr("action","/member/updateMember/${sessionScope.member.loginType}").submit();
					} else {
						alert("누락된 항목 확인 후 다시 시도해주세요.");
						//alert("pwd : "+checkPwdFlag+", "+"same pwd : "+checkSamePwdFlag+", "+"phone : "+checkPhoneFlag+", "+"certificatedNum : "+checkCertificatedNumFlag);
					}
				} else {
					if((checkPhoneFlag || phoneNum != "") && checkCertificatedNumFlag) {
						$("#updateMember-complete").attr("method","POST").attr("action","/member/updateMember/${sessionScope.member.loginType}").submit();
					} else {
						alert("누락된 항목 확인 후 다시 시도해주세요.");
					}
				}
				
			} else {
				$("#updateMember-complete").attr("method","POST").attr("action","/member/updateMember/${sessionScope.member.loginType}").submit();
			}
			
		})
		
		$("#back").on("click", function() {
			history.go(-1);
		})
		
	});
	
	$(function() {
		//인증번호 전송
		$("input[value='인증번호 전송']").on("click", function() {
			var phoneNum = $("#memberPhone1").val()+"-"+$("#memberPhone2").val()+"-"+$("#memberPhone3").val();
			$.ajax({
				type : "GET",
				url : "/member/json/sendCertificatedNum",
				data : {
					"phoneNum" : phoneNum
				},
				success : function(result) {
					alert("인증번호가 발송되었습니다.");
					certificatedNumG = result;
				}
			})
		});
		
		//changed image preview
		 $("#fileInput").on("change", function(){
             readURL(this);
         });
		
	});
	
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

				<section id="updateMember">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-md-12 mx-auto">
								<h2>내 정보 수정</h2>
								<div class="my-4">
									<form id="updateMember-complete" enctype="multipart/form-data">
									<input type="hidden" name="memberName" value="${member.memberName}"/>
									<input type="hidden" name="memberId" value="${member.memberId}"/>
									<input type="hidden" name="nickname" value="${member.nickname}"/>
									<input type="hidden" name="profileImage" value="${member.profileImage}"/>
									<input type="hidden" name="memberPhone" value="${member.memberPhone}"/>
									<input type="hidden" name="memberRole" value="${member.memberRole}"/>
									<c:if test="${sessionScope.member.memberRole == 'admin'}">
										<input type="hidden" name="password" value="${member.password}">
										<input type="hidden" name="ageRange" value="${member.ageRange}">
										<input type="hidden" name="gender" value="${member.gender}">
										<input type="hidden" name="statusMessage" value="${member.statusMessage}">
									</c:if>
										<div class="row mt-5 mb-5 align-items-center">
											<div class="col-md-3" id="edit-profileImage">
												<div class="col-md" align="center">
													<!-- profileImage 도윤님 src 참고 start -->
													<div class="file-view mt-4">
														<c:if test="${member.profileImage == 'defaultImage.png'}">
															<!-- <img id="profileImage" src="/resources/images/defaultImage.png" class="rounded-circle" width="150" height="150"/> -->
															<img id="profileImage" src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/common/defaultImage.png" class="rounded-circle" width="150" height="150"/>
														</c:if>
														<c:if test="${member.profileImage != 'defaultImage.png' && member.profileImage != null}">
															<%-- <img id="profileImage" src="/resources/images/uploadImages/${member.profileImage}" class="rounded-circle" width="150" height="150"/> --%>
															<img id="profileImage" src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/member/${member.profileImage}" class="rounded-circle" width="150" height="150"/>
														</c:if>
													</div>
													<%-- <c:if test="${sessionScope.member.memberRole != 'admin'}"> --%>
														<div style="margin-top:10px;margin-left:5px;">
															<span class="file-drag-btn">이미지 변경</span>
															<input class="file-drag-input" type="file" id="fileInput" name="fileInput" value="${member.profileImage}">
														</div>
													<%-- </c:if> --%>
													<!-- profileImage 도윤님 src 참고 end -->
												</div>
											</div>
											<!-- memberRole user일 때 프로필 이미지 옆 공간 -->
											<c:if test="${sessionScope.member.memberRole == 'user'}">
												<div class="col-md-9">
													<div class="row align-items-right">
														<div class="col-md-7">
															<h4 class="mb-1">
																	<span class="badge badge-pill badge-dark" style="background-color: #f56a6a;">${member.memberRank}</span>&nbsp;&nbsp;
																${member.nickname}
															</h4>
														</div>
													</div>
													<div class="row mb-4">
														<div class="col-md-11">
															<textarea class="form-control" id="statusMessage" name="statusMessage"
															placeholder="100자 이내로 자유롭게 기술해주세요." style="resize: none;" rows="3">${member.statusMessage}</textarea>
														</div>
													</div>
												</div>
											</c:if>
											<!-- memberRole owner일 때 프로필 이미지 옆 공간 -->
											<c:if test="${sessionScope.member.memberRole == 'owner'}">
												<div class="col-md-9" style="vertical-align:middle;margin-bottom: 55px;">
													<div class="row col-md-12">
														<h4 class="mb-1">
															이름&nbsp;&nbsp;
														</h4>
														${member.memberName}
													</div>
													<br/>
													<div class="row col-md-12">
														<h4 class="mb-1">
															아이디&nbsp;&nbsp;
														</h4>
														${member.memberId}
													</div>
													<br/>
												</div>
												<!-- 왜 선 안 그어지지? 이거 수정할 예정 -->
												<div class="row col-md-12">
													<div class="row col-md-12">
														<hr class="col-md-12"/>
														<div class="col-md-6">
															<label for="memberPhone">전화번호</label>
															<input type="text" id="memberPhone1" name="memberPhone1" value="${member.memberPhone.substring(0, 3)}" maxlength="3"/>
															<input type="text" id="memberPhone2" name="memberPhone2" value="${member.memberPhone.substring(4, 8)}" maxlength="4"/>
															<input type="text" id="memberPhone3" name="memberPhone3" value="${member.memberPhone.substring(9)}" maxlength="4"/>
															<div class="row">
																<span id="checkPhoneNumMsg" style="color: red; font-weight: bold; float:left"></span>
																<input type="button" value="인증번호 전송" style="float:right"/>
															</div>
														</div>
														<div class="col-md-6">
															<label for="certificatedNum">인증번호</label>
															<input type="text" id="certificatedNum" maxlength="6"/>
															<span id="checkCertificatedNumMsg" style="color: red; font-weight: bold"></span>
														</div>
														<br/>
													</div>
													<div class="row col-md-12">
														<div class="col-md-6">
															<label for="password">비밀번호</label> <input type="password"
																class="form-control" id="password" name="password"
																minlength="8" maxlength="15"
																placeholder="8-15자 이내로 입력해주세요." required>
															<span id="checkPwdMsg" style="color: red; font-weight: bold"></span>
														</div>
														<div class="col-md-6">
															<label for="checkPassword">비밀번호 확인</label> <input
																type="password" class="form-control" id="checkPassword"
																minlength="8" maxlength="15"
																placeholder="비밀번호를 다시 입력해주세요." required>
															<span id="checkSamePwdMsg" style="color: red; font-weight: bold"></span>
														</div>
													</div>
												</div>
											</c:if>
											<c:if test="${sessionScope.member.memberRole == 'admin'}">
												<div class="form-row col-md-9">
													<div class="col-md-2">
														<label>이름</label>
													</div>
													<div class="col-md-10">
														<h5>${member.memberName}</h5>
													</div>
													<br/>
													<div class="col-md-2">
														<label>아이디</label>
													</div>
													<div class="col-md-10">
														<h5>${member.memberId}</h5>
													</div>
												</div>
											</c:if>
										</div>
										<hr class="my-4" />
										<c:if test="${sessionScope.member.memberRole == 'user'}">
											<div class="form-row">
												<div class="col-6">
													<label for="memberName">이름</label> <span id="memberName"
														style="font-weight: bold">${member.memberName}</span>
												</div>
												<div class="col-6">
													<label for="memberId">아이디</label> <span id="memberId"
														style="font-weight: bold">${member.memberId}</span>
												</div>
											</div>
											<br />
											<div class="form-row">
												<c:if test="${member.loginType == '1'}">
													<div class="col-md-6">
														<label for="password">비밀번호</label> <input type="password"
															class="form-control" id="password" name="password"
															minlength="8" maxlength="15"
															placeholder="8-15자 이내로 입력해주세요." required>
														<span id="checkPwdMsg" style="color: red; font-weight: bold"></span>
													</div>
													<div class="col-md-6">
														<label for="checkPassword">비밀번호 확인</label> <input
															type="password" class="form-control" id="checkPassword"
															minlength="8" maxlength="15"
															placeholder="비밀번호를 다시 입력해주세요." required>
														<span id="checkSamePwdMsg" style="color: red; font-weight: bold"></span>
													</div>
												</c:if>
											</div>
											<br />
											<div class="form-row">
												<div class="col-md-6">
													<label for="memberPhone">전화번호</label>
													<input type="text" id="memberPhone1" name="memberPhone1" value="${member.memberPhone.substring(0, 3)}" maxlength="3"/>
													<input type="text" id="memberPhone2" name="memberPhone2" value="${member.memberPhone.substring(4, 8)}" maxlength="4"/>
													<input type="text" id="memberPhone3" name="memberPhone3" value="${member.memberPhone.substring(9)}" maxlength="4"/>
													<div class="row">
														<span id="checkPhoneNumMsg" style="color: red; font-weight: bold; float:left"></span>
														<input type="button" value="인증번호 전송" style="float:right"/>
													</div>
												</div>
												<div class="col-md-6">
													<label for="certificatedNum">인증번호</label>
													<input type="text" id="certificatedNum" maxlength="6"/>
													<span id="checkCertificatedNumMsg" style="color: red; font-weight: bold"></span>
												</div>
											</div>
											<br />
											<div class="form-row">
												<div class="col-6">
													<label for="ageRange">연령대</label>
													<!-- ageRange checked 확인 start -->
													<c:if test="${member.ageRange == '10대'}">
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
														<br/><br/>
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
													<c:if test="${member.ageRange == '20대'}">
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
														<br/><br/>
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
													<c:if test="${member.ageRange == '30대'}">
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
														<br/><br/>
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
													<c:if test="${member.ageRange == '40대'}">
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
														<br/><br/>
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
													<c:if test="${member.ageRange == '50대'}">
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
														<br/><br/>
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
													<c:if test="${member.ageRange == '60대 이상'}">
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
														<br/><br/>
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
													<!-- ageRange checked 확인 end -->
												</div>
												<div class="col-6">
													<!-- gender checked 확인 start -->
													<c:if test="${member.gender == 'male'}">
														<label for="gender">성별</label>
														<input class="form-check-input" type="radio" name="gender" id="gender1" value="male" checked>
														<label class="form-check-label" for="gender1">
														    남
														</label>
														<input class="form-check-input" type="radio" name="gender" id="gender2" value="female">
														<label class="form-check-label" for="gender2">
														    여
														</label>
													</c:if>
													<c:if test="${member.gender == 'female'}">
														<label for="gender">성별</label>
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
											</div>
										</c:if>
										<c:if test="${sessionScope.member.memberRole == 'admin'}">
											<div class="form-row col-md-12 mt-5">
												<div class="col-md-6">
													<label for="regDate">가입일</label> <span id="regDate"
														style="font-weight: bold">${member.regDate}</span>
												</div>
												<div class="col-md-6">
													<label for="reportCount">신고 당한 횟수</label> <span
														id="reportCount" style="font-weight: bold">${member.reportCount}</span>
												</div>
											</div>
											<br/>
											<div class="form-row col-md-12">
												<c:if test="${member.memberRole == 'user'}">
													<div class="col-md-6">
														<label for="blacklistDate">블랙리스트</label>
														<c:if test="${! empty member.blacklistDate}">
															<input type="radio" class="custom-control-input" id="checkBlacklist1" name="regBlacklist" value="true" checked> 
															<label for="checkBlacklist1">블랙리스트 등록</label>
															<input type="radio" class="custom-control-input" id="checkBlacklist0" name="regBlacklist" value="false"> 
															<label for="checkBlacklist0">블랙리스트 해제</label>
														</c:if>
														<c:if test="${empty member.blacklistDate}">
															<input type="radio" class="custom-control-input" id="checkBlacklist1" name="regBlacklist" value="true"> 
															<label for="checkBlacklist1">블랙리스트 등록</label>
															<input type="radio" class="custom-control-input" id="checkBlacklist0" name="regBlacklist" value="false" checked> 
															<label for="checkBlacklist0">블랙리스트 해제</label>
														</c:if>
													</div>
												</c:if>
												<!-- <div class="checkbox mb-12">
													<input type="checkbox" class="custom-control-input" id="checkBlacklist" value="" style="float:right;"/> 
													<label for="checkBlacklist">블랙리스트 설정/해제하기</label>
												</div> -->
												<div class="col-md-6">
													<label for="deleteDate">탈퇴일</label>
													<c:if test="${! empty member.deleteDate}">
														<span id="deleteDate"
															style="font-weight: bold">${member.deleteDate}</span>
													</c:if>
													<c:if test="${empty member.deleteDate}">
														<span id="deleteDate"
															style="font-weight: bold">X</span>
													</c:if>
												</div>
											</div>
										</c:if>
										<div align="center" class="mt-5">
											<input type="button" id="back" class="button secondary mr-3" value="이전" />
											<input type="button" id="updateMember-submit" class="button primary" value="수정" />
										</div>
									</form>
								</div>
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