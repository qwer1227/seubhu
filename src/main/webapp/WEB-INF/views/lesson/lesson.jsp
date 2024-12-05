<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<%@ page import="java.util.*" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>


    <style>

        .fc-day a {
            color: black;
            text-decoration: none;
        }

        .fc-day-sun a {
            color: red;
            text-decoration: none;
        }

        /* 토요일 날짜 파란색 */
        .fc-day-sat a {
            color: blue;
            text-decoration: none;
        }

        .fc-event {
            overflow: hidden; /* 넘치는 텍스트 숨기기 */
            text-overflow: ellipsis; /* 넘치는 텍스트에 '...' 표시 */
            white-space: nowrap; /* 텍스트가 줄 바꿈 없이 한 줄로 표시 */
        }

    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl" id="wrap">
    <div class="row text-center mb-3">
        <h2>레슨 일정 보기</h2>
    </div>
    <div class="row mb-3">
        <div class="col-2">
            <label for="subject">과정 선택:</label>
            <select id="subject" class="form-select">
                <option value="전체">전체</option>
                <option value="호흡">호흡</option>
                <option value="자세">자세</option>
                <option value="운동">운동</option>
            </select>
        </div>
        <div class="col d-flex mt-2">
            <div class="m-3 d-flex">
                <div style="width: 30px; height:30px; border-radius: 5px; background: #AEDFF7"></div>
                <span class="p-1">호흡</span>
            </div>
            <div class="m-3 d-flex">
                <div style="width: 30px; height:30px; border-radius: 5px; background: #d8f6d4"></div>
                <span class="p-1">자세</span>
            </div>
            <div class="m-3 d-flex">
                <div style="width: 30px; height:30px; border-radius: 5px; background: #D9C8F2"></div>
                <span class="p-1">운동</span>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col mb-3 form-check">
            <input type="checkbox" id="completed-include">
            <label for="completed-include">마감 포함</label>
        </div>
    </div>
    <div class="row mb-3">
        <div id='calendar'></div>
    </div>
</div>

<div class="modal" id="eventModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 id="modal-title" class="modal-title"></h5>
            </div>
            <div class="modal-body">
                <p id="modal-subject"></p>
                <p id="modal-description"></p>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script>


    document.addEventListener('DOMContentLoaded', function () {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                left: 'prev,next,today',
                center: 'title',
                right: 'dayGridMonth,dayGridWeek,timeGridWeek'
            },
            buttonText: {
                today: '현재날짜',
                month: '월별',
                week: '주별',
                timeGridWeek: '주별시간',
                day: '일별',
                list: '목록',
            },
            views: {
                dayGridMonth: {
                    titleFormat: {
                        year: 'numeric',
                        month: 'numeric',
                    }
                },
                dayGridWeek: {
                    titleFormat: {
                        year: 'numeric',
                        month: 'numeric',
                    }
                },
                timeGridWeek: {
                    titleFormat: {
                        year: 'numeric',
                        month: 'numeric',
                        day: 'numeric',
                    }
                }
            },
            editable: true,
            droppable: true,

            // Load events dynamically from the database
            events: function (info, successCallback, failureCallback) {
                refreshEvents(info, successCallback, failureCallback);
            },

            // Handle event clicks
            eventClick: function (info) {
                $('#modal-title').text(info.event.title);
                $('#modal-subject').text(info.event.extendedProps.subject);
                $('#modal-description').text(info.event.extendedProps.lessonNo);
                $('#eventModal').modal('show');
            },

            eventMouseEnter: function(info) {
                // info 객체로 이벤트 관련 정보를 가져올 수 있음
                console.log("Event Title:", info.event.title);
                console.log("Extended Props:", info.event.extendedProps);

                // 예: 툴팁 추가
                const tooltip = new Tooltip(info.el, {
                    title: info.event.extendedProps.description || 'No description',
                    placement: 'top', // 툴팁 위치: top, bottom, left, right
                    trigger: 'hover',
                    container: 'body'
                });
            },

            eventMouseEnter: function(info) {
                info.el.style.backgroundColor = 'yellow'; // 배경색 변경
                info.el.style.color = 'red';             // 텍스트 색상 변경
            },

            eventMouseLeave: function(info) {
                info.el.style.backgroundColor = info.backgroundColor;      // 원래 색상으로 복구
                info.el.style.color = '';
            },

        });

        // Refresh events based on selected filters
        function refreshEvents(info, successCallback, failureCallback) {
            let start = moment(info.start).format("YYYY-MM-DD");
            let end = moment(info.end).format("YYYY-MM-DD");
            let subject = $('#subject').val(); // 선택된 과정 필터 값
            const includeCompleted = $('#completed-include').prop('checked');

            let param = {
                start: start,
                end: end,
                subject: subject, // subject 값을 추가
                includeCompleted: includeCompleted
            };

            $.ajax({
                type: 'get',
                url: '/lesson/list',  // Server API endpoint
                data: param,          // param 객체를 data로 전달
                dataType: 'json'
            })
                .done(function (events) {
                    console.log("Fetched Events:", events); // 데이터를 디버깅용으로 출력
                    var formattedEvents = events.map(event => {
                        // 조건별 색상 매핑
                        const colorMap = {
                            '호흡': '#d0e8fa',
                            '자세': '#d8f6d4',
                            '운동': '#efe1fd'
                        };

                        const backgroundColor = colorMap[event.subject] || 'black';
                        const borderColor = backgroundColor; // 테두리 색상도 동일하게 설정

                        return {
                            title: event.title,
                            start: event.start,
                            end: event.end,
                            description: 'asdasd',
                            allDay: false,
                            textColor: 'black', // 텍스트 색상
                            borderColor: borderColor,
                            backgroundColor: backgroundColor, // 배경색
                            display: 'block',
                            extendedProps: {
                                lessonNo: event.lessonNo,  // 추가 정보
                                subject: event.subject // subject 포함
                            },
                        };
                    });

                    console.log("Formatted Events:", formattedEvents);

                    // 캘린더에 렌더링할 이벤트 데이터 전달
                    successCallback(formattedEvents);
                })
                .fail(function () {
                    console.error("Failed to load event data.");
                    failureCallback();
                });
        }

        function lessonDetail(lessonNo) {
            if (lessonNo !== undefined && lessonNo !== null && lessonNo !== "") {  // Validate lessonNo
                console.log("LessonNo:", lessonNo); // Log to ensure lessonNo is being passed as int
                location.href = ("/lesson/detail?lessonNo=" + lessonNo);
            } else {
                console.error("Invalid lessonNo");
            }
        }

        // Subject or Completed include filter changes
        $(document).on('change', '#subject', function () {
            console.log("Subject changed:", $('#subject').val());
            calendar.refetchEvents();
        });

        $(document).on('change', '#completed-include', function () {
            console.log("Completed include changed:", $('#completed-include').prop('checked')); // 상태 확인
            calendar.refetchEvents();
        });

        $('#subject, #completed-include').on('change', function () {
            calendar.refetchEvents(); // 이벤트 다시 불러오기
        });



        // Initialize the calendar
        calendar.render();
    });

</script>
</body>
</html>