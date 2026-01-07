# 样式管理说明

## 类名重名问题

**答案：类名不能在同一作用域内重名**

在 Dart/Flutter 中，如果你在同一个文件中定义两个同名的类，会报错。但是你可以：

1. **使用不同的类名**（推荐）
   - 例如：`LoginStyles`、`HomeStyles`、`ProfileStyles`
   - 每个功能模块使用不同的类名

2. **使用 `as` 关键字重命名导入**
   ```dart
   import 'styles/login_styles.dart' as Login;
   import 'styles/home_styles.dart' as Home;
   
   // 使用时
   Login.LoginStyles.loginTitle
   Home.HomeStyles.homeTitle
   ```

3. **使用不同的包/命名空间**
   - 将不同功能的样式放在不同的包中

## 为每个功能创建样式

**答案：完全可以，而且这是推荐的做法！**

### 推荐的组织方式

1. **按功能模块划分**（当前采用的方式）
   - `app_colors.dart` - 全局通用颜色
   - `app_spacing.dart` - 全局通用间距
   - `app_text_styles.dart` - 全局通用文本样式
   - `login_styles.dart` - 登录页面样式
   - `home_styles.dart` - 首页样式
   - `profile_styles.dart` - 个人资料样式

2. **命名约定**
   - 全局样式：`AppXxx`（如 `AppColors`、`AppSpacing`）
   - 功能样式：`XxxStyles`（如 `LoginStyles`、`HomeStyles`）

### 使用示例

```dart
import 'styles/app_colors.dart';
import 'styles/login_styles.dart';
import 'styles/home_styles.dart';

// 使用全局样式
Container(
  color: AppColors.primary,
  padding: AppSpacing.paddingMedium,
)

// 使用功能样式
Text('登录', style: LoginStyles.loginTitle)
Container(decoration: HomeStyles.homeCardDecoration)
```

### 优势

1. **模块化**：每个功能的样式独立管理
2. **可维护性**：修改某个功能的样式不影响其他功能
3. **可读性**：代码更清晰，知道样式属于哪个功能
4. **可扩展性**：新功能可以轻松添加新的样式类


