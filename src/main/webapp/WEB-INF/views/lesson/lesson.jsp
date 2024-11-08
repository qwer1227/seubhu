<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<%@ page import="java.util.*" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/common/common.jsp" %>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth'
            });
            calendar.render();
        });
    </script>
</head>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">

    <h2>레슨</h2>
    <div class="row mb-3">
        <div id='calendar' class="col"></div>
    </div>
    <div class="row">
        <div class="col text-end">
            <a href="/lesson/form" class="btn bg-black text-white">레슨 모집글 작성</a>
        </div>
    </div>
</div>


<%@include file="/WEB-INF/common/footer.jsp" %>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var calendarEl = document.getElementById('calendar');
        // new FullCalendar.Calendar(대상 DOM객체, {속성:속성값, 속성2:속성값2..})


        var calendar = new FullCalendar.Calendar(calendarEl, {


            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth'
            },

            buttonText: {
                today: '현재날짜',
                month: '월별',
                week: '주',
                day: '일',
                list: '목록'
            },
            editable: true,
            droppable: true, // this allows things to be dropped onto the calendar

            // events: [
            //     { // this object will be "parsed" into an Event Object
            //         title: '자세교정 12/10', // a property!
            //         display: 'block',
            //         backgroundColor:'white',
            //         textColor: 'black',
            //         start: '2024-11-08', // a property!
            //          // a property! ** see important note below about 'end' **
            //         url:'lesson/detail'
            //     }
            // ],

            events: function (info, successCallback, failureCallback, event) {
                refreshEvents(info, successCallback);
            },

            eventClick: function () {
                lessonDetail();
            },

        });

        function lessonDetail() {
            window.open('/lesson/detail');
        }

        // DB에서 목록 가져오기?
        function refreshEvents(info, successCallback) {
            let start = moment(info.start).format("YYYY-MM-DD");
            let end = moment(info.end).format("YYYY-MM-DD");

            let param = {
                start: start,
                end: end
            };

            $.ajax({
                type: 'get',
                url: '/lesson/list',
                data: param,
                dataType: 'json'
            })
                .done(function (eventObject) {
                    successCallback(eventObject);
                })
        }

        calendar.render();

    });


</script>
</body>
</html>