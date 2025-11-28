<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Order #${order.id} - E-Shop</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h3>Order #${order.id}</h3>
                        <a href="order?action=my" class="btn btn-secondary">Back to Orders</a>
                    </div>
                    <div class="card-body">
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h5>Shipping Info</h5>
                                <p><strong>Receiver:</strong> ${order.receiver}</p>
                                <p><strong>Phone:</strong> ${order.phone}</p>
                                <p><strong>Address:</strong> ${order.address}</p>
                            </div>
                            <div class="col-md-6 text-end">
                                <h5>Order Info</h5>
                                <p><strong>Date:</strong> ${order.createTime}</p>
                                <p><strong>Status:</strong> ${order.statusText}</p>
                                <p><strong>Total:</strong> $${order.totalAmount}</p>
                            </div>
                        </div>

                        <h5>Items</h5>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${order.items}" var="item">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="assets/images/${item.productImage}" alt="${item.productName}"
                                                    width="40" class="me-2"
                                                    onerror="this.src='https://via.placeholder.com/40'">
                                                ${item.productName}
                                            </div>
                                        </td>
                                        <td>$${item.price}</td>
                                        <td>${item.quantity}</td>
                                        <td>$${item.price * item.quantity}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </body>

        </html>