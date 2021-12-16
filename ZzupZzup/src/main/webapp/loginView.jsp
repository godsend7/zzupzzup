<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html>
	
<head>
	<meta charset="EUC-KR">
	
	<title>로그인 화면</title>
	<!-- client Id를 meta Tag를 통해 부여 (init method로 사용 시 불필요) -->
	<!-- <meta name ="google-signin-client_id" content="329512929952-8u0grve26uikqovpi0sb4khlruv8qevg.apps.googleusercontent.com"> -->
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	
	<!-- Google login Platform Library (Google Sign-in) -->
  	<script src="https://apis.google.com/js/client:platform.js?onload=init" async defer></script>
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
    <script>
    	function checkLoginStatus() {
    		//현재 로그인이 되어있는 상태인지 판별
			if (googleAuth.isSignedIn.get()) {
				console.log('login');
				
			} else {
				console.log('logout');
			}
    	}
    
    	function init() {
    		console.log('init');
    		gapi.load('auth2', function() {
    			/* gapi.auth2.init();
    			options = new gapi.auth2.SigninOptionsBuilder();
    			options.setPrompt('select_account');
    			options.setScope('email profile openid https://www.googleapis.com/auth/user/birthday.read'); */
    			console.log('auth2');
    			window.googleAuth = gapi.auth2.init({
    				client_id: '329512929952-8u0grve26uikqovpi0sb4khlruv8qevg.apps.googleusercontent.com',
    				scope : 'email profile openid',
    				/* prompt : 'select_account' */
    				response_type : 'code',
    				access_type:'offline'
    			})
    			

    			//then 첫번째 인자 값 => init(초기화)에 성공 시 함수를 리턴
    			//then 두번째 인자 값 => error가 발생했을 때 함수를 리턴
    			googleAuth.then(function() {
    				console.log('googleAuth success');
    				checkLoginStatus();
    			}, function() {
    				console.log('googleAuth fail');
    			});
    		});
    	}
    	
    	$(function() {
    		$('#signinButton').click(function() {
        	    // signInCallback defined in step 6.
        	    googleAuth.grantOfflineAccess().then(signInCallback);
        	});
    	});
    	
    </script>
    
    <!-- <script>
	    function onSignIn(googleUser) {
	    	var profile = googleUser.getBasicProfile();
	    	console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
	    	console.log('Name: ' + profile.getName());
	    	console.log('Image URL: ' + profile.getImageUrl());
	    	console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
	    }
    </script> -->
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		
		//============= "로그인"  Event 연결 =============
		$(function(){
			$("#userId").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#loginChek").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
				
				$.ajax( 
						{
							url : "/user/json/login",
							method : "POST" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify({
								userId : id,
								password : pw
							}),
							success : function(JSONData , status) {
								//Debug...
								//alert(status);
								//alert("JSONData : \n"+JSONData);
								//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
								//alert( JSONData != null );
								
								if( JSONData != null ){
									//[방법1]
									$(window.parent.document.location).attr("href","/index.jsp");
									
									//[방법2]
									//window.parent.document.location.reload();
									
									//[방법3]
									//$(window.parent.frames["topFrame"].document.location).attr("href","/layout/top.jsp");
									//$(window.parent.frames["leftFrame"].document.location).attr("href","/layout/left.jsp");
									//$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+JSONData.userId);
									//==> 방법 1 , 2 , 3 결과 학인
								}else{
									alert("아이디 , 패스워드를 확인하시고 다시 로그인...");
								}
							},
							error : function() {
								alert("아이디 , 패스워드를 다시 확인해주세요!!");
							}
					}); 
			});
		});
			
		//============= 회원원가입화면이동 =============
		$( function() {
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
	</script>		
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">
		
			<div class="col-md-6">
					<img src="/images/logo-spring.png" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>

			        <form id="login" class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">아 이 디</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">패 스 워 드</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary" id="loginChek" >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
					    </div>
					    <div class="col-sm-offset-4 col-sm-6 text-center" id="signinButton">
					      <img src='/images/btn_google_signin_dark_normal_web@2x.png' width="150px" >
					    </div>
					  </div>
					</form>
					
					<form id="snsLogin">
						<input type="hidden" name="userId" value=""/>
						<input type="hidden" name="userName" value=""/>
					</form>
			   	 </div>
			
			</div>
			
  	 	</div>
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
 	</div>
 	<!--  화면구성 div end /////////////////////////////////////-->

<script>
function signInCallback(authResult) {
  var snsName;
  var snsEmail;
  console.log(authResult);
  if (authResult['code']) {
	
    var profile = googleAuth.currentUser.get().getBasicProfile();
    snsName = profile.getName();
    snsEmail = profile.getEmail();
    // Send the code to the server
    $.ajax({
      type: 'POST',
      url: 'http://localhost:8070/user/json/googleCheck',
      // Always include an `X-Requested-With` header in every AJAX request,
      // to protect against CSRF attacks.
      dataType : 'json',
      data: {
	    userName : snsName,
	    email : snsEmail
	  },
      success: function(data) {
        // Handle or verify the server response.
        console.log(data.userId);
        if (data.userId != null) {
			self.location='../index.jsp';
		} else {
			$('input[name=userName]').attr('value',snsName);
			$('input[name=userId]').attr('value',snsEmail);
			$("#snsLogin").attr("method","POST").attr("action","/user/addSNSLoginUser").attr("target","_parent").submit();
		}
      },
      error: function(data) {
    	  console.log(data);
      }
    });
  } else {
    // There was an error.
	//window.location.reload();
  }
}
</script>
</body>

</html>