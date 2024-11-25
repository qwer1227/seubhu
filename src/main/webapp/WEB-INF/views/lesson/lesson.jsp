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
                <div style="width: 30px; height:30px; border-radius: 5px; background: #A8D5BA"></div>
                <span class="p-1">자세</span>
            </div>
            <div class="m-3 d-flex">
                <div style="width: 30px; height:30px; border-radius: 5px; background: #D9C8F2"></div>
                <span class="p-1">운동</span>
            </div>
        </div>
    </div>
    <div class="row mb-3">
        <div id='calendar'></div>
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
                subject: subject // subject 값을 추가
            };

            $.ajax({
                type: 'get',
                url: '/lesson/list',  // Server API endpoint
                data: param,         // param 객체를 data로 전달
                dataType: 'json'
            })
                .done(function (events) {
                    console.log("Fetched Events:", events); // 데이터를 디버깅용으로 출력
                    var formattedEvents = events.map(event => {
                        // 조건별 색상 매핑
                        const colorMap = {
                            '호흡': 'green',
                            '자세': 'blue',
                            '운동': 'orange'
                        };
                        var backgroundColor = 'black'
                        console.log(event.subject)
                        if (event.subject == '호흡') {
                            backgroundColor = '#AEDFF7';
                        }
                        if (event.subject == '자세') {
                            backgroundColor = '#A8D5BA';
                        }
                        if (event.subject == '운동') {
                            backgroundColor = '#D9C8F2';
                        }
                        const borderColor = backgroundColor; // 테두리 색상도 동일하게 설정

                        return {
                            title: event.title,
                            start: event.start,
                            end: event.end,
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

        calendar.render();


        $(document).on('change', '#subject', function () {
            console.log("Subject changed:", $('#subject').val());
            calendar.refetchEvents();
        });
    });
</script>
</body>
</html>