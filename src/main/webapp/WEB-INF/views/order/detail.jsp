<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<script>

    $(document).ready(function () {
        payment();
    });

    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }

                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }

                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }


                document.getElementById('postalcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;

                var guideTextBox = document.getElementById("guide");

                if (data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
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

        $('#iamportPayment').on('click', function () {
            let data = {
                memberNo: parseInt($("#memberNo").val()),
                orderName: $("#orderName").val(),
                orderPhone: $("#orderPhone").val(),
                orderAddr: $("#orderAddr").val(),
                addrDetail: $("#addrDetail").val(),
                orderAmount: parseInt($(".totalPrice").val()),
                orderPayment: $('input[name="payment"]:checked').val(),
                orderDelivery: parseInt($("#orderDelivery").val()),
                orderId: createOrderId(),
                cartNo: cartData,
                orderPrice: priceData,
                productNo : $(".orderDetail_productNo").val(),
                cartQty: $(".orderDetail_cartQty").val(),
                proPrice : $(".orderDetail_totalPrice").val(),
                merchant_uid: createOrderId(),
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
                } else {
                    alert('결제가 실패하였습니다. 다시 시도해주세요.')
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
                alert(res);
                location.href = "${contextPath}/order/completePage";
            },
            error: function (res) {
                alert(res);
            }
        })
    }

</script>
<title>Insert title here</title>
</head>
<body>
    ${orderList}
    <input type="hidden" id="memberNo" value="${loginMember.memberNo}">

    주문/결제
    <table border="1">
        <thead>
        <tr>
            <td>이미지</td>
            <td>상품명</td>
            <td>옵션</td>
            <td>수량</td>
            <td>상품금액(할인포함)</td>
            <td></td>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${orderList}" var="order">
            <tr>
                <td>이미지</td>
                <td>${order.proName}</td>
                <td>옵션</td>
                <td>${order.cartQty}</td>
                <td>${order.proPrice}</td>

                <td class="orderDetail_td" colspan="5">
                    <input type="hidden" class="orderDetail_cartNo" name="cartNo" value="${order.cartNo}">
                    <input type="hidden" class="orderDetail_productNo" name="productNo" value="${order.productNo}">
                    <input type="hidden" class="orderDetail_cartQty" name="orderQty" value="${order.cartQty}">
                    <input type="hidden" class="orderDetail_totalPrice" name="orderPrice" value="${order.totalPrice}">
                </td>
            </tr>
        </c:forEach>
        </tbody>

    </table>
    <br><br>
    배송지정보
    <hr>

    이름 <input type="text" id="orderName" value="${loginMember.name}"><br>
    휴대폰번호 <input type="text" id="orderPhone" value="${loginMember.phone}"><br>
    주소 <input type="text" id="orderAddr" value="${loginMember.address}"><br>
    상세주소 <input type="text" id="addrDetail" value="${loginMember.addrDetail}"><br>
    요청사항 <input type="text" id="orderRequest" name="orderRequest" value=""><br>
    <c:set var="total" value="0"/>
    <c:forEach var="result" items="${orderList}" varStatus="status">
        <c:set var="total" value="${total + (result.totalPrice)}"/>
    </c:forEach>

    <c:if test="${total >= 50000}">
        배송비 <input type="number" id="orderDelivery" name="orderDelivery" value="0"><br>
        합계 <input type="number" class="totalPrice" name="totalPrice" value="${total}"><br>
    </c:if>

    <c:if test="${total <= 50000}">
        배송비 <input type="number" id="orderDelivery" name="orderDelivery" value="3000"><br>
        합계 <input type="number" class="totalPrice" name="totalPrice" value="${total + 3000}"><br>
    </c:if>

    결제수단
    <input type="radio" name="payment" value="kakaopay" checked="checked">카카오페이
    <input type="radio" name="payment" value="tosspay">토스
    <input type="radio" name="payment" value="html5_inicis">신용카드
    <input type="radio" name="payment" value="settle">세틀뱅크
    <button id="iamportPayment">구매하기</button>
    <br>

    <%--<div class="col-lg-12">
        <div class="row">
            <div class="col-lg-3">
                <label>배송지 주소</label><span class="emph"></span>
            </div>
            <div class="col-lg-9">
                <div class="row">
                    <div class="col-lg-4">
                        <input type="text" id="newPostalcode" name="postalcode">
                    </div>
                    <div class="col-lg-3" style="padding: 0;">
                        <button type="button" class="site-btn deliverListBtn postalBtn" onclick="daumPostcode();">우편번호</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6" style="padding-right: 3px;">
                        <input type="text" id="newRoadAddress">
                    </div>
                    <div class="col-lg-6" style="padding-left: 3px;">
                        <input type="text" id="newDetailAddress">
                    </div>
                    <span id="guide" style="color:#999;display:none"></span>
                </div>
            </div>
        </div>
    </div>--%>

    <form id="cancelOrder" action="${contextPath}/order/cancelOrder" method="post">
        <input type="hidden" id="orderImpUid" name="orderImpUid" value="imp_874799358603">
        <input type="hidden" id="ordreAmount" name="ordreAmount" value="23000">
        <%--								<input type="hidden" name="impUid" value="${order.impUid}">--%>
        <input type="hidden" id="orderReason" name="orderReason" value="TEST">
        <%--<input type="hidden" name="amount" value="${order.orderAmount}">--%>
        <button id="btnCancel">취소</button>
    </form>

</body>
</html>