<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="../resources/js/jquery-3.6.0.js"></script>
    <script>

        $(function () {
            //fnAdd();
            fnRemove();
        })

        /*function fnAdd() {
            $('#btnAdd').on('click', function () {
                var cartQty = $('#cartQty').val();
                $.ajax({
                    url: '${contextPath}/cart/add',
                    type: 'POST',
                    data: cartQty,
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (obj) {
                        if (obj.res > 0) {
                            console.log('SUCCESS');
                        } else if (obj.res == 0) {
                            console.log('이미 동일한 상품이 존재합니다.')
                        } else {
                            console.log('FAIL')
                        }
                    },
                    error: function (request, status, error) {
                        console.log("code=" + request.status + "message=" + request.responseText + "error=" + error);
                    }
                })
            })
        }*/


        $('#decreaseQuantity').click(function (e) {
            e.preventDefault();
            var stat = $('#cartQty').text();
            var num = parseInt(stat, 10);
            num--;
            if (num <= 0) {
                alert('더이상 줄일수 없습니다.');
                num = 1;
            }
            $('#cartQty').text(num);
        });

        $('#increaseQuantity').click(function (e) {
            e.preventDefault();
            var stat = $('#cartQty').text();
            var num = parseInt(stat, 10);
            num++;

            if (num > 5) {
                alert('더이상 늘릴수 없습니다.');
                num = 5;
            }
            $('#cartQty').text(num);
        });

        function fnRemove() {
            $('#btnRemove').on('click', function () {
                $.ajax({
                    url: '${contextPath}/cart/remove/' + $('#cNo').val(),
                    type: 'GET',
                    dataType: 'json',
                    success: function (obj) {
                        if (obj.res > 0) {
                            console.log('SUCCESS')
                            $('#cNo').val('');
                        } else {
                            console.log('FAIL')
                        }
                    },
                    error: function (request, status, error) {
                        console.log("code=" + request.status + "message=" + request.responseText + "error=" + error);
                    }
                })
            })
        }
    </script>
</head>
<body>

<div>
    <form id="f" method="post" action="${contextPath}/cart/add">
        <a href="#" id="increaseQuantity">PLUS</a>
        <input type="number" name="cartQty" value=1 id="cartQty">
        <a href="#" id="decreaseQuantity">MINUS</a>
        <button>추가</button>
    </form>
</div>


</body>
</html>