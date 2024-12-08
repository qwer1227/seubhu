package store.seub2hu2.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import store.seub2hu2.community.dto.MarathonForm;
import store.seub2hu2.community.mapper.MarathonMapper;
import store.seub2hu2.community.mapper.UploadMapper;
import store.seub2hu2.community.vo.Crew;
import store.seub2hu2.community.vo.Marathon;
import store.seub2hu2.community.vo.MarathonOrgan;
import store.seub2hu2.community.vo.UploadFile;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

@Service
public class MarathonService {

    @Autowired
    private MarathonMapper marathonMapper;

    @Autowired
    private UploadMapper uploadMapper;

    public Marathon addNewMarathon(MarathonForm form){
        Marathon marathon = new Marathon();
        marathon.setNo(form.getNo());
        marathon.setTitle(form.getTitle());
        marathon.setContent(form.getContent());
        marathon.setMarathonDate(form.getMarathonDate());
        marathon.setStartDate(form.getStartDate());
        marathon.setEndDate(form.getEndDate());
        marathon.setUrl(form.getUrl());
        marathon.setPlace(form.getPlace());
        marathon.setThumbnail(form.getThumbnail());

        marathonMapper.insertMarathon(marathon);

        if (marathon.getUploadFile() != null) {
            UploadFile uploadFile = marathon.getUploadFile();
            uploadFile.setNo(marathon.getNo());
            uploadFile.setSaveName(marathon.getUploadFile().getSaveName());
            uploadFile.setOriginalName(marathon.getOriginalFileName());
            // UploadFile 테이블에 저장
            uploadMapper.insertMarathonFile(uploadFile);
        }

        if (form.getHost().equals("host")){
            MarathonOrgan organ = new MarathonOrgan();
            organ.setMarathonNo(form.getNo());
            organ.setOrganRole("host");
            organ.setOrganName(form.getOrganName());
            marathonMapper.insertMarathonOrgan(organ);
        }

        if (form.getOrganizer().equals("organizer")){
            MarathonOrgan organ = new MarathonOrgan();
            organ.setMarathonNo(form.getNo());
            organ.setOrganRole("organizer");
            organ.setOrganName(form.getOrganName());
            marathonMapper.insertMarathonOrgan(organ);
        }

        return marathon;
    }

    public ListDto<Marathon> getMarathons(Map<String, Object> condition){
        int totalRows = marathonMapper.getTotalMarathons(condition);

        int page = (Integer) condition.get("page");
        int rows = (Integer) condition.get("rows");
        Pagination pagination = new Pagination(page, totalRows, rows);

        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        List<Marathon> marathons = marathonMapper.getMarathons(condition);
        ListDto<Marathon> dto = new ListDto<>(marathons, pagination);

        return dto;
    }
}
