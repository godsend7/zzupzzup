<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/layout/toolbar.jsp" />

<!-- start:해당 부분은 지우고 아래 container안에 작성 -->

<!-- end -->

<div class="container">

	<!-- start:Form -->
	<h3>예약하기</h3>

	<form method="post" action="#">
		<div class="row gtr-uniform">
			<div class="col-6 col-12-xsmall">
				<label for="demo-name">NickName</label> 
				<p>비트캠프, 에이아이</p>
			</div>
			<div class="col-6 col-12-xsmall">
				<label for="demo-restaurantName">음식점 명</label> 
				<p>거구장</p>
			</div>
			<div class="col-6 col-12-xsmall">
				<label for="demo-restaurantPhone">음식점 전화번호</label> 
				<p>999-9999</p>
			</div>
			
			<div class="col-6 col-12-xsmall">
				<label for="demo-restaurantAdress">음식점 소재지 주소</label> 
				<p> 도로명 - 서울 특별시~~~
              		지번  - 인사동 ~~~~ </p>
			</div>
			
			<div class="col-6 col-12-xsmall">
				<label for="demo-restaurantType">음식 종류</label> 
				<p>중식</p>
			</div>
			
			<div class="col-6 col-12-xsmall">
				<label for="demo-memberCount">예약 인원 수</label> 
				<p>3 명</p>
			</div>
			
			<!-- Break -->
			<div class="col-4 col-12-small">
				<label for="demo-orderName">주문 메뉴 명</label> 
				<select class="form-select" id="orderName" required>
                <option value="">Choose...</option>
                <option>United States</option>
              </select>
			</div>
			<div class="col-4 col-12-small">
				<label for="demo-orderCount">주문 메뉴 수량</label> 
				<select class="form-select" id="orderCount" required>
                <option value="">Choose...</option>
                <option>United States</option>
              </select>
			</div>
			
			<div class="col-4 col-12-small">
			<label >주문 메뉴와 수량을 확인 후 체크해주세요</label> 
				<input type="checkbox" id="demo-copy" name="demo-copy"> <label
					for="demo-copy"></label>
			</div>
			<!-- Break -->
			
			<!-- Break -->
			<div class="col-6">
				<label for="date">날짜 선택</label>
				<input type="date" id="date">
			</div>
			<div class="col-6">
				<label for="time">시간 선택</label>
      			<input type="time" id="time">
			</div>
			<!-- Break -->
			<h3>결제하기</h3>
			
			<!-- Break -->
			<div class="col-12">
				<label for="demo-priority">결제 수단</label>
			</div>
			<div class="col-4 col-12-small">
				<input type="radio" id="demo-priority-low" name="demo-priority"
					checked> <label for="demo-priority-low">선 결제</label>
			</div>
			<div class="col-4 col-12-small">
				<input type="radio" id="demo-priority-normal" name="demo-priority">
				<label for="demo-priority-normal">방문 결제</label>
			</div>
			
			<!-- Break -->
			<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
			<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
			<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
			<script type="text/javascript"></script>
		 
		 

			
			<script>
			var IMP = window.IMP; // 생략가능
		    IMP.init('imp30711347');
		    function requestPay() {
		      // IMP.request_pay(param, callback) 결제창 호출
		      IMP.request_pay({ // param
		          pg: "html5_inicis",
		          pay_method: "card",
		          merchant_uid: 'merchant_' + new Date().getTime(),
		          name: "노르웨이 회전 의자",
		          amount: 100,
		          buyer_email: "gildong@gmail.com",
		          buyer_name: "홍길동",
		          buyer_tel: "010-4242-4242",
		          buyer_addr: "서울특별시 강남구 신사동",
		          buyer_postcode: "01181"
		      }, function (rsp) { // callback
		    	  console.log(rsp);
		          if (rsp.success) {
		        	  var msg = '결제가 완료되었습니다.';
		              msg += '고유ID : ' + rsp.imp_uid;
		              msg += '상점 거래ID : ' + rsp.merchant_uid;
		              msg += '결제 금액 : ' + rsp.paid_amount;
		              msg += '카드 승인번호 : ' + rsp.apply_num;
		              alert('성공<a href="javascript:Test()">');
		          } else {
		        	  var msg = '결제에 실패하였습니다.';
		              msg += '에러내용 : ' + rsp.error_msg;
		          }
		      });
		    }        
		    </script>
			
			<!-- Break -->
			
			<div class="col-12">
				<ul class="actions">
					<li><input type="button" value="결제하기" class="primary" onclick="requestPay()"/></li>
					<li><input type="reset" value="이전 페이지" class="normal" /></li>
				</ul>
			</div>
		</div>
	</form>
	<!-- end -->

</div>

<jsp:include page="/layout/sidebar.jsp" />