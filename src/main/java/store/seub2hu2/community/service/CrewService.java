package store.seub2hu2.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.community.dto.CrewForm;
import store.seub2hu2.community.mapper.CrewMapper;
import store.seub2hu2.community.mapper.UploadMapper;
import store.seub2hu2.community.vo.Crew;
import store.seub2hu2.community.vo.CrewMember;
import store.seub2hu2.community.vo.UploadFile;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.FileUtils;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;
import store.seub2hu2.util.WebContentFileUtils;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class CrewService {

    @Value("${upload.directory.community}")
    private String saveImageDirectory;

    @Value("C:/files/crew")
    private String saveFileDirectory;


    @Autowired
    private WebContentFileUtils webContentFileUtils;
    @Autowired
    private CrewMapper crewMapper;
    @Autowired
    private UploadMapper uploadMapper;

    public Crew addNewCrew(CrewForm form
            , @AuthenticationPrincipal LoginUser loginUser) {
        Crew crew = new Crew();
        crew.setNo(form.getNo());
        crew.setTitle(form.getTitle());
        crew.setName(form.getName());
        crew.setSchedule(form.getSchedule());
        crew.setLocation(form.getLocation());
        crew.setDescription(form.getDescription());

        MultipartFile image = form.getImage();
        MultipartFile upfile = form.getUpfile();

        // 작성자가 대표 이미지 추가 시, crews 테이블에 저장
        if (!image.isEmpty()) {
            String originalImageName = image.getOriginalFilename();
            String ImageName = System.currentTimeMillis() + originalImageName;
            webContentFileUtils.saveWebContentFile(image, saveImageDirectory, ImageName);

            UploadFile uploadThumbnail = new UploadFile();
            uploadThumbnail.setOriginalName(originalImageName);
            uploadThumbnail.setSaveName(ImageName);

            crew.setThumbnail(uploadThumbnail);
        }

        // 첨부파일 추가 시, crews 테이블에 저장
        if (!upfile.isEmpty()) {
            String originalFileName = upfile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFileName;
            FileUtils.saveMultipartFile(upfile, saveFileDirectory, filename);

            UploadFile uploadFile = new UploadFile();
            uploadFile.setOriginalName(originalFileName);
            uploadFile.setSaveName(filename);

            crew.setUploadFile(uploadFile);
        }
        crewMapper.insertCrew(crew);

        // 썸네일/첨부파일 추가 시, crew_files 테이블에 저장

        if (crew.getThumbnail() != null) {
            UploadFile uploadThumbnail = crew.getThumbnail();
            uploadThumbnail.setNo(crew.getNo());
            uploadThumbnail.setSaveName(crew.getThumbnail().getSaveName());
            uploadThumbnail.setOriginalName(crew.getThumbnail().getOriginalName());
            uploadMapper.insertCrewFile(uploadThumbnail);
        }
        if (crew.getUploadFile() != null) {
            UploadFile uploadFile = crew.getUploadFile();
            uploadFile.setNo(crew.getNo());
            uploadFile.setSaveName(crew.getUploadFile().getSaveName());
            uploadFile.setOriginalName(crew.getUploadFile().getOriginalName());
            uploadMapper.insertCrewFile(uploadFile);
        }

        CrewMember member = new CrewMember();
        member.setCrewNo(crew.getNo());
        member.setReader(true);
        member.setJoinDate(new Date());
        member.setJoin(true);

        User user = new User();
        user.setNo(loginUser.getNo());
        user.setNickname(loginUser.getNickname());
        member.setUser(user);

        crewMapper.insertCrewMember(member);

        return crew;
    }

    public ListDto<Crew> getCrews(Map<String, Object> condition) {
        int totalRows = crewMapper.getTotalRowsForCrew(condition);

        int page = (Integer) condition.get("page");
        int rows = (Integer) condition.get("rows");
        Pagination pagination = new Pagination(page, totalRows, rows);

        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        List<Crew> crews = crewMapper.getCrews(condition);
        ListDto<Crew> dto = new ListDto<>(crews, pagination);

        return dto;
    }
}
