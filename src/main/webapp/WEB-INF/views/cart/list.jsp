<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="../resources/js/jquery-3.6.0.js"></script>
    <script>

        $(function () {
            removeOne();
            removeAll();
            updateCart();
            updateQty();
            setTotalInfo();
            order();
            shop();

            $(".hide_cart_checkbox").on("change", function () {
                setTotalInfo($(".cart_info_td"));
            });


            $(".all_check_input").on("click", function () {

                if ($(".all_check_input").prop("checked")) {
                    $(".hide_cart_checkbox").prop("checked", true);
                } else {
                    $(".hide_cart_checkbox").prop("checked", false);
                }

                setTotalInfo($(".cart_info_td"));

            });

            $(".hide_cart_checkbox").on("click", function () {
                let checkAll = true;
                $.each($('.hide_cart_checkbox'), function (i, checkOne) {
                    if ($(checkOne).is(':checked') == false) {
                        $(".all_check_input").prop('checked', false);
                        checkAll = false;
                        return false;
                    }

                    if (checkAll) {
                        $(".all_check_input").prop('checked', true);
                    }
                    setTotalInfo($(".cart_info_td"));
                })
            })
        })

        function order() {

            $(".order_btn").on("click", function () {

                let form_contents = '';
                let orderNo = 0;

                $(".cart_info_td").each(function (i, element) {
                    if ($(element).find(".hide_cart_checkbox").is(":checked") == true) {

                        let productNo = parseInt($(element).find(".hide_productNo_input").val());
                        let cartQty = $(element).find(".hide_cartQty_input").val();
                        let cartNo = parseInt($(element).find(".hide_cartNo_input").val());

                        let productNo_input = "<input name='orders[" + orderNo + "].productNo' type='hidden' value='" + productNo + "'>";
                        form_contents += productNo_input;

                        let cartQty_input = "<input name='orders[" + orderNo + "].cartQty' type='hidden' value='" + cartQty + "'>";
                        form_contents += cartQty_input;

                        let cartNo_input = "<input name='orders[" + orderNo + "].cartNo' type='hidden' value='" + cartNo + "'>";
                        form_contents += cartNo_input;

                        orderNo += 1;
                    }
                });
                $(".order_form").append(form_contents);
                $(".order_form").submit();
            });
        }

        function shop() {
            $(".shop_btn").on('click', function () {
                location.href = '${contextPath}/product/list';
            })
        }

        function removeOne() {
            $(".delete_btn").on('click', function () {
                let cartNo = $(this).data("cartno");
                let data = {
                    cartNo: cartNo
                }
                if (confirm('장바구니에서 삭제하시겠습니까?')) {
                    $.ajax({
                        url: "${contextPath}/cart/remove",
                        type: "post",
                        data: data,
                        success: function (res) {
                            if (res > 0) {
                                location.href = '${contextPath}/cart/list';
                            }
                        },
                        error: function (request, status, error) {
                            console.log("code : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                        }
                    })
                }
            })
        }

        function removeAll() {
            $(".delete_btn_All").on('click', function () {
                let memberNo = $(".delete_btn_All").val();
                let data = {
                    memberNo: memberNo
                }
                if (confirm('장바구니를 전체 삭제하시겠습니까?')) {
                    $.ajax({
                        url: '${contextPath}/cart/removeAll',
                        type: 'post',
                        data: data,
                        success: function (res) {
                            if (res > 0) {
                                location.href = '${contextPath}/cart/list';
                            }
                        },
                        error: function (request, status, error) {
                            console.log("code : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                        }
                    })
                }
            })
        }

        function updateQty() {
            $(".plus_btn").on("click", function () {
                let quantity = $(this).parent("div").find("input").val();
                $(this).parent("div").find("input").val(++quantity);
            });
            $(".minus_btn").on("click", function () {
                let quantity = $(this).parent("div").find("input").val();
                if (quantity > 1) {
                    $(this).parent("div").find("input").val(--quantity);
                }
            });
        }

        function updateCart() {
            $(".qty_modify_btn").on("click", function () {
                let cartNo = $(this).val();
                $(".update_cartNo").val(cartNo);
                let cartQty = $(this).parent("td").find("input").val();
                $(".update_cartQty").val(cartQty);
                $(".qty_update_form").submit();
            });
        }

        function setTotalInfo() {

            let totalPrice = 0;
            let totalCount = 0;
            let deliveryPrice = 0;
            let finalTotalPrice = 0;

            $(".cart_info_td").each(function (i, element) {

                if ($(element).find(".hide_cart_checkbox").is(":checked") === true) {
                    totalPrice += parseInt($(element).find(".hide_totalPrice_input").val());
                    totalCount += parseInt($(element).find(".hide_cartQty_input").val());
                }
            });

            if (totalPrice >= 50000) {
                deliveryPrice = 0;
            } else if (totalPrice == 0) {
                deliveryPrice = 0;
            } else {
                deliveryPrice = 3000;
            }

            finalTotalPrice = totalPrice + deliveryPrice;

            $(".totalPrice_span").text(totalPrice.toLocaleString());
            $(".totalCount_span").text(totalCount);
            $(".delivery_price").text(deliveryPrice);
            $(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());
        }

    </script>
</head>
<body>

<div class="content_subject">
    <span>장바구니</span>
</div>
<c:if test="${empty cartList}">
    장바구니가 비어있습니다.
</c:if>
<c:if test="${not empty cartList}">
    <table border="1">
        <thead>
        <tr aria-rowspan="8"></tr>
        <tr>
            <td>
                <div class="all_check_input_div">
                    <input type="checkbox" class="all_check_input input_size" checked="checked">
                    <span class="all_chcek_span"></span>
                </div>
            </td>
            <td>Image</td>
            <td>상품명</td>
            <td>판매가</td>
            <td>수량</td>
            <td>합계</td>
            <td>삭제</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${cartList}" var="cart" varStatus="vs">
            <tr>
                <td class="td_width_1 cart_info_td">
                    <input type="checkbox" class="hide_cart_checkbox input_size" checked="checked">
                    <input type="hidden" class="hide_productPrice_input" value="${cart.proPrice}">
                    <input type="hidden" class="hide_cartNo_input" value="${cart.cartNo}">
                    <input type="hidden" class="hide_salePrice_input" value="${cart.proDiscount}">
                    <input type="hidden" class="hide_cartQty_input" value="${cart.cartQty}">
                    <input type="hidden" class="hide_totalPrice_input" value="${cart.proPrice * cart.cartQty}">
                    <input type="hidden" class="hide_productNo_input" value="${cart.productNo}">
                </td>
                <td>이미지</td>
                <td><input type="hidden" class="cartNo" value="${cart.cartNo}" name="cartNo">${cart.proName}</td>
                <td><fmt:formatNumber value="${cart.proPrice}"></fmt:formatNumber>원</td>
                <td>
                    <div class="table_text_align_center qty_div">
                        <input type="number" value="${cart.cartQty}" class="qty_input">
                        <button class="qty_btn plus_btn">+</button>
                        <button class="qty_btn minus_btn">-</button>
                    </div>
                    <button class="qty_modify_btn" value="${cart.cartNo}" id="button_${vs.index}">수정</button>
                </td>
                <td><fmt:formatNumber value="${cart.cartQty * cart.proPrice}"></fmt:formatNumber>원</td>
                <td>
                    <input type="button" class="delete_btn" value="삭제" data-cartno="${cart.cartNo}">
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <button class="delete_btn_All" value="${loginMember.memberNo}">전체삭제</button>
</c:if>
<form action="${contextPath}/cart/update" method="post" class="qty_update_form">
    <input type="hidden" name="cartQty" class="update_cartQty">
    <input type="hidden" name="cartNo" class="update_cartNo">
</form>
<form action="${contextPath}/order/detailPage/${loginMember.memberNo}" class="order_form" method="get">
</form>
<br><br>
<hr>
<table>
    <thead>
    <tr>
        <td>총 상품금액</td>
        <td>배송비</td>
        <td>결제예정금액</td>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><span class="totalPrice_span">70000</span>원</td>
        <td><span class="delivery_price">3000</span>원</td>
        <td><span class="finalTotalPrice_span">70000</span>원</td>
    </tr>
    </tbody>
</table>
<div class="content_total_section">
    <div class="total_wrap">
        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>총 상품 가격</td>
                            <td>총 주문 상품수</td>
                            <td>배송비</td>
                        </tr>
                        <tr>
                            <td>
                                <span class="totalPrice_span">70000</span> 원
                            </td>
                            <td>
                                <span class="totalKind_span"></span>총 <span class="totalCount_span"></span>개
                            </td>
                            <td>
                                <span class="delivery_price">3000</span>원
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <hr>
        <table>
            <tr>
                <td>
                    <table>
                        <tbody>
                        <tr>
                            <td>
                                <strong>총 결제 예상 금액</strong>
                            </td>
                            <td>
                                <span class="finalTotalPrice_span">70000</span> 원
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </td>
                <td>
                </td>
            </tr>
        </table>
    </div>
</div>
<c:if test="${empty cartList}">
    <button class="shop_btn">쇼핑하기</button>
</c:if>
<c:if test="${not empty cartList}">
    <div class="content_btn_section">
        <button class="order_btn">주문하기</button>
    </div>
</c:if>

</body>
</html>