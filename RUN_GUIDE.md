# Flutter 项目运行指南

## 多平台支持

Flutter 支持多个平台运行，包括：

- ✅ **Web** - 可以在任何浏览器中运行（Chrome、Edge、Firefox、Safari 等）
- ✅ **Android** - Android 手机和模拟器
- ✅ **iOS** - iPhone 和 iPad（需要 macOS）
- ✅ **Windows** - Windows 桌面应用
- ✅ **macOS** - macOS 桌面应用
- ✅ **Linux** - Linux 桌面应用

## 运行项目

### 1. 检查 Flutter 环境

首先确保 Flutter 已正确安装并配置：

```bash
flutter doctor
```

### 2. 查看可用设备

查看所有可用的运行设备：

```bash
cd /Users/garenge/Downloads/Develop/flutter/my_app
flutter devices
```

### 3. 运行在 Web（浏览器）

**使用默认浏览器（Chrome）：**
```bash
flutter run -d chrome
```

**使用 Edge 浏览器：**
```bash
flutter run -d edge
```

**或者指定 Web 服务器端口：**
```bash
flutter run -d chrome --web-port=8080
```

### 4. 运行在其他平台

**Android 模拟器：**
```bash
flutter run -d android
```

**iOS 模拟器（仅 macOS）：**
```bash
flutter run -d ios
```

**macOS 桌面：**
```bash
flutter run -d macos
```

**Windows 桌面：**
```bash
flutter run -d windows
```

**Linux 桌面：**
```bash
flutter run -d linux
```

## 使用 Edge 浏览器运行

### 方法 1：直接指定 Edge

```bash
flutter run -d edge
```

### 方法 2：如果 Edge 不在设备列表中

1. 先运行在 Chrome：
   ```bash
   flutter run -d chrome
   ```

2. 复制显示的 URL（例如：http://localhost:xxxxx）

3. 在 Edge 浏览器中打开该 URL

### 方法 3：构建 Web 版本后手动打开

```bash
# 构建 Web 版本
flutter build web

# 构建后的文件在 build/web 目录
# 可以用任何 Web 服务器运行，或者直接用 Edge 打开 index.html
```

## 常见问题

### Flutter 命令未找到

如果提示 `flutter: command not found`，需要：

1. **找到 Flutter 安装路径**
   - 通常在 `~/flutter` 或 `/usr/local/flutter`

2. **添加到 PATH**
   
   编辑 `~/.zshrc`（macOS）：
   ```bash
   export PATH="$PATH:$HOME/flutter/bin"
   ```
   
   然后重新加载：
   ```bash
   source ~/.zshrc
   ```

3. **验证安装**
   ```bash
   flutter doctor
   ```

### Web 支持未启用

如果 Web 平台不可用，需要启用：

```bash
flutter config --enable-web
```

### 热重载（Hot Reload）

**重要：Flutter Web 的热重载需要应用在开发模式下运行！**

#### 手动触发热重载

运行后，在终端中：
- 按 `r` - 热重载（Hot Reload）- 快速更新 UI
- 按 `R` - 热重启（Hot Restart）- 完全重启应用
- 按 `q` - 退出应用

#### 为什么保存文件后没有自动刷新？

**Flutter Web 平台的特点：**
1. **Web 平台不支持自动热重载** - 不像移动平台，Web 需要手动触发热重载
2. **必须在开发模式下运行** - 使用 `flutter run -d chrome` 或 `flutter run -d edge`
3. **IDE 自动热重载** - 某些 IDE（如 VS Code、Android Studio）可以配置自动热重载

#### 解决方案

**方案 1：使用 IDE 的自动热重载功能**

**VS Code：**
1. 安装 Flutter 扩展
2. 使用 `F5` 或点击运行按钮启动应用
3. 保存文件时，VS Code 会自动触发热重载（如果配置正确）

**Android Studio：**
1. 运行应用后，点击工具栏的 🔥 图标（热重载）
2. 或者配置自动热重载：`Settings > Languages & Frameworks > Flutter > Enable hot reload on save`

**方案 2：手动触发热重载**

每次保存文件后：
1. 切换到运行 Flutter 的终端窗口
2. 按 `r` 键触发热重载

**方案 3：使用 Flutter DevTools**

1. 运行应用后，在终端会显示 DevTools 的 URL
2. 在浏览器中打开 DevTools
3. 可以在 DevTools 中触发热重载

#### 检查是否在开发模式

确保使用以下命令运行（不是 `flutter build web`）：
```bash
flutter run -d chrome
# 或
flutter run -d edge
```

如果使用 `flutter build web`，生成的是生产版本，不支持热重载。

#### 热重载的限制

某些更改需要**热重启**（按 `R`）而不是热重载（按 `r`）：
- 修改 `main()` 函数
- 修改全局变量和静态字段的初始值
- 修改枚举类型
- 修改 `initState()` 中的代码
- 添加或删除字段

## 快速开始

最简单的运行方式（Web）：

```bash
cd /Users/garenge/Downloads/Develop/flutter/my_app
flutter run -d chrome
# 或者
flutter run -d edge
```

项目会自动在浏览器中打开！

