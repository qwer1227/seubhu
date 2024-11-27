package store.seub2hu2.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.community.dto.NoticeForm;
import store.seub2hu2.community.mapper.NoticeMapper;
import store.seub2hu2.community.mapper.UploadMapper;
import store.seub2hu2.community.vo.Notice;
import store.seub2hu2.community.vo.UploadFile;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.FileUtils;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

@Service
public class NoticeService {

    @Value("C:/files/notice")
    private String saveDirectory;

    @Autowired
    private NoticeMapper noticeMapper;

    @Autowired
    private UploadMapper uploadMapper;

    public void addNewNotice(NoticeForm form
                            , @AuthenticationPrincipal LoginUser loginUser) {

        Notice notice = new Notice();
        notice.setTitle(form.getTitle());
        notice.setFirst(form.isFirst());
        notice.setTitle(form.getTitle());
        notice.setContent(form.getContent());

        MultipartFile multipartFile = form.getUpfile();

        if (!multipartFile.isEmpty()) {
            String originalFilename = multipartFile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFilename;
            FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);

            UploadFile uploadFile = new UploadFile();
            uploadFile.setOriginalName(originalFilename);
            uploadFile.setSaveName(filename);

            notice.setUpfile(uploadFile);
        }

        noticeMapper.insertNotice(notice);

        if (notice.getUpfile() != null) {
            UploadFile uploadFile = notice.getUpfile();
            uploadFile.setNo(notice.getNo());
            uploadFile.setSaveName(notice.getUpfile().getSaveName());
            uploadFile.setOriginalName(notice.getUpfile().getOriginalName());

            uploadMapper.insertNoticeFile(uploadFile);
        }
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
