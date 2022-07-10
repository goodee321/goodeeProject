<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
        crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

    $(document).ready(function () {
        payment();

        $(window).scroll(function () {
            let contHeight = $(".order_cont").height();
            let customContHeight = $(".custom_cont").height();
            let scroll = $(this).scrollTop();
            if (scroll > 274 && scroll < contHeight - customContHeight + 300) {
                $(".custom_cont").css("position", "fixed").css("top", "17px");
            } else if (scroll > contHeight - customContHeight + 158) {
                $(".custom_cont").css("position", "absolute").css("top", contHeight - customContHeight - 41);
            } else {
                $(".custom_cont").css("position", "fixed").css("top", "270px");
            }
        });

        $('input[name="shipping"]:radio').click(function () {
            switch ($(this).prop('id')) {
                case 'shippingBasic':
                    $("#orderName").val($("#memberId").val());
                    $("#orderPostcode").val($("#memberPost").val());
                    $("#orderAddr").val($("#memberAddr").val());
                    $("#addrDetail").val($("#memberAddrdetail").val());
                    $("#orderPhone").val($("#memberPhone").val());
                    break;
                case 'shippingSameCheck':
                    $("#orderName").val($("#orderNameId").val());
                    $("#orderPostcode").val($("#orderPostId").val());
                    $("#orderAddr").val($("#orderAddrId").val());
                    $("#addrDetail").val($("#addrDetailId").val());
                    $("#orderPhone").val($("#mobileNum").val());
                    break;
                case 'shippingNew':
                    $("#orderName").val('');
                    $("#orderPostcode").val('');
                    $("#orderAddr").val('');
                    $("#addrDetail").val('');
                    $("#orderPhone").val('');
                    break;
            }
        })

        $("#selectSelf").hide();

        $("#orderMessage").change(function () {
            $("#orderMessage option:selected").each(function () {
                if ($(this).val() == 'self') {
                    $("#selectSelf").show();
                } else {
                    $("#selectSelf").hide();
                }
            })
        })

        $('.popup .close').click(function() {
            $(this).parent().fadeOut(300);
        });

    });

    function openPop(){
        document.getElementById("myShippingListLayer").style.display = "block";
        document.getElementById("layer_wrap_cont").style.display = "block";
    }

    function open(){
        document.getElementById("layer_wrap_cont").style.display = "none";
        document.getElementById("deliveryAddLayer").style.display = "block";
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {

                let addr = '';
                let extraAddr = '';

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                if (data.userSelectedType === 'R') {
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("extraAddress").value = extraAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }
                document.getElementById('orderPostcode').value = data.zonecode;
                document.getElementById("orderAddr").value = addr;
                document.getElementById("addrDetail").focus();
            }
        }).open();
    }

    function createOrderId() {
        let today = new Date();
        let year = today.getFullYear();
        let month = ('0' + (today.getMonth() + 1)).slice(-2);
        let day = ('0' + today.getDate()).slice(-2);
        let dateString = year + month + day;
        let randomNum = Math.floor(10000000 + Math.random() * 90000000);
        let orderNum = dateString + randomNum;
        return orderNum;
    }

    function payment() {

        let cartValue = $("input[name='cartNo']").length;
        let cartData = new Array(cartValue);
        for (let i = 0; i < cartValue; i++) {
            cartData[i] = $("input[name='cartNo']")[i].value;
        }

        let priceValue = $("input[name='orderPrice']").length;
        let priceData = new Array(priceValue);
        for (let i = 0; i < priceValue; i++) {
            priceData[i] = $("input[name='orderPrice']")[i].value;
        }


        let Message = $("#orderMessage option:selected").text();
        if ($("#orderMessage option:selected").val() == "self") {
            Message = $("#selectSelf").val();
        }

        $('.order-buy').on('click', function () {
            let data = {
                memberNo: parseInt($("#memberNo").val()),
                orderName: $("#orderName").val(),
                orderPhone: $("#orderPhone").val(),
                orderAddr: $("#orderAddr").val(),
                addrDetail: $("#addrDetail").val(),
                orderAmount: parseInt($("#finalTotal").val()),
                orderPayment: $('input[name="payment"]:checked').val(),
                orderDelivery: parseInt($(".orderDelivery").val()),
                orderId: createOrderId(),
                cartNo: cartData,
                orderPrice: priceData,
                productNo: $(".orderDetail_productNo").val(),
                cartQty: $(".orderDetail_cartQty").val(),
                proPrice: $(".orderDetail_totalPrice").val(),
                productSize: $(".orderDetail_productSize").val(),
                merchant_uid: createOrderId(),
                orderPostcode: parseInt($("#orderPostcode").val()),
                orderMessage: Message
            }

            IMP.init("imp28036390");
            IMP.request_pay({
                pg: $("input[name='payment']:checked").val(),
                merchant_uid: data.merchant_uid,
                name: data.orderName,
                amount: data.orderAmount,
                buyer_email: "${loginMember.email}",
                buyer_name: $("#orderName").val(),
                buyer_tel: $("#orderPhone").val(),
                buyer_addr: $("#orderAddr").val()
            }, function (rsp) {
                if (rsp.success) {
                    data.impUid = rsp.imp_uid;
                    orderComplete(data);
                }
            })
        })
    }

    function orderComplete(data) {
        $.ajax({
            url: "${contextPath}/order/result",
            method: "post",
            traditional: true,
            data: data,
            success: function (res) {
                if (res > 0) {
                    location.href = '${contextPath}/order/completePage/' + data.orderId;
                } else {
                    alert('결제가 실패되었습니다. 새로고침 후 다시 시도해주세요.');
                }
            }
        })
    }

