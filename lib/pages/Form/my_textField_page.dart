import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/base/my_base_stateful_page.dart';
import 'package:my_app/widgets/unified_text_field.dart';

class MyTextFieldPage extends MyBaseStatefulPage {
  const MyTextFieldPage({super.key});

  @override
  State<MyTextFieldPage> createState() => _MyTextFieldPageState();

  @override
  String get pageTitle => 'TextField 常见用法';

  @override
  Color? get pageBackgroundColor => Colors.grey[100];
}

class _MyTextFieldPageState extends MyBaseStatefulPageState<MyTextFieldPage> {
  final _basicController = TextEditingController();
  final _passwordController = TextEditingController();
  final _numberController = TextEditingController();
  final _multiLineController = TextEditingController();
  final _emailController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _basicController.dispose();
    _passwordController.dispose();
    _numberController.dispose();
    _multiLineController.dispose();
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: '清空',
        onPressed: () {
          _basicController.clear();
          _passwordController.clear();
          _numberController.clear();
          _multiLineController.clear();
          _emailController.clear();
          setState(() {});
        },
        icon: const Icon(Icons.delete_sweep),
        color: Colors.white,
      ),
    ];
  }

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSection(
          title: '1) 基础输入（controller / onChanged / 清空）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UnifiedTextField(
                controller: _basicController,
                placeholder: '请输入任意内容',
                clearButtonMode: OverlayVisibilityMode.editing,
                suffix: _buildClearSuffix(_basicController),
                onChanged: (_) => setState(() {}),
                materialDecoration: const InputDecoration(
                  labelText: '基础输入',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '当前长度：${_basicController.text.characters.length}，内容：${_basicController.text.isEmpty ? '（空）' : _basicController.text}',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        _buildSection(
          title: '2) 焦点与键盘动作（Next / Done）',
          child: AutofillGroup(
            child: Column(
              children: [
                UnifiedTextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  placeholder: 'name@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                  materialDecoration: const InputDecoration(
                    labelText: '邮箱（Next）',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                UnifiedTextField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  placeholder: '输入密码',
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  onSubmitted: (_) {
                    _passwordFocusNode.unfocus();
                    TextInput.finishAutofillContext();
                  },
                  suffix: IconButton(
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  materialDecoration: const InputDecoration(
                    labelText: '密码（Done）',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildSection(
          title: '3) 数字输入（keyboardType + inputFormatters）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UnifiedTextField(
                controller: _numberController,
                placeholder: '只允许数字（最多 6 位）',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLength: 6,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                onChanged: (_) => setState(() {}),
                materialDecoration: const InputDecoration(
                  labelText: '验证码 / 数字输入',
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '解析结果：${int.tryParse(_numberController.text) ?? '（无效/为空）'}',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        _buildSection(
          title: '4) 多行输入（minLines / maxLines）',
          child: UnifiedTextField(
            controller: _multiLineController,
            placeholder: '多行文本…',
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 3,
            maxLines: 6,
            onChanged: (_) => setState(() {}),
            materialDecoration: const InputDecoration(
              labelText: '备注',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        _buildSection(
          title: '5) 只读 / 禁用',
          child: Column(
            children: [
              UnifiedTextField(
                initialText: 'readOnly=true：可选中/复制，但不弹键盘编辑（可配合 onTap 自定义动作）',
                readOnly: true,
                maxLines: null,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('你点击了只读输入框')),
                  );
                },
                materialDecoration: const InputDecoration(
                  labelText: '只读输入框',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              const UnifiedTextField(
                initialText: 'enabled=false：完全禁用（不响应输入）',
                enabled: false,
                materialDecoration: InputDecoration(
                  labelText: '禁用输入框',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        _buildSection(
          title: '常见知识点速记',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bullet('建议在 StatefulWidget 管理 controller/focusNode，并在 dispose 释放'),
              _bullet('桌面端要支持“鼠标拖拽/触控板拖拽”，需要放开 ScrollBehavior.dragDevices'),
              _bullet('textInputAction + onSubmitted 常用于 Next/Done 逻辑与焦点跳转'),
              _bullet('inputFormatters 发生在文本进入 controller 之前（可用于只允许数字/限制长度等）'),
              _bullet('obscureText 仅是视觉隐藏，不是加密；敏感信息仍需注意日志/截图等'),
              _bullet('readOnly 与 enabled=false 不同：readOnly 仍可获得焦点/选择文本'),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildClearSuffix(TextEditingController controller) {
    return IconButton(
      tooltip: '清空',
      onPressed: () {
        controller.clear();
        setState(() {});
      },
      icon: const Icon(Icons.clear),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
