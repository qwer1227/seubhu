package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.community.vo.UploadFile;

import java.util.List;

@Mapper
public interface UploadMapper {

    void insertBoardFile(@Param("uploadFile") UploadFile uploadFile);
    List<UploadFile> getBoardFiles();
    UploadFile getFileByBoardNo(int boardNo);
    void updateBoardFile(UploadFile uploadFile);

    void insertNoticeFile(@Param("uploadFile") UploadFile uploadFile);
    void updateNoticeFile(UploadFile uploadFile);
}
