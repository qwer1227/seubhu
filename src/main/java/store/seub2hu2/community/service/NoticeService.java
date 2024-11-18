package store.seub2hu2.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.community.mapper.NoticeMapper;
import store.seub2hu2.community.vo.Notice;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

@Service
public class NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;

    public void addNewNotice(Notice notice) {
        noticeMapper.insertNotice(notice);
    }

    public ListDto<Notice> getNotices(Map<String, Object> condition) {
        int totalRows = noticeMapper.getTotalRowsForNotice(condition);

        int page = (Integer) condition.get("page");
        int rows = (Integer) condition.get("rows");
        Pagination pagination = new Pagination(page, totalRows, rows);

        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        List<Notice> notices = noticeMapper.getNotices(condition);
        ListDto<Notice> dto = new ListDto<>(notices, pagination);

        return dto;
    }
}
