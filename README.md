# PinXiXi 电商平台

一个基于 JavaWeb 技术栈开发的简洁电商平台，实现了完整的在线购物体验。

## 📋 项目概述

PinXiXi 是一个功能完整的电商平台，采用经典的 JSP + Servlet + MySQL 架构，为用户提供商品浏览、搜索、购物车、模拟支付、用户注册登录以及个人中心等核心功能。

### 🎯 项目特色

- **简洁实用**: 功能完整但不冗余，专注核心电商体验
- **技术经典**: 采用成熟的 JavaWeb 技术栈，易于学习和维护
- **响应式设计**: 基于 Bootstrap 框架，适配多种设备
- **模块化架构**: 清晰的分层设计，便于扩展和维护

## 🛠️ 技术栈

### 后端技术
- **Java EE 8** - 核心开发语言和平台
- **Servlet API 4.0** - Web 请求处理
- **JSP 2.3** - 动态网页生成
- **JSTL 1.2** - JSP 标准标签库
- **JDBC** - 数据库连接
- **Maven** - 项目构建和依赖管理

### 前端技术
- **Bootstrap** - 响应式 UI 框架
- **HTML5/CSS3** - 页面结构和样式
- **JavaScript** - 前端交互逻辑

### 数据库
- **MySQL 8** - 关系型数据库

### 开发环境
- **Apache Tomcat 9** - Web 服务器
- **JDK 8+** - Java 开发环境

## 🏗️ 项目架构

```
PinXiXi_shop/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/yycy/
│   │   │       ├── controller/     # Servlet 控制器
│   │   │       ├── service/        # 业务逻辑层
│   │   │       ├── dao/           # 数据访问层
│   │   │       ├── entity/        # 实体类
│   │   │       ├── filter/        # 过滤器
│   │   │       └── util/          # 工具类
│   │   ├── resources/             # 配置文件
│   │   └── webapp/                # Web 资源
│   │       ├── WEB-INF/          # Web 配置
│   │       ├── images/           # 图片资源
│   │       └── *.jsp             # JSP 页面
│   └── test/                      # 测试代码
├── database/                      # 数据库脚本
├── docs/                         # 项目文档
├── target/                       # 编译输出
└── pom.xml                       # Maven 配置
```

### 分层架构

- **表现层 (Presentation Layer)**: JSP + Bootstrap + JSTL
- **控制层 (Control Layer)**: Servlets
- **业务逻辑层 (Service Layer)**: Java 业务类
- **数据访问层 (DAO Layer)**: JDBC 数据访问
- **数据持久层 (Data Layer)**: MySQL 数据库

## 🚀 功能模块

### 1. 首页模块
- 商品列表展示（卡片式布局）
- 商品名称模糊搜索
- 快速加入购物车
- 轮播图展示
- 导航栏功能

### 2. 商品详情模块
- 详细商品信息展示
- 多图片展示（主图+缩略图）
- 数量选择器
- 加入购物车/立即购买
- 迷你商品导航列表

### 3. 购物车模块
- 购物车商品管理
- 数量调整和删除
- 实时金额计算
- 清空购物车
- 结算功能

### 4. 支付模块
- 订单信息确认
- 用户信息展示
- 模拟支付流程
- 支付成功页面

### 5. 用户模块
- 用户注册（用户名+密码）
- 用户登录/退出
- 会话管理

### 6. 个人中心模块
- 个人信息管理（昵称、电话、邮箱、性别）
- 密码修改
- 头像上传
- 收货地址管理

## 📊 数据库设计

### 核心数据表

#### 用户表 (users)
- 用户基本信息（用户名、密码、昵称等）
- 联系方式（邮箱、电话）
- 头像路径

#### 商品表 (products)
- 商品基本信息（名称、描述、价格）
- 商品图片路径
- 销量统计

#### 地址表 (addresses)
- 用户收货地址信息
- 省市区详细地址

## 🔧 安装和运行

### 环境要求
- JDK 8 或更高版本
- Apache Tomcat 9
- MySQL 8
- Maven 3.6+

### 安装步骤

1. **克隆项目**
```bash
git clone [项目地址]
cd PinXiXi_shop
```

2. **数据库配置**
```bash
# 创建数据库
mysql -u root -p
CREATE DATABASE pinxixi_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

# 导入数据
mysql -u root -p pinxixi_shop < database/PinXiXi_shop.sql
```

3. **配置数据库连接**
修改数据库连接配置（在相应的配置文件中）：
```properties
db.url=jdbc:mysql://localhost:3306/pinxixi_shop
db.username=root
db.password=your_password
```

4. **编译项目**
```bash
mvn clean compile
```

5. **打包部署**
```bash
mvn clean package
```

6. **部署到 Tomcat**
将生成的 `target/PinXiXi_shop-1.0-SNAPSHOT.war` 文件部署到 Tomcat 的 webapps 目录

7. **启动服务**
启动 Tomcat 服务器，访问 `http://localhost:8080/PinXiXi_shop-1.0-SNAPSHOT`

## 📱 使用说明

### 用户操作流程

1. **浏览商品**: 访问首页查看商品列表，使用搜索功能查找特定商品
2. **查看详情**: 点击商品进入详情页，查看详细信息和图片
3. **用户注册**: 新用户需要先注册账号（用户名+密码）
4. **用户登录**: 使用注册的账号登录系统
5. **购物车操作**: 将喜欢的商品加入购物车，调整数量
6. **结算支付**: 确认订单信息，进行模拟支付
7. **个人中心**: 管理个人信息、修改密码、上传头像、设置地址

### 管理员功能
- 默认管理员账号：`admin` / `123456`
- 可以使用所有用户功能进行测试

## 🧪 测试

### 运行测试
```bash
mvn test
```

### 测试数据
数据库脚本中包含了测试用的商品数据和用户数据，可以直接用于功能测试。

## 📖 开发文档

详细的开发文档位于 `docs/` 目录：
- `需求分析.md` - 详细的功能需求说明
- `项目架构.md` - 系统架构设计文档
- `开发计划.md` - 项目开发计划
- `项目结构.md` - 代码结构说明

## 🤝 贡献指南

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

本项目仅用于学习和教育目的。

---

**注意**: 本项目为 JavaWeb 课程期末作业，采用经典的 JSP + Servlet 架构，专注于基础 Web 开发技术的学习和实践。
