package store.seub2hu2.product.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.product.dto.ProdListDto;
import store.seub2hu2.product.mapper.ProductMapper;
import store.seub2hu2.product.vo.Product;

import java.util.List;

@Service
@Transactional
public class ProductService {

    @Autowired
    ProductMapper productMapper;

    public List<ProdListDto> getProducts() {

        List<ProdListDto> products = productMapper.getProducts();
        System.out.println(products);
        return products;
    }
}
