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
	.badge-dark {
    	background-color: #f56a6a;
	}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("getMember.jsp");
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

				<section id="getMember">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-12 col-lg-10 col-xl-8 mx-auto">
								<h2 class="h3 mb-4 page-title">내 정보 조회</h2>
								<div class="my-4">
									<form id="getMember">
										<div class="row mt-5 align-items-center">
											<div class="col-md-3 mb-5">
												<div class="col-md" align="center">
													<img
														src="/resources/images/uploadImages/${member.profileImage}"
														class="avatar-img rounded-circle" width="150" /> <br />
													<c:if test="${sessionScope.member.memberRole == 'user'}">
														<span
															id="mannerScore" style="font-weight: bold">
															<svg
																xmlns="http://www.w3.org/2000/svg" width="10" height="10"
																fill="#b01025" class="bi bi-heart-fill"
																viewBox="0 0 16 16">
															  <path fill-rule="evenodd"
																	d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"
																	/>
															</svg> ${member.mannerScore}
														</span>
													</c:if>
												</div>
											</div>
											<div class="col-md-5">
												<div class="row align-items-right">
													<div class="col-md-7">
														<h4 class="mb-1">
															<c:if test="${sessionScope.member.memberRole == 'user'}">
																<span class="badge badge-pill badge-dark">${member.memberRank}</span>&nbsp;&nbsp;
															</c:if>
															${member.nickname}
														</h4>
													</div>
												</div>
												<div class="row mb-4">
													<div class="col-md-7">
														<p class="text-muted">${member.statusMessage}</p>
													</div>
												</div>
											</div>
										</div>
										<input type="button" style="float: right"
											class="btn btn-primary" value="수정하기" /> <br />
										<hr class="my-4" />
										<div class="form-row">
											<div class="col-6">
												<label for="memberName">이름</label> <span id="memberName"
													style="font-weight: bold">${member.memberName}</span>
											</div>
											<div class="col-6">
												<label for="email">이메일</label> <span id="email"
													style="font-weight: bold">${member.memberId}</span>
											</div>
										</div>
										<br />
										<div class="form-row">
											<div class="col-6">
												<label for="memberPhone">전화번호</label> <span id="memberPhone"
													style="font-weight: bold">${member.memberPhone}</span>
											</div>
										</div>
										<c:if test="${sessionScope.member.memberRole != 'owner'}">
											<br />
											<div class="form-row">
												<div class="col-6">
													<label for="ageRange">연령대</label> <span id="ageRange"
														style="font-weight: bold">${member.ageRange}</span>
												</div>
												<div class="col-6">
													<label for="gender">성별</label> <span id="gender"
														style="font-weight: bold"> <c:if
															test="${member.gender == 'male'}">
													남자
													</c:if> <c:if test="${member.gender == 'female'}">
													여자
													</c:if>
													</span>
												</div>
											</div>
										</c:if>
										<c:if test="${sessionScope.member.memberRole == 'admin'}">
											<hr class="my-4"/>
											<div class="form-row">
												<div class="col-6">
													<label for="regDate">가입일</label> <span id="regDate"
														style="font-weight: bold">${member.regDate}</span>
												</div>
												<div class="col-6">
													<label for="reportCount">신고 당한 횟수</label> <span
														id="reportCount" style="font-weight: bold">${member.reportCount}</span>
												</div>
											</div>
											<br/>
											<div class="form-row">
												<c:if test="${! empty member.deleteDate}">
													<div class="col-6">
														<label for="deleteDate">탈퇴일</label> <span id="deleteDate"
															style="font-weight: bold">${member.deleteDate}</span>
													</div>
												</c:if>
												<c:if test="${! empty member.blacklistDate}">
													<div class="col-6">
														<label for="blacklistDate">블랙리스트</label> <span id="blacklistDate"
															style="font-weight: bold">${member.blacklistDate}</span>
													</div>
												</c:if>
											</div>
										</c:if>
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