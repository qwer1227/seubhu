package store.seub2hu2.community.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class CrewService {


    @Value("C:/files/inviting")
    private String saveDirectory;
}
