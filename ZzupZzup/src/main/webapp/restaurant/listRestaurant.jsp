<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/layout/toolbar.jsp" />
    
    <div class="container">
    	
    	<div class="col-md-12">
			<div
				class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
					<%-- <img src="/images/uploadFiles/${.fileName}"/> --%>
					<strong class="d-inline-block mb-2 text-success">Restaurant</strong>
					<h4 class="mb-0">${restaurant.restaurantName} <small>${restaurant.menuType}</small></h4>
					<div class="mb-1 text-muted">Nov 11</div>
					<p class="mb-auto">This is a wider card with supporting text
						below as a natural lead-in to additional content.</p>
					<a href="#" class="stretched-link">Continue reading</a>
				</div>
			</div>
		</div>
    	
	</div>
    
    <jsp:include page="/layout/sidebar.jsp" />