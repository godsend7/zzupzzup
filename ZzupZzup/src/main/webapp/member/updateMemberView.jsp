<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-getMember</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("updateMemberView.jsp");
		console.log("${member.profileImage}");
		/* var memberRole = ${sessionScope.member.memberRole};
		var checkBlacklist = $("#regBlacklist").prop("checked"); */
		
		$("#updateMember-complete").on("click", function() {
			//location.href = "/member/updateMember";
			$("#updateMember").attr("method","POST").attr("action","/member/updateMember?memberId=${member.memberId}").submit();
		})
		
	});
	
	$(function() {
		//인증번호 전송
		$("input[value='인증번호 전송']").on("click", function() {
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

				<section id="updateMember-section">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-12 col-lg-10 col-xl-8 mx-auto">
								<h2 class="h3 mb-4 page-title">내 정보 수정</h2>
								<div class="my-4">
									<form id="updateMember">
									<input type="hidden" id="member-id-hidden" value="${param.memberId}"/>
									<%-- <input type="hidden" id="profile-image-hidden" value="${member.profileImage}"/> --%>
										<div class="row mt-5 align-items-center">
											<div class="col-md-3 mb-5" id="edit-profileImage">
												<div class="col-md" align="center">
													<!-- profileImage 도윤님 src start -->
														<input class="file-drag-input" type="file" id="fileDragInput" name="fileDragInput" value="${member.profileImage}">
														<input type="hidden" id="profileImage" name="profileImage" value="${member.profileImage}">
													<div class="file-view mt-4">
														<c:if test="${member.profileImage == 'defaultImage.png'}">
															<img src="/resources/images/${member.profileImage}" class="rounded-circle" width="150" height="150"/>
														</c:if>
														<c:if test="${member.profileImage != 'defaultImage.png'}">
															<img src="/resources/images/uploadImages/${member.profileImage}" class="rounded-circle" width="150" height="150"/>
														</c:if>
													</div>
													<div style="margin-top:10px;margin-left:5px;">
														<span class="file-drag-btn">프로필 편집</span>
													</div>
													<!-- profileImage 도윤님 src end -->
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
															<textarea class="form-control" id="stateMessage" name="stateMessage"
															placeholder="100자 이내로 자유롭게 기술해주세요." rows="3">${member.statusMessage}</textarea>
														</div>
													</div>
												</div>
											</c:if>
											<!-- memberRole owner일 때 프로필 이미지 옆 공간 -->
											<c:if test="${sessionScope.member.memberRole == 'owner'}">
												<div class="col-md-9" style="vertical-align:middle;margin-bottom: 55px;">
													<div class="col-md-7">
														<h4 class="mb-1">
															이름
														</h4>
														${member.memberName}
													</div>
													<br/>
													<div class="col-md-7">
														<h4 class="mb-1">
															아이디
														</h4>
														${member.memberId}
													</div>
													<br/>
													<div class="col-md-7">
														<h4 class="mb-1">
															전화번호
														</h4>
														<input type="text" id="memberPhone" value="${member.memberPhone}"/>
													</div>
												</div>
											</c:if>
											<c:if test="${sessionScope.member.memberRole == 'admin'}">
												<div class="form-row col-md-9" style="margin-bottom:40px">
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
										<br/>
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
													</div>
													<div class="col-md-6">
														<label for="checkPassword">비밀번호 확인</label> <input
														type="password" class="form-control" id="checkPassword"
														minlength="8" maxlength="15"
														placeholder="비밀번호를 다시 입력해주세요." required>
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
													<input type="button" value="인증번호 전송" style="float:right"/>
												</div>
												<div class="col-md-6">
													<label for="certificeatedNum">인증번호</label>
													<input type="text" id="certificeatedNum" maxlength="6"/>
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
										<c:if test="${sessionScope.member.memberRole == 'owner'}">
											<div class="form-row">
												<div class="col-6">
													<h4 align="left"><strong>등록된 음식점 목록</strong></h4>
												</div>
												<div class="col-6">
													<a href="/restaurant/addRestaurant">
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16" id="addRestaurant-ownerPage" style="float:right;">
														  <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"/>
														</svg>
													</a>
												</div>
												<!-- 등록된 음식점 수 띄우기 -->
												<c:if test="${restaurant.member.memberId == member.memberId}">
													<c:forEach var="restaurant" items="${list}">
														<div class="col-12">
															<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
																<div class="col p-4 d-flex flex-column position-static">
																	<c:if test="${restaurant.reservationStatus = true}">
																		<div style="text-align: right;"><span class="badge badge-info">예약 및 결제 가능</span></div>
																	</c:if>
																	<!-- <a style="text-align: right;"><strong class="d-inline-block mb-2 text-primary">불량음식점</strong></a> -->
																	<h2 class="mb-0">${restaurant.restaurantName}&nbsp;<small style="color:gray;">${restaurant.returnMenuType}</small></h2><hr>
																	<div class="mb-1 text-muted"><strong>대표자명</strong> | ${restaurant.member.memberName}</div>
																	<div class="mb-1 text-muted"><strong>주소</strong> | ${restaurant.streetAddress}</div>
																	<div class="mb-1 text-muted"><strong>전화번호</strong> | ${restaurant.restaurantTel}</div>
																	<a href="/restaurant/getRestaurant?restaurantNo=${restaurant.restaurantNo}" style="text-align: right;" class="stretched-link" id="restinfo">상세보기</a>
																</div>
															</div>
														</div>
													</c:forEach>
												</c:if>
											</div>
										</c:if>
										<c:if test="${sessionScope.member.memberRole == 'admin'}">
											<hr class="my-4"/>
											<div class="form-row col-md-12">
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
												<c:if test="${! empty member.deleteDate}">
													<div class="col-md-6">
														<label for="deleteDate">탈퇴일</label> <span id="deleteDate"
															style="font-weight: bold">${member.deleteDate}</span>
													</div>
												</c:if>
												<c:if test="${! empty member.blacklistDate}">
													<div class="col-md-6">
														<label for="blacklistDate">블랙리스트</label>
														<span id="blacklistDate"
															style="font-weight: bold">${member.blacklistDate}</span>
													</div>
													<div class="checkbox mb-12">
														<br/>
														<input type="checkbox" class="custom-control-input" id="regBlacklist" value="" style="float:right;"/> 
														<label for="regBlacklist">블랙리스트 설정/해제하기</label>
													</div>
												</c:if>
											</div>
										</c:if>
										<hr class="my-4" />
										<input type="button" style="float: right" id="updateMember-complete"
											class="btn btn-primary" value="수정" />
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