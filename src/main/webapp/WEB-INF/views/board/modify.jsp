<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- DataTables CSS -->
<link
	href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link
	href="/resources/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
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
								<input type="hidden" name="pageNum"
									value='<c:out value="${cri.pageNum}"/>'> <input
									type="hidden" name="amount"
									value='<c:out value="${cri.amount}"/>'>
								<table class="table table-striped table-bordered table-hover">
									<div class="form-group">
										<label> Bno</label> <input class="form-control" name="bno"
											value='<c:out value="${board.bno}"/>' readonly="readonly">
									</div>
									<div class="form-group">
										<label> Title</label> <input class="form-control" name="title"
											value='<c:out value="${board.title}"/>'>
									</div>
									<div class="form-group">
										<label>Content</label>
										<textarea class="form-control" rows="3" name="content">${board.content}</textarea>
									</div>
									<div class="form-group">
										<label>Writer</label> <input class="form-control"
											value='<c:out value="${board.writer}"/>' name="writer"
											readonly="readonly">
									</div>
									<div class="form-group">
										<label>RegDate</label>
										<%-- <input class="form-control"
											value='<c:out value="${board.regDate}"/>' name="regdate"
											readonly="readonly"> --%>
										<input class="form-control" name="regDate"
											value='<fmt:formatDate value="${board.regDate}" pattern="yyyy/MM/dd"/>'
											readonly="readonly">
									</div>
									<div class="form-group">
										<label>UpdateDate</label>
										<%-- <input class="form-control"
											value='<c:out value="${board.updateDate}"/>'
											name="updatedate" readonly="readonly"> --%>
										<input class="form-control" name="updatedate"
											value='<fmt:formatDate value="${board.updateDate}" pattern="yyyy/MM/dd"/>'
											readonly="readonly">
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
		$('button').on("click", function(e) {
			e.preventDefault();
			var operation = $(this).data("oper");
			console.log(operation);
			if (operation === 'remove') {
				formObj.attr("action", "/board/remove");
			} else if (operation === "list") {
				//move to list
				formObj.attr("action", "/board/list").attr("method", "get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
			}
			formObj.submit();
		});
	});
</script>
</html>
