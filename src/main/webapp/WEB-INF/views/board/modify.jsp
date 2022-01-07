<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script src="/resources/vendor/jquery/jquery.min.js"></script>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


</head>

<body>
	<jsp:include page="../includes/header.jsp"></jsp:include>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">게시글 수정 및 삭제</h1>
			</div>

			<!-- /.col-lg-12 -->
		</div>
		<div class="row">
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">게시글 수정 및 삭제</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<div class="table-responsive">
							<form role="form" action="/board/modify" method="post">
								<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'> <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'> <input type='hidden' name="keyword" value="<c:out value="${cri.keyword}"/>"> <input type='hidden' name="type" value="<c:out value="${cri.type}"/>">
								<table class="table table-striped table-bordered table-hover">
									<div class="form-group">
										<label> Bno</label> <input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
									</div>
									<div class="form-group">
										<label> Title</label> <input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
									</div>
									<div class="form-group">
										<label>Content</label>
										<textarea class="form-control" rows="3" name="content">${board.content}</textarea>
									</div>
									<div class="form-group">
										<label>Writer</label> <input class="form-control" value='<c:out value="${board.writer}"/>' name="writer" readonly="readonly">
									</div>
									<div class="form-group">
										<label>RegDate</label>
										<%-- <input class="form-control"
											value='<c:out value="${board.regDate}"/>' name="regdate"
											readonly="readonly"> --%>
										<input class="form-control" name="regDate" value='<fmt:formatDate value="${board.regDate}" pattern="yyyy/MM/dd"/>' readonly="readonly">
									</div>
									<div class="form-group">
										<label>UpdateDate</label>
										<%-- <input class="form-control"
											value='<c:out value="${board.updateDate}"/>'
											name="updatedate" readonly="readonly"> --%>
										<input class="form-control" name="updatedate" value='<fmt:formatDate value="${board.updateDate}" pattern="yyyy/MM/dd"/>' readonly="readonly">
									</div>

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

									<button data-oper="modify" type="submit" class="btn btn-info">Modify</button>
									<button data-oper="remove" type="submit" class="btn btn-danger">Remove</button>
									<button data-oper="list" type="submit" class="btn btn-success">List</button>
								</table>

							</form>
						</div>
						<!-- /.table-responsive -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
		</div>
	</div>
	<!-- /#wrapper -->
	<jsp:include page="../includes/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
      $(document).ready(function() {
         var formObj = $("form");
         $("button").on("click", function(e) {
            e.preventDefault();
            var operation = $(this).data("oper");
            console.log(operation);
            if (operation === "remove") {
               formObj.attr("action", "/board/remove");
            } else if (operation === 'list') {
               formObj.attr("action","/board/list").attr("method","get");
               var pageNumTag = $("input[name='pageNum']").clone();
               var amountTag = $("input[name='amount']").clone();
               var typeTag = $("input[name='type']").clone();
               var keywordTag = $("input[name='keyword']").clone();
               formObj.empty();
               formObj.append(pageNumTag);
               formObj.append(amountTag);
               formObj.append(typeTag);
               formObj.append(keywordTag);
            }else if(operation==='modify'){
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
               formObj.append(str);
            }
            formObj.submit();
         });
         
         var bnoValue = '<c:out value="${board.bno}"/>';
         
         $.getJSON("/board/getAttachList",{bno:bnoValue},function(arr){
            var str='';
            $(arr).each(function(i,obj){
               if(!obj.fileType){
                  var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
                  str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
                  str +="<span>"+obj.fileName+"</span>";
                  str +="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                  str +="<img src='/resources/images/attach.png'></a>";
                  str +="</div></li>";
               }else{
                  var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
                  str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
                  str +="<span>"+obj.fileName+"</span>";
                  str +="<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                  str +="<img src='/display?fileName="+fileCallPath+"'>";
                  str +="</div></li>";
               }
            });
            $(".uploadResult ul").html(str);
         });
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
               alert("파일 크기 초과");
               return false;
            }
            if (regex.test(fileName)) {
               alert("해당 종류의 파일은 업로드 할 수 없음");
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
         if(confirm("이 파일을 삭제하시겠습니까?")){
            var targetLi = $(this).closest("li");
            debugger;
            targetLi.remove();
         }
      });
      
   </script>
<!--    <script type="text/javascript">
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
               alert("파일 크기 초과");
               return false;
            }
            if (regex.test(fileName)) {
               alert("해당 종류의 파일은 업로드 할 수 없음");
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
               if(!obj.fileType){
                  var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
                  str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
                  str +="<span>"+obj.fileName+"</span>";
                  str +="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                  str +="<img src='/resources/images/attach.png'></a>";
                  str +="</div></li>";
               }else{
                  var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
                  str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
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
   </script> -->
</html>
