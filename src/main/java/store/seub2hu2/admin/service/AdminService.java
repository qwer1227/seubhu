package store.seub2hu2.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.admin.mapper.AdminMapper;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AdminService {

//    private final AdminMapper adminMapper;
//
//    private final LessonMapper lessonMapper;
//
//    private final CommunityMapper communityMapper;
//
//    private final CommunityMapper courseMapper;
//
//    private final OrderMapper orderMapper;
//
//    private final ProductMapper productMapper;
//
    @Autowired
    private AdminMapper adminMapper;

        public ListDto<User> getAllUsers(Map<String, Object> condition) {

            int totalRows = adminMapper.getTotalRows(condition);

            int page = (Integer) condition.get("page");
            int rows = (Integer) condition.get("rows");
            Pagination pagination = new Pagination(page, totalRows, rows);

            int begin = pagination.getBegin();
            int end = pagination.getEnd();
            condition.put("begin", begin);
            condition.put("end", end);

            List<User> users = adminMapper.getUsers(condition);

            ListDto<User> dto = new ListDto<>(users, pagination);
            return dto;
        }
}
