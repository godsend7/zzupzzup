<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	#loginModal #login-view {
		padding: 10px;
	}

	#loginModal #login-view a {
		width:100%;
	}
	
	#loginModal #login-view input {
		margin-top: 15px;
		margin-bottom: 15px;
	}
</style>

<!-- kakao login api cdn -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script type="text/javascript">

	Kakao.init('e2b092b99c10982f7e28b410d1b6a8f4');							// initialize Kakao SDK
	console.log("Is Kakao SDK inintailized? :: "+Kakao.isInitialized());	// check Kakao SDK initailized

	$(function() {
		console.log("modal-archive.jsp");
		
		//login type == 1
		$("#login").on("click", function() {

			var memberId = $("input[type=email]").val();
			var password = $("input[type=password]").val();

			console.log("memberId:" + memberId);
			console.log("password:" + password);

			$.ajax({
				url : "/member/json/login",
				method : "POST",
				contentType : 'application/json',
				dataType : "json",
				data : JSON.stringify({
					"memberId" : memberId,
					"password" : password
				}),
				success : function(data) {
					if (data != null) {
						
						if(data.eliminated && !data.recovered) {
							alert("로그인 할 수 없습니다.");
						} else if(data.regBlacklist) {
							alert("블랙리스트로 등록된 계정입니다. 자세한 사항은 이메일(zzupzzup101@gmail.com)로 문의 바랍니다.");
						} else if(data.recovered) {
							var confirmRecovery = confirm("계정 복구를 진행하시겠습니까?")
							$.ajax({
								url : "/member/json/recoveryMember",
								method : "POST",
								contentType : 'application/json',
								dataType : "json",
								data : JSON.stringify({
									"memberId" : memberId,
									"password" : password,
									"recovered" : confirmRecovery
								}),
								success : function(result) {
									if(confirmRecovery) {
										alert("계정 복구가 완료되었습니다.");
										location.href = "/";
									} else {
										//alert("엥 그럼 왜 로그인 함?");
										alert("계정 복구가 취소되었습니다.");
									}
								},
								error : function(error) {
									alert(JSON.stringify(error));
								}
							})
						} else {
							//main.jsp로 이동
							location.href = "/";
						}
					}
				},
				error : function(error) {
					alert("아이디 또는 비밀번호가 잘못 입력되었습니다. 다시 확인하여 주세요.");
					//alert(JSON.stringify(error));
				}
			});
		});
		
		//login type == 2
		$("#kakaoLogin").on("click", function() {

			// 로그인 시도
		    Kakao.Auth.loginForm({
		        success: function(authObj) {
		          console.log(JSON.stringify(authObj));
		          console.log(Kakao.Auth.getAccessToken());
		          
		          var accessToken = authObj.access_token;
	              var refreshToken = authObj.refresh_token;
		        
		          // 로그인 성공 시 API 호출
		          Kakao.API.request({
		            url: '/v2/user/me',
		            success: function(result) {
		              //alert(JSON.stringify("[result] clientId : "+result.id+", memberId : "+result.kakao_account.email+", gender : "+result.kakao_account.gender+", age_range : "+result.kakao_account.age_range+", access_token : "+accessToken+", refresh_token : "+refreshToken));
		              
		              var clientId = result.id;
		              var memberId = result.kakao_account.email;
		              var gender = result.kakao_account.gender;
		              var age = result.kakao_account.age_range;
		              
		              $.ajax({
		                  url : "/member/json/checkIdDuplication?memberId="+memberId,
		                  method : "POST",
		                  headers : {
		                      "Accept" : "application/json",
		                      "Content-Type" : "application/json"
		                    },
		                  data : {
		                	  "memberId" : memberId
		                	},
		                  success : function(checkId){
		                      
		                      if(checkId) { //DB에 아이디가 없을 경우 => 회원가입
		                          console.log("DB 정보 없음");
		                          $("#login-view").after("<form id='kakao-login-value'>"
		              									+"<input type='hidden' name='memberId' value='"+memberId+"'>"
		              									+"<input type='hidden' name='gender' value='"+gender+"'>"
		              									+"<input type='hidden' name='age' value='"+age+"'>"
		                  								+"</form>");
		                          $("#kakao-login-value").attr("method","GET").attr("action","/member/addMember/user/2").submit();
		                          
		                      } else { //DB에 아이디가 존재할 경우 => 로그인
		                          console.log("DB 정보 있음");
		                          $.ajax({
		              				url : "/member/json/kakaoLogin",
	                				method : "POST",
	                				contentType : 'application/json',		                				
	                				dataType : "json",
		                			data : JSON.stringify({
		                				"memberId" : memberId
		                			}),
		                			success : function(data) {
		               					if (data != null) {
		               						if(data.eliminated && !data.recovered) {
		            							alert("로그인 할 수 없습니다.");
		            						} else if(data.regBlacklist) {
		            							alert("블랙리스트로 등록된 계정입니다. 자세한 사항은 이메일(zzupzzup101@gmail.com)로 문의 바랍니다.");
		            						} else if(data.recovered) {
		            							var confirmRecovery = confirm("계정 복구를 진행하시겠습니까?")
		            							$.ajax({
		            								url : "/member/json/recoveryMember",
		            								method : "POST",
		            								contentType : 'application/json',
		            								dataType : "json",
		            								data : JSON.stringify({
		            									"memberId" : memberId,
		            									"recovered" : confirmRecovery
		            								}),
		            								success : function(result) {
		            									if(confirmRecovery) {
		            										alert("계정 복구가 완료되었습니다.");
		            										location.href = "/";
		            									} else {
		            										//alert("엥 그럼 왜 로그인 함?");
		            										alert("계정 복구가 취소되었습니다.");
		            									}
		            								},
		            								error : function(error) {
		            									alert(JSON.stringify(error));
		            								}
		            							})
		            						} else {
		            							//main.jsp로 이동
		            							location.href = "/";
		            						}
		               					}
		               				}
		               			});
		                      }
		                  }
		              })
		            },
		            fail: function(error) {
		              alert(JSON.stringify(error));
		            }
		          });
		                  
		        },
		        fail: function(err) {
		          alert(JSON.stringify(err));
		        }
		      });
			
		});
		
		//findAccount
		$("#findAccount-btn").on("click", function() {

			var memberName = $("#memberName").val();
			var memberId = $("#memberId-find").val();
			var memberPhone = $("#memberPhone1").val()+"-"+$("#memberPhone2").val()+"-"+$("#memberPhone3").val();

			console.log("memberName:" + memberName);
			console.log("memberId:" + memberId);
			console.log("memberPhone:" + memberPhone);

			if(memberName != "" && (memberId != "" || ($("#memberPhone1").val() != "" && $("#memberPhone2").val() != "" && $("#memberPhone3").val() != ""))) {
				//alert("들어왔니?");
				$.ajax({
					url : "/member/json/findAccount",
					method : "POST",
					contentType : 'application/json',
					dataType : "json",
					data : JSON.stringify({
						"memberName" : memberName,
						"memberId" : memberId,
						"memberPhone" : memberPhone
					}),
					success : function(data) {
						//alert("왜 ... 안 타는데 ...");
						if (data != null) {
							if(memberId != null) {	//비밀번호 찾기
								//alert("이거 안 타나?");
								if(data.loginType == 1) {
									$("#find-check").html("<h4>입력하신 회원님의 메일 주소로 비밀번호 재설정 링크를 발송하였습니다.</h4>");
								} else {
									$("#find-check").html("<h4>SNS 계정으로 가입한 회원은 비밀번호를 재설정할 수 없습니다.</h4>");
								}
							} else if($("#memberPhone1").val() != null && $("#memberPhone2").val() != null && $("#memberPhone3").val() != null) {		//아이디 찾기
								//alert("너도 안 타니?");
								$("#find-check").html("<h4>요청하신 회원님의 ID는 " 
														+"<strong>["+data.memberId+"]("+data.loginType+")</strong>"
														+"입니다.</h4>");
							}
						} else {
							alert("해당하는 정보가 없습니다.");
						}
					},
					error: function(request, status, error) {
						alert("에러만 잘 나고 ...");
						alert("request : "+request.status+"\n message : "+request.responseText+"\n error : "+error);
					}
				});	
			} else {
				alert("누락된 항목 확인 후 다시 시도하여 주십시오.");
			}
			
		});
		
		//deleteMember
		$("#checkPwdForDelete-btn").on("click", function() {

			var memberId = "${sessionScope.member.memberId}";
			var password = $("#password-forDelete").val();
			var deleteType = $("input[name=deleteType]:checked").val();
			var deleteReason = $("textarea[name=deleteReason]").val();
			var loginType = "${sessionScope.member.loginType}";

			console.log("memberId:" + memberId);
			console.log("password:" + password);
			console.log("deleteType:" + deleteType);
			console.log("deleteReason:"+deleteReason);
			console.log("loginType:"+loginType);

			$.ajax({
				url : "/member/json/deleteMember",
				method : "POST",
				contentType : 'application/json',
				dataType : "json",
				data : JSON.stringify({
					"memberId" : memberId,
					"password" : password,
					"deleteType" : deleteType,
					"deleteReason" : deleteReason,
					"loginType" : loginType
				}),
				success : function(data) {
					if (data.loginType == 1) {
						alert("탈퇴 처리가 완료되었습니다.");
						location.href = "/";
					} else if(data.loginType == 2) {
						unlinkKakao();
						alert("탈퇴 처리가 완료되었습니다.");
						location.href = "/";
					}
				},
				error : function(request, status, error) {
					//alert("에러 왜 뜨는데");
					alert("request : "+request.status+"\n message : "+request.responseText+"\n error : "+error);
				}
			});
		});
		
		//logout
		$("#logout").on("click", function() {
			if(${sessionScope.member.loginType == 1}){
				$(self.location).attr("href", "/member/logout");
			} else if(${sessionScope.member.loginType == 2}) {
				logoutFromKakao();
				$(self.location).attr("href", "/member/logout");
			}
			
		});
		
		//계정 찾기 클릭 시 로그인 모달 닫기
		$("#findAccountModal-nav").on("click", function() {
			$("#loginModal").modal("hide");
		})
		
		//아이디 찾기 탭 클릭 시 
		$("#findId").on("click", function() {
			$("#findId a").attr("class", "nav-link active");
			$("#findPwd a").attr("class", "nav-link");
			$("#find-form").html("<div class='col-md-11 form-row' style='margin-left: 20px;margin-top: 10px;'>"
									+"<label for='memberName' class='col-md-2'>이름</label>"
									+"<input type='text' id='memberName' name='memberName' class='col-md-9' Placeholder='이름을 입력해주세요.'/>"
								  +"</div>"
								  +"<div class='col-md-11 form-row' style='margin-left: 20px;margin-top: 10px;'>"
									+"<label for='memberPhone' class='col-md-2'>전화번호</label>"
									+"<input type='text' id='memberPhone1' name='memberPhone1' class='col-md-3' maxlength='3'/>&nbsp;&#45;&nbsp;"
									+"<input type='text' id='memberPhone2' name='memberPhone2' class='col-md-3' maxlength='4'/>&nbsp;&#45;&nbsp;"
									+"<input type='text' id='memberPhone3' name='memberPhone3' class='col-md-3' maxlength='4'/>"
								  +"</div>");
			$("#find-check").html("");
		});
		
		$("#findPwd").on("click", function() {
			$("#findId a").attr("class", "nav-link");
			$("#findPwd a").attr("class", "nav-link active");
			$("#find-form").html("<div class='col-md-11 form-row' style='margin-left: 20px;margin-top: 10px;'>"
									+"<label for='memberName' class='col-md-2'>이름</label>"
									+"<input type='text' id='memberName' name='memberName' class='col-md-9' Placeholder='이름을 입력해주세요.'/>"
								  +"</div>"
								  +"<div class='col-md-11 form-row' style='margin-left: 20px;margin-top: 10px;'>"
									+"<label for='memberId' class='col-md-2'>아이디</label>"
									+"<input type='text' id='memberId-find' name='memberId' class='col-md-9' Placeholder='아이디를 입력해주세요.'/>"
								  +"</div>");
			$("#find-check").html("");
		});
		
		//1,2,3 체크 시
		$("#deleteType1").on("change", function() {
			if($("#deleteType1").prop("checked")) {
				$("#checked-etc").html("");
			}
		});
		
		$("#deleteType2").on("change", function() {
			if($("#deleteType2").prop("checked")) {
				$("#checked-etc").html("");
			}
		});
		
		$("#deleteType3").on("change", function() {
			if($("#deleteType3").prop("checked")) {
				$("#checked-etc").html("");
			}
		});
		
		//기타 사유가 체크 되었을 시
		$("#deleteType4").on("change", function() {
			if($("#deleteType4").prop("checked")) {
				$("#checked-etc").html("<h5>기타 사유 입력</h5>"
										+"<textarea class='form-control' id='deleteReason' name='deleteReason'"
										+"placeholder='100자 이내로 자유롭게 기술해주세요.' style='resize: none;' rows='3'></textarea>");
			}
		});
		
		//상대 프로필 조회
		$(document).on("click", ".getOtherUserModal", function () { 
			console.log($(this).data('id'));
			
			var memberId = $(this).data('id');
			
			$.ajax({
				url : "/member/json/getOtherUser",
				method : "POST",
				contentType : 'application/json',
				dataType : "json",
				data : JSON.stringify({
					"memberId" : memberId
				}),
				success : function(data) {
					if (data != null) {
						$("#get-other-user-modal-body").html("<div class='row mt-5 align-items-center'>"
									+"<div class='col-md-4 mb-5'>"
									+"<div align='center' id='get-other-user-profile-image'>"
									+"</div></div>"
									+"<div class='col-md-8'>"
									+"<div class='row align-items-right'>"
									+"<div class='col-md-7'>"
									+"<h4 class='mb-1'>"
									+"<span class='badge badge-pill badge-dark' style='background-color: #f56a6a;'>"+data.memberRank+"</span>&nbsp;"
									+"<span class='badge badge-pill badge-dark' style='background-color: #f56a6a;'>"+data.ageRange+"</span>&nbsp;"
									+"<span class='badge badge-pill badge-dark' style='background-color: #f56a6a;' id='get-other-user-gender'>"
									+"</span>&nbsp;&nbsp;"+data.nickname+"</h4>"
									+"</div></div>"
									+"<div class='row mb-4'>"
									+"<div class='col-md-7'>"
									+"<p class='text-muted'>"+data.statusMessage+"</p>"
									+"</div></div></div></div>");
						
						if(data.profileImage == "defaultImage.png") {
							$("#get-other-user-profile-image").html("<img src='/resources/images/defaultImage.png'"
																	+"class='avatar-img rounded-circle' width='150' height='150'/>"
																	+"<br/>"
																	+"<span id='mannerScore' style='font-weight: bold'>"
																	+"<svg xmlns='http://www.w3.org/2000/svg' width='10' height='10'"
																	+"fill='#b01025' class='bi bi-heart-fill' viewBox='0 0 16 16'>"
																  	+"<path fill-rule='evenodd' d='M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z'/>"
																	+"</svg> "+data.mannerAllScore+"</span>");
						} else {
							$("#get-other-user-profile-image").html("<img src='/resources/images/uploadImages/"+data.profileImage+"'"
																	+"class='avatar-img rounded-circle' width='150' height='150'/>"
																	+"<br/>"
																	+"<span id='mannerScore' style='font-weight: bold'>"
																	+"<svg xmlns='http://www.w3.org/2000/svg' width='10' height='10'"
																	+"fill='#b01025' class='bi bi-heart-fill' viewBox='0 0 16 16'>"
																  	+"<path fill-rule='evenodd' d='M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z'/>"
																	+"</svg> "+data.mannerAllScore+"</span>");
						}
						
						if(data.gender == "male") {
							$("#get-other-user-gender").text("남자");
						} else {
							$("#get-other-user-gender").text("여자");
						}
						
					}
				},
				error : function(request, status, error) {
					//alert("에러 왜 뜨는데");
					alert("request : "+request.status+"\n message : "+request.responseText+"\n error : "+error);
				}
			})
		});
		
		
	});
	
	//*logout kakao  
	function logoutFromKakao() {
		
	    if (Kakao.Auth.getAccessToken()) {
	      Kakao.Auth.logout(function() {})
	    } else {
	    	alert("로그인 상태가 아닙니다.");
	    	return;
	    }
	  }  
	
	//*unlink kakao  
	function unlinkKakao() {
		Kakao.API.request({
		  url: '/v1/user/unlink',
		  success: function(response) {
		    console.log(response);
		    
		  },
		  fail: function(error) {
		    console.log(error);
		  },
		});
	  }
