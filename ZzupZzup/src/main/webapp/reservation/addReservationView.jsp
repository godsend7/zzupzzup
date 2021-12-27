<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/layout/toolbar.jsp" />

    <div class="container">
  <main>
    <div class="py-5 text-center">
      <!-- <img class="d-block mx-auto mb-4" src="/docs/5.1/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57"> -->
      <h2>예약 및 결제하기</h2>
      <!-- <p class="lead">Below is an example form built entirely with Bootstrap’s form controls. Each required form group has a validation state that can be triggered by attempting to submit the form without completing it.</p> -->
    </div>

    <div class="row g-5">
      <div class="col-md-5 col-lg-4 order-md-last">
        <h3 class="d-flex justify-content-between align-items-center mb-3">
          <span class="text-primary">결제하기</span>
        </h3>
        <ul class="list-group mb-3">
          <li class="list-group-item d-flex justify-content-between lh-sm">
            <div>
              <h6 class="my-0"></h6>
             <div class="my-2">
            <div class="form-check">
              <input id="credit" name="paymentMethod" type="radio" class="form-check-input" checked required>
              <label class="form-check-label" for="credit">선 결제</label>
              
            </div>
            <div class="form-check">
              <input id="debit" name="paymentMethod" type="radio" class="form-check-input" required>
              <label class="form-check-label" for="debit">방문 결제</label>
            </div>
            </div>
            <span class="text-muted"></span>
          </li>
          <li class="list-group-item d-flex justify-content-between lh-sm">
          <!--  //////////////////////결제파트/////////////////////////////// -->
            <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
			<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
			<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
			<script type="text/javascript"></script>
		 
		 	<body>
			<button onclick="requestPay()">결제하기</button>
			</body>

			
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
		    <!--  //////////////////////결제파트/////////////////////////////// -->
          </li>
         
      </div>
      <div class="col-md-7 col-lg-8">
        <h3 class="mb-3">예약하기</h3>
        <form class="needs-validation" novalidate>
          <div class="row g-3">
            <div class="col-sm-6">
              <label for="firstName" class="form-label">Nick name</label>
              비트캠프, 에이아이, 아카데미
              <div class="invalid-feedback">
                Valid first name is required.
              </div>
            </div>
            
            <div class="col-sm-6">
              <label for="firstName" class="form-label">음식점 명</label>
              거구장
              <div class="invalid-feedback">
                Valid first name is required.
              </div>
            </div>

            <div class="col-sm-6">
              <label for="lastName" class="form-label">음식점 전화번호</label>
              999-9999
              <div class="invalid-feedback">
                Valid last name is required.
              </div>
            </div>
            
            <div class="col-sm-6">
              <label for="firstName" class="form-label">음식점 소재지 주소</label>
              도로명 - 서울 특별시~~~
              지번  - 인사동 ~~~~ 
              <div class="invalid-feedback">
                Valid first name is required.
              </div>
            </div>
            
             <div class="col-sm-6">
              <label for="firstName" class="form-label">음식 종류</label>
              중식
              <div class="invalid-feedback">
                Valid first name is required.
              </div>
            </div>
            
             <div class="col-sm-6">
              <label for="firstName" class="form-label">예약 인원 수</label>
              3 명
              <div class="invalid-feedback">
                Valid first name is required.
              </div>
            </div>


            <div class="col-12">
              <label for="email" class="form-label">음식점 전화번호 <span class="text-muted">(Optional)</span></label>
             02-976-7834
              <div class="invalid-feedback">
                Please enter a valid email address for shipping updates.
              </div>
            </div>

            <div class="col-12">
              <label for="address" class="form-label">주문 메뉴 명</label>
              <input type="text" class="form-control" id="address" placeholder="1234 Main St" required>
              <div class="invalid-feedback">
                Please enter your shipping address.
              </div>
            </div>

            <div class="col-12">
              <label for="address2" class="form-label">주문 메뉴 수량 <span class="text-muted">(Optional)</span></label>
              <input type="text" class="form-control" id="address2" placeholder="Apartment or suite">
            </div>

            <div class="col-md-5">
              <label for="country" class="form-label">주문 메뉴 명</label>
              <select class="form-select" id="country" required>
                <option value="">Choose...</option>
                <option>United States</option>
              </select>
              <div class="invalid-feedback">
                Please select a valid country.
              </div>
            </div>

            <div class="col-md-4">
              <label for="state" class="form-label">주문 메뉴 수량</label>
              <select class="form-select" id="state" required>
                <option value="">Choose...</option>
                <option>California</option>
              </select>
              <div class="invalid-feedback">
                Please provide a valid state.
              </div>
            </div>

            <div class="col-md-3">
              <label for="zip" class="form-label">라디오로 어케바꿈????</label>
              <input type="text" class="form-control" id="zip" placeholder="" required>
              <div class="invalid-feedback">
                Zip code required.
              </div>
            </div>
          </div>

          <hr class="my-4">

	          <div class="input-group">
			  <select class="custom-select" id="inputGroupSelect04" aria-label="Example select with button addon">
			  <label for="inputGroupSelect04" class="form-label">예약 날짜 시간 선택</label>
			    <option selected>예약 날짜/시간 선택</option>
			    <option value="1">One</option>
			    <option value="2">Two</option>
			    <option value="3">Three</option>
			  </select>
			  <div class="input-group-append">
			    <button class="btn btn-outline-secondary" type="button">Button</button>
			  </div>
			</div>
			
			<div class="input-group">
			  <select class="custom-select" id="inputGroupSelect04" aria-label="Example select with button addon">
			    <option selected>예약 날짜/시간 선택</option>
			    <option value="1">One</option>
			    <option value="2">Two</option>
			    <option value="3">Three</option>
			  </select>
			  <div class="input-group-append">
			    <button class="btn btn-outline-secondary" type="button">Button</button>
			  </div>
			</div>


          <hr class="my-4">

          <button class="w-50 btn btn-primary btn-lg" type="submit">이전 페이지</button>
        </form>
      </div>
    </div>
  </main>

  <footer class="my-5 pt-5 text-muted text-center text-small">
    <p class="mb-1">&copy; 2017–2021 Company Name</p>
    <ul class="list-inline">
      <li class="list-inline-item"><a href="#">Privacy</a></li>
      <li class="list-inline-item"><a href="#">Terms</a></li>
      <li class="list-inline-item"><a href="#">Support</a></li>
    </ul>
  </footer>
</div>
    
    <jsp:include page="/layout/sidebar.jsp" />
			
    