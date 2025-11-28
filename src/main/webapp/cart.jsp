<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Shopping Cart - 电商平台</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
                <div class="container">
                    <a class="navbar-brand" href="products">电商平台</a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item"><a class="nav-link" href="products">继续购物</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <h2>购物车</h2>
                <c:choose>
                    <c:when test="${empty sessionScope.cart}">
                        <div class="alert alert-info">您的购物车是空的。 <a href="products">去购物！</a></div>
                    </c:when>
                    <c:otherwise>
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>商品</th>
                                    <th>价格</th>
                                    <th>数量</th>
                                    <th>小计</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${sessionScope.cart}" var="item">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="assets/images/${item.product.image}"
                                                    alt="${item.product.name}" width="50" class="me-3"
                                                    onerror="this.src='https://via.placeholder.com/50'">
                                                <span>${item.product.name}</span>
                                            </div>
                                        </td>
                                        <td>$${item.product.price}</td>
                                        <td style="width: 150px;">
                                            <form action="cart" method="post" class="d-flex">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1"
                                                    class="form-control me-2">
                                                <button type="submit" class="btn btn-sm btn-secondary">更新</button>
                                            </form>
                                        </td>
                                        <td>$${item.totalPrice}</td>
                                        <td>
                                            <a href="cart?action=remove&id=${item.product.id}"
                                                class="btn btn-sm btn-danger">移除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3" class="text-end"><strong>总计：</strong></td>
                                    <td colspan="2"><strong>$${cartTotal}</strong></td>
                                </tr>
                            </tfoot>
                        </table>
                        <div class="d-flex justify-content-between">
                            <a href="cart?action=clear" class="btn btn-warning">清空购物车</a>
                            <a href="order?action=checkout" class="btn btn-success btn-lg">去结算</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>