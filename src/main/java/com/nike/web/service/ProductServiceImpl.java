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
import com.nike.web.mapper.ProductMapper;
import com.nike.web.util.FileUtils;
import com.nike.web.util.PageUtils;

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
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		// beginRecord + endRecord => Map
		Map<String, Object> map = new HashMap<>();
		map.put("beginRecord", pageUtils.getBeginRecord() -1);
		map.put("recordPerPage", pageUtils.getRecordPerPage());
		
		// list.jsp로 보낼 데이터
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("products", productMapper.selectProductList(map));
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
		
		PageUtils pageUtils = new PageUtils();
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
			int proStock = Integer.parseInt(multipartRequest.getParameter("proStock"));
			double proDiscount= Double.parseDouble(multipartRequest.getParameter("proDiscount"));
			String proDetail = multipartRequest.getParameter("proDetail");
			int proSize = Integer.parseInt(multipartRequest.getParameter("proSize"));
			
			// GalleryDTO
			ProductDTO product = ProductDTO.builder()
					.proName(proName)
					.proPrice(proPrice)
					.proStock(proStock)
					.proDiscount(proDiscount)
					.proDetail(proDetail)
					.proSize(proSize)
					.build();
			
			
			int productResult = productMapper.insertProduct(product);  // INSERT 수행
		
		
			// 첨부된 모든 파일들
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
}

		