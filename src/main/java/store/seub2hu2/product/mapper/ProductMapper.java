package store.seub2hu2.product.mapper;

import org.apache.ibatis.annotations.Mapper;
import store.seub2hu2.product.vo.Product;

import java.util.List;

@Mapper
public interface ProductMapper {

    List<Product> getProduct();

}
