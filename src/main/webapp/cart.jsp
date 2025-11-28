<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Shopping Cart - E-Shop</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
                <div class="container">
                    <a class="navbar-brand" href="products">E-Shop</a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item"><a class="nav-link" href="products">Continue Shopping</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <h2>Shopping Cart</h2>
                <c:choose>
                    <c:when test="${empty sessionScope.cart}">
                        <div class="alert alert-info">Your cart is empty. <a href="products">Go shopping!</a></div>
                    </c:when>
                    <c:otherwise>
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th>Action</th>
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
                                                <button type="submit" class="btn btn-sm btn-secondary">Update</button>
                                            </form>
                                        </td>
                                        <td>$${item.totalPrice}</td>
                                        <td>
                                            <a href="cart?action=remove&id=${item.product.id}"
                                                class="btn btn-sm btn-danger">Remove</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3" class="text-end"><strong>Total:</strong></td>
                                    <td colspan="2"><strong>$${cartTotal}</strong></td>
                                </tr>
                            </tfoot>
                        </table>
                        <div class="d-flex justify-content-between">
                            <a href="cart?action=clear" class="btn btn-warning">Clear Cart</a>
                            <a href="order?action=checkout" class="btn btn-success btn-lg">Proceed to Checkout</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>