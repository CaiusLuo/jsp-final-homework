<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>My Orders - E-Shop</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
                <div class="container">
                    <a class="navbar-brand" href="products">E-Shop</a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item"><a class="nav-link" href="products">Home</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <h2>My Orders</h2>
                <% String msg=request.getParameter("msg"); if (msg !=null) { %>
                    <div class="alert alert-success">
                        <%= msg %>
                    </div>
                    <% } %>

                        <c:choose>
                            <c:when test="${empty orders}">
                                <div class="alert alert-info">You have no orders yet.</div>
                            </c:when>
                            <c:otherwise>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Date</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${orders}" var="o">
                                            <tr>
                                                <td>#${o.id}</td>
                                                <td>${o.createTime}</td>
                                                <td>$${o.totalAmount}</td>
                                                <td>
                                                    <span
                                                        class="badge bg-${o.status == 1 ? 'warning' : (o.status == 2 ? 'info' : (o.status == 3 ? 'primary' : (o.status == 4 ? 'success' : 'secondary')))}">
                                                        ${o.statusText}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="order?action=detail&id=${o.id}"
                                                        class="btn btn-sm btn-outline-primary">View Details</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>