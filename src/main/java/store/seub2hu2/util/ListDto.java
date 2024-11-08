package store.seub2hu2.util;

import java.util.List;

public class ListDto<T> {
    // 목록 화면에 표시할 데이터
    List<T> data;
    // 목록 화면에 표시되는 페이징 처리 정보
    Pagination pagination;

    // 생성자 메소드로 데이터 저장
    public ListDto(List<T> data, Pagination pagination) {
        this.data = data;
        this.pagination = pagination;
    }

    // getter 메소드로 데이터 꺼내기
    public List<T> getData() {
        return data;
    }

    public Pagination getPagination() {
        return pagination;
    }
}
