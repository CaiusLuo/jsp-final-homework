<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Checkout - 电商平台</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h3>结算</h3>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">订单摘要</h5>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>商品</th>
                                            <th>数量</th>
                                            <th>价格</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${sessionScope.cart}" var="item">
                                            <tr>
                                                <td>${item.product.name}</td>
                                                <td>${item.quantity}</td>
                                                <td>$${item.totalPrice}</td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td colspan="2" class="text-end"><strong>总计：</strong></td>
                                            <td><strong>$${cartTotal}</strong></td>
                                        </tr>
                                    </tbody>
                                </table>

                                <h5 class="mt-4">收货信息</h5>
                                <form action="order" method="post">
                                    <input type="hidden" name="action" value="submit">
                                    <input type="hidden" name="totalAmount" value="${cartTotal}">
                                    <div class="mb-3">
                                        <label class="form-label">收货人姓名</label>
                                        <input type="text" name="receiver" class="form-control" required
                                            value="${sessionScope.user.username}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">电话</label>
                                        <input type="text" name="phone" class="form-control" required
                                            value="${sessionScope.user.phone}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">收货地址</label>
                                        <textarea name="address" class="form-control" rows="3" required></textarea>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <a href="cart?action=view" class="btn btn-secondary">返回购物车</a>
                                        <button type="submit" class="btn btn-primary">提交订单</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>