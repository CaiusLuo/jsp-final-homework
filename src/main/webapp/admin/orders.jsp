<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Manage Orders - 电商平台 Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
                <div class="container">
                    <a class="navbar-brand" href="../products">电商平台 Admin</a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item"><a class="nav-link" href="dashboard.jsp">控制台</a></li>
                            <li class="nav-item"><a class="nav-link" href="manage?action=products">商品管理</a></li>
                            <li class="nav-item"><a class="nav-link active" href="manage?action=orders">订单管理</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <h2>订单管理</h2>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>编号</th>
                            <th>用户ID</th>
                            <th>日期</th>
                            <th>总价</th>
                            <th>状态</th>
                            <th>操作</th>
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
                                    <form action="order/update" method="post" class="d-flex align-items-center">
                                        <input type="hidden" name="id" value="${o.id}">
                                        <select name="status" class="form-select form-select-sm me-2"
                                            style="width: auto;">
                                            <option value="1" ${o.status==1 ? 'selected' : '' }>待支付</option>
                                            <option value="2" ${o.status==2 ? 'selected' : '' }>已支付</option>
                                            <option value="3" ${o.status==3 ? 'selected' : '' }>已发货</option>
                                            <option value="4" ${o.status==4 ? 'selected' : '' }>已完成</option>
                                            <option value="5" ${o.status==5 ? 'selected' : '' }>已取消</option>
                                        </select>
                                        <button type="submit" class="btn btn-sm btn-primary">更新</button>
                                    </form>
                                </td>
                                <td>
                                    <a href="../order?action=detail&id=${o.id}" target="_blank"
                                        class="btn btn-sm btn-info">查看</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>