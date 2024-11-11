package store.seub2hu2.community.vo;

import lombok.Getter;

@Getter
public enum BoardCategory {

    NOMAL("일반", 100)
    , PRIDE("자랑", 110)
    , QUESTION("질문", 120)
    , TRAINING_LOG("훈련일지", 130);

    private String status;
    private int catNo;

    private BoardCategory(String name, int catNo) {
        this.status = name;
        this.catNo = catNo;
    }

//    public static BoardCategory fromString(String value){
//        for (BoardCategory category : values()) {
//            if (category.name().equalsIgnoreCase(value)) {
//                return category;
//            }
//        }
//        throw new IllegalArgumentException("Unknown enum value: " + value);
//    }
}

