import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储管理器
/// 提供统一的数据持久化接口，支持多种数据类型
class PreferenceStorageManager {
  /// 存储键名常量定义
  /// 在这里添加新的键名即可用于新的功能
  static const String keyAppDesignStyle = 'app_design_style';

  /// 获取 SharedPreferences 实例
  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // ==================== 通用方法：字符串类型 ====================

  /// 保存字符串值
  /// [key] 存储键名
  /// [value] 要保存的字符串值
  /// 返回保存是否成功
  static Future<bool> setString(String key, String value) async {
    try {
      final prefs = await _prefs;
      return await prefs.setString(key, value);
    } catch (e) {
      print('保存字符串失败 [key: $key]: $e');
      return false;
    }
  }

  /// 读取字符串值
  /// [key] 存储键名
  /// 返回保存的字符串值，如果没有保存过则返回 null
  static Future<String?> getString(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getString(key);
    } catch (e) {
      print('读取字符串失败 [key: $key]: $e');
      return null;
    }
  }

  // ==================== 通用方法：整数类型 ====================

  /// 保存整数值
  /// [key] 存储键名
  /// [value] 要保存的整数值
  /// 返回保存是否成功
  static Future<bool> setInt(String key, int value) async {
    try {
      final prefs = await _prefs;
      return await prefs.setInt(key, value);
    } catch (e) {
      print('保存整数失败 [key: $key]: $e');
      return false;
    }
  }

  /// 读取整数值
  /// [key] 存储键名
  /// 返回保存的整数值，如果没有保存过则返回 null
  static Future<int?> getInt(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getInt(key);
    } catch (e) {
      print('读取整数失败 [key: $key]: $e');
      return null;
    }
  }

  // ==================== 通用方法：布尔类型 ====================

  /// 保存布尔值
  /// [key] 存储键名
  /// [value] 要保存的布尔值
  /// 返回保存是否成功
  static Future<bool> setBool(String key, bool value) async {
    try {
      final prefs = await _prefs;
      return await prefs.setBool(key, value);
    } catch (e) {
      print('保存布尔值失败 [key: $key]: $e');
      return false;
    }
  }

  /// 读取布尔值
  /// [key] 存储键名
  /// [defaultValue] 如果不存在时返回的默认值，默认为 false
  /// 返回保存的布尔值，如果没有保存过则返回 defaultValue
  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    try {
      final prefs = await _prefs;
      return prefs.getBool(key) ?? defaultValue;
    } catch (e) {
      print('读取布尔值失败 [key: $key]: $e');
      return defaultValue;
    }
  }

  // ==================== 通用方法：浮点数类型 ====================

  /// 保存浮点数值
  /// [key] 存储键名
  /// [value] 要保存的浮点数值
  /// 返回保存是否成功
  static Future<bool> setDouble(String key, double value) async {
    try {
      final prefs = await _prefs;
      return await prefs.setDouble(key, value);
    } catch (e) {
      print('保存浮点数失败 [key: $key]: $e');
      return false;
    }
  }

  /// 读取浮点数值
  /// [key] 存储键名
  /// 返回保存的浮点数值，如果没有保存过则返回 null
  static Future<double?> getDouble(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getDouble(key);
    } catch (e) {
      print('读取浮点数失败 [key: $key]: $e');
      return null;
    }
  }

  // ==================== 通用方法：字符串列表类型 ====================

  /// 保存字符串列表
  /// [key] 存储键名
  /// [value] 要保存的字符串列表
  /// 返回保存是否成功
  static Future<bool> setStringList(String key, List<String> value) async {
    try {
      final prefs = await _prefs;
      return await prefs.setStringList(key, value);
    } catch (e) {
      print('保存字符串列表失败 [key: $key]: $e');
      return false;
    }
  }

  /// 读取字符串列表
  /// [key] 存储键名
  /// 返回保存的字符串列表，如果没有保存过则返回 null
  static Future<List<String>?> getStringList(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getStringList(key);
    } catch (e) {
      print('读取字符串列表失败 [key: $key]: $e');
      return null;
    }
  }

  // ==================== 通用方法：删除数据 ====================

  /// 删除指定键的数据
  /// [key] 要删除的存储键名
  /// 返回删除是否成功
  static Future<bool> remove(String key) async {
    try {
      final prefs = await _prefs;
      return await prefs.remove(key);
    } catch (e) {
      print('删除数据失败 [key: $key]: $e');
      return false;
    }
  }

  /// 检查指定键是否存在
  /// [key] 要检查的存储键名
  /// 返回键是否存在
  static Future<bool> containsKey(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.containsKey(key);
    } catch (e) {
      print('检查键是否存在失败 [key: $key]: $e');
      return false;
    }
  }

  /// 清除所有数据（谨慎使用）
  /// 返回清除是否成功
  static Future<bool> clear() async {
    try {
      final prefs = await _prefs;
      return await prefs.clear();
    } catch (e) {
      print('清除所有数据失败: $e');
      return false;
    }
  }

  // ==================== 便捷方法：应用设计风格（使用通用方法实现）====================

  /// 保存应用设计风格
  /// [style] 风格值：'material' 或 'cupertino'
  /// 返回保存是否成功
  static Future<bool> saveAppDesignStyle(String style) {
    return setString(keyAppDesignStyle, style);
  }

  /// 读取应用设计风格
  /// 返回风格值：'material' 或 'cupertino'，如果没有保存过则返回 null
  static Future<String?> getAppDesignStyle() {
    return getString(keyAppDesignStyle);
  }

  /// 删除应用设计风格（恢复默认）
  /// 返回删除是否成功
  static Future<bool> clearAppDesignStyle() {
    return remove(keyAppDesignStyle);
  }
}
