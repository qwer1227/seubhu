package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.community.vo.Notice;

import java.util.List;
import java.util.Map;

@Mapper
public interface NoticeMapper {

    void insertNotice(@Param("notice") Notice notice);
    List<Notice> getNotices(@Param("condition") Map<String, Object> condition);
    int getTotalRowsForNotice(@Param("condition") Map<String, Object> condition);
    Notice getNoticeByNo(@Param("no") int no);
}