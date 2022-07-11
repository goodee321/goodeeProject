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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
            crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/6d7aa13a31.js" crossorigin="anonymous"></script>
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

            $(".order_btn").on("click", function (event) {

                let cartCnt = parseInt($(".hide_cartCnt_input").val());
                let form_contents = '';
                let orderNo = 0;

                $(".cart_info_td").each(function (i, element) {
                    if ($(element).find(".hide_cart_checkbox").is(":checked") == true && cartCnt > 1) {

                        let productNo = parseInt($(element).find(".hide_productNo_input").val());
                        let cartQty = $(element).find(".hide_cartQty_input").val();
                        let cartNo = parseInt($(element).find(".hide_cartNo_input").val());
                        let productSize = parseInt($(element).find(".hide_productSize_input").val());

                        let productNo_input = "<input name='orders[" + orderNo + "].productNo' type='hidden' value='" + productNo + "'>";
                        form_contents += productNo_input;

                        let cartQty_input = "<input name='orders[" + orderNo + "].cartQty' type='hidden' value='" + cartQty + "'>";
                        form_contents += cartQty_input;

                        let cartNo_input = "<input name='orders[" + orderNo + "].cartNo' type='hidden' value='" + cartNo + "'>";
                        form_contents += cartNo_input;

                        let productSize_input = "<input name='orders[" + orderNo + "].productSize' type='hidden' value='" + productSize + "'>";
                        form_contents += productSize_input;

                        orderNo += 1;

                    }

                    $(".order_form").append(form_contents);
                    $(".order_form").submit();

                });

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
            $(".font-semibold_plus_btn").on("click", function () {
                let quantity = $(this).parent("div").find("input").val();
                $(this).parent("div").find("input").val(++quantity);
            });
            $(".font-semibold_minus_btn").on("click", function () {
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
                    finalTotalPrice += parseInt($(element).find(".hide_finalPrice_input").val());
                }
            });

            if (finalTotalPrice >= 50000) {
                deliveryPrice = 0;
            } else if (finalTotalPrice == 0) {
                deliveryPrice = 0;
            } else {
                deliveryPrice = 3000;
            }

            finalTotalPrice += deliveryPrice;

            $(".totalPrice_span").text(totalPrice.toLocaleString());
            $(".totalCount_span").text(totalCount);
            $(".delivery_price").text(deliveryPrice.toLocaleString());
            $(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());
            $(".lastTotalPrice_span").text(finalTotalPrice.toLocaleString());
        }

    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <link href="../resources/css/cart.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .qty_modify_btn {
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #FFFFFF;
            width: 40px;
            height: 25px;
            font-size: 12px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container" style="margin-top: 50px;">
    <div id="contents">
        <div class="width_column100">
            <div id="white_container">
                <div class="xans-element- xans-order xans-order-basketpackage">
                    <div class="orderListArea themoon85-discount-app-msg">
                        <div class="orderListArea">
                            <div class=".xans-order-basketpackage .orderListArea .title">
                                <table class="xans-element- xans-order xans-order-normnormal boardList">
                                    <thead class="line">
                                    <tr>
                                        <th>
                                            <div class="all_check_input_div">
                                                <input type="checkbox" class="all_check_input input_size"
                                                       checked="checked">
                                                <span class="all_chcek_span"></span>
                                            </div>
                                        </th>
                                        <th scope="col" class="thumb">이미지</th>
                                        <th scope="col" class="product">상품명</th>
                                        <th scope="col" class="option">옵션<br>(사이즈)</th>
                                        <th scope="col" class="price">상품가</th>
                                        <th scope="col" class="sale">판매가</th>
                                        <th scope="col" class="quantity">수량</th>
                                        <th scope="col" class="total">합계</th>
                                        <th scope="col" class="button"></th>
                                    </tr>
                                    </thead>
                                    <tbody class="xsans-element- xans-order xans-order-list price_checker"
                                           style="text-align: center">
                                    <c:if test="${empty cartList}">
                                        <tr>
                                            <td colspan="8"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="8" style="padding-bottom: 0px;">
                                                <img src="../resources/images/order/sneakers.png" width="60px">
                                                <h2 class="emptyCart">장바구니에 담긴 상품이 없습니다.</h2>
                                                <p>원하는 상품을 장바구니에 담아보세요!</p>
                                                <button class="shop_btn">쇼핑하러 가기<i class="fa-solid fa-angles-right"
                                                                                   style="color: #fa671c; margin-left: 6px;"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <tr>
                                        <td colspan="8"></td>
                                    </tr>
                                    <c:if test="${not empty cartList}">
                                    <c:forEach items="${cartList}" var="cart" varStatus="vs">
                                        <tr>
                                            <td class="td_width_1 cart_info_td">
                                                <input type="checkbox" class="hide_cart_checkbox input_size"
                                                       checked="checked">
                                                <input type="hidden" class="hide_productPrice_input"
                                                       value="${cart.proPrice}">
                                                <input type="hidden" class="hide_cartNo_input"
                                                       value="${cart.cartNo}">
                                                <input type="hidden" class="hide_salePrice_input"
                                                       value="${cart.proDiscount}">
                                                <input type="hidden" class="hide_cartQty_input"
                                                       value="${cart.cartQty}">
                                                <input type="hidden" class="hide_totalPrice_input"
                                                       value="${cart.proPrice * cart.cartQty}">
                                                <input type="hidden" class="hide_productNo_input"
                                                       value="${cart.productNo}">
                                                <input type="hidden" class="hide_productSize_input"
                                                       value="${cart.productSize}">
                                                <input type="hidden" class="hide_finalPrice_input"
                                                       value="${cart.proPrice * (1 - cart.proDiscount) * cart.cartQty}">
                                                <input type="hidden" class="hide_cartCnt_input" value="${cartCnt}">
                                            </td>
                                            <td class="thumb">
                                                <a href="${contextPath}/product/detail?proNo=${cart.productNo}">
                                                    <img src="https://images.unsplash.com/photo-1529374255404-311a2a4f1fd9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
                                                         alt="" style="width: 120px; height: 120px"></a>
                                            </td>
                                            <td class="price">
                                                <input type="hidden" class="cartNo" value="${cart.cartNo}"
                                                       name="cartNo">
                                                <a href="${contextPath}/product/detail?proNo=${cart.productNo}">${cart.proName}</a>
                                            </td>
                                            <td class="option">
                                                    ${cart.productSize}
                                            </td>
                                            <td class="price">
                                                <fmt:formatNumber value="${cart.proPrice}"></fmt:formatNumber>원
                                            </td>
                                            <td class="sale">
                                                <fmt:formatNumber
                                                        value="${cart.proPrice * (1-cart.proDiscount)}"></fmt:formatNumber>원
                                            </td>
                                            <td class="quantity">
                                                <div class="table_text_align_center qty_div">
                                                    <a class="font-semibold_minus_btn"><i
                                                            class="fa-solid fa-circle-minus"
                                                            style="cursor: pointer"></i></a>
                                                    <input type="number" value="${cart.cartQty}" class="cartQty" style="margin-bottom: 5px">
                                                    <a class="font-semibold_plus_btn"><i class="fa-solid fa-circle-plus"
                                                                                         style="cursor: pointer"></i></a>
                                                </div>
                                                <button class="qty_modify_btn" value="${cart.cartNo}"
                                                        id="button_${vs.index}">변경
                                                </button>
                                            </td>
                                            <td class="total">
                                                <fmt:formatNumber
                                                    value="${cart.cartQty * cart.proPrice * (1-cart.proDiscount)}"></fmt:formatNumber>원
                                            </td>
                                            <td class="button">
                                                <a class="delete_btn" data-cartno="${cart.cartNo}"><i
                                                        class="fa-solid fa-xmark" style="cursor: pointer"></i></a>
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
                                <form action="${contextPath}/order/detailPage/${loginMember.memberNo}"
                                      class="order_form" method="get">
                                </form>
                                <br><br>
                                <c:if test="${not empty cartList}">
                                    <table style="margin: 70px auto 30px auto;">
                                        <thead>
                                        <tr>
                                            <td class="tdTitle">총 선택상품금액</td>
                                            <td rowspan="2" class="tdIcon"><i class="fa-solid fa-plus"></i></td>
                                            <td class="tdTitle">배송비</td>
                                            <td rowspan="2" class="tdIcon"><i class="fa-solid fa-minus"></i></td>
                                            <td class="tdTitle">할인금액</td>
                                            <td rowspan="2" class="tdIcon"><i class="fa-solid fa-equals"></i></td>
                                            <td rowspan="2" class="totalOrder"> 총 주문금액 <span
                                                    class="finalTotalPrice_span"></span>원
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdContent"><span class="totalPrice_span"></span>원</td>
                                            <td class="tdContent"><span class="delivery_price">3000</span>원</td>
                                            <c:set var="sale" value="0"/>
                                            <c:forEach var="cart" items="${cartList}" varStatus="status">
                                                <c:set var="sale"
                                                       value="${sale + (cart.proPrice * cart.proDiscount * cart.cartQty)}"/>
                                            </c:forEach>
                                            <td class="totalSalePrice"><fmt:formatNumber
                                                    value="${sale}"></fmt:formatNumber>원
                                            </td>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td colspan="7" style="text-align: center">
                                                <button class="order_btn">총 <span
                                                        class="totalCount_span"></span>건 (<span
                                                        class="lastTotalPrice_span"></span>원) 주문하기
                                                </button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>