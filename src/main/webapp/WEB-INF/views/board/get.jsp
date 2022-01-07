<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<%@include file="../includes/header.jsp"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<header>
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
</header>
<body>
	<!-- 푸터에 있음 -->


	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">등록 수정</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->

		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">DataTables Advanced Tables</div>
					<!-- /.panel-heading -->
					<div class="panel-body">

						<div class="form-group">
							<label>Bno</label><input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
						</div>
						<div class="form-group">
							<label>Title</label><input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly="readonly">
							<%-- <label>Title</label><input class="form-control" name="title" value="${board.title}"/> --%>
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea class="form-control" name="content" rows="3" readonly="readonly">${board.content}</textarea>
						</div>
						<div class="form-group">
							<label>Writer</label><input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
						</div>

						<%-- <button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
					<button data-oper="list" class="btn btn-default" onclick="location.href='/board/list'">List</button> --%>


						<button data-oper='modify' class="btn btn-outline btn-primary">Modify</button>
						<button data-oper='list' class="btn btn-outline btn-success">List</button>
						<form id="operForm" action="/board/modify" method="get">
							<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'> <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'> <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
							<!--  -->
							<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'> <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
						</form>
					</div>
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">File Attach</div>
							<div class="panel-body">
								<div class="uploadResult">
									<ul></ul>
								</div>
								<div class="bigPictureWrapper">
									<div class="bigPicture"></div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.table-responsive -->
				</div>

				<!-- /.panel-body -->

				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i>Reply
						<button id="addReplyBtn" type="button" class="btn btn-xs pull-right">Add Reply</button>
					</div>
					<div class="panel-body">
						<ul class="chat">
							<li class="left clearfix" date-rno='12'>
								<div>
									<div class="header">
										<strong class="primary-font">user00</strong> <small class="pull-right text-muted"></small>
									</div>
									<p>Good job</p>
								</div>
							</li>
						</ul>
					</div>
					<div class="panel-footer"></div>
				</div>
			</div>

			<!-- /.panel -->
		</div>
		<!-- /.col-lg-6 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
					</div>

					<div class="modal-body">
						<div class="form-group">
							<label>Reply</label> <input class="form-control" name="reply" value="New Reply!!!!">
						</div>
						<div class="form-group">
							<label>Replyer</label> <input class="form-control" name="replyer" value="New Reply!!!!">
						</div>
						<div class="form-group">
							<label>ReplyDate</label> <input class="form-control" name="replyDate" value="asdasd">
						</div>
					</div>
					<div class="modal-footer">
						<button id="modalModBtn" type="button" class="btn btn-info">Modify</button>
						<button id="modalRemoveBtn" type="button" class="btn btn-info">Remove</button>
						<button id="modalRegisterBtn" type="button" class="btn btn-info">Register</button>
						<button id="modalCloseBtn" type="button" class="btn btn-info">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- /.row -->

	<!-- /#page-wrapper -->
	<!-- <script type="text/javascript">
	$(document).ready(function(){
		var operForm = $("#operForm");
		$('button[data-oper="modify"]').on("click",function(e){
			operForm.attr("action","/board/modify").submit();
		});
		$('button[data-oper="list"]').on("click",function(e){
			operForm.find("#bno").remove();
			operForm.attr("action","/board/list");
			operForm.submit();
		});
		console.log(replyService);
		
		var bnoValue='<c:out value="${board.bno}"/>';
		replyService.add(
				{reply:"JS TEST", replyer:"js tester", bno:bnoValue}
		,function(result){
			alert("RESULT : "+result);
		});
	});
