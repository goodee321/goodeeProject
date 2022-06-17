package com.nike.web.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data

public class ProductImageDTO {
	private int piNo;
	private String piName;
	private String piPath;
	private String piOrigin;
	private int pNo;
}
