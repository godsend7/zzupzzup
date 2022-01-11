<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
.report-form {
	text-align: center;
}

.reportDetail {
	text-align: left;
}

.report-hidden {
	display: none;
}

.reportTypeBox {
	text-align: left;
}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	var reportCategory = ""; 
	var toReport = "";
	
	$(document).on("click", ".reportModal", function () { 
		$(this).removeData('id');
		var reportArray = $(this).data('id');
		//console.log(reportArray);
		reportCategory = reportArray[0];
		toReport = reportArray[1];
		
		if (reportArray[0] == 1) {
			console.log("채팅방 신고");
			$(".h5").text("채팅방 신고");
			$(".reportType1").text("허위 광고성 채팅방입니다.");
			$(".reportType2").text("부적절한 언행을 사용하였습니다.");
			$(".reportType3").parent("div").attr("class","report-hidden");
		} else if (reportArray[0] == 2) {
			console.log("채팅방 참여자 신고");
			$(".h5").text("채팅방 참여자 신고");
			$(".reportType1").text("돈을 지불하지 않았습니다.");
			$(".reportType2").text("부적절한 언행을 사용하였습니다.");
			$(".reportType3").text("약속에 불참하였습니다.");
		} else if (reportArray[0] == 3) {
			console.log("리뷰 신고");
			$(".h5").text("리뷰 신고");
			$(".reportType1").text("허위 광고성 리뷰입니다.");
			$(".reportType2").text("부적절한 언어를 사용하였습니다.");
			$(".reportType3").text("해당 음식점과 일치하지 않는 내용입니다.");
		} else if (reportArray[0] == 4) {
			console.log("게시물 신고");
			$(".h5").text("게시물 신고");
			$(".reportType1").text("허위 광고성 게시물입니다.");
			$(".reportType2").text("부적절한 언어를 사용하였습니다.");
			$(".reportType3").text("해당 음식점에 일치하지 않는 영수증이 아닙니다.");
		} else if (reportArray[0] == 5) {
			console.log("음식점 제보");
			$(".h5").text("음식점 제보");
			$(".reportType1").text("일치하지 않는 정보를 제공하고 있습니다.");
			$(".reportType2").text("영업시간이 다릅니다.");
			$(".reportType3").text("폐점된 가게입니다.");
		}
		
		$("input[name='reportCategory']").val(reportCategory);
		
	});
	
	$(function() {
		$("#addReport").on("click", function() {
			console.log(toReport);
			$("input[name='toReport']").val(toReport);
			$("#report").attr("method", "POST").attr("action", "/report/addReport").submit();
		});
	});
</script>


<!-- Modal -->
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
	aria-labelledby="reportModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title" id="reportModalLabel">신고/제보하기</h2>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form class="form-signin report-form" id="report">
				
					<input type="hidden" name="memberId" value="${member.memberId}"/>
					<input type="hidden" name="reportCategory" value=""/>
					<input type="hidden" name="toReport" value=""/>
					
					<h5 class="h5 mb-5"></h5>
					
					<div class="reportTypeBox">
						<div class="col-12 col-12-small">
							<input type="radio" id="reportType1" name="reportType" value="1" checked> <label for="reportType1" class="reportType1"></label>
						</div>
						<br/>
						<div class="col-12 col-12-small">
							<input type="radio" id="reportType2" name="reportType" value="2"> <label for="reportType2" class="reportType2"></label>
						</div>
						<br/>
						<div class="col-12 col-12-small">
							<input type="radio" id="reportType3" name="reportType" value="3"> <label for="reportType3" class="reportType3"></label>
						</div>
					</div>
					<br/>
					<br/>
					<!-- Break -->
					<div class="col-12">
						<label for="reportDetail" class="reportDetail">기타 내용 입력</label>
						<textarea name="reportDetail" id="reportDetail" placeholder="100자 이내로 입력해주세요." maxlength='100' rows="3"></textarea>
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<div>
					<input type='button' class='primary' id='addReport' value='등록'></input>
				</div>
		    </div>
		</div>
	</div>
</div>