</script>
<link href="../../resources/css/order.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
<input type="hidden" id="memberNo" value="${loginMember.memberNo}">
<div id="wrap">
    <div id="container">
        <div id="contents">
            <div class="sub_content">
                <div class="content_box">
                    <div class="order_wrap">
                        <div class="order_tit">
                            <h2>주문서작성/결제<br></h2>
                        </div>
                        <div class="order_cont">
                            <div class="cart_cont_list">

                                <div class="order_table_type">

                                    <c:forEach items="${orderList}" var="order">
                                        <table>
                                            <colgroup>
                                                <col style="width:23%">
                                                <col>
                                                <col style="width:5%">
                                                <col style="width:13%">
                                                <col style="width:10%">
                                            </colgroup>
                                            <tbody>
                                            <tr class="order-goods-layout" data-goodsNo="1000002266">
                                                <td class="td_left" style="padding-left:30px;">
                                                    <input type="hidden" class="orderDetail_cartNo" name="cartNo"
                                                           value="${order.cartNo}">
                                                    <input type="hidden" class="orderDetail_productNo" name="productNo"
                                                           value="${order.productNo}">
                                                    <input type="hidden" class="orderDetail_cartQty" name="orderQty"
                                                           value="${order.cartQty}">
                                                    <input type="hidden" class="orderDetail_totalPrice"
                                                           name="orderPrice"
                                                           value="${order.totalPrice}">
                                                    <input type="hidden" class="orderDetail_productSize"
                                                           name="productSize"
                                                           value="${order.productSize}">
                                                    <div class="pick_add_cont">
                                                <span class="pick_add_img">
                                                    <a href="${contextPath}/product/detail?proNo=${order.productNo}"><img
                                                            src="https://image.shutterstock.com/image-photo/grey-casual-sports-shoessneaker-isolated-600w-1541764289.jpg"
                                                            width="120px" height="120px" class="middle"
                                                            class="imgsize-s"/></a>
                                                </span>
                                                        <div class="pick_add_info">
                                                            <em><a href="${contextPath}/product/detail?proNo=${order.productNo}">${order.proName}</a></em>
                                                            <div class="pick_option_box">
                                                                <span class="text_type_cont">옵션 : ${order.productSize} </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                </td>
                                                <td class="td_order_amount">
                                                    <div class="order_goods_num">
                                                        <strong>${order.cartQty}개</strong>
                                                    </div>
                                                </td>
                                                <td class="td_benefit">
                                                    <ul class="benefit_list">
                                                        <li class="benefit_mileage js_mileage">
                                                            <span>상품 할인</span>
                                                            <strong style="font-weight: bold">-<fmt:formatNumber
                                                                    pattern="#,##0"
                                                                    value="${order.discountPrice * order.cartQty}"/>원</strong>
                                                        </li>
                                                    </ul>
                                                </td>
                                                <td style="width:118px;">
                                                    <strong class="order_sum_txt"><fmt:formatNumber pattern="#,##0"
                                                                                                    value="${order.totalPrice}"/>원</strong>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="order_view_info">
                                <div class="order_info order_line">
                                    <div class="order_zone_tit">
                                        <h4>주문자 정보</h4>
                                    </div>

                                    <div class="order_table_type">
                                        <table class="table_left">
                                            <input type="hidden" id="memberId" value="${loginMember.name}">
                                            <input type="hidden" id="memberPost" value="${loginMember.postcode}">
                                            <input type="hidden" id="memberAddr" value="${loginMember.address}">
                                            <input type="hidden" id="memberAddrdetail"
                                                   value="${loginMember.addrDetail}">
                                            <input type="hidden" id="memberPhone" value="${loginMember.phone}">
                                            <colgroup>
                                                <col style="width:15%;">
                                                <col style="width:85%;">
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th scope="row"><span class="important">주문자 성명</span></th>
                                                <td><input type="text" id="orderNameId" name="orderNameId"
                                                           value="${loginMember.name}"
                                                           maxlength="20"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">주소</th>
                                                <td> [${loginMember.postcode}]
                                                    ${loginMember.address}, ${loginMember.addrDetail}
                                                    <input type="hidden" id="orderPostId" name="orderPostId"
                                                           value="${loginMember.postcode}">
                                                    <input type="hidden" id="orderAddrId" name="orderAddrId"
                                                           value="${loginMember.address}">
                                                    <input type="hidden" id="addrDetailId" name="addrDetailId"
                                                           value="${loginMember.addrDetail}">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="important">휴대폰 번호</span></th>
                                                <td>
                                                    <input type="text" id="mobileNum" name="orderCellPhone"
                                                           value="${loginMember.phone}"
                                                           maxlength="20"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="important">이메일</span></th>
                                                <td class="member_email">
                                                    <input type="text" name="orderEmail" value="kny2237@naver.com"/>
                                                    <select id="emailDomain" class="chosen-select">
                                                        <option value="self">직접입력</option>
                                                        <option value="naver.com">naver.com</option>
                                                        <option value="hanmail.net">hanmail.net</option>
                                                        <option value="daum.net">daum.net</option>
                                                        <option value="nate.com">nate.com</option>
                                                        <option value="gmail.com">gmail.com</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="delivery_info order_line">
                                    <div class="order_zone_tit">
                                        <h4>배송정보</h4>
                                    </div>

                                    <div class="order_table_type shipping_info">
                                        <table class="table_left shipping_info_table">
                                            <colgroup>
                                                <col style="width:15%;">
                                                <col style="width:85%;">
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th scope="row">배송지 확인</th>
                                                <td>
                                                    <div class="form_element">
                                                        <ul>
                                                            <li>
                                                                <input type="radio" name="shipping" id="shippingBasic"
                                                                       checked="checked">
                                                                <label for="shippingBasic"
                                                                       class="choice_s"><span></span>기본
                                                                    배송지</label>
                                                            </li>
                                                            <li>
                                                                <input type="radio" name="shipping"
                                                                       id="shippingSameCheck">
                                                                <label for="shippingSameCheck"
                                                                       class="choice_s"><span></span>주문자 정보와
                                                                    동일</label>
                                                            </li>
                                                            <li>
                                                                <input type="radio" name="shipping" id="shippingNew">
                                                                <label for="shippingNew" class="choice_s"><span></span>직접
                                                                    입력</label>
                                                            </li>
                                                        </ul>
                                                        <a href="javascript:openPop()"
                                                           class="btn_gray_small btn_open_layer js_shipping">
                                                            <span>배송지 관리</span>
                                                        </a>
                                                        <input type="hidden" class="shipping-delivery-visit" value="n"/>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="important">받으실분</span></th>
                                                <td><input type="text" name="receiverName" id="orderName"
                                                           value="${loginMember.name}"
                                                           maxlength="20"/></td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="important">받으실 곳</span></th>
                                                <td class="member_address">
                                                    <div class="address_postcode">
                                                        <input type="text" id="orderPostcode" name="orderPostcode"
                                                               value="${loginMember.postcode}"
                                                               readonly="readonly"/>
                                                        <input type="hidden" name="receiverZipcode"/>
                                                        <button type="button" class="btn_post_search"
                                                                onclick="execDaumPostcode()">
                                                            우편번호검색
                                                        </button>
                                                    </div>
                                                    <div class="address_input">
                                                        <input type="text" name="orderAddr" id="orderAddr"
                                                               value="${loginMember.address}"
                                                               readonly="readonly"/>
                                                        <input type="text" id="addrDetail" name="addrDetail"
                                                               value="${loginMember.addrDetail}"/>
                                                        <input type="hidden" name="extraAddress" id="extraAddress">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="important">휴대폰 번호</span></th>
                                                <td>
                                                    <input type="text" id="orderPhone" name="orderPhone"
                                                           value="${loginMember.phone}"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">요청사항</th>
                                                <td class="td_last_say">
                                                    <select id="orderMessage" class="chosen-select"
                                                            style="width: 265px">
                                                        <option value="call">배송 전에 미리 연락 바랍니다.</option>
                                                        <option value="office">부재시 경비실에 맡겨 주세요.</option>
                                                        <option value="phone">부재시 전화 주시거나 문자 남겨 주세요.</option>
                                                        <option value="self">직접입력</option>
                                                    </select>
                                                    <input type="text" id="selectSelf" name="selectSelf"
                                                           style="margin-top: 6px;"/>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="payment_progress order_line"
                                     style="padding-bottom: 20px; margin-bottom: 90px;">
                                    <div class="order_zone_tit">
                                        <h4>결제수단 선택 / 결제</h4>
                                    </div>
                                    <div class="payment_progress_list">
                                        <div class="js_pay_content">
                                            <div id="settlekind_general" class="general_payment">
                                                <dl>
                                                    <dt style="width:140px;">결제수단</dt>
                                                    <dd>
                                                        <div class="form_element">
                                                            <ul class="payment_progress_select">
                                                                <li id="settlekindType_gb">
                                                                    <input type="radio" id="settleKind_gb"
                                                                           name="payment"
                                                                           value="kakaopay" checked="checked"/>
                                                                    <label for="settleKind_gb"
                                                                           class="choice_s"
                                                                           style="padding-right: 10px;"><span></span>카카오페이</label>
                                                                </li>
                                                                <li id="settlekindType_pv">
                                                                    <input type="radio" id="settleKind_pv"
                                                                           name="payment"
                                                                           value="tosspay"/>
                                                                    <label for="settleKind_pv"
                                                                           class="choice_s"
                                                                           style="padding-right: 10px;"><span></span>토스</label>
                                                                </li>
                                                                <li id="settlekindType_pc">
                                                                    <input type="radio" id="settleKind_pc"
                                                                           name="payment"
                                                                           value="html5_inicis"/>
                                                                    <label for="settleKind_pc"
                                                                           class="choice_s"
                                                                           style="padding-right: 10px;"><span></span>신용카드</label>
                                                                </li>
                                                                <li id="settlekindType_pb">
                                                                    <input type="radio" id="settleKind_pb"
                                                                           name="payment"
                                                                           value="settle"/>
                                                                    <label for="settleKind_pb"
                                                                           class="choice_s"><span></span>세틀뱅크</label>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="custom_wrap1">
                            <div class="custom_cont">
                                <div class="custom_payment_info">
                                    <div class="custom_order_table_type">
                                        <table class="table_left2" style="width: 100%;">
                                            <colgroup>
                                                <col>
                                                <col>
                                            </colgroup>
                                            <tbody>
                                            <c:set var="total" value="0"/>
                                            <c:forEach var="result" items="${orderList}" varStatus="status">
                                                <c:set var="total"
                                                       value="${total + (result.proPrice * result.cartQty)}"/>
                                            </c:forEach>
                                            <tr class="order_right_list1">
                                                <th scope="row">상품 합계 금액</th>
                                                <td>
                                                    <strong style="font-size:16px; font-weight:500; color:#111;"
                                                            id="totalGoodsPrice"
                                                            class="order_payment_sum"><fmt:formatNumber pattern="#,##0"
                                                                                                        value="${total}"/>원</strong>
                                                </td>
                                            </tr>
                                            <c:set var="saleTotal" value="0"/>
                                            <c:forEach var="result" items="${orderList}" varStatus="status">
                                                <c:set var="saleTotal"
                                                       value="${saleTotal + (result.discountPrice * result.cartQty)}"/>
                                            </c:forEach>
                                            <tr class="order_list_sale_bottom">
                                            </tr>
                                            <tr class="order_right_list1">
                                                <th scope="row">할인 금액</th>
                                                <td><strong><b class="total-member-dc-price"
                                                               style="color:#fc123e">-<fmt:formatNumber
                                                        value="${saleTotal}"
                                                        pattern="#,##0"/>
                                                </b></strong>원
                                                </td>
                                            </tr>
                                            <tr class="order_list_sale">
                                            <tr class="order_list_sale_bottom">
                                            </tr>
                                            <tr class="order_right_list1">
                                                <th scope="row">배송비</th>
                                                <c:if test="${total >= 50000}">
                                                    <td>
                                                        <input type="hidden" class="orderDelivery" value=0>
                                                        <span class="totalDeliveryCharge"><b>0</b></span>원
                                                    </td>
                                                </c:if>
                                                <c:if test="${total <= 50000}">
                                                    <td>
                                                        <input type="hidden" class="orderDelivery" value=3000>
                                                        <span class="totalDeliveryCharge"><b>3,000</b></span>원
                                                    </td>
                                                </c:if>
                                            </tr>
                                            <tr class="order_list_sale" style="margin-left: 5px">
                                                <th style="color: #999; display: contents; font-size: 15px; font-weight: normal">
                                                    └ 50,000원 이상 주문 시 무료배송
                                                </th>
                                            </tr>
                                            <tbody id="mileageDefault" style="display: none;">
                                            </tbody>
                                            <tr class="order_list_sale_bottom" style="display: none;">
                                            </tr>
                                            <c:set var="total" value="0"/>
                                            <c:forEach var="result" items="${orderList}" varStatus="status">
                                                <c:set var="total" value="${total + (result.totalPrice)}"/>
                                            </c:forEach>
                                            <tr class="order_right_list1">
                                                <th scope="row" style="font-size:18px;">최종 결제 금액</th>
                                                <td>
                                                    <c:if test="${total >= 50000}">
                                                        <input type="hidden" id="finalTotal" value="${total}">
                                                        <span>
                                                            <strong class="totalSettlePriceView"
                                                                    style="font-size:20px; color:#fc123e">
                                                                <fmt:formatNumber
                                                                        pattern="#,##0" value="${total}"/>
                                                            </strong>원
                                                            </span>
                                                    </c:if>
                                                    <c:if test="${total <= 50000}">
                                                        <input type="hidden" id="finalTotal" value="${total + 3000}">
                                                        <span>
                                                            <strong class="totalSettlePriceView"
                                                                    style="font-size:20px; color:#fc123e;">
                                                                <fmt:formatNumber
                                                                        pattern="#,##0" value="${total + 3000}"/>
                                                            </strong>원
                                                            </span>
                                                    </c:if>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="payment_final">
                                    <div class="btn_center_box">
                                        <button class="btn_order_buy order-buy"><em>결제하기</em></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </form>
                </div>
                <div id="myShippingListLayer" class="layer_wrap delivery_add_list_layer" style="display: none">
                    <div class="layer_wrap_cont" id="layer_wrap_cont"
                         style="position: absolute; margin: 0px; top: 246px; left: 400px; display: none">
                        <div class="ly_tit">
                            <h4>나의 배송지 관리</h4>
                        </div>
                        <div class="ly_cont">
                            <div class="scroll_box">
                                <h5>배송지 목록</h5>
                                <div class="delivery_add_list">
                                    <div class="top_table_type">
                                        <table>
                                            <colgroup>
                                                <col style="width:10%">
                                                <col style="width:13%">
                                                <col style="width:12%">
                                                <col>
                                                <col style="width:20%">
                                                <col style="width:12%">
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th>선택</th>
                                                <th>배송지이름</th>
                                                <th>받으실분</th>
                                                <th>주 소</th>
                                                <th>연락처</th>
                                                <th>수정/삭제</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                    <a href="javascript:open()" class="btn_ly_add_shipping btn_open_layer">+ 새 배송지
                                        추가</a>
                                </div>
                                <div class="pagination">
                                </div>
                            </div>
                        </div>
                        <a href="javascript:closePop()" class="ly_close layer_close"><i class="fa-solid fa-x"></i></a>
                    </div>
                    <div id="deliveryAddLayer" class="layer_wrap dn" style="position: absolute; margin: 0px; top: 246px; left: 41.5px; display: none">
                        <form name="frmDeliveryAddressRegist" id="frmDeliveryAddressRegist"
                              action="../order/layer_shipping_ps.php" method="post" novalidate="novalidate">
                            <input type="hidden" name="mode" value="shipping_regist">
                            <input type="hidden" name="sno" value="">
                            <input type="hidden" name="shippingNo" value="">
                            <div class="ly_tit">
                                <h4>나의 배송지 관리</h4>
                            </div>
                            <div class="ly_cont">
                                <div class="scroll_box">
                                    <h5>배송지 등록</h5>
                                    <div class="left_table_type">
                                        <table>
                                            <colgroup>
                                                <col style="width:20%;">
                                                <col style="width:80%;">
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th scope="row"><span class="important">배송지 별칭</span></th>
                                                <td><input type="text" name="shippingTitle" value=""></td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="important">주문자 성명</span></th>
                                                <td><input type="text" name="shippingName" maxlength="20" value=""></td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="important">배송지 주소</span></th>
                                                <td class="member_address">
                                                    <div class="address_postcode">
                                                        <input type="text" name="shippingZonecode" value=""
                                                               readonly="readonly">
                                                        <button type="button"
                                                                onclick="gd_postcode_search('shippingZonecode', 'shippingAddress', 'shippingZipcode');"
                                                                class="btn_post_search">우편번호검색
                                                        </button>
                                                        <input type="hidden" name="shippingZipcode" value="">
                                                    </div>
                                                    <div class="address_input">
                                                        <input type="text" name="shippingAddress" value=""
                                                               readonly="readonly">
                                                        <input type="text" name="shippingAddressSub" value="">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="important">휴대폰번호</span></th>
                                                <td>
                                                    <input type="text" id="shippingMobile" name="shippingCellPhone"
                                                           value="">
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="btn_center_box">
                                    <button type="button" class="btn_ly_cancel layer_close"><strong>취소</strong></button>
                                    <button type="submit" class="btn_ly_save"><strong>저장</strong></button>
                                </div>
                            </div>
                            <a href="javascript:closePop2()" class="ly_close layer_close"><img
                                    src="/data/skin/front/dalbame_pc/img/common/layer/btn_layer_close.png" alt="닫기"></a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</body>
</html>