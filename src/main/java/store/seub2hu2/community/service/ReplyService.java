package store.seub2hu2.community.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import store.seub2hu2.community.dto.ReplyForm;
import store.seub2hu2.community.mapper.ReplyMapper;
import store.seub2hu2.community.vo.Reply;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.vo.User;

import java.util.List;

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
        reply.setUpdatedDate(null);
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
        reply.setUpdatedDate(null);
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

    public int getCheckLike(int replyNo
                            , @AuthenticationPrincipal LoginUser loginUser) {

        System.out.println("getCheckLike replyNo:" + replyNo);
        System.out.println("getCheckLike loginUser:" + loginUser.getNo());

        return replyMapper.hasUserLikedReply(replyNo, loginUser.getNo());
    }

    public void updateReplyLike(int replyNo
            , @AuthenticationPrincipal LoginUser loginUser) {

        System.out.println("=================== replyNo:" + replyNo);
        System.out.println("=================== loginUser:" + loginUser.getNo());
        replyMapper.insertReplyLike(replyNo, loginUser.getNo());
    }

    public void updateReplyUnlike(int replyNo
            , @AuthenticationPrincipal LoginUser loginUser) {
        replyMapper.deleteReplyLike(replyNo, loginUser.getNo());
    }
}
