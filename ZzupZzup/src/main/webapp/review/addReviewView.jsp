<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <jsp:include page="/layout/toolbar.jsp" />
 
 <script>
 window.onload = function() {
	  $(function () {
 		$("#btn").on("click", function() {
 			$("#review").attr("method", "POST").attr("action" , "/review/addReview").submit();
 		});
 	});
 }
 </script>
    
 <div class="container">
 	<form id="review">
		<div class="form-group">
		 	<div class="col-6 col-12-xsmall">
 				<input type="text" name="scopeClean" id="scopeClean">
 			</div>
		 </div>
		 
		 <div class="form-group">
		 	<div class="col-sm-4">
 			<input type="text" class="form-control" name="scopeTaste" id="scopeTaste">
 			</div>
		 </div>
		 
		 <div class="form-group">
		 	<div class="col-sm-4">
 				<input type="text" class="form-control" name="scopeKind" id="scopeKind">
 			</div>
		 </div>
		 
		 <div class="form-group">
		 	<div class="col-sm-4">
 				<input type="text" class="form-control" name="reviewDetail" id="reviewDetail">
		 	</div>
 	   	 </div>
 	   
 	   	 <div class="form-group">
		   	<div class="col-sm-offset-4  col-sm-4 text-center">
 	   			<button  type="button" id="btn"></button>
 	   		</div>
	  	 </div>
 	</form>
 </div>
    
 <jsp:include page="/layout/sidebar.jsp" />