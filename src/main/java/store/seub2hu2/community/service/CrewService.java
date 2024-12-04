package store.seub2hu2.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.community.dto.CrewForm;
import store.seub2hu2.community.exception.CommunityException;
import store.seub2hu2.community.mapper.CrewMapper;
import store.seub2hu2.community.mapper.CrewReplyMapper;
import store.seub2hu2.community.mapper.UploadMapper;
import store.seub2hu2.community.vo.Crew;
import store.seub2hu2.community.vo.CrewMember;
import store.seub2hu2.community.vo.Reply;
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
    @Autowired
    private CrewReplyMapper crewReplyMapper;

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


        User user = new User();
        user.setNo(loginUser.getNo());
        user.setNickname(loginUser.getNickname());
        crew.setUser(user);

        // crew_members 테이블에 저장
        CrewMember member = new CrewMember();
        member.setCrewNo(crew.getNo());
        member.setReader("Y");
        member.setJoinDate(new Date());
        member.setJoin("Y");

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

    public Crew getCrewDetail(int crewNo){
        Crew crew = crewMapper.getCrewDetailByNo(crewNo);
        UploadFile uploadThumbnail = uploadMapper.getThumbnailByCrewNo(crewNo);
        UploadFile uploadFile = uploadMapper.getFileByCrewNo(crewNo);
        List<Reply> reply = crewReplyMapper.getRepliesByCrewNo(crewNo);

        if (crew == null){
            throw new CommunityException("존재하지 않는 게시글입니다.");
        }

        crew.setThumbnail(uploadThumbnail);
        crew.setUploadFile(uploadFile);
        crew.setReply(reply);

        return crew;
    }

    public void updateCrewViewCnt(int crewNo){
        Crew crew = crewMapper.getCrewDetailByNo(crewNo);
        crew.setViewCnt(crew.getViewCnt() + 1);
        crewMapper.updateCrewCnt(crew);
    }

    public void updateCrew(CrewForm form){
        Crew savedCrew = crewMapper.getCrewDetailByNo(form.getNo());
        savedCrew.setNo(form.getNo());
        savedCrew.setType(form.getType());
        savedCrew.setTitle(form.getTitle());
        savedCrew.setLocation(form.getLocation());
        savedCrew.setDescription(form.getDescription());
        savedCrew.setSchedule(form.getSchedule());

        savedCrew.setName(form.getName());
        savedCrew.setDeleted("N");

        MultipartFile image = form.getImage();
        MultipartFile upfile = form.getUpfile();

        // 기존 썸네일 정보 조회
        UploadFile prevThumbnail = uploadMapper.getThumbnailByCrewNo(savedCrew.getNo());
        if (!image.isEmpty()) {
            // 기존 썸네일이 존재하면 "Y"로 변경 저장
            if (prevThumbnail != null) {
                uploadMapper.updateCrewFile(prevThumbnail.getFileNo());
            }

            // 신규 썸네일 정보를 조회하여 CREW_FILES 테이블에 저장
            String originalImageName = image.getOriginalFilename();
            String ImageName = System.currentTimeMillis() + originalImageName;
            webContentFileUtils.saveWebContentFile(image, saveImageDirectory, ImageName);

            UploadFile uploadThumbnail = new UploadFile();
            uploadThumbnail.setNo(savedCrew.getNo());
            uploadThumbnail.setOriginalName(originalImageName);
            uploadThumbnail.setSaveName(ImageName);
            savedCrew.setThumbnail(uploadThumbnail);

            uploadMapper.insertCrewFile(uploadThumbnail);
        }

        // 기존 첨부파일 정보 조회
        UploadFile prevUploadFile = uploadMapper.getFileByCrewNo(savedCrew.getNo());
        if (!upfile.isEmpty()) {
            // 기존 첨부파일이 존재하면 "Y"로 변경 저장
            if (prevUploadFile != null) {
                uploadMapper.updateCrewFile(prevUploadFile.getFileNo());
            }
            // 신규 첨부파일 정보를 조회하여 CREW_FILES 테이블에 저장
            String originalFileName = upfile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFileName;
            FileUtils.saveMultipartFile(upfile, saveFileDirectory, filename);

            UploadFile uploadFile = new UploadFile();
            uploadFile.setNo(savedCrew.getNo());
            uploadFile.setOriginalName(originalFileName);
            uploadFile.setSaveName(filename);
            savedCrew.setUploadFile(uploadFile);

            uploadMapper.insertCrewFile(uploadFile);
        }

        if (prevUploadFile != null){
            UploadFile uploadFile = new UploadFile();
            uploadFile.setNo(savedCrew.getNo());
            uploadFile.setOriginalName(prevUploadFile.getOriginalName());
            uploadFile.setSaveName(prevUploadFile.getSaveName());
            savedCrew.setUploadFile(uploadFile);
        }

        crewMapper.updateCrew(savedCrew);
    }

    public void deleteCrew(int crewNo){
        Crew savedCrew = crewMapper.getCrewDetailByNo(crewNo);
        savedCrew.setDeleted("Y");

        crewMapper.updateCrew(savedCrew);
    }

    public void deleteCrewFile(int fileNo){
        uploadMapper.updateCrewFile(fileNo);
    }
}
