<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Bootstrap Admin Theme</title>

<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style>
.uploadResult {
	width: 100%;
	background-color: #ddd;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 20px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-conent: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 400px;
}
</style>
</head>

<body>
	<jsp:include page="../includes/header.jsp"></jsp:include>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">????????? ??????</h1>
			</div>

			<!-- /.col-lg-12 -->
		</div>
		<div class="row">
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">????????? ?????????</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover">
								<form role="form" action="/board/register" method="post">
									<div class="form-group">
										<label>Title</label> <input class="form-control" name="title">
									</div>
									<div class="form-group">
										<label>Content</label>
										<textarea class="form-control" rows="3" name="content"></textarea>
									</div>
									<div class="form-group">
										<label>Writer</label> <input class="form-control" name="writer">
									</div>
									<button type="submit" class="btn btn-default">Submit</button>
									<button type="reset" class="btn btn-default">Reset</button>
								</form>
							</table>
						</div>
						<!-- /.table-responsive -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">File Attach</div>
					<div class="panel-body">
						<div class="form-group uploadDiv">
							<input type="file" name="uploadFile" multiple>
						</div>
						<div class="uploadResult">
							<ul></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /#wrapper -->
	<jsp:include page="../includes/footer.jsp"></jsp:include>
</body>

<script type="text/javascript">
      var formObj = $("form[role='form']");
      $("button[type='submit']").on("click", function(e) {
         e.preventDefault();
         console.log("submit clicked");
      });
      
      $("input[type='file']").change(function(e) {
         var cloneObj =$(".uploadDiv").clone();
         
         var formData = new FormData();
         var InputFile = $("input[name='uploadFile']");
         var files = InputFile[0].files;
         var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
         var maxSize = 52400000;
         function checkExtension(fileName, fileSize) {
            if (fileSize >= maxSize) {
               alert("?????? ?????? ??????");
               return false;
            }
            if (regex.test(fileName)) {
               alert("?????? ????????? ????????? ????????? ??? ??? ??????");
               return false;
            }
            return true;
         }
         for (var i = 0; i < files.length; i++) {
            if (!checkExtension(files[i].name, files[i].size)) {
               return false;
            }
            formData.append("uploadFile", files[i])
         }
         console.log("files length : " + files.length);
         $.ajax({
            url : '/uploadAjaxAction',
            processData : false,
            contentType : false,
            data : formData,
            type : 'POST',
            dataType :'json',
            success : function(result) {
               console.log(result);
               showUploadedFile(result);
               $(".uploadDiv").html(cloneObj.html());
            }
         });
         var uploadResult=$(".uploadResult ul");
         function showUploadedFile(uploadResultArr){
            var str="";
            $(uploadResultArr).each(function(i,obj){
               if(!obj.image){
                  var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
                  str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
                  str +="<span>"+obj.fileName+"</span>";
                  str +="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                  str +="<img src='/resources/images/attach.png'></a>";
                  str +="</div></li>";
               }else{
                  var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
                  str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
                  str +="<span>"+obj.fileName+"</span>";
                  str +="<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                  str +="<img src='/display?fileName="+fileCallPath+"'>";
                  str +="</div></li>";
               }
            });
            uploadResult.append(str);
         }
      });
      
      $(".uploadResult").on("click","button",function(e){
         var targetFile = $(this).data("file");
         var type = $(this).data("type");
         var targetLi = $(this).closest("li");
         
         $.ajax({
            url:'/deleteFile',
            data:{fileName:targetFile,type:type},
            dataType:'text',
            type:'post',
            success:function(result){
               alert(result);
               targetLi.remove();
            }
         });
      });
      
      $("button[type='submit']").on("click",function(e){
         e.preventDefault();
         console.log("submit clicked");
         var str="";
         $(".uploadResult ul li").each(function(i,obj){
            var jobj = $(obj);
            console.dir(jobj);
            str +="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
            str +="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
            str +="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
            str +="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
         });
         formObj.append(str).submit();
      });
      
      function showImage(fileCallPath){
         alert(fileCallPath);
         $(".bigPictureWrapper").css("display","flex").show();
         $(".bigPicture").html("<img src='/display?fileName="+encodeURI(fileCallPath)+"'>").animate({width:'100%',height:'100%'},1000);
      }
      $(".bigPictureWrapper").on("click",function(e){
         $(".bigPicture").animate({width:'0%',height:'0%'},1000);
         setTimeout(function(){
            $('.bigPictureWrapper').hide();
         },1000);
      });
   </script>
