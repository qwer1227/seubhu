package store.seub2hu2.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.mypage.mapper.PostMapper;
import store.seub2hu2.mypage.vo.Post;


@Service
public class PostService {

    @Autowired
    PostMapper postMapper;

    public Post getPostDetail(int postNo){
        Post post = postMapper.getPostByNo(postNo);

        return post;
    }

    public void insertPost(Post post){
        postMapper.insertPost(post);
    }

}
