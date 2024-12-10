package store.seub2hu2.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.product.dto.ProdListDto;

import java.util.List;

    @Service
    public class HomeService {

        @Autowired
        private HomeMapper homeMapper;

        // 주간 베스트 상품 - 별점 순으로 조회
        public List<ProdListDto> getWeeklyBestProductsByRating() {
            return homeMapper.getWeeklyBestProductsByRating();
        }

        // 주간 베스트 상품 - 조회수 순으로 조회 (러닝화 기준)
        public List<ProdListDto> getWeeklyBestProductsByViewCount() {
            return homeMapper.getWeeklyBestProductsByViewCount();
        }
    }

