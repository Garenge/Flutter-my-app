import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/base/my_base_stateful_page.dart';

/// FutureBuilder 示例页面
class FutureBuilderPage extends MyBaseStatefulPage {
  const FutureBuilderPage({super.key});

  @override
  State<FutureBuilderPage> createState() => _FutureBuilderPageState();

  @override
  String get pageTitle => 'FutureBuilder 示例';

  @override
  Color? get pageBackgroundColor => Colors.grey[100];
}

class _FutureBuilderPageState extends MyBaseStatefulPageState<FutureBuilderPage> {
  Future<Map<String, dynamic>>? _userFuture;

  /// 获取单个用户数据
  Future<Map<String, dynamic>> _fetchUser(int userId) async {
    await Future.delayed(const Duration(seconds: 1)); // 模拟网络延迟
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users/$userId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('获取用户失败: ${response.statusCode}');
    }
  }

  void _loadUser(int userId) {
    setState(() {
      _userFuture = _fetchUser(userId);
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSection(
          title: 'FutureBuilder 示例',
          description: '使用 FutureBuilder 自动处理异步加载状态',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _loadUser(1),
                      child: const Text('加载用户 1'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _loadUser(2),
                      child: const Text('加载用户 2'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _loadUser(3),
                      child: const Text('加载用户 3'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FutureBuilder<Map<String, dynamic>>(
                future: _userFuture,
                builder: (context, snapshot) {
                  // 加载中状态
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      child: const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text('加载中...'),
                          ],
                        ),
                      ),
                    );
                  }

                  // 错误状态
                  if (snapshot.hasError) {
                    return Container(
                      padding: const EdgeInsets.all(16),
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
                              '错误: ${snapshot.error}',
                              style: TextStyle(color: Colors.red[900]),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // 有数据状态
                  if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.blue[700]),
                              const SizedBox(width: 8),
                              Text(
                                user['name'] ?? '未知',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow('邮箱', user['email'] ?? ''),
                          _buildInfoRow('电话', user['phone'] ?? ''),
                          _buildInfoRow('网站', user['website'] ?? ''),
                          if (user['address'] != null) ...[
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              '地址',
                              '${user['address']['city']}, ${user['address']['street']}',
                            ),
                          ],
                        ],
                      ),
                    );
                  }

                  // 初始状态（未加载）
                  return Container(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Text(
                        '点击上方按钮加载用户数据',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  );
                },
              ),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 获取 FutureBuilder 代码示例文本
  String _getCodeExample() {
    return '''// FutureBuilder 示例
FutureBuilder<Map<String, dynamic>>(
  future: fetchUser(),
  builder: (context, snapshot) {
    // 加载中
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    
    // 错误
    if (snapshot.hasError) {
      return Text('错误: \${snapshot.error}');
    }
    
    // 有数据
    if (snapshot.hasData) {
      return Text('用户名: \${snapshot.data!['name']}');
    }
    
    return Text('无数据');
  },
)''';
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
