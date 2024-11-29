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

import java.util.Date;

@Service
public class CrewService {

    @Value("C:/files/crew")
    private String saveDirectory;

    @Autowired
    private CrewMapper crewMapper;
    @Autowired
    private UploadMapper uploadMapper;

    public Crew addNewCrew(CrewForm form, @AuthenticationPrincipal LoginUser loginUser){
        Crew crew = new Crew();
        crew.setTitle(form.getTitle());
        crew.setCategory(form.getCategory());
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
            FileUtils.saveMultipartFile(image, saveDirectory, ImageName);

            UploadFile uploadThumbnail = new UploadFile();
            uploadThumbnail.setOriginalName(originalImageName);
            uploadThumbnail.setSaveName(ImageName);

            crew.setThumbnail(uploadThumbnail);
        }

        // 첨부파일 추가 시, crews 테이블에 저장
        if (!upfile.isEmpty()) {
            String originalFileName = upfile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFileName;
            FileUtils.saveMultipartFile(upfile, saveDirectory, filename);

            UploadFile uploadFile = new UploadFile();
            uploadFile.setOriginalName(originalFileName);
            uploadFile.setSaveName(filename);

            crew.setUploadFile(uploadFile);
        }
        crewMapper.insertCrew(crew);

        // 썸네일/첨부파일 추가 시, crew_files 테이블에 저장
        if (crew.getThumbnail() != null || crew.getUploadFile() != null) {
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
}
