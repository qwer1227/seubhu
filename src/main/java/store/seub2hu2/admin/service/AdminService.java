package store.seub2hu2.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.admin.mapper.AdminMapper;
import store.seub2hu2.community.CommunityMapper;
import store.seub2hu2.lesson.LessonMapper;
import store.seub2hu2.order.OrderMapper;
import store.seub2hu2.product.ProductMapper;

@Service
@RequiredArgsConstructor
@Transactional
public class AdminService {

    private final AdminMapper adminMapper;

    private final LessonMapper lessonMapper;

    private final CommunityMapper communityMapper;

    private final CommunityMapper courseMapper;

    private final OrderMapper orderMapper;

    private final ProductMapper productMapper;
}
