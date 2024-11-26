package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.community.vo.Report;

@Mapper
public interface BoardReportMapper {

    void insertReport(@Param("report") Report report);
    void updateDisableBoard(@Param("no") int boardNo, @Param("userNo") int userNo);
}
