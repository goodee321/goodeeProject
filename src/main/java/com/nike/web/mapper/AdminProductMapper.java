package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.ProductDTO;
import com.nike.web.domain.ProductImageDTO;
import com.nike.web.domain.ProductQtyDTO;

@Mapper
public interface AdminProductMapper {

	
			
			
			
			public int insertProduct(ProductDTO product);
			
			public int insertProductQty(ProductQtyDTO productQty);
			
			public int insertProductAttach(ProductImageDTO productImageAttach);
			
			public int updateProduct(ProductDTO product);
			
			public int updateProductQty(ProductQtyDTO product);
			
			public List<ProductImageDTO> selectProductImageListInTheProduct(Integer proimgNo);
			
			public int deleteProduct(Integer proNo);
			
			
			
			public int productQtyOverLap(Map<String, Object> map);
			
			
			public ProductQtyDTO changeProductOptionByNo(Map<String, Object> map);
			
	
			
			
			
			// 전체상품목록
			public List<ProductDTO> selectProductList(Map<String, Object> map);
			
			
			// 전체상품수
			public int selectProductCount();
					
			
			// 검색상품목록
			public List<ProductDTO> selectFindProductList(Map<String, Object> map);
						
			
			// 검색상품수
			public int selectFindProductCount(Map<String, Object> map);
			
					
			// 선택삭제
			public int deleteProductList(List<Long> list);
					
					
			// 상세보기
			public ProductDTO selectProductByNo(Integer proNo);
			
			
			// 썸네일
			public ProductImageDTO selectProductImageByNo(Integer proimgNo);
			
			
			public void deleteProductImage(Integer proimgNo);
	
	
}
