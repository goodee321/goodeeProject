package com.nike.web.service;

import java.io.File;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nike.web.domain.ProductDTO;
import com.nike.web.domain.ProductImageDTO;
import com.nike.web.domain.ProductQtyDTO;
import com.nike.web.domain.ReviewDTO;
import com.nike.web.domain.ReviewImageDTO;
import com.nike.web.mapper.ProductMapper;
import com.nike.web.util.FileUtils;
import com.nike.web.util.PageUtils;
import com.nike.web.util.PageUtils2;

import net.coobird.thumbnailator.Thumbnails;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductMapper productMapper;
	
	@Override
	public void findProducts(HttpServletRequest request, Model model) {
		// 전체 갤러리 갯수
		int totalRecord = productMapper.selectProductCount();
		// page 파라미터
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// PageEntity 계산
		PageUtils2 pageUtils = new PageUtils2();
		pageUtils.setPageEntity(totalRecord, page);
	
		// beginRecord + endRecord => Map
		Map<String, Object> map = new HashMap<>();
		map.put("beginRecord", pageUtils.getBeginRecord() -1);
		map.put("recordPerPage", pageUtils.getRecordPerPage());
		
		// list.jsp로 보낼 데이터
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("products", productMapper.selectProductList(map));
		System.out.println(productMapper.selectProductList(map));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/product/list"));
			
		
	}
	
	@Override
	public void getFindProducts(HttpServletRequest request, Model model) {
		
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", request.getParameter("column"));
		map.put("query", request.getParameter("query"));
		
		int totalRecord = productMapper.selectFindProductCount(map);
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		PageUtils2 pageUtils = new PageUtils2();
		pageUtils.setPageEntity(totalRecord, page);
		
		map.put("beginRecord", pageUtils.getBeginRecord() - 1);
		map.put("recordPerPage", pageUtils.getRecordPerPage());
		
		model.addAttribute("productRecord",totalRecord);
		model.addAttribute("products", productMapper.selectFindProductList(map));
		model.addAttribute("startNo", totalRecord - (page - 1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/product/find?column=" + column + "&query=" + query));
		
	}
	
	@Override
	public ResponseEntity<byte[]> display(Integer proimgNo, String type) {
		
		// 보내줘야 할 이미지 정보(path, saved) 읽기
		ProductImageDTO productImage = productMapper.selectProductImageByNo(proimgNo);
	
		// 보내줘야 할 이미지	
		File file = null;
		switch(type) {
		case "thumb":
			file = new File(productImage.getProimgPath(), "s_" + productImage.getProimgName());
			break;
		case "image":
			file = new File(productImage.getProimgPath(), productImage.getProimgName());

			break;
		}
		
		// ResponseEntity
		ResponseEntity<byte[]> entity = null;
		try {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", Files.probeContentType(file.toPath()));
			entity = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return entity;
		
	}

	
	
		
		@Transactional
		@Override
		public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model) {
			
			// 전달된 파라미터
			//no, stock 데이터 DB에서 가져와야함
			String proName = multipartRequest.getParameter("proName");
			int proPrice = Integer.parseInt(multipartRequest.getParameter("proPrice"));
			String proDetail = multipartRequest.getParameter("proDetail");
			
			// GalleryDTO
			ProductDTO product = ProductDTO.builder()
					.proName(proName)
					.proPrice(proPrice)
					.proDetail(proDetail)
					.build();
			
			
			Integer productResult = productMapper.insertProduct(product);  // INSERT 수행
		
			
					// 첨부insertProductQty된 모든 파일들
			List<MultipartFile> files = multipartRequest.getFiles("files");  // 파라미터 files
			// 파일 첨부 결과
			int productImageAttachResult;
			if(files.get(0).getOriginalFilename().isEmpty()) {  // 첨부가 없으면 files.size() == 1임. [MultipartFile[field="files", filename=, contentType=application/octet-stream, size=0]] 값을 가짐.
				productImageAttachResult = 1;
			} else {  // 첨부가 있으면 "files.size() == 첨부파일갯수"이므로 productImageAttachResult = 0으로 시작함.
				productImageAttachResult = 0;
			}
			
			for (MultipartFile multipartFile : files) {
				
				// 예외 처리는 기본으로 필요함.
				try {
					
					// 첨부가 없을 수 있으므로 점검해야 함.
					if(multipartFile != null && multipartFile.isEmpty() == false) {  // 첨부가 있다.(둘 다 필요함)
						
						// 첨부파일의 본래 이름(origin)
						String origin = multipartFile.getOriginalFilename();
						origin = origin.substring(origin.lastIndexOf("\\") + 1);  // IE는 본래 이름에 전체 경로가 붙어서 파일명만 빼야 함.
						
						// 첨부파일의 저장된 이름(proimgName)
						String proimgName = FileUtils.getUuidName(origin);
						
						// 첨부파일의 저장 경로(ProimgPath)
						// String proimgPath = FileUtils.getTodayPath();
						String proimgPath = multipartRequest.getServletContext().getRealPath("/resources/gallery");
						
						// 저장 경로(디렉터리) 없으면 만들기
						File dir = new File(proimgPath);
						if(dir.exists() == false) {
							dir.mkdirs();
						}
						
						// 첨부파일
						File file = new File(dir, proimgName);
						
						// 첨부파일 확인
						String contentType = Files.probeContentType(file.toPath());  // 이미지의 Content-Type(image/jpeg, image/png, image/gif)
						if(contentType.startsWith("image")) {
							
							// 첨부파일 서버에 저장(업로드)
							multipartFile.transferTo(file);
							
							// 썸네일 서버에 저장(썸네일 정보는 DB에 저장되지 않음)
							// 썸네일 내용 확인해서 프론트(list)로 보내기
							String thumbnails = "s_" + proimgName;
							Thumbnails.of(file)
								.size(100, 100)
								.toFile(new File(dir, thumbnails));
							// FileAttachDTO
							
							

							ProductImageDTO productImageAttach = ProductImageDTO.builder()
									.proimgPath(proimgPath)
									.proimgOrigin(origin)
									.proimgName(proimgName)
									.proNo(product.getProNo())
									.build();
							
							// FileAttach INSERT 수행
							productImageAttachResult += productMapper.insertProductAttach(productImageAttach);
					
							
						}

					}
					
				} catch(Exception e) {
					e.printStackTrace();
				}
				
			}
			
			// 응답
			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				if(productResult == 1 && productImageAttachResult == files.size()) {
					out.println("<script>");
					out.println("alert('제품이 등록되었습니다.')");
					out.println("location.href='" + multipartRequest.getContextPath() + "/product/list'");
					out.println("</script>");
					out.close();
				} else {
					out.println("<script>");
					out.println("alert('제품이 등록되지 않았습니다.')");
					out.println("history.back()");
					out.println("</script>");
					out.close();
				}
			} catch (Exception e) {	
				e.printStackTrace();
			}
			
		}
		//제품 옵션 인서트
		
		@Override
		public void saveProductOptionOk(HttpServletRequest request, HttpServletResponse response) {
			// 전달된 파라미터
			Integer proNo = Integer.parseInt(request.getParameter("proNo"));
			Integer proQty = Integer.parseInt(request.getParameter("proQty"));
			Double proDiscount= Double.parseDouble(request.getParameter("proDiscount"));
			Integer proSize = Integer.parseInt(request.getParameter("proSize"));
			
			ProductQtyDTO productQty = ProductQtyDTO.builder()
					.proNo(proNo)
					.proSize(proSize)
					.proQty(proQty)
					.proDiscount(proDiscount)
					.build();
			
			Map<String, Object> map = new HashMap<>();
			map.put("proNo", proNo);
			map.put("proSize", proSize);
			
			int productQtyOverlap = productMapper.productQtyOverLap(map);
			
			if(productQtyOverlap == 0) {
			Integer productQtyResult = productMapper.insertProductQty(productQty);
			
			// 응답
			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				if(productQtyResult == 1 ) {				
					out.println("<script>");
					out.println("alert('옵션이 등록되었습니다.')");
					out.println("location.href='" + request.getContextPath() + "/product/list'");
					out.println("</script>");
					out.close();
				} else {
					out.println("<script>");
					out.println("alert(' "+proSize + "사이즈가 이미 존재합니다.')");
					out.println("history.back()");
					out.println("</script>");
					out.close();
				}
			} catch (Exception e) {	
				e.printStackTrace();
			}
			
			}else {
				response.setContentType("text/html");
				try {
				PrintWriter out = response.getWriter();
				 {				
					 out.println("<script>");
						out.println("alert(' "+proSize + "사이즈가 이미 존재합니다.')");
						out.println("history.back()");
						out.println("</script>");
						out.close();
			}
			}catch(Exception e2) {
				e2.printStackTrace();
			}
			}
		}
		
		//업데이트
		
		// 제품 상세 페이지
		@Override
		public ProductDTO getProductByNo(Integer proNo) {
			return productMapper.selectProductByNo(proNo);
		}
		@Override
		public void changeProductOptionPage(HttpServletRequest request, Model model) {
			Integer proNo = Integer.parseInt(request.getParameter("proNo"));
			
			// 갤러리 정보 가져와서 model에 저장하기
			model.addAttribute("product", productMapper.selectProductByNo(proNo));
			
			// 첨부 파일 정보 가져와서 model에 저장하기
			model.addAttribute("productImages", productMapper.selectProductImageListInTheProduct(proNo));
			
		}
		
		@Override
		public void removeProductImage(Integer proimgNo) {
		
			// fileAttachNo가 일치하는 FileAttachDTO 정보를 DB에서 가져오면
			// 삭제할 파일의 경로와 이름이 있다.
			ProductImageDTO imageProduct = productMapper.selectProductImageByNo(proimgNo);
			
			// 첨부 파일 알아내기
			File file = new File(imageProduct.getProimgPath(), imageProduct.getProimgName());

			try {
				
				// 첨부 파일이 이미지가 맞는지 확인
				String contentType = Files.probeContentType(file.toPath());
				if(contentType.startsWith("image")) {
				
					// 원본 이미지 삭제
					if(file.exists()) {
						file.delete();
					}
					
					// 썸네일 이미지 삭제
					File thumbnail = new File(imageProduct.getProimgPath(), "s_" +  imageProduct.getProimgName());
					if(thumbnail.exists()) {
						thumbnail.delete();
					}
				}	
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				// FILE_ATTACH 테이블의 ROW 삭제
				productMapper.deleteProductImage(proimgNo);
			}
		
		@Override
		public void findDetailReviews(HttpServletRequest request, Model model) {
			
			int totalRecord = productMapper.selectDetailReviewCount();
			Integer proNo = Integer.parseInt(request.getParameter("proNo"));
			 
			Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
			int page = Integer.parseInt(opt.orElse("1"));
			
			PageUtils pageUtils = new PageUtils();
			pageUtils.setPageEntity(totalRecord, page);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("beginRecord", pageUtils.getBeginRecord() -1);
			map.put("recordPerPage", pageUtils.getRecordPerPage());
			map.put("proNo", proNo);
			
			model.addAttribute("totalRecord", totalRecord);
			model.addAttribute("reviews", productMapper.selectDetailReviewList(map));
			model.addAttribute("startNo", totalRecord - (page -1) * pageUtils.getRecordPerPage());
			model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/prduct/detail?proNo=" + proNo));
		}
		
		@Override
		public void addDetailReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
			
			Integer proNo = Integer.parseInt(multipartRequest.getParameter("proNo"));
			Integer memberNo = Integer.parseInt(multipartRequest.getParameter("memberNo"));
			String reviewTitle = multipartRequest.getParameter("reviewTitle");
			String reviewContent = multipartRequest.getParameter("reviewContent");
			Integer reviewStar = Integer.parseInt(multipartRequest.getParameter("reviewStar"));
			
			ReviewDTO review = ReviewDTO.builder()
					.proNo(proNo)
					.memberNo(memberNo)
					.reviewTitle(reviewTitle)
					.reviewContent(reviewContent)
					.reviewStar(reviewStar)
					.build();
			
			int result = productMapper.insertDetailReview(review);
			
			
			List<MultipartFile> files = multipartRequest.getFiles("files");
			
			// 파일 첨부 결과
			int fileAttachResult;
			if(files.get(0).getOriginalFilename().isEmpty()) {
				fileAttachResult = 1;
			} else {
				fileAttachResult = 0;
			}
			
			
			for(MultipartFile multipartFile : files) {
				
				try {
					
					// 파일첨부 점검
					if(multipartFile != null && multipartFile.isEmpty() == false) {
						
						String origin = multipartFile.getOriginalFilename();
						origin = origin.substring(origin.lastIndexOf("\\") + 1);
						
						// 첨부파일의 저장된 이름
						String riName = FileUtils.getUuidName(origin);
						
						// 저장경로
//						String path = FileUtils.getTodayPath();
						String riPath = multipartRequest.getServletContext().getRealPath("/resources/reviews");
						
						File dir = new File(riPath);
						if(dir.exists() == false) {
							dir.mkdirs();
						}
						
						// 첨부파일의 경로와 이름
						File file = new File(dir, riName); 
						
						String contentType = Files.probeContentType(file.toPath());
						if(contentType.startsWith("image")) {
							
							// 서버에 저장
							multipartFile.transferTo(file);
							
							// 썸네일 서버에 저장
							Thumbnails.of(file)
								.size(100, 100)
								.toFile(new File(dir, "thumb_" + riName));
							
							ReviewImageDTO reviewImage = ReviewImageDTO.builder()
									.riNo(result)
									.riName(riName)
									.riPath(riPath)
									.riOrigin(origin)
									.reviewNo(review.getReviewNo())
									.build();
							fileAttachResult += productMapper.insertDetailReviewImage(reviewImage);
							
						}
					}
					
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				if(result == 1 && fileAttachResult == files.size()) {
					out.println("<script>");
					out.println("alert('리뷰가 등록되었습니다.')");
					out.println("location.href='" + multipartRequest.getContextPath() + "/product/detail?proNo=" + proNo + '\'');
					out.println("</script>");
					out.close();
				} else {
					out.println("<script>");
					out.println("alert('리뷰가 등록되지않았습니다.')");
					out.println("history.back()");
					out.println("</script>");
					out.close();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		
		
				// 이미지 수정 되면 삭제될수 있게 설정

		// 갤러리 수정
		@Transactional
		@Override
		public void changeProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response){
			
			// 전달된 파라미터
			Integer proNo = Integer.parseInt(multipartRequest.getParameter("proNo"));
			String proName = multipartRequest.getParameter("proName");
			Integer proPrice = Integer.parseInt(multipartRequest.getParameter("proPrice"));
			String proDetail = multipartRequest.getParameter("proDetail");
			
			
			ProductDTO product = ProductDTO.builder()
					.proNo(proNo)
					.proName(proName)
					.proPrice(proPrice)
					.proDetail(proDetail)
					.build();
			
		
			int productResult = productMapper.updateProduct(product);  // UPDATE 수행
			
			
			// 첨부된 모든 파일들
			List<MultipartFile> files = multipartRequest.getFiles("files");  // 파라미터 files
			
			// 파일 첨부 결과
			int productImageResult;
			if(files.get(0).getOriginalFilename().isEmpty()) {  // 첨부가 없으면 files.size() == 1임. [MultipartFile[field="files", filename=, contentType=application/octet-stream, size=0]] 값을 가짐.
				productImageResult = 1;  
			} else {  // 첨부가 있으면 "files.size() == 첨부파일갯수"이므로 fileAttachResult = 0으로 시작함.
				productImageResult = 0;
			}
			
			for (MultipartFile multipartFile : files) {
				
				// 예외 처리는 기본으로 필요함.
				try {
					
					// 첨부가 없을 수 있으므로 점검해야 함.
					if(multipartFile != null && multipartFile.isEmpty() == false) {  // 첨부가 있다.(둘 다 필요함)
						
						// 첨부파일의 본래 이름(origin)
						String origin = multipartFile.getOriginalFilename();
						origin = origin.substring(origin.lastIndexOf("\\") + 1);  // IE는 본래 이름에 전체 경로가 붙어서 파일명만 빼야 함.
						
						// 첨부파일의 저장된 이름(saved)
						String proimgName = FileUtils.getUuidName(origin);
						
						// 첨부파일의 저장 경로(디렉터리)
						String proimgPath = FileUtils.getTodayPath();
						
						// 저장 경로(디렉터리) 없으면 만들기
						File dir = new File(proimgPath);
						if(dir.exists() == false) {
							dir.mkdirs();
						}
						
						// 첨부파일
						File file = new File(dir, proimgName);
						
						// 첨부파일 확인
						String contentType = Files.probeContentType(file.toPath());  // 이미지의 Content-Type(image/jpeg, image/png, image/gif)
						if(contentType.startsWith("image")) {
							
							// 첨부파일 서버에 저장(업로드)
							multipartFile.transferTo(file);
							
							// 썸네일 서버에 저장(썸네일 정보는 DB에 저장되지 않음)
							Thumbnails.of(file)
								.size(100, 100)
								.toFile(new File(dir, "s_" + proimgName));
							
							// FileAttachDTO
							ProductImageDTO productImage = ProductImageDTO.builder()
									.proimgPath(proimgPath)
									.proimgOrigin(origin)
									.proimgName(proimgName)
									.proNo(product.getProNo())
									.build();
							
							// FileAttach INSERT 수행
							productImageResult += productMapper.insertProductAttach(productImage);
							
						}

					}
					
				} catch(Exception e) {
					e.printStackTrace();
				}
				
			}
			
			// 응답
			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				if( productResult == 1  && productImageResult == files.size()) {
					out.println("<script>");
					out.println("alert('제품 정보가 수정되었습니다.')");
					out.println("location.href='" + multipartRequest.getContextPath() + "/product/detail?proNo=" + proNo + "'");
					out.println("</script>");
					out.close();
				} else {
					out.println("<script>");
					out.println("alert('제품 정보가 수정되지 않았습니다.')");
					out.println("history.back()");
					out.println("</script>");
					out.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		
		@Override	//옵션 수정 페이지 정보
		public ProductQtyDTO changeProductOptionDetail(HttpServletRequest request) {
			Integer proNo = Integer.parseInt(request.getParameter("proNo"));
			Integer proSize = Integer.parseInt(request.getParameter("proSize"));
			
			Map<String, Object> map = new HashMap<>();
			map.put("proNo", proNo );
			map.put("proSize", proSize );
			
			ProductQtyDTO productQty = productMapper.changeProductOptionByNo(map);
			return productQty;
		}
		
		@Override	//옵션 수정
		public void changeProductOption(HttpServletRequest request, HttpServletResponse response) {
			Integer proNo = Integer.parseInt(request.getParameter("proNo"));
			Integer proSize = Integer.parseInt(request.getParameter("proSize"));
			Integer proQty = Integer.parseInt(request.getParameter("proQty"));
			Double proDiscount = Double.parseDouble(request.getParameter("proDiscount"));
			
			
			ProductQtyDTO productQty = ProductQtyDTO.builder()
					.proNo(proNo)
					.proSize(proSize)
					.proQty(proQty)
					.proDiscount(proDiscount)
					.build();
			
				
			int productQtyResult=  productMapper.updateProductQty(productQty);
			// 응답
						try {
							response.setContentType("text/html");
							PrintWriter out = response.getWriter();
							if( productQtyResult == 1 ) {
								out.println("<script>");
								out.println("alert('제품 옵션 정보가 수정되었습니다.')");
								out.println("location.href='" + request.getContextPath() + "/product/detail?proNo=" + proNo + "'");
								out.println("</script>");
								out.close();
							} else {
								out.println("<script>");
								out.println("alert('추가되지 않은 옵션이므로 옵션 추가 항목으로 이동합니다.')");
								out.println("location.href='" + request.getContextPath() + "/product/saveProductOption?proNo=" + proNo + "'");
								out.println("</script>");
								out.close();
							}
						} catch (Exception e) {
							e.printStackTrace();
						}

			
		}
			
		

		
		//삭제
		// 갤러리 삭제
		public void productDelete(HttpServletRequest request, HttpServletResponse response) {
			
			// 파라미터 galleryNo
			Optional<String> opt = Optional.ofNullable(request.getParameter("proNo"));
			Integer proNo = Integer.parseInt(opt.orElse("0"));
			
			// 저장되어 있는 첨부 파일 목록 가져오기
			List<ProductImageDTO> images = productMapper.selectProductImageListInTheProduct(proNo);
			
			// 저장되어 있는 첨부 파일이 있는지 확인
			if(images != null && images.isEmpty() == false) {
				
				// 하나씩 삭제
				for(ProductImageDTO attach : images) {
				
					// 첨부 파일 알아내기
					File file = new File(attach.getProimgPath(), attach.getProimgName());

					try {
						
						// 첨부 파일이 이미지가 맞는지 확인
						String contentType = Files.probeContentType(file.toPath());
						if(contentType.startsWith("image")) {
						
							// 원본 이미지 삭제
							if(file.exists()) {
								file.delete();
							}
							
							// 썸네일 이미지 삭제
							File thumbnail = new File(attach.getProimgPath(), "s_" +attach.getProimgName());
							if(thumbnail.exists()) {
								thumbnail.delete();
							}
							
						}
						
					} catch (Exception e) {
						e.printStackTrace();
					}
					
				}
				
			}
			
			// GALLERY 테이블의 ROW 삭제
			int res = productMapper.deleteProduct(proNo);
			
			// 응답
			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				if(res == 1) {
					out.println("<script>");
					out.println("alert('제품이 삭제되었습니다.')");
					out.println("location.href='" + request.getContextPath() + "/product/list'");
					out.println("</script>");
					out.close();
				} else {
					out.println("<script>");
					out.println("alert('제품이 삭제되지 않았습니다.')");
					out.println("history.back()");
					out.println("</script>");
					out.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
	
}

		