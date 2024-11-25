package store.seub2hu2.community.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import store.seub2hu2.community.dto.ReplyForm;
import store.seub2hu2.community.mapper.BoardMapper;
import store.seub2hu2.community.mapper.ReplyMapper;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.Reply;
import store.seub2hu2.security.LoginUser;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.ListDto;

import java.util.List;
import java.util.Map;

@Service
public class ReplyService {

    @Autowired
    private ReplyMapper replyMapper;

    public void addNewReply(ReplyForm form
            , @AuthenticationPrincipal LoginUser loginUser) {
        Reply reply = new Reply();
        reply.setBoardNo(form.getBoardNo());
        reply.setContent(form.getContent());
        reply.setDeleted("N");

        User user = new User();
        user.setNo(loginUser.getNo());
        reply.setUser(user);

        replyMapper.insertReply(reply);

        reply.setPrevNo(reply.getNo());
        reply.setDeleted(reply.getDeleted());
        replyMapper.updateReply(reply);
    }

    public void addNewComment(ReplyForm form
            , @AuthenticationPrincipal LoginUser loginUser) {
        Reply reply = new Reply();
        reply.setBoardNo(form.getBoardNo());
        reply.setContent(form.getContent());
        reply.setDeleted("N");

        User user = new User();
        user.setNo(loginUser.getNo());
        reply.setUser(user);

        replyMapper.insertReply(reply);

        reply.setPrevNo(form.getPrevNo());
        reply.setDeleted(reply.getDeleted());
        replyMapper.updateReply(reply);
    }

    public List<Reply> getReplies(int boardNo) {
        List<Reply> replyList = replyMapper.getRepliesByBoardNo(boardNo);

        return replyList;
    }

    public void deleteReply(int replyNo) {
        Reply reply = replyMapper.getReplyByReplyNo(replyNo);
        reply.setBoardNo(reply.getBoardNo());
        replyMapper.deleteReplyByNo(replyNo);
    }

    public void updateReply(ReplyForm form) {
        Reply reply = replyMapper.getReplyByReplyNo(form.getNo());
        reply.setContent(form.getContent());

        replyMapper.updateReply(reply);
    }
}
