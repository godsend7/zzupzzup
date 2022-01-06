$(function(){
		//==> drag 파일 업로드
		let $fileDragArea = $(".file-drag-area");
		let $fileDragBtn = $(".file-drag-btn");
		let $fileDragInput = $(".file-drag-input");
		let $fileDragMsg = $(".file-drag-msg");
		let $fileDragView = $(".file-drag-view");
		let $image = $("#file");
		
		//박스 안에 Drag 들어왔을 때
		$fileDragArea.on("dragenter", function(e){
			console.log("dragenter");
			$fileDragArea.addClass('is-active');
		});
	
	
		//박스 안에 Drag 하고 있을 때
		$fileDragArea.on("dragover", function(e){
			console.log("dragover");
			
			// 드래그 한 것이 파일인지 아닌지 체크
			let valid = e.originalEvent.dataTransfer.types.indexOf('Files')>= 0;
			console.log(valid);
			
			if(!valid){
				$fileDragArea.addClass('is-warning');
			}else{
				$fileDragArea.addClass('is-active');
			}
		});
		
		//박스 밖으로 Drag 나갈 때
		$fileDragArea.on("dragleave", function(e){
			console.log("dragleave");
			$fileDragArea.removeClass('is-active');
		});
		
		//박스 안에서 Drag를 Drop 했을 때
		$fileDragArea.on("drop", function(e){
			console.log("drop");
			$fileDragArea.removeClass('is-active');
			
		});
		
		// change inner text
		$fileDragInput.on('change', function(e) {
			console.log("파일업로드 실행");
			
			//이미지 정보들을 초기화
			sel_files = []; 
			$(".file-drag-view").empty();
			
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);
			
			console.log("이것은 : " + filesArr);
			
			var index = 0;
			filesArr.forEach(function(f) {
				
				console.dir(f);
				
				//유효성 체크
				if(!isValid(f)){
					return;
				}
				
				sel_files.push(f);
				
				var reader = new FileReader();
				reader.onload = function(e) {
					
					var html = "<a href='#' class = 'cvf_delete_image' id='img_id_"+index+"'><img src=\""+ e.target.result
							+ "\" data-file='" + f.name + "' class='selProductFile' title='click to remove'></a>";
					
					$(".file-drag-view").append(html);
					index++;
				}
				
				reader.readAsDataURL(f);
			});
			
			//특정 이미지 삭제
			$('body').on('click', 'a.cvf_delete_image', function(e) {
				e.preventDefault();
				$(this).remove();
				
                var file = $(this).children().attr("data-file");

				for (var i = 0; i < sel_files.length; i++) {
					if (sel_files[i].name == file) {
						sel_files.splice(i, 1);
						break;
					}
				}
				
				console.log(sel_files);
			});
		});
	
		function isValid(data){
			
			//파일인지 유효성 검사
			if(!data.type.indexOf('file') < 0){
				alert("파일이 아닙니다.");
				return false;
			}
			
			//이미지인지 유효성 검사
			if(data.type.indexOf('image') < 0){
				alert('이미지 파일만 업로드 가능합니다.');
				return false;
			}
			
			//파일의 사이즈는 10MB 미만
			if(data.size >= 1024 * 1024 * 10){
				alert('10MB 이상인 파일은 업로드할 수 없습니다.');
				return false;
			}
			
			return true;
		}
		
		//==>취소 클릭시 뒤로 감
		$("input[value='취소']").on("click", function() {
			history.back();
		});
	});
	
	function fileUploadAction() { 
		console.log("fileUploadAction");
		$fileDragInput.trigger('click');
	}
	
	function uploadFiles() {
		var formData = new FormData();
		for (var i = 0; i < sel_files.length; i++) {
			console.log(sel_files[i]);
			formData.append("uploadFile", sel_files[i]);
		}
	
		$.ajax({
			url : "/review/json/addDragFile",
			processData : false,
			contentType : false,
			method: 'POST',
			data: formData,
			success:function(data){
				console.log(data);
				
			 	$.each(data, function(index, item) {
			 		var imageUpload = "<input type='hidden' name='reviewImage[" + index + "]' value='"+ item + "'>";
			 		$(".imageUploadBox").append(imageUpload);
			 		//console.log(item);
			 	});
				
				//$("#review").attr("method", "POST").attr("action" , "/review/addReview").attr("enctype", "multipart/form-data").attr("accept-charset","UTF-8").submit();
		    },
		    error:function(e){
				console.log("실패");
		    }
		});
	}