</script>



<!-- login modal -->
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
				<form class="form-signin" id="login-view">
					<!-- <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
					<h6 class="h6 mb-6 font-weight-normal" style="margin-bottom: 20px;">로그인 후 이용하여 주십시오.</h6>
					<label for="memberId" class="sr-only">Email address</label> <input
						type="email" id="memberId" name="memberId" class="form-control"
						placeholder="example@zzupzzup.com" required autofocus> <label
						for="password" class="sr-only">Password</label> <input
						type="password" id="password" name="password" class="form-control"
						placeholder="비밀번호를 입력해주세요." required>
					<br/>
					<a class="button" id="login">login</a>
					<hr>
					<div align="center" style="margin-top:5px;">
						<a id="kakaoLogin" href="#">
						  <img
						    src="/resources/images/common/kakao_login_medium_wide.png"
						    width="280"
						    alt="카카오 로그인 버튼" />
						</a>
					</div>
					<!-- <input
						class="btn btn-lg btn-primary btn-block" id="naverLogin"
						type="button" value="네이버 로그인 (구현 예정)" /> --><br/><br/>
					<div align="right">
						회원이 아니신가요? > 
						<a href="/member/addMember/user/1">유저</a>&nbsp;/
						<a href="/member/addMember/owner/1">업주</a>
					</div>
					<div align="right">
						<a id="findAccountModal-nav" data-toggle="modal" data-target="#findAccountModal">아이디/비밀번호 찾기 ></a>
					</div>
					<!-- <p class="mt-5 mb-3 text-muted">&copy; 2017-2021</p> -->
				</form>
			</div>
		</div>
	</div>
