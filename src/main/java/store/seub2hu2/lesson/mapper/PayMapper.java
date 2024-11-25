package store.seub2hu2.lesson.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.lesson.vo.Payment;

@Mapper
public interface PayMapper {

    public void insertPay(@Param("pay") Payment payment);


}
