$(function(){
	//dropdown menu 
	$("body").on("click", ".dropmenu-btn", function(e){
		e.preventDefault();
		e.stopPropagation();
		let isActive = $(this).siblings(".dropmenu-list").hasClass("active");
		//console.log(isActive);
		if(isActive){
			$(".dropmenu-list").removeClass("active");
		}else{
			$(".dropmenu-list").removeClass("active");
			$(this).siblings(".dropmenu-list").addClass("active");
		}
	});
	$("body").on("click", function(){
		let isActive = $(".dropmenu-list").hasClass("active");
		if(isActive){
			console.log("바디 클릭했을 때 드롭메뉴 켜졌다");
			$(".dropmenu-list").removeClass("active");
		}
	});
});