</div>

<!-- ID, PWD 찾기 modal -->
<div class="modal fade" id="findAccountModal" tabindex="-1" role="dialog"
	aria-labelledby="findAccountModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title" id="findAccountModalLabel">계정 찾기</h2>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<ul class="nav nav-tabs findAccount-top-tabs">
				  	<li class="nav-item" id="findId">
				    	<a class="nav-link active" id="findId-tab" href="#">아이디 찾기</a>
				  	</li>
				  	<li class="nav-item" id="findPwd">
				    	<a class="nav-link" id="findPwd-tab" href="#">비밀번호 찾기</a>
				  	</li>
				</ul>
				<form id="form-findAccount">
					<div id="find-form" style="margin-left: 0px;margin-right: 0px;">
						<div class="col-md-11 form-row" style="margin-left: 20px;margin-top: 10px;">
							<label for="memberName" class="col-md-3">이름</label>
							<input type="text" id="memberName" name="memberName" class="col-md-9" Placeholder="이름을 입력해주세요."/>
						</div>
						<div class="col-md-11 form-row" style="margin-left: 20px;margin-top: 10px;">
							<label for="memberPhone1" class="col-md-3">전화번호</label>
							<input type="text" id="memberPhone1" name="memberPhone1" class="col-md-2" maxlength="3"/>&nbsp;&#45;&nbsp;
							<input type="text" id="memberPhone2" name="memberPhone2" class="col-md-3" maxlength="4"/>&nbsp;&#45;&nbsp;
							<input type="text" id="memberPhone3" name="memberPhone3" class="col-md-3" maxlength="4"/>
						</div>
					</div>
				</form>
				<div id="find-check" align="center"></div>
			</div>
			<div class="modal-footer">
		      <input type="button" class="btn btn-primary" id="findAccount-btn" value="확인">
		    </div>
		</div>
	</div>
