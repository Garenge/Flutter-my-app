# 解决 Flutter Web 白屏问题

## 快速解决方案

### 1. 使用 HTML 渲染器（推荐）

Flutter Web 默认使用 CanvasKit 渲染器，可能需要下载额外资源导致白屏。尝试使用 HTML 渲染器：

**在 VS Code 中：**
1. 按 `Cmd+Shift+P` 打开命令面板
2. 输入 "Flutter: Launch Emulator"
3. 选择设备后，在运行配置中添加参数

**或者通过终端：**
```bash
cd /Users/garenge/Downloads/Develop/flutter/my_app
flutter run -d chrome --web-renderer html
```

### 2. 清除缓存并重新运行

```bash
cd /Users/garenge/Downloads/Develop/flutter/my_app
flutter clean
flutter pub get
flutter run -d chrome --web-renderer html
```

### 3. 检查浏览器控制台

1. 在浏览器中按 `F12` 打开开发者工具
2. 查看 **Console** 标签页是否有错误
3. 查看 **Network** 标签页，检查资源是否加载成功

## 常见错误和解决方案

### 错误 1: `_flutter is not defined`

**原因：** `flutter.js` 文件未加载

**解决：**
- 检查 `web/index.html` 中是否有 `<script src="flutter.js" defer></script>`
- 确保使用 `flutter run` 而不是 `flutter build web`

### 错误 2: `Failed to load main.dart.js`

**原因：** Dart 代码编译失败或文件路径错误

**解决：**
```bash
flutter clean
flutter pub get
flutter run -d chrome --web-renderer html
```

### 错误 3: Service Worker 错误

**原因：** Service Worker 配置问题

**解决：** 已修复 `index.html`，确保使用正确的 API

## 调试步骤

### 步骤 1: 检查 VS Code 输出

1. 在 VS Code 中，打开 **View > Output**
2. 选择 "Flutter" 或 "Dart" 输出
3. 查看是否有编译错误

### 步骤 2: 检查浏览器控制台

1. 在浏览器中按 `F12`
2. 查看 Console 标签页的错误信息
3. 截图或复制错误信息

### 步骤 3: 检查网络请求

1. 在浏览器开发者工具中，打开 **Network** 标签页
2. 刷新页面
3. 检查是否有失败的请求（红色）

### 步骤 4: 尝试不同的渲染器

```bash
# 尝试 HTML 渲染器
flutter run -d chrome --web-renderer html

# 尝试 CanvasKit 渲染器（默认）
flutter run -d chrome --web-renderer canvaskit

# 尝试自动选择
flutter run -d chrome --web-renderer auto
```

## 如果仍然白屏

### 1. 检查代码是否有错误

查看 VS Code 的问题面板（`Cmd+Shift+M`），确保没有编译错误。

### 2. 尝试最小化代码

创建一个最简单的测试：

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(child: Text('Hello Flutter')),
    ),
  ));
}
```

如果这个能运行，说明问题在原有代码中。

### 3. 检查 Flutter 版本

```bash
flutter doctor
flutter --version
```

确保 Flutter 版本是最新的稳定版。

## 联系支持

如果以上方法都不行，请提供：
1. 浏览器控制台的错误信息（截图）
2. VS Code 输出面板的错误信息
3. `flutter doctor` 的输出
4. `flutter run -d chrome --web-renderer html -v` 的完整输出


