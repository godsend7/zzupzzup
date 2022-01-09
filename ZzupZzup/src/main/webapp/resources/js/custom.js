$(function(){
	//dropmenu 
	$(".dropmenu-btn").on("click", function(e){
		e.preventDefault();
		let isActive = $(this).siblings(".dropmenu-list").hasClass("active");
		//console.log(isActive);
		if(isActive){
			$(".dropmenu-list").removeClass("active");
		}else{
			$(".dropmenu-list").removeClass("active");
			$(this).siblings(".dropmenu-list").addClass("active");
		}
	});
});