</div>

<!-- 회원탈퇴 modal -->
<div class="modal fade" id="deleteMemberModal" tabindex="-1" role="dialog"
	aria-labelledby="deleteMemberModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title" id="deleteMemberModalLabel">회원 탈퇴</h2>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="form-deleteMember">
					<h5>탈퇴 사유</h5>
					<div class="form-row col-md-12">
						<input type="radio" class="custom-control-input" id="deleteType1" name="deleteType" value="1" checked> 
						<label for="deleteType1" class="">더 이상 이 서비스를 이용하고 싶지 않아서</label>
						<input type="radio" class="custom-control-input" id="deleteType2" name="deleteType" value="2"> 
						<label for="deleteType2">기존의 타 사이트를 이용하고 있어서</label>
						<input type="radio" class="custom-control-input" id="deleteType3" name="deleteType" value="3"> 
						<label for="deleteType3">탈퇴 후 재가입을 위해서</label>
						<input type="radio" class="custom-control-input" id="deleteType4" name="deleteType" value="4"> 
						<label for="deleteType4">기타 사유(직접 입력)</label>
					</div>
					<div id="checked-etc" class="col-md-12"></div>
					<br/>
					<h5 align="center"><strong style='color:red;'>탈퇴 후 7일 이내에 접속 시 계정이 복구되며, 탈퇴한 계정은 다시 이용할 수 없습니다.</strong></h5>
				</form>
			</div>
			<div class="modal-footer">
			<c:if test="${member.loginType == 1}">
				<a id="checkPwdForDeleteModal-nav" data-toggle="modal" data-target="#checkPwdForDeleteModal">
			      	<input type="button" class="btn btn-primary" id="deleteMember-btn" value="확인">
			      </a>
			</c:if>
		    <c:if test="${member.loginType != 1}">
				<input type="button" class="btn btn-primary" id="checkPwdForDelete-btn" value="확인">
			</c:if>  
		    </div>
		</div>
	</div>