<!-- <script>



	var cloneObj = $(".uploadDiv").clone(); //????????? ?????? <input type='file'>????????? ????????? <div>??????
	var formObj = $("form[role='form']");
	
	
	$(document).ready(function() {
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;
		
		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("?????? ?????? ??????");
				return false;
				}
			if (regex.test(fileName)) {
				alert("?????? ????????? ????????? ????????? ??? ??? ??????");
				return false;
				}
			return true;
			}
		
		
		var uploadUL = $(".uploadResult ul"); 
		
 		
//		$(uploadResultArr).each(function(i, obj) {
//			if(!obj.image){
//				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
//			str += "<li><div><a href='/download?fileName="+fileCallPath+"'><img src='resources/images/attach.png'>" 
//			+ obj.fileName + "</a><span data-file =\'"+fileCallPath+"\'data-type='file'>x</span></div></li>";
//			}else{
//			/* 	str+="<li>"+obj.fileName+"</li>"; */
//			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
//			var originPath = obj.uploadPath +"/"+ obj.uuid+"_"+obj.fileName;
//			originPath = originPath.replace(new RegExp(/\\/g),"/");
//			str+="<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName="+fileCallPath+"'></a><span data-file =\'"+fileCallPath+"\'data-type='image'>x</span></li>";
//			}
//		});
//		uploadUL.append(str);
//		/* uploadResult.append(str); */ 
//	}//show UPloadedFile

	
	function showUploadedFile(uploadResultArr) {
		 if(!uploadResultArr||uploadResultArr.length==0){return;} 
		 var uploadResult = $(".uploadResult ul"); 
		var str = "";
		
		
		$(uploadResultArr).each(function(i, obj) {
			if(!obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
			str +="<li data-path ='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
			str +="<span>"+obj.fileName+"</span>";
			str +="<button type = 'button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button></br>";
			str +="<img src = '/resources/images/attach.png'>";
			str +="</div></li>";
			}else{
			/* 	str+="<li>"+obj.fileName+"</li>"; */
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
			var originPath = obj.uploadPath +"/"+ obj.uuid+"_"+obj.fileName;
			originPath = originPath.replace(new RegExp(/\\/g),"/");
			/* str+="<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName="+fileCallPath+"'></a><span data-file =\'"+fileCallPath+"\'data-type='image'>x</span></li>"; */
			str +="<li data-path ='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
			str +="<span>"+obj.fileName+"</span>";
			str +="<button type = 'button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button></br>";
			str +="<img src='/display?fileName="+fileCallPath+"'>";
			str +="</div></li>";
			}
		});
		uploadUL.append(str);
		/* uploadResult.append(str); */ 
	}//show UPloadedFile
	
	
	$("button[type='submit']").on("click", function(e) {
		e.preventDefault();
		console.log("submit clicked");
		var str="";
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
			console.dir(jobj);
			str+="<input type = 'hidden' name='attachList["+i+"].fileName' value ='"+jobj.data("filename")+"'>";
			str+="<input type = 'hidden' name='attachList["+i+"].uuid' value ='"+jobj.data("uuid")+"'>";
			str+="<input type = 'hidden' name ='attachList["+i+"].uploadPath' value ='"+jobj.data("path")+"'>";
			str+="<input type = 'hidden' name ='attachList["+i+"].fileType' value ='"+jobj.data("type")+"'>";
		})
		formObj.append(str).submit();
	}); // form submit ????????????
	
	
	
	$(document).on('change', "input[type='file']",function(e) {
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
		});//$a.jax ??????
		//??????????????? 
	});
	
	
	//uploadResult
	$(".uploadResult").on("click", "button", function(e){
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		//console.log(targetFile);
		alert("delete File");
		$.ajax({
			url:'/deleteFile',
			data : {fileName : targetFile, type : type},
			dataType : 'text',
			type : 'post',
			success : function(result){
				alert(result);
				targetLi.remove();
			}
		})
	})
})	
</script> -->
</html>
