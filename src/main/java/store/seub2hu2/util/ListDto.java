package store.seub2hu2.util;

import java.util.List;



import store.seub2hu2.util.Pagination;

public class ListDto<T> {
    // 목록화면에 표시되는 데이터다.
    List<T> data;
    // 목록화면에 표시되는 페이징처리 정보다.
    store.seub2hu2.util.Pagination paging;

    public ListDto(List<T> data, Pagination paging) {
        this.data = data;
        this.paging = paging;
    }

    public List<T> getData() {
        return data;
    }

    public Pagination getPaging() {
        return paging;
    }
}
