<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        h2 {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>

<div class="container-xxl text-center" id="wrap">
    <h2>운동일지</h2>

    <!-- FullCalendar를 표시할 영역 -->
    <div id="calendar"></div>

    <!-- 운동일지 모달 (추가 및 수정) -->
    <div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="eventModalLabel">운동일지</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="eventForm">
                        <div class="mb-3">
                            <label for="eventTitle" class="form-label">운동 제목:</label>
                            <input type="text" id="eventTitle" name="title" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="eventDescription" class="form-label">운동 내용:</label>
                            <textarea id="eventDescription" name="description" class="form-control" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="saveEvent">저장</button>
                    <button type="button" class="btn btn-danger" id="deleteEvent" style="display: none;">삭제</button>
                    <button type="button" class="btn btn-secondary" id="closeModal" data-bs-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        let calendarEl = document.getElementById('calendar');
        let calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            selectable: true,
            editable: true,
            events: [], // 초기 이벤트 데이터, 서버에서 받아오도록 설정 가능
            dateClick: function (info) {
                openModal(info.dateStr);
            },
            eventClick: function (info) {
                openModal(info.event.startStr, info.event);
            }
        });

        calendar.render();

        // Modal 관련 로직
        function openModal(date, event = null) {
            $('#eventForm')[0].reset(); // 폼 초기화
            if (event) {
                $('#eventTitle').val(event.title);
                $('#eventDescription').val(event.extendedProps.description);
                $('#deleteEvent').show();
            } else {
                $('#deleteEvent').hide();
            }

            // 모달 표시
            var myModal = new bootstrap.Modal(document.getElementById('eventModal'));
            myModal.show();

            // 저장
            $('#saveEvent').off('click').on('click', function () {
                let title = $('#eventTitle').val();
                let description = $('#eventDescription').val();

                if (event) {
                    event.setProp('title', title);
                    event.setExtendedProp('description', description);
                } else {
                    calendar.addEvent({
                        title: title,
                        start: date,
                        description: description
                    });
                }
                myModal.hide();
            });

            // 삭제
            $('#deleteEvent').off('click').on('click', function () {
                if (event) {
                    event.remove();
                }
                myModal.hide();
            });

            // 취소
            $('#closeModal').off('click').on('click', function () {
                myModal.hide();
            });
        }
    });
</script>
</body>
</html>
