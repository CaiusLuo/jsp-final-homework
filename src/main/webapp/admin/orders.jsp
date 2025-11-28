<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Manage Orders - E-Shop Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
                <div class="container">
                    <a class="navbar-brand" href="../products">E-Shop Admin</a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
                            <li class="nav-item"><a class="nav-link" href="manage?action=products">Products</a></li>
                            <li class="nav-item"><a class="nav-link active" href="manage?action=orders">Orders</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <h2>Orders</h2>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User ID</th>
                            <th>Date</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="o">
                            <tr>
                                <td>${o.id}</td>
                                <td>${o.userId}</td>
                                <td>${o.createTime}</td>
                                <td>$${o.totalAmount}</td>
                                <td>
                                    <form action="manage" method="get" class="d-flex align-items-center">
                                        <input type="hidden" name="action" value="updateOrder">
                                        <input type="hidden" name="id" value="${o.id}">
                                        <select name="status" class="form-select form-select-sm me-2"
                                            style="width: auto;">
                                            <option value="1" ${o.status==1 ? 'selected' : '' }>Pending</option>
                                            <option value="2" ${o.status==2 ? 'selected' : '' }>Paid</option>
                                            <option value="3" ${o.status==3 ? 'selected' : '' }>Shipped</option>
                                            <option value="4" ${o.status==4 ? 'selected' : '' }>Completed</option>
                                            <option value="5" ${o.status==5 ? 'selected' : '' }>Cancelled</option>
                                        </select>
                                        <button type="submit" class="btn btn-sm btn-primary">Update</button>
                                    </form>
                                </td>
                                <td>
                                    <a href="../order?action=detail&id=${o.id}" target="_blank"
                                        class="btn btn-sm btn-info">View</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>