# -*- coding: utf-8 -*-
import os
import codecs

# 定义所有需要替换的文本映射
translations = {
    # 通用
    'E-Shop': '电商平台',
    'E-Shop Home': '电商平台 - 首页',
    'Login - E-Shop': '登录 - 电商平台',
    'Register - E-Shop': '注册 - 电商平台',
    'Shopping Cart - E-Shop': '购物车 - 电商平台',
    'Checkout - E-Shop': '结算 - 电商平台',
    'My Orders - E-Shop': '我的订单 - 电商平台',
    'My Profile - E-Shop': '我的资料 - 电商平台',
    'Admin Dashboard - E-Shop': '管理员控制台 - 电商平台',
    'Manage Products - E-Shop Admin': '商品管理 - 电商平台管理',
    'Manage Orders - E-Shop Admin': '订单管理 - 电商平台管理',
    'E-Shop Admin': '电商平台管理',
    
    # 导航
    '>Home<': '>首页<',
    '>Cart<': '>购物车<',
    '>Login<': '>登录<',
    '>Register<': '>注册<',
    '>My Orders<': '>我的订单<',
    'Admin\r\n                                                        Dashboard': '管理员控制台',
    '>Logout<': '>退出登录<',
    '>Dashboard<': '>控制台<',
    '>Products<': '>商品管理<',
    '>Orders<': '>订单管理<',
    
    # 按钮和链接
    '>Search<': '>搜索<',
    '>Buy Now<': '>立即购买<',
    '>Continue Shopping<': '>继续购物<',
    '>Back to Home<': '>返回首页<',
    '>Update<': '>更新<',
    '>Remove<': '>移除<',
    '>Clear Cart<': '>清空购物车<',
    '>Proceed to Checkout<': '>去结算<',
    '>Add to\r\n                                    Cart<': '>加入购物车<',
    '>View Details<': '>查看详情<',
    '>Back to Orders<': '>返回订单列表<',
    '>Update Profile<': '>更新资料<',
    '>Add New Product<': '>添加新商品<',
    '>Edit<': '>编辑<',
    '>Delete<': '>删除<',
    '>Go to Products<': '>进入商品管理<',
    '>Go to Orders<': '>进入订单管理<',
    '>Cancel<': '>取消<',
    '>Save Product<': '>保存商品<',
    '>View<': '>查看<',
    '>Back to Cart<': '>返回购物车<',
    '>Place Order<': '>提交订单<',
    
    # 表单标签
    '>Username<': '>用户名<',
    '>Password<': '>密码<',
    '>Email<': '>邮箱<',
    '>Phone<': '>电话<',
    '>Name<': '>名称<',
    '>Category<': '>分类<',
    '>Price<': '>价格<',
    '>Stock<': '>库存<',
    '>Description<': '>描述<',
    '>Image<': '>图片<',
    '>Receiver Name<': '>收货人姓名<',
    '>Address<': '>收货地址<',
    
    # 表格列
    '>Product<': '>商品<',
    '>Quantity<': '>数量<',
    '>Total<': '>小计<',
    '>Action<': '>操作<',
    '>Actions<': '>操作<',
    '>Order ID<': '>订单编号<',
    '>Date<': '>日期<',
    '>Status<': '>状态<',
    '>ID<': '>编号<',
    '>User ID<': '>用户ID<',
    '>Qty<': '>数量<',
    '>Subtotal<': '>小计<',
    '>Receiver:<': '>收货人：<',
    
    # 标题
    '>Welcome Back<': '>欢迎回来<',
    '>Create Account<': '>创建账户<',
    '>Shopping Cart<': '>购物车<',
    '>Checkout<': '>结算<',
    '>My Orders<': '>我的订单<',
    '>My Profile<': '>我的资料<',
    'Welcome, Admin!': '欢迎，管理员！',
    '>Order Summary<': '>订单摘要<',
    '>Shipping Information<': '>收货信息<',
    '>Shipping Info<': '>收货信息<',
    '>Order Info<': '>订单信息<',
    '>Items<': '>商品明细<',
    '>Manage Products<': '>管理商品<',
    '>Manage Orders<': '>管理订单<',
    
    # 提示文本
    'placeholder="Search products..."': 'placeholder="搜索商品..."',
    'Login to your account': '登录您的账户',
    'Join us today!': '立即加入我们！',
    "Don't have an account?": '还没有账户？',
    'Already have an account?': '已有账户？',
    'Your cart is empty.': '您的购物车是空的。',
    'Go shopping!': '去购物！',
    'No products found.': '没有找到商品。',
    'You have no orders yet.': '您还没有订单。',
    'New Password (leave blank to keep\r\n                                                    current)': '新密码（留空保持不变）',
    'Add, edit, or delete products.': '添加、编辑或删除商品。',
    'View and update order status.': '查看和更新订单状态。',
    "onclick=\"return confirm('Are you sure?')\"": "onclick=\"return confirm('确定要删除吗？')\"",
    'Current:': '当前图片：',
    'In Stock:': '库存：',
    
    # 状态选项
    '>Pending<': '>待支付<',
    '>Paid<': '>已支付<',
    '>Shipped<': '>已发货<',
    '>Completed<': '>已完成<',
    '>Cancelled<': '>已取消<',
    
    # 其他
    '>Total:<': '>总计：<',
    'Add New': '添加新',
    'Edit': '编辑',
}

def translate_file(filepath):
    """翻译单个文件"""
    try:
        # 读取文件（UTF-8编码）
        with codecs.open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 执行所有替换
        for en, zh in translations.items():
            content = content.replace(en, zh)
        
        # 写回文件（UTF-8编码，无BOM）
        with codecs.open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        
        print(f"✓ Translated: {filepath}")
        return True
    except Exception as e:
        print(f"✗ Error translating {filepath}: {e}")
        return False

def main():
    """主函数"""
    base_dir = r'd:\Desktop\jsp-final-homework\src\main\webapp'
    
    # 需要翻译的文件列表
    files_to_translate = [
        'index.jsp',
        'login.jsp',
        'register.jsp',
        'cart.jsp',
        'product_detail.jsp',
        'my_orders.jsp',
        'order_confirm.jsp',
        'order_detail.jsp',
        'profile.jsp',
        r'admin\dashboard.jsp',
        r'admin\products.jsp',
        r'admin\orders.jsp',
        r'admin\product_form.jsp',
    ]
    
    success_count = 0
    for file in files_to_translate:
        filepath = os.path.join(base_dir, file)
        if os.path.exists(filepath):
            if translate_file(filepath):
                success_count += 1
        else:
            print(f"✗ File not found: {filepath}")
    
    print(f"\n完成！成功翻译 {success_count}/{len(files_to_translate)} 个文件")

if __name__ == '__main__':
    main()
