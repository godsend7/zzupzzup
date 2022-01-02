<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script src="jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
     
    <script>            
        $(document).ready (function () {                
            $('.btnAdd').click (function () {                                        
                $('.buttons').append (                        
                    '<input type="text" name="txt"> <input type="button" class="btnRemove" value="Remove"><br>'                    
                ); // end append                            
                $('.btnRemove').on('click', function () { 
                    $(this).prev().remove (); // remove the textbox
                    $(this).next ().remove (); // remove the <br>
                    $(this).remove (); // remove the button
                });
            }); // end click                                            
        }); // end ready
        
        
        $(function(){ 
        	$("#showbtn").click( function(){ 
        		if($("#displayselect").val() == "1") { 
        			$("#displaydiv").show(); 
        		} else if($("#displayselect").val() == "2") { 
        			$("#displaydiv").slideDown(); 
        		} else if($("#displayselect").val() == "3") { 
        			$("#displaydiv").fadeIn(); 
        		} }); 
        	
        	$("#hidebtn").click(function(){ 
        		if($("#displayselect").val() == "1") { 
        			$("#displaydiv").hide(); 
        		} else if($("#displayselect").val() == "2") { 
        			$("#displaydiv").slideUp();
        		} else if($("#displayselect").val() == "3") { 
        			$("#displaydiv").fadeOut(); 
        		} 
        	}); 
        });
        
    </script> 
</head>
<body>
	<div class="buttons">
		<input type="text" name="txt"> <input type="button" class="btnAdd" value="Add"><br>
	</div>
	
	
	<select id="displayselect">
		<option value="1">show/hide</option>
		<option value="2">slide</option>
		<option value="3">fade</option>
	</select>
	<input type="button" id="showbtn" value="보여주기">
	<input type="button" id="hidebtn" value="숨기기">
	
	<div style="display: none;" id="displaydiv">
		<span>초기 숨겨져 있는 화면1</span><br>
		<span>초기 숨겨져 있는 화면2</span><br>
		<span>초기 숨겨져 있는 화면3</span><br>
		<span>초기 숨겨져 있는 화면4</span>
	</div>	
	
</body>
</html>