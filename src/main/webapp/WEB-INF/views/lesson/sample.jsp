<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<title>샘플 애플리케이션</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container mt-3">
	<div class="row">
		<div class="col-2">
			<div class="list-group list-group-flush mt-5">
				<a href="" class="list-group-item" id="link-add-todo">새 일정등록</a>
				<a href="" class="list-group-item" id="link-get-dept-todo">부서 일정 조회</a>
				<a href="" class="list-group-item" id="link-search-todo">일정 검색</a>
			</div>
		</div>
		<div class="col-10">
			<div id="calendar"></div>
		</div>
	</div>
</div>
<!-- Todo 등록폼 -->
<div class="modal" tabindex="-1" id="modal-todo-form">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">일정 정보 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="card">
					<div class="card-body">
						<form class="row g-3">
							<div class="col-sm-4">
								<label class="form-label">구분</label>
								<select class="form-select form-select-sm" name="catNo">
									<c:forEach var="cat" items="${categories }">
										<option value="${cat.no }"> ${cat.name }</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-8">
								<label class="form-label">제목</label>
								<input type="text" class="form-control form-control-sm" name="title">
							</div>
							<div class="col-sm-12">
								<label class="form-label">하루종일</label>
								<div class="form-check form-switch d-inline float-end">
									<input class="form-check-input" type="checkbox" role="switch" name="allDay" value="Y">
								</div>
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">시작일자</label>
								<input type="date" class="form-control form-control-sm" name="startDate">
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">시작시간</label>
								<input type="time" class="form-control form-control-sm" name="startTime">
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">종료일자</label>
								<input type="date" class="form-control form-control-sm" name="endDate">
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">종료시간</label>
								<input type="time" class="form-control form-control-sm" name="endTime">
							</div>
							<div class="col-sm-12">
								<label class="form-label">내용</label>
								<textarea rows="3" class="form-control" name="description"></textarea>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary btn-sm" id="btn-add-todo">확인</button>
			</div>
		</div>
	</div>
</div>
<!-- Todo 상세 모달 -->
<div class="modal" tabindex="-1" id="modal-todo-info">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">일정 상세 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="card">
					<div class="card-body">
						<form class="row g-3">
							<input type="hidden" name="todoNo" />
							<div class="col-sm-4">
								<label class="form-label">구분</label>
								<select class="form-select form-select-sm" name="catNo">
									<c:forEach var="cat" items="${categories }">
										<option value="${cat.no }"> ${cat.name }</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-8">
								<label class="form-label">제목</label>
								<input type="text" class="form-control form-control-sm" name="title">
							</div>
							<div class="col-sm-12">
								<label class="form-label">하루종일</label>
								<div class="form-check form-switch d-inline float-end">
									<input class="form-check-input" type="checkbox" role="switch" name="allDay" value="Y">
								</div>
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">시작일자</label>
								<input type="date" class="form-control form-control-sm" name="startDate">
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">시작시간</label>
								<input type="time" class="form-control form-control-sm" name="startTime">
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">종료일자</label>
								<input type="date" class="form-control form-control-sm" name="endDate">
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">종료시간</label>
								<input type="time" class="form-control form-control-sm" name="endTime">
							</div>
							<div class="col-sm-12">
								<label class="form-label">내용</label>
								<textarea rows="3" class="form-control" name="description"></textarea>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-warning btn-sm" id="btn-modify-todo">수정</button>
				<button type="button" class="btn btn-danger btn-sm" id="btn-delete-todo">삭제</button>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.4/index.global.min.js'></script>
