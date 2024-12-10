package store.seub2hu2.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import store.seub2hu2.admin.service.AdminService;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminRestController {

    @Autowired
    private AdminService adminService;

    @GetMapping("/getHome")
    public ResponseEntity<Map<String, Object>> getHome(@RequestParam(name = "day", required = false) String day

                                                       ) {
        if (day == null || day.isEmpty()) {
            // 현재 날짜로 기본 설정
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            day = sdf.format(new Date());
        }

        // 금일 날짜 계산
        String today = day;

        // 하루 전 날짜 계산
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date currentDate = new Date();
        currentDate.setTime(currentDate.getTime() - (1000 * 60 * 60 * 24));  // 하루 전
        String yesterday = formatter.format(currentDate);

        Map<String, Object> yesterdayData = adminService.getTotalSubject(yesterday);

        Map<String, Object> conditions = adminService.getTotalSubject(day);

        conditions.put("labels", Arrays.asList("호흡", "자세", "운동"));
        conditions.put("data", Arrays.asList(conditions.get("breath"), conditions.get("action"), conditions.get("exercise")));


        return ResponseEntity.ok(conditions);
    }

    @GetMapping("/getChart")
    public ResponseEntity<Map<String, Object>> chart(@RequestParam(name = "day", required = false) String day) {

        if (day == null || day.isEmpty()) {
            // 현재 날짜로 기본 설정
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            day = sdf.format(new Date());
        }

        Map<String, Object> conditions = adminService.getTotalSubject(day);

        conditions.put("day", day);
        conditions.put("labels", Arrays.asList("호흡", "자세", "운동"));
        conditions.put("data", Arrays.asList(conditions.get("breath"), conditions.get("action"), conditions.get("exercise")));


        return ResponseEntity.ok(conditions);
    }
}
