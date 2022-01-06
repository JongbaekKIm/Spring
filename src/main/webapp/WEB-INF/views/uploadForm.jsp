<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<style>
.uploadResult{
width : 100%;
background-color : #ddd;
}
.uploadResult ul{
display : flex;
flex-flow : row;
justify-content : center;
align-items : center;
}
.uploadResult ul li{
list-style : none;
padding : 10px;
}
.uploadResult ul li img{
width : 20px;
}
.uploadResult ul li span{
color:white;
}
.bigPictureWrapper{
position:absolute;
display : none;
justify-conent:center;
align-items:center;
top:0%;
width : 100%;
height : 100%;
background-color : gray;
z-index:100;
background:rgba(255, 255, 255, 0.5);
}
.bigPicture{
position : relative;
display : flex;
justify-content : center;
align-items : center;
}
.bigPicture img{
width:400px;
}
</style>
</head>
<body>
	<h1>Upload w/i Ajax</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<div class="uploadResult">
		<ul></ul>
	</div>
	<div class = "bigPictureWrapper">
	<div class="bigPicture"></div></div>
	<button id="uploadBtn">Upload</button>
</body>

<script>
	var cloneObj = $(".uploadDiv").clone(); //업로드 전에 <input type='file'>객체가 포함된 <div>복사

	$(document).ready(function() {
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;
		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("파일 크기 초과");
				return false;
			}
			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드 할 수 없음");
				return false;
			}
			return true;
		}
		var uploadResult = $(".uploadResult ul");
		function showUploadedFile(uploadResultArr) {
			var str = "";
			$(uploadResultArr).each(function(i, obj) {
				if(!obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				str += "<li><a href='/download?fileName="+fileCallPath+"'><img src='resources/images/attach.png'>" 
				+ obj.fileName + "</a></li>";
				}else{
				/* 	str+="<li>"+obj.fileName+"</li>"; */
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				var originPath = obj.uploadPath +"/"+ obj.uuid+"_"+obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g),"/");
				str+="<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName="+fileCallPath+"'></a></li>";
				}
			});
			uploadResult.append(str);
		}
		$("#uploadBtn").on("click", function(e) {
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			console.log(files);

			//add filedata to formdata
			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			console.log("files.length : " + files.length);

			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log(result);
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());
					alert("Uploaded");
				}
			});//$a.jax 종료

		});

	
		
	});
		function showImage(fileCallPath){
			/* alert(fileCallPath); */
			$(".bigPictureWrapper").css("display", "flex").show();
			$(".bigPicture").html("<img src='display?fileName="+encodeURI(fileCallPath)+"'>").animate({width:'100%', height:'100%'}, 1000);
			$(".bigPictureWrapper").on("click", function(e){
				$(".bigPicture").animate({width:'0%', height:'0%'},1000);
				setTimeout(function(){
					$('.bigPictureWrapper').hide();
				}, 1000);
			})//bigPictureWrapper click
		}//<a>태그에서 직접 showImage()호출 할 수있도록 document ready 외부에 선언
</script>
</html>