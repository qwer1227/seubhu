package store.seub2hu2.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.community.mapper.BoardMapper;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.product.dto.ProdListDto;

import java.util.List;

    @Service
    public class HomeService {

        @Autowired
        private HomeMapper homeMapper;


        // 최신 글 5개 조회
        public List<Board> getTopViewedBoards() {
            return homeMapper.getTopViewedBoards(); // 최신 글 5개 반환
        }

        // 주간 베스트 상품 - 별점 순으로 조회
        public List<ProdListDto> getWeeklyBestProductsByRating() {
            return homeMapper.getWeeklyBestProductsByRating();
        }

        // 주간 베스트 상품 - 조회수 순으로 조회 (러닝화 기준)
        public List<ProdListDto> getWeeklyBestProductsByViewCount() {
            return homeMapper.getWeeklyBestProductsByViewCount();
        }
    }

