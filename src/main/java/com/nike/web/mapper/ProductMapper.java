package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.ProductDTO;
import com.nike.web.domain.ProductImageDTO;
import com.nike.web.domain.ProductQtyDTO;
import com.nike.web.domain.ReviewDTO;
import com.nike.web.domain.ReviewImageDTO;

@Mapper
public interface ProductMapper {

	// 갤러리 목록
		public int selectProductCount();
		public List<ProductDTO> selectProductList(Map<String, Object> map);
		public ProductImageDTO selectProductImageByNo(Integer proimgNo);
		public List<ProductImageDTO> selectProductImageListInTheProduct(Integer proimgNo);
		
		
		
		// 갤러리 삽입
		public int insertProduct(ProductDTO product);
		public int insertProductQty(ProductQtyDTO productQty);
		public int insertProductAttach(ProductImageDTO productImageAttach);
		public int selectFindProductCount(Map<String, Object> map);
		public List<ProductDTO> selectFindProductList(Map<String, Object> map);
		public int productQtyOverLap(Map<String, Object> map);
		

		
		//갤러리 수정
		public ProductDTO selectProductByNo(Integer proNo);
		public ProductQtyDTO changeProductOptionByNo(Map<String, Object> map);
		public int updateProductQty(ProductQtyDTO product);
		public int updateProduct(ProductDTO product);
		
		
		
		
		public List<ReviewDTO> selectDetailReviewList(Map<String, Object> map);
		public int selectDetailReviewCount();
		public int insertDetailReview(ReviewDTO review);
		public Integer insertDetailReviewImage(ReviewImageDTO reviewImage);

		
}