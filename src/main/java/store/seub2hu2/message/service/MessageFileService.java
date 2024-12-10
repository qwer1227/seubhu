package store.seub2hu2.message.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import store.seub2hu2.message.mapper.MessageFileMapper;

@Service
@RequiredArgsConstructor
@Slf4j
public class MessageFileService {

    @Value("${upload.directory.message}")
    private String saveDirectory;

    private final MessageFileMapper messageFileMapper;

}