</div>

<!-- 회원탈퇴 전 비밀번호 확인 modal -->
<div class="modal fade" id="checkPwdForDeleteModal" tabindex="-1" role="dialog"
	aria-labelledby="checkPwdForDeleteModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title" id="checkPwdForDeleteModalLabel">회원 탈퇴</h2>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="checkPwdForDelete-form">
					<div class="col-md-12" align="center">
						<h4>본인 확인을 위해 비밀번호를 입력하여 주세요.</h4>
						<br/>
						<input type="password" name="password" id="password-forDelete" class="col-md-7"/>
					</div>
				</form>
			</div>
			<div class="modal-footer">
		      <input type="button" class="btn btn-primary" id="checkPwdForDelete-btn" value="확인">
		    </div>
		</div>
	</div>
</div>

<!-- 상대 프로필 modal -->
<div class="modal fade" id="getOtherUserModal" tabindex="-1" role="dialog"
	aria-labelledby="checkPwdForDeleteModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title" id="checkPwdForDeleteModalLabel">프로필</h2>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" id="get-other-user-modal-body">
				<%-- <form id="getOtherUser-form">
					<input type="hidden" name="memberId" value="${member.memberId}"/>
				</form> --%>
			<!-- <div class="modal-footer">
		      <input type="button" class="btn btn-primary" id="checkPwdForDelete-btn" value="확인">
		    </div> -->
		    </div>
		</div>
	</div>
</div>