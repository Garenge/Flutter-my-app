import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/base/my_base_stateful_page.dart';

/// GET 请求示例页面
class GetRequestPage extends MyBaseStatefulPage {
  const GetRequestPage({super.key});

  @override
  State<GetRequestPage> createState() => _GetRequestPageState();

  @override
  String get pageTitle => 'GET 请求示例';

  @override
  Color? get pageBackgroundColor => Colors.grey[100];
}

class _GetRequestPageState extends MyBaseStatefulPageState<GetRequestPage> {
  // 使用 JSONPlaceholder API 作为测试 API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // GET 请求相关状态（使用 Map，便于直接查看原始键值对）
  List<Map<String, dynamic>> _users = [];
  bool _isLoadingUsers = false;
  String? _getError;

  /// GET 请求示例：获取用户列表
  Future<void> _fetchUsers() async {
    setState(() {
      _isLoadingUsers = true;
      _getError = null;
      _users = [];
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
      );

      print('response: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          // 直接使用键值对列表，避免引入额外模型解析
          _users = data.cast<Map<String, dynamic>>();
          _isLoadingUsers = false;
        });
      } else {
        setState(() {
          _getError = '请求失败，状态码: ${response.statusCode}';
          _isLoadingUsers = false;
        });
      }
    } catch (e) {
      setState(() {
        _getError = '请求异常: $e';
        _isLoadingUsers = false;
      });
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSection(
          title: 'GET 请求示例',
          description: '使用 http.get() 方法获取用户列表数据',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: _isLoadingUsers ? null : _fetchUsers,
                icon: _isLoadingUsers
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download),
                label: Text(_isLoadingUsers ? '加载中...' : '获取用户列表'),
              ),
              const SizedBox(height: 12),
              if (_getError != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[300]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getError!,
                          style: TextStyle(color: Colors.red[900]),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_users.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  '获取到 ${_users.length} 个用户：',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ..._users.take(5).map((user) => _buildUserCard(user)),
                if (_users.length > 5)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '... 还有 ${_users.length - 5} 个用户',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildCodeSection(),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    user['id'].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name'] ?? '未知',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user['email'] ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 获取 GET 请求代码示例文本
  String _getCodeExample() {
    return '''// ✅ 推荐：使用 await（当前写法）
Future<void> fetchUsers() async {
  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // 处理数据...
    } else {
      // 处理错误...
    }
  } catch (e) {
    // 统一错误处理
  }
}

// ❌ 不推荐：使用 .then()（回调方式）
Future<void> fetchUsersWithThen() {
  http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'))
    .then((response) {
      if (response.statusCode == 200) {
        json.decode(response.body).then((data) {
          // 处理数据...
          // 嵌套回调，难以阅读和维护
        });
      }
    })
    .catchError((error) {
      // 错误处理
    });
}

// await 的优势：
// 1. 代码顺序执行，更易读
// 2. 错误处理简单（try-catch）
// 3. 避免回调地狱
// 4. 变量作用域清晰
// 5. 更容易调试''';
  }

  Widget _buildCodeSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '代码示例',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
              _getCodeExample(),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
