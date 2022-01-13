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
			$(".dropmenu-list").removeClass("active");
		}
	});
});