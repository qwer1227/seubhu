package store.seub2hu2.community.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.community.dto.ReplyForm;
import store.seub2hu2.community.mapper.BoardMapper;
import store.seub2hu2.community.mapper.ReplyMapper;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.Reply;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.ListDto;

import java.util.List;
import java.util.Map;

@Service
public class ReplyService {

    @Autowired
    private BoardMapper boardMapper;

    @Autowired
    private ReplyMapper replyMapper;

    public Reply addNewReply(ReplyForm form, int userNo) {
        Reply reply = new Reply();
        reply.setBoardNo(form.getBoardNo());
        reply.setContent(form.getContent());

        User user = new User();
        user.setNo(userNo);
        reply.setUser(user);

        replyMapper.insertReply(reply);

        reply.setPrevNo(reply.getNo());
        replyMapper.updateReply(reply);

        return reply;
    }

    public Reply addNewComment(ReplyForm form, int userNo) {
        Reply reply = new Reply();
        reply.setBoardNo(form.getBoardNo());
        reply.setContent(form.getContent());

        User user = new User();
        user.setNo(userNo);
        reply.setUser(user);

        replyMapper.insertReply(reply);

        reply.setPrevNo(form.getPrevNo());
        replyMapper.updateReply(reply);

        return reply;
    }

    public List<Reply> getReplies(@Param("no") int boardNo) {
        List<Reply> replyList = replyMapper.getRepliesByBoardNo(boardNo);

        return replyList;
    }

    public void deleteReply(@Param("no") int replyNo) {
        Reply reply = replyMapper.getReplyByReplyNo(replyNo);
        reply.setDeleted("Y");
        replyMapper.deleteReplyByNo(reply.getNo());
    }
}
