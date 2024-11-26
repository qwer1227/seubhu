package store.seub2hu2.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import store.seub2hu2.community.mapper.BoardScrapMapper;
import store.seub2hu2.security.user.LoginUser;

@Service
public class ScrapService {

    @Autowired
    private BoardScrapMapper scrapMapper;

    public int getCheckScrap(int boardNo
                            , @AuthenticationPrincipal LoginUser loginUser){
        return scrapMapper.hasUserScrapedBoard(boardNo, loginUser.getNo());
    }

    public void updateBoardScrap(int boardNo
                                 , @AuthenticationPrincipal LoginUser loginUser){
        scrapMapper.insertScrap(boardNo, loginUser.getNo());
    }

    public void deleteBoardScrap(int boardNo
                                    , @AuthenticationPrincipal LoginUser loginUser){
        scrapMapper.deleteScrap(boardNo, loginUser.getNo());
    }
}