</script> -->


	<script src="/resources/js/reply.js"></script>
	<script type="text/javascript">
   $(document).ready(
      function() {
         //reply module
         console.log(replyService);
         var operForm = $("#operForm");
         $('button[data-oper="modify"]').on("click",   function(e) {
            operForm.attr("action",   "/board/modify").submit();
         });
         $('button[data-oper="list"]').on("click", function(e) {
            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
         })
                                
         var bnoValue='<c:out value="${board.bno}"/>';
         var bno='<c:out value="${board.bno}"/>';
         $.getJSON("/board/getAttachList", {bno:bno}, function(arr){
        	 console.log(arr);
         })
                           /* //댓글 추가
                            replyService.add(
                              {reply:"JS TEST", replyer:"js tester", bno:bnoValue}//댓글 데이터
                              , function(result){
                                 alert("RESULT : " + result);
                              }) 
                           
                           //getJSON 처리 (게시글을 조회할 때마다 댓글 추가 확인)
                           //댓글 조회
                            replyService.getList(
                              {bno:bnoValue, page:1}   //bno와 page번호의 param을 가져옴
                              ,function(list){
                                 for(var i=0, len = list.length||0; i<len; i++){
                                    console.log(list[i]);
                                 }
                              }); 
                           
                           //댓글 삭제
                           replyService.remove(
                              3
                              ,function(count){
                                 console.log(count);
                                 if(count==="success"){alert("REMOVED");}
                              }, function(err){
                                 alert('error occurred....');
                              });
                           
                           //댓글 수정
                           replyService.update({
                              rno:4,
                              bno:bnoValue,
                              reply:"modified reply...."                              
                           }, function(result){
                              alert("수정 완료");
                           }); 
                              
                           //특정 댓글 조회
                           replyService.get(4, function(data){
                              console.log(data);
                           });  */

      //댓글목록의 이벤트 처리
         var replyUL = $(".chat");//showList(페이지번호)는 해당 게시글의 댓글을 가져온 후 <li>티그를 만들어서 화면에 출력
         showList(1);
         function showList(page){
            replyService.getList(
               {bno:bnoValue, page:page||1}
               ,function(replyCnt, list){//댓글의 페이지 계산과 출력
                  console.log("replyCnt: "+replyCnt); console.log("list: " + list);
                  if(page ==0){
                     pageNum = Math.ceil(replyCnt/10.0);   //한페이지에 10개씩 보여줌.
                     showList(pageNum);
                     return;
                  }
                  var str="";
                   if(list == null || list.length==0){
                     replyUL.html("");
                     return;
                  }
                   for(var i=0, len=list.length ||0; i<len; i++){
                      str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
                      str+="<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
                      str+="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small><div>"; 
                      str+="<p>"+list[i].reply+"</p><div></li>";
                  }
                  replyUL.html(str);
                  showReplyPage(replyCnt);
               });   //function call
         }   //showList
         
         
         //모달창 출현
            var modal=$(".modal");
            var modalInputReply = modal.find("input[name='reply']");
            var modalInputReplyer = modal.find("input[name='replyer']");
            var modalInputReplyDate = modal.find("input[name='replyDate']");
                             
            var modalModBtn = $("#modalModBtn");
            var modalRemoveBtn = $("#modalRemoveBtn");
            var modalRegisterBtn = $("#modalRegisterBtn");
            var modalCloseBtn = $("#modalCloseBtn");
                             
            $("#addReplyBtn").on("click", function (e){
               modal.find("input").val("");
               modalInputReplyDate.closest("div").hide();
               modal.find("button[id!='modalCloseBtn']").hide();
               modalRegisterBtn.show();
               $(".modal").modal("show");
            });
                             
         //새로운 댓글 처리
         modalRegisterBtn.on("click", function(e){
            var reply={
               reply:modalInputReply.val(),
               replyer:modalInputReplyer.val(),
               bno:bnoValue
            };
                                replyService.add(reply, function(result){
                                   alert(result); //댓글 등록이 정상임을 팝업으로 알림
                                   modal.find("input").val("");   //댓글 등록이 정상적으로 이루어지면 내용을 지움.
                                   modal.modal("hide");   //모달창 닫음
                                   
                                   //showList(1);
                                   showList(0);   //새로운 댓글을 추가하면 page값을 0으로 전송하고, 댓글의 전체숫자를 파악한 후에 페이지 이동
                                });
                             });
                             
                             //특정 댓글의 클릭 이벤트
                             $(".chat").on("click","li", function(e){
                            	   modalInputReplyDate.closest("div").show();
                                var rno=$(this).data("rno");
                                console.log(rno);
                                replyService.get(rno, function(reply){
                                   modalInputReply.val(reply.reply);
                                   modalInputReplyer.val(reply.replyer);
                                   modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
                                   modal.data("rno", reply.rno);
                                   
                                   modal.find("button[id!='modalCloseBtn']").hide();
                                   modalModBtn.show();
                                   modalRemoveBtn.show();
                                   $(".modal").modal("show");
                                });
                             });
                             
                             //댓글의 수정/삭제 처리 이벤트
                             modalModBtn.on("click", function(e){
                                var reply={rno:modal.data("rno"), reply:modalInputReply.val()};
                                replyService.update(reply, function(result){
                                   alert(result);
                                   modal.modal("hide");
                                   showList(pageNum);
                                });
                             });
                             
                             modalCloseBtn.on("click", function(e){
                                    modal.modal("hide");
                              });
                             
                             modalRemoveBtn.on("click", function(e){
                                var rno = modal.data("rno");
                                replyService.remove(rno, function(result){
                                   alert(result);
                                   modal.modal("hide");
                                   showList(pageNum);
                                });
                             });
                             
                           
         //댓글의 페이지 번호 처리
         var pageNum=1;
         var replyPageFooter = $(".panel-footer");
         function showReplyPage(replyCnt){
            console.log("showReplyPage : " + replyCnt);
            var endNum = Math.ceil(pageNum/10.0)*10;
            var startNum = endNum -9;
            var prev = startNum !=1;
            var next = false;
            if(endNum*10>=replyCnt){endNum = Math.ceil(replyCnt/10.0);}
            if(endNum*10<replyCnt){next = true;}
            var str = "<ul class='pagination pull-right'>";
            
            if(prev){
               str +="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
            }
            for(var i=startNum; i<=endNum; i++){
               var active = pageNum == i?"active":"";
               str += "<li class='page-item " +active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
            }
            if(next){
               str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
            }
            str+="</ul></div>";
            console.log(str);
            replyPageFooter.html(str);
         }//showReplyPage
         replyPageFooter.on("click", "li a", function(e){
             e.preventDefault();
             console.log("page click");
             var targetPageNum = $(this).attr("href");
             console.log("targetPageNum : " + targetPageNum);
             pageNum = targetPageNum;
             showList(pageNum);   //댓글 수정과 삭제시에도 댓글이 포함된 페이지로 이동하도록 수정
          })
       //댓글 페이지 이동 시 댓글 출력
       });
</script>
	<script>



	var cloneObj = $(".uploadDiv").clone(); //업로드 전에 <input type='file'>객체가 포함된 <div>복사
	var formObj = $("form[role='form']");
	
	
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
		
		
		$(arr).each(function(i, obj) {
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
		$(".uploadResul ul").html(str);
		/* uploadResult.append(str); */ 
	}//show UPloadedFile
	
	$(".uploadResult").on("click", "li", function(e){
		console.log("view image");
		var liObj = $(this);
		var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
		if(!liObj.data("type")){
			
		}
		else{showIamge(path);}
	});
	
	
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
	}); // form submit 동작막기
	
	
	
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
		});//$a.jax 종료
		//파일업로드 
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
	<%@include file="../includes/footer.jsp"%>

</body>
</html>