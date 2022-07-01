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
    private Integer proimgNo;
    private String proimgName;
    private String proimgPath;
    private String proimgOrigin;
    private Integer proNo;
}