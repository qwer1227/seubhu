package store.seub2hu2.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.community.dto.BoardForm;
import store.seub2hu2.community.mapper.BoardMapper;
import store.seub2hu2.community.vo.Board;

@Service
@Transactional
public class BoardService {

    @Autowired
    private BoardMapper boardMapper;

    public void insertBoard(Board board){
        boardMapper.insertBoard(board);
    }
}
