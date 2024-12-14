package store.seub2hu2.community.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.community.dto.ReplyForm;
import store.seub2hu2.community.mapper.ReplyMapper;
import store.seub2hu2.community.vo.Reply;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.vo.User;

import java.util.List;

@Slf4j
@Service
@Transactional
public class ReplyService {

    @Autowired
    private ReplyMapper replyMapper;

    public void addNewReply(ReplyForm form
            , @AuthenticationPrincipal LoginUser loginUser) {
        Reply reply = new Reply();
        reply.setType("board");
        reply.setTypeNo(form.getTypeNo());
        reply.setContent(form.getContent());
        reply.setDeleted("N");

        User user = new User();
        user.setNo(loginUser.getNo());
        reply.setUser(user);

        replyMapper.insertReply(reply);

        reply.setPrevNo(reply.getNo());
        reply.setDeleted(reply.getDeleted());
        reply.setContent(reply.getContent());
        reply.setUpdatedDate(null);

        replyMapper.updateReply(reply);
    }

    public void addNewComment(ReplyForm form
            , @AuthenticationPrincipal LoginUser loginUser) {
        Reply reply = new Reply();
        reply.setPrevNo(form.getPrevNo());
        reply.setType("board");
        reply.setTypeNo(form.getTypeNo());
        reply.setContent(form.getContent());
        reply.setDeleted("N");

        System.out.println("===============" + form.getTypeNo());

        User user = new User();
        user.setNo(loginUser.getNo());
        reply.setUser(user);

        replyMapper.insertReply(reply);
    }

    public List<Reply> getReplies(int typeNo) {
        List<Reply> replyList = replyMapper.getRepliesByTypeNo(typeNo);

        return replyList;
    }

    public int getReplyCnt(int typeNo) {
        return replyMapper.getReplyCntByTypeNo(typeNo);
    }

    public void updateReply(ReplyForm form) {
        Reply reply = replyMapper.getReplyByReplyNo(form.getNo());
        reply.setContent(form.getContent());
        reply.setDeleted("N");

        replyMapper.updateReply(reply);
    }

    public void deleteReply(int replyNo) {
        Reply reply = replyMapper.getReplyByReplyNo(replyNo);
        reply.setDeleted("Y");
        replyMapper.updateReply(reply);
    }

    public int getCheckLike(int replyNo
            , @AuthenticationPrincipal LoginUser loginUser) {

        return replyMapper.hasUserLikedReply(replyNo, loginUser.getNo());
    }

    public void updateReplyLike(int replyNo
            , @AuthenticationPrincipal LoginUser loginUser) {

        Reply reply = replyMapper.getReplyByReplyNo(replyNo);

        replyMapper.insertReplyLike(reply, loginUser.getNo());
    }

    public void deleteReplyLike(int replyNo
            , @AuthenticationPrincipal LoginUser loginUser) {


        replyMapper.deleteReplyLike(replyNo, loginUser.getNo());

    }
}
