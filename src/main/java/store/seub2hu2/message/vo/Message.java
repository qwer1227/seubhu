package store.seub2hu2.message.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Message {

    private int messageNo;
    private int userNo;
    private String title;
    private String content;
    private Date createdDate;
    private Date updatedDate;
    private String Deleted;
    private MessageFile messageFile;

}

