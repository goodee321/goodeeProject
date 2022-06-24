package com.nike.web.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CartDTO {

	//  Cart
	private int cartNo;
	private int memberNo;
	private int productNo;
	private int cartQty;
	private Date cartRegdate;

	//	Product
	private String proName;
	private int proSize;
	private int proPrice;
	private long proDiscount;
	private int proDelivery;

	//	Product Image
	private int proimgNo;

	private int salePrice;  // 한 상품당 할인율이 계산된 실제 판매가
	private int totalPrice; // 한 상품당 장바구니에 담긴 수량 × 판매가(salePrice)

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getCartQty() {
		return cartQty;
	}

	public void setCartQty(int cartQty) {
		this.cartQty = cartQty;
	}

	public Date getCartRegdate() {
		return cartRegdate;
	}

	public void setCartRegdate(Date cartRegdate) {
		this.cartRegdate = cartRegdate;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public int getProSize() {
		return proSize;
	}

	public void setProSize(int proSize) {
		this.proSize = proSize;
	}

	public int getProPrice() {
		return proPrice;
	}

	public void setProPrice(int proPrice) {
		this.proPrice = proPrice;
	}

	public long getProDiscount() {
		return proDiscount;
	}

	public void setProDiscount(long proDiscount) {
		this.proDiscount = proDiscount;
	}

	public int getProDelivery() {
		return proDelivery;
	}

	public void setProDelivery(int proDelivery) {
		this.proDelivery = proDelivery;
	}

	public int getProimgNo() {
		return proimgNo;
	}

	public void setProimgNo(int proimgNo) {
		this.proimgNo = proimgNo;
	}

	public void setFinalPrice() {
		int deliveryFee = 2500;
		if (this.proDelivery == 1) {
			this.salePrice = this.proPrice - (int) (this.proPrice * this.proDiscount) + deliveryFee;
		} else {
			this.salePrice = this.proPrice - (int) (this.proPrice * this.proDiscount);
		}
		this.totalPrice = this.salePrice * this.cartQty;
	}

}