<script src="https://momentjs.com/downloads/moment.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {

	let clickedEvent;
	let todoFormModal = new bootstrap.Modal("#modal-todo-form");
	let todoInfoModal = new bootstrap.Modal("#modal-todo-info");

	$("#modal-todo-info, #modal-todo-info").on('hidden.bs.modal', function(event) {
		$(":input[name=title]").val("");
		$("select[name=catNo] option:eq(0)").prop("selected", true);
		$(":checkbox[name=allDay]").prop("checked", false);
		$(":input[name=startDate]").val("");
		$(":input[name=startTime]").val("").prop("disabled", false);
		$(":input[name=endDate]").val("");
		$(":input[name=endTime]").val("").prop("disabled", false);
		$("textarea[name=description]").val("")
	})

	let calendar = new FullCalendar.Calendar(document.getElementById("calendar"), {
		locale: 'ko',
		initialView: 'dayGridMonth',
		events: function(info, successCallback, failureCallback) {
			refreshEvents(info, successCallback);
		},
		dateClick: function(info) {
			let clickedDate = info.dateStr;
			let nowTime = moment().format("HH:mm");
			openTodoFormModal(info.dateStr, nowTime);
		},
		eventClick: function(info) {
			clickedEvent = info.event;
			openTodoInfoModal();
		}
	});
	calendar.render();

	$("#link-add-todo").click(function(event) {
		event.preventDefault();

		let nowDate = moment().format("YYYY-MM-DD");
		openTodoFormModal(nowDate);
	});

	$("#btn-modify-todo").click(function() {

	});

	$("#btn-delete-todo").click(function() {
		let todoNo = $("#modal-todo-info :input[name=todoNo]").val();
		$.ajax({
			type: "get",
			url: "/todos/delete",
			data: {todoNo: todoNo}
		})
		.done(function() {
			clickedEvent.remove();
		})
		.always(function() {
			todoInfoModal.hide();
		})
	});

	$(":checkbox[name=allDay]").change(function() {
		if ($(this).prop('checked')) {
			$(":input[name=startTime]").prop("readOnly", true);
			$(":input[name=endTime]").prop("readOnly", true);
		} else {
			let startTime = moment().format('HH:mm');
			let endTime = moment().add('1', 'h').format('HH:mm');
			$(":input[name=startTime]").prop("readOnly", false).val(startTime);
			$(":input[name=endTime]").prop("readOnly", false).val(endTime);
		}
	});

	$("#btn-add-todo").click(function() {
		let todo = {
			title: $(":input[name=title]").val(),
			catNo: $("select[name=catNo]").val(),
			startDate: $(":input[name=startDate]").val(),
			endDate: $(":input[name=endDate]").val(),
			description: $("textarea[name=description]").val()
		};
		let allDay = $(":checkbox[name=allDay]:checked").val();
		if (allDay) {
			todo['allDay'] = 'Y';
		} else {
			todo['allDay'] = 'N';
			todo['startTime'] = $(":input[name=startTime]").val();
			todo['endTime'] = $(":input[name=endTime]").val();
		}
		addTodo(todo);
		todoInfoModal.hide();
	});

	function openTodoFormModal(date) {
		let startTime = moment().format('HH:mm');
		let endTime = moment().add('1', 'h').format('HH:mm');

		$("#modal-todo-form :input[name=startDate]").val(date);
		$("#modal-todo-form :input[name=startTime]").val(startTime);
		$("#modal-todo-form :input[name=endDate]").val(date);
		$("#modal-todo-form :input[name=endTime]").val(endTime);

		todoFormModal.show();
	}

	function openTodoInfoModal() {
		let todoNo = clickedEvent.id;
		let title = clickedEvent.title;
		let catNo = clickedEvent.extendedProps.catNo;
		let allDay = clickedEvent.allDay;
		let startDate = moment(clickedEvent.start).format("YYYY-MM-DD");
		let startTime = moment(clickedEvent.start).format('HH:mm');
		let endDate = moment(clickedEvent.start).format("YYYY-MM-DD")
		let endTime = moment(clickedEvent.start).add(23, 'h').add(59, 'm').format("HH:mm");
		let description = clickedEvent.extendedProps.description;

		$("#modal-todo-info :input[name=todoNo]").val(todoNo);
		$("#modal-todo-info :input[name=title]").val(title);
		$("#modal-todo-info :input[name=catNo]").val(catNo);
		$("#modal-todo-info :checkbox[name=allDay]").prop("checked", allDay);
		$("#modal-todo-info :input[name=startDate]").val(startDate);
		$("#modal-todo-info :input[name=startTime]").val(startTime);
		$("#modal-todo-info :input[name=endDate]").val(startDate);
		$("#modal-todo-info :input[name=endTime]").val(endTime);
		$("#modal-todo-info :input[name=description]").val(description);

		todoInfoModal.show();
	}

	function addTodo(todo) {
		$.ajax({
			type: 'post',
			url: '/todos/add',
			data: JSON.stringify(todo),
			contentType: 'application/json',
			dataType: 'json'
		})
		.done(function(todoEvent) {
			calendar.addEvent(todoEvent);
		})
	}

	function refreshEvents(info, successCallback) {
		let startDate = moment(info.start).format("YYYY-MM-DD");
		let endDate = moment(info.end).format("YYYY-MM-DD");

		let param = {
			startDate: startDate,
			endDate: endDate
		};

		$.ajax({
			type: 'get',
			url: '/todos/events',
			data: param,
			dataType: 'json'
		})
		.done(function(eventObject) {
			successCallback(eventObject);
		})
	}
});
</script>
</body>
</html>