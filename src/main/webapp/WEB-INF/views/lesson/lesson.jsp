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
        body {
            background-color: #fafafa;
        }
        .fc-day a {
            color:black;
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
                <option>전체</option>
                <option>호흡</option>
                <option>자세</option>
                <option>운동</option>
            </select>
        </div>
    </div>
    <div class="row mb-3">
        <div id='calendar'></div>
    </div>
    <div class="row">
        <div class="col text-end">
            <a href="/lesson/form" class="btn bg-black text-white">레슨 모집글 작성</a>
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
                right: 'dayGridMonth,dayGridWeek'
            },
            buttonText: {
                today: '현재날짜',
                month: '월별',
                week: '주별',
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
                lessonDetail(info.event.extendedProps.lessonNo);
            },
        });

        function refreshEvents(info, successCallback, failureCallback) {
            let start = moment(info.start).format("YYYY-MM-DD");
            let end = moment(info.end).format("YYYY-MM-DD");
            let subject = $('#subject').val(); // 선택된 과정 필터 값

            let param = {
                start: start,
                end: end,
                subject: subject // course 값을 추가
            };

            $.ajax({
                type: 'get',
                url: '/lesson/list',  // Server API endpoint
                data: param,         // param 객체를 data로 전달
                dataType: 'json'
            })
                .done(function (events) {
                    console.log(events); // Log the response to check the lessonNo
                    var formattedEvents = events.map(event => ({
                        title: event.title,
                        start: event.start,
                        end: event.end,
                        textColor: 'white',
                        borderColor: 'black',
                        backgroundColor: 'black',
                        display: 'block',
                        extendedProps: {
                            lessonNo: event.lessonNo,  // The lessonNo received from the database
                        },
                    }));
                    successCallback(formattedEvents);
                })
                .fail(function () {
                    console.error("Failed to load event data.");
                    failureCallback();
                });
        }

        calendar.render();


        $(document).on('change', '#subject', function () {
            // 필터 변경 시 캘린더 다시 로드
            calendar.refetchEvents();
        });
    });
</script>
</body>
</html>