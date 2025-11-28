<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Checkout - E-Shop</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h3>Checkout</h3>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Order Summary</h5>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Qty</th>
                                            <th>Price</th>
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
                                            <td colspan="2" class="text-end"><strong>Total:</strong></td>
                                            <td><strong>$${cartTotal}</strong></td>
                                        </tr>
                                    </tbody>
                                </table>

                                <h5 class="mt-4">Shipping Information</h5>
                                <form action="order" method="post">
                                    <input type="hidden" name="action" value="submit">
                                    <input type="hidden" name="totalAmount" value="${cartTotal}">
                                    <div class="mb-3">
                                        <label class="form-label">Receiver Name</label>
                                        <input type="text" name="receiver" class="form-control" required
                                            value="${sessionScope.user.username}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Phone</label>
                                        <input type="text" name="phone" class="form-control" required
                                            value="${sessionScope.user.phone}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Address</label>
                                        <textarea name="address" class="form-control" rows="3" required></textarea>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <a href="cart?action=view" class="btn btn-secondary">Back to Cart</a>
                                        <button type="submit" class="btn btn-primary">Place Order</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>