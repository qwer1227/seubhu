package store.seub2hu2.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import store.seub2hu2.community.dto.ReportForm;
import store.seub2hu2.community.mapper.ReportMapper;
import store.seub2hu2.community.vo.Report;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.vo.User;

@Service
public class ReportService {

    @Autowired
    private ReportMapper reportMapper;

    public void registerReportToBoard(ReportForm form
            , @AuthenticationPrincipal LoginUser loginUser) {

        Report report = new Report();
        report.setType(form.getType());
        report.setReason(form.getReason());

        User user = new User();
        user.setNo(loginUser.getNo());
        user.setNickname(loginUser.getNickname());
        report.setUser(user);

        if (form.getType().equals("board")){
            report.setBoardNo(form.getNo());
        }

        if (form.getType().equals("reply")){
            report.setReplyNo(form.getNo());
        }

        reportMapper.insertReportToBoard(report);
    }

    public void registerReportToCrew(ReportForm form
            , @AuthenticationPrincipal LoginUser loginUser) {

        Report report = new Report();
        report.setType(form.getType());
        report.setReason(form.getReason());

        User user = new User();
        user.setNo(loginUser.getNo());
        user.setNickname(loginUser.getNickname());
        report.setUser(user);

        if (form.getType().equals("crew")){
            report.setCrewNo(form.getNo());
        }

        if (form.getType().equals("reply")){
            report.setReplyNo(form.getNo());
        }

        reportMapper.insertReportToCrew(report);
    }
}
