import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/base/my_base_stateful_page.dart';

/// POST 请求示例页面
class PostRequestPage extends MyBaseStatefulPage {
  const PostRequestPage({super.key});

  @override
  State<PostRequestPage> createState() => _PostRequestPageState();

  @override
  String get pageTitle => 'POST 请求示例';

  @override
  Color? get pageBackgroundColor => Colors.grey[100];
}

class _PostRequestPageState extends MyBaseStatefulPageState<PostRequestPage> {
  // 使用 JSONPlaceholder API 作为测试 API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // POST 请求相关状态
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isPosting = false;
  String? _postResult;
  String? _postError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// POST 请求示例：创建用户
  Future<void> _createUser() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      setState(() {
        _postError = '请输入姓名和邮箱';
      });
      return;
    }

    setState(() {
      _isPosting = true;
      _postError = null;
      _postResult = null;
    });

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _nameController.text,
          'email': _emailController.text,
          'username': _nameController.text.toLowerCase().replaceAll(' ', '_'),
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        setState(() {
          _postResult = '创建成功！\nID: ${data['id']}\n姓名: ${data['name']}\n邮箱: ${data['email']}';
          _isPosting = false;
          _nameController.clear();
          _emailController.clear();
        });
      } else {
        setState(() {
          _postError = '创建失败，状态码: ${response.statusCode}';
          _isPosting = false;
        });
      }
    } catch (e) {
      setState(() {
        _postError = '请求异常: $e';
        _isPosting = false;
      });
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSection(
          title: 'POST 请求示例',
          description: '使用 http.post() 方法提交数据创建新用户',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '姓名',
                  hintText: '请输入姓名',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: '邮箱',
                  hintText: '请输入邮箱',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _isPosting ? null : _createUser,
                icon: _isPosting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add),
                label: Text(_isPosting ? '创建中...' : '创建用户'),
              ),
              if (_postError != null) ...[
                const SizedBox(height: 12),
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
                          _postError!,
                          style: TextStyle(color: Colors.red[900]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (_postResult != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green[300]!),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.green[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _postResult!,
                          style: TextStyle(color: Colors.green[900]),
                        ),
                      ),
                    ],
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

  /// 获取 POST 请求代码示例文本
  String _getCodeExample() {
    return '''// POST 请求示例
Future<void> createUser() async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/users'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'name': 'John Doe',
      'email': 'john@example.com',
    }),
  );

  if (response.statusCode == 201) {
    final data = json.decode(response.body);
    // 处理成功响应...
  } else {
    // 处理错误...
  }
}''';
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
