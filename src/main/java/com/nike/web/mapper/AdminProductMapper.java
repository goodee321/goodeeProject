package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.ProductDTO;
import com.nike.web.domain.ProductImageDTO;
import com.nike.web.domain.ProductQtyDTO;

@Mapper
public interface AdminProductMapper {

	
	
			public int selectProductCount();
			
			
			public int insertProduct(ProductDTO product);
			
			public int insertProductQty(ProductQtyDTO productQty);
			
			
			public int insertProductAttach(ProductImageDTO productImageAttach);
			
			public int updateProduct(ProductDTO product);
			
			public int updateProductQty(ProductQtyDTO product);
			
			public List<ProductImageDTO> selectProductImageListInTheProduct(Integer proimgNo);
			
			public int deleteProduct(Integer proNo);
			
			public ProductDTO selectProductByNo(Integer proNo);
			
			public int productQtyOverLap(Map<String, Object> map);
			
	
			// admin
			public List<ProductDTO> selectProductList(Map<String, Object> map);
					
					
			public List<ProductDTO> selectFindProductList(Map<String, Object> map);
			
			
			public int selectFindProductCount(Map<String, Object> map);
			
					
			// 선택삭제(Admin)
			public int deleteProductList(List<Long> list);
					
					
					
			// 상세보기(Admin)
			public ProductDTO selectProductByNo(Long proNo);
			
			
			public ProductImageDTO selectProductImageByNo(Integer proimgNo);
	
	
}
