<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/layout/toolbar.jsp" />

<!-- start:해당 부분은 지우고 아래 container안에 작성 -->
<div class="row">
	<div class="col-12">
		<ul>
			<li><a href="/ui-template/basic-template.jsp">기본 템플릿</a></li>
			<li><a href="/ui-template/button.jsp">버튼</a></li>
			<li><a href="/ui-template/form.jsp">등록양식</a></li>
			<li><a href="/ui-template/form-view.jsp">등록양식 결과</a></li>
			<li><a href="/ui-template/thumbnail.jsp">썸네일리스트</a></li>
			<li><a href="/ui-template/list.jsp">일반리스트</a></li>
			<li><a href="/ui-template/carousel.jsp">슬라이드</a></li>
			<li><a href="/ui-template/table.jsp">테이블</a></li>
			<li><a href="/ui-template/etc-ui.jsp">기타ui</a></li>
		</ul>
	</div>
</div>
<!-- end -->

<div class="container">

	<!-- start:Table -->
	<h3>Table</h3>

	<h4>Default</h4>
	<div class="table-wrapper">
		<table>
			<thead>
				<tr>
					<th>Name</th>
					<th>Description</th>
					<th>Price</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Item1</td>
					<td>Ante turpis integer aliquet porttitor.</td>
					<td>29.99</td>
				</tr>
				<tr>
					<td>Item2</td>
					<td>Vis ac commodo adipiscing arcu aliquet.</td>
					<td>19.99</td>
				</tr>
				<tr>
					<td>Item3</td>
					<td>Morbi faucibus arcu accumsan lorem.</td>
					<td>29.99</td>
				</tr>
				<tr>
					<td>Item4</td>
					<td>Vitae integer tempus condimentum.</td>
					<td>19.99</td>
				</tr>
				<tr>
					<td>Item5</td>
					<td>Ante turpis integer aliquet porttitor.</td>
					<td>29.99</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2"></td>
					<td>100.00</td>
				</tr>
			</tfoot>
		</table>
	</div>
	
	<ul class="pagination">
		<li><span class="button disabled">Prev</span></li>
		<li><a href="#" class="page active">1</a></li>
		<li><a href="#" class="page">2</a></li>
		<li><a href="#" class="page">3</a></li>
		<li><span>&hellip;</span></li>
		<li><a href="#" class="page">8</a></li>
		<li><a href="#" class="page">9</a></li>
		<li><a href="#" class="page">10</a></li>
		<li><a href="#" class="button">Next</a></li>
	</ul>

	<h4>Alternate</h4>
	<div class="table-wrapper">
		<table class="alt">
			<thead>
				<tr>
					<th>Name</th>
					<th>Description</th>
					<th>Price</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Item1</td>
					<td>Ante turpis integer aliquet porttitor.</td>
					<td>29.99</td>
				</tr>
				<tr>
					<td>Item2</td>
					<td>Vis ac commodo adipiscing arcu aliquet.</td>
					<td>19.99</td>
				</tr>
				<tr>
					<td>Item3</td>
					<td>Morbi faucibus arcu accumsan lorem.</td>
					<td>29.99</td>
				</tr>
				<tr>
					<td>Item4</td>
					<td>Vitae integer tempus condimentum.</td>
					<td>19.99</td>
				</tr>
				<tr>
					<td>Item5</td>
					<td>Ante turpis integer aliquet porttitor.</td>
					<td>29.99</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2"></td>
					<td>100.00</td>
				</tr>
			</tfoot>
		</table>
	</div>
	
	<ul class="pagination">
		<li><span class="button disabled">Prev</span></li>
		<li><a href="#" class="page active">1</a></li>
		<li><a href="#" class="page">2</a></li>
		<li><a href="#" class="page">3</a></li>
		<li><span>&hellip;</span></li>
		<li><a href="#" class="page">8</a></li>
		<li><a href="#" class="page">9</a></li>
		<li><a href="#" class="page">10</a></li>
		<li><a href="#" class="button">Next</a></li>
	</ul>

</div>

<jsp:include page="/layout/sidebar.